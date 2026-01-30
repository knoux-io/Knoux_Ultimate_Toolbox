# KNOX Ultimate Toolbox - Markdown Issues Fixer (PowerShell Version)
# Fixes markdown formatting issues in BAT files automatically

# Configuration
$RootPath = "F:\KNOX_ULTIMATE_TOOLBOX"
$BackupPath = "F:\KNOX_ULTIMATE_TOOLBOX\backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
$LogFile = "$RootPath\markdown_fix_log_$(Get-Date -Format 'yyyyMMdd').txt"

# Initialize logging
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "[$Timestamp] [$Level] $Message"
    Write-Host $LogEntry
    Add-Content -Path $LogFile -Value $LogEntry
}

# Create backup function
function New-Backup {
    Write-Log "Creating backup of all BAT files..."
    
    if (-not (Test-Path $BackupPath)) {
        New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    }
    
    $BatFiles = Get-ChildItem -Path $RootPath -Filter "*.bat" -Recurse
    $BackupCount = 0
    
    foreach ($File in $BatFiles) {
        $RelativePath = $File.FullName.Replace($RootPath, "")
        $BackupFile = "$BackupPath$RelativePath"
        $BackupDir = Split-Path $BackupFile -Parent
        
        if (-not (Test-Path $BackupDir)) {
            New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
        }
        
        Copy-Item -Path $File.FullName -Destination $BackupFile -Force
        $BackupCount++
    }
    
    Write-Log "Backup completed: $BackupCount files backed up to $BackupPath"
    return $BackupCount
}

# Fix code fences without language
function Fix-CodeFences {
    param([string]$FilePath)
    
    $Content = Get-Content -Path $FilePath -Raw
    $OriginalContent = $Content
    $FixCount = 0
    
    # Replace ``` with ```batch (but not if already has language)
    $Pattern = '```\s*\n(?![a-zA-Z])'
    $Content = $Content -replace $Pattern, "```batch`n"
    
    # Count actual replacements
    $FixCount = ([regex]::Matches($OriginalContent, $Pattern)).Count
    
    if ($FixCount -gt 0) {
        Set-Content -Path $FilePath -Value $Content -NoNewline
        Write-Log "Fixed $FixCount code fences in $FilePath"
    }
    
    return $FixCount
}

# Fix blank lines before headings
function Fix-HeadingBlankBefore {
    param([string]$FilePath)
    
    $Content = Get-Content -Path $FilePath -Raw
    $OriginalContent = $Content
    $FixCount = 0
    
    # Add blank line before headings if not present
    $Pattern = '([^\r\n])\r?\n(#{1,6}\s)'
    $Content = $Content -replace $Pattern, "`$1`r`n`r`n`$2"
    
    # Count actual replacements
    $FixCount = ([regex]::Matches($OriginalContent, $Pattern)).Count
    
    if ($FixCount -gt 0) {
        Set-Content -Path $FilePath -Value $Content -NoNewline
        Write-Log "Added $FixCount blank lines before headings in $FilePath"
    }
    
    return $FixCount
}

# Fix blank lines before lists
function Fix-ListBlankBefore {
    param([string]$FilePath)
    
    $Content = Get-Content -Path $FilePath -Raw
    $OriginalContent = $Content
    $FixCount = 0
    
    # Add blank line before lists if not present
    $Pattern = '([^\r\n])\r?\n(\[[0-9]+\]|\*|\-|\+)'
    $Content = $Content -replace $Pattern, "`$1`r`n`r`n`$2"
    
    # Count actual replacements
    $FixCount = ([regex]::Matches($OriginalContent, $Pattern)).Count
    
    if ($FixCount -gt 0) {
        Set-Content -Path $FilePath -Value $Content -NoNewline
        Write-Log "Added $FixCount blank lines before lists in $FilePath"
    }
    
    return $FixCount
}

# Fix blank lines after headings
function Fix-HeadingBlankAfter {
    param([string]$FilePath)
    
    $Content = Get-Content -Path $FilePath -Raw
    $OriginalContent = $Content
    $FixCount = 0
    
    # Add blank line after headings if not present
    $Pattern = '(#{1,6}\s[^\r\n]+)\r?\n([^\r\n])'
    $Content = $Content -replace $Pattern, "`$1`r`n`r`n`$2"
    
    # Count actual replacements
    $FixCount = ([regex]::Matches($OriginalContent, $Pattern)).Count
    
    if ($FixCount -gt 0) {
        Set-Content -Path $FilePath -Value $Content -NoNewline
        Write-Log "Added $FixCount blank lines after headings in $FilePath"
    }
    
    return $FixCount
}

# Fix spacing inconsistencies
function Fix-Spacing {
    param([string]$FilePath)
    
    $Content = Get-Content -Path $FilePath -Raw
    $OriginalContent = $Content
    $FixCount = 0
    
    # Fix multiple consecutive blank lines (reduce to max 2)
    $Pattern = '\r?\n\r?\n\r?\n(\r?\n)+'
    $Content = $Content -replace $Pattern, "`r`n`r`n"
    $FixCount += ([regex]::Matches($OriginalContent, $Pattern)).Count
    
    # Fix trailing whitespace
    $Pattern = '[ \t]+(\r?\n|$)'
    $Content = $Content -replace $Pattern, "`$1"
    $FixCount += ([regex]::Matches($OriginalContent, $Pattern)).Count
    
    if ($FixCount -gt 0) {
        Set-Content -Path $FilePath -Value $Content -NoNewline
        Write-Log "Fixed $FixCount spacing issues in $FilePath"
    }
    
    return $FixCount
}

# Scan for issues
function Find-Issues {
    Write-Log "Scanning for markdown issues..."
    
    $BatFiles = Get-ChildItem -Path $RootPath -Filter "*.bat" -Recurse
    $Stats = @{
        CodeFences = 0
        HeadingBlankBefore = 0
        ListBlankBefore = 0
        HeadingBlankAfter = 0
        Spacing = 0
        TotalFiles = $BatFiles.Count
        FilesWithIssues = 0
    }
    
    foreach ($File in $BatFiles) {
        $Content = Get-Content -Path $File.FullName -Raw
        $FileHasIssues = $false
        
        # Check for code fences without language
        if ($Content -match '```\s*\n(?![a-zA-Z])') {
            $Stats.CodeFences += ([regex]::Matches($Content, '```\s*\n(?![a-zA-Z])')).Count
            $FileHasIssues = $true
        }
        
        # Check for headings without blank lines before
        if ($Content -match '([^\r\n])\r?\n(#{1,6}\s)') {
            $Stats.HeadingBlankBefore += ([regex]::Matches($Content, '([^\r\n])\r?\n(#{1,6}\s)')).Count
            $FileHasIssues = $true
        }
        
        # Check for lists without blank lines before
        if ($Content -match '([^\r\n])\r?\n(\[[0-9]+\]|\*|\-|\+)') {
            $Stats.ListBlankBefore += ([regex]::Matches($Content, '([^\r\n])\r?\n(\[[0-9]+\]|\*|\-|\+)')).Count
            $FileHasIssues = $true
        }
        
        # Check for headings without blank lines after
        if ($Content -match '(#{1,6}\s[^\r\n]+)\r?\n([^\r\n])') {
            $Stats.HeadingBlankAfter += ([regex]::Matches($Content, '(#{1,6}\s[^\r\n]+)\r?\n([^\r\n])')).Count
            $FileHasIssues = $true
        }
        
        # Check for spacing issues
        if ($Content -match '\r?\n\r?\n\r?\n(\r?\n)+' -or $Content -match '[ \t]+(\r?\n|$)') {
            $Stats.Spacing += ([regex]::Matches($Content, '\r?\n\r?\n\r?\n(\r?\n)+|[ \t]+(\r?\n|$)')).Count
            $FileHasIssues = $true
        }
        
        if ($FileHasIssues) {
            $Stats.FilesWithIssues++
        }
    }
    
    return $Stats
}

# Verify fixes
function Test-Fixes {
    Write-Log "Verifying fixes..."
    
    $Stats = Find-Issues
    
    Write-Log "Verification Results:"
    Write-Log "  Code fences without language: $($Stats.CodeFences) remaining"
    Write-Log "  Headings without blank lines (before): $($Stats.HeadingBlankBefore) remaining"
    Write-Log "  Lists without blank lines (before): $($Stats.ListBlankBefore) remaining"
    Write-Log "  Headings without blank lines (after): $($Stats.HeadingBlankAfter) remaining"
    Write-Log "  Spacing issues: $($Stats.Spacing) remaining"
    Write-Log "  Files with issues: $($Stats.FilesWithIssues)/$($Stats.TotalFiles)"
    
    if ($Stats.FilesWithIssues -eq 0) {
        Write-Log "✅ ALL ISSUES FIXED!" "SUCCESS"
        return $true
    } else {
        Write-Log "⚠️  Some issues remain" "WARNING"
        return $false
    }
}

# Main fixing function
function Invoke-FixAll {
    param([switch]$NoBackup, [switch]$VerifyOnly)
    
    Write-Log "Starting KNOX Markdown Issues Fixer"
    Write-Log "Root path: $RootPath"
    
    if (-not (Test-Path $RootPath)) {
        Write-Log "Root path not found: $RootPath" "ERROR"
        return
    }
    
    if ($VerifyOnly) {
        Test-Fixes
        return
    }
    
    # Create backup unless skipped
    $BackupCount = 0
    if (-not $NoBackup) {
        $BackupCount = New-Backup
    }
    
    # Get all BAT files
    $BatFiles = Get-ChildItem -Path $RootPath -Filter "*.bat" -Recurse
    $TotalFixes = 0
    
    Write-Log "Processing $($BatFiles.Count) BAT files..."
    
    foreach ($File in $BatFiles) {
        $FileFixes = 0
        
        # Apply all fixes
        $FileFixes += Fix-CodeFences -FilePath $File.FullName
        $FileFixes += Fix-HeadingBlankBefore -FilePath $File.FullName
        $FileFixes += Fix-ListBlankBefore -FilePath $File.FullName
        $FileFixes += Fix-HeadingBlankAfter -FilePath $File.FullName
        $FileFixes += Fix-Spacing -FilePath $File.FullName
        
        $TotalFixes += $FileFixes
        
        if ($FileFixes -gt 0) {
            Write-Log "Processed $($File.Name): $FileFixes fixes applied"
        }
    }
    
    Write-Log "Fixing completed!"
    Write-Log "Total files processed: $($BatFiles.Count)"
    Write-Log "Total fixes applied: $TotalFixes"
    if ($BackupCount -gt 0) {
        Write-Log "Backup files: $BackupCount"
    }
    
    # Verify fixes
    Test-Fixes
}

# Show help
function Show-Help {
    Write-Host "KNOX Markdown Issues Fixer - PowerShell Script"
    Write-Host ""
    Write-Host "Usage:"
    Write-Host "  .\fix_markdown_issues_powershell.ps1 [options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -NoBackup    Skip backup creation"
    Write-Host "  -VerifyOnly  Only verify current state, don't fix"
    Write-Host "  -Help        Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\fix_markdown_issues_powershell.ps1"
    Write-Host "  .\fix_markdown_issues_powershell.ps1 -NoBackup"
    Write-Host "  .\fix_markdown_issues_powershell.ps1 -VerifyOnly"
}

# Main execution
param(
    [switch]$NoBackup,
    [switch]$VerifyOnly,
    [switch]$Help
)

if ($Help) {
    Show-Help
    exit
}

try {
    Invoke-FixAll -NoBackup:$NoBackup -VerifyOnly:$VerifyOnly
} catch {
    Write-Log "Error occurred: $($_.Exception.Message)" "ERROR"
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Log "Script completed"
