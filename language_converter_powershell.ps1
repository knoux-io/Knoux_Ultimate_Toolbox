# KNOX Ultimate Toolbox - Language Converter PowerShell Script
# Version: 1.0.0
# Purpose: Convert all files from Arabic to English with full backup

param(
    [Parameter(Mandatory=$false)]
    [string]$Mode = "all",
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun,
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

# Configuration
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackupDir = Join-Path $ScriptDir "backup_before_conversion"
$LogFile = Join-Path $ScriptDir "conversion_log.txt"
$Encoding = [System.Text.Encoding]::UTF8

# Translation mappings
$Translations = @{
    # Menu items
    "اختر" = "Select"
    "المسح السريع" = "Quick Scan"
    "المسح الشامل" = "Full Scan"
    "المسح المخصص" = "Custom Scan"
    "الإعدادات" = "Settings"
    "العودة للقائمة الرئيسية" = "Back to Main Menu"
    "الخروج" = "Exit"
    
    # Common phrases
    "جاري" = "Processing"
    "اكتمل" = "Completed"
    "بنجاح" = "Successfully"
    "فشل" = "Failed"
    "تحذير" = "Warning"
    "خطأ" = "Error"
    
    # Section names
    "التشخيص" = "Diagnostics"
    "التحسين" = "Optimization"
    "الأمان" = "Security"
    "الشبكة" = "Network"
    "القرص" = "Disk"
    "الريجستري" = "Registry"
    "الخدمات" = "Services"
    "التعديلات" = "Tweaks"
    "المعلومات" = "Information"
    "النسخ الاحتياطي" = "Backup"
    "المطورين" = "Developers"
    "المتقدم" = "Advanced"
    
    # Common UI elements
    "القائمة الرئيسية" = "Main Menu"
    "الأدوات" = "Tools"
    "الخيارات" = "Options"
    "النتائج" = "Results"
    "التقرير" = "Report"
    "الحالة" = "Status"
    "الإعدادات" = "Settings"
    
    # Time and progress
    "دقيقة" = "minute"
    "ثانية" = "second"
    "ساعة" = "hour"
    "يوم" = "day"
    "أسبوع" = "week"
    "شهر" = "month"
    "سنة" = "year"
}

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "[$timestamp] $Message" | Out-File -FilePath $LogFile -Append -Encoding $Encoding
}

function Create-Backup {
    Write-Log "Creating backup directory..."
    
    if (-not (Test-Path $BackupDir)) {
        New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
        Write-Log "Created backup directory: $BackupDir"
    }
    
    Write-Log "Backing up files..."
    
    # Backup batch files
    $batchFiles = Get-ChildItem -Path $ScriptDir -Filter "*.bat" -File
    foreach ($file in $batchFiles) {
        $backupPath = Join-Path $BackupDir $file.Name
        Copy-Item -Path $file.FullName -Destination $backupPath -Force
        Write-Log "Backed up: $($file.Name)"
    }
    
    # Backup markdown files
    $mdFiles = Get-ChildItem -Path $ScriptDir -Filter "*.md" -File
    foreach ($file in $mdFiles) {
        $backupPath = Join-Path $BackupDir $file.Name
        Copy-Item -Path $file.FullName -Destination $backupPath -Force
        Write-Log "Backed up: $($file.Name)"
    }
    
    Write-Log "Backup completed successfully"
}

function Convert-BatchFile {
    param([string]$FilePath)
    
    Write-Log "Converting batch file: $FilePath"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would convert: $FilePath"
        return
    }
    
    $content = Get-Content -Path $FilePath -Raw -Encoding $Encoding
    
    # Apply translations
    foreach ($arabic in $Translations.Keys) {
        $english = $Translations[$arabic]
        $content = $content -replace [regex]$arabic, $english
    }
    
    # Fix common batch file patterns
    $content = $content -replace 'echo \[1\] (.*)', 'echo [1] $1'
    $content = $content -replace 'echo \[2\] (.*)', 'echo [2] $1'
    $content = $content -replace 'echo \[3\] (.*)', 'echo [3] $1'
    $content = $content -replace 'echo \[4\] (.*)', 'echo [4] $1'
    $content = $content -replace 'echo \[5\] (.*)', 'echo [5] $1'
    $content = $content -replace 'echo \[6\] (.*)', 'echo [6] $1'
    $content = $content -replace 'echo \[7\] (.*)', 'echo [7] $1'
    $content = $content -replace 'echo \[8\] (.*)', 'echo [8] $1'
    $content = $content -replace 'echo \[9\] (.*)', 'echo [9] $1'
    $content = $content -replace 'echo \[10\] (.*)', 'echo [10] $1'
    
    # Save converted file
    $content | Out-File -FilePath $FilePath -Encoding $Encoding -Force
    Write-Log "Converted batch file: $FilePath"
}

function Convert-MarkdownFile {
    param([string]$FilePath)
    
    Write-Log "Converting markdown file: $FilePath"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would convert: $FilePath"
        return
    }
    
    $content = Get-Content -Path $FilePath -Raw -Encoding $Encoding
    
    # Apply translations
    foreach ($arabic in $Translations.Keys) {
        $english = $Translations[$arabic]
        $content = $content -replace [regex]$arabic, $english
    }
    
    # Fix markdown formatting
    $content = $content -replace '(?<!\n)(^#+\s)', "`n`$&"
    $content = $content -replace '(^#+\s.*$)(?<!\n)', '$&`n'
    $content = $content -replace '(?<!\n)(^\s*[-*+]\s)', "`n`$&"
    $content = $content -replace '(^\s*[-*+]\s.*$)(?<!\n)', '$&`n'
    $content = $content -replace '(?<!\n)(```\w*)', "`n`$&"
    $content = $content -replace '(```\w*.*?```)(?<!\n)', '$&`n'
    $content = $content -replace '```\s*$', '```\nbash'
    
    # Save converted file
    $content | Out-File -FilePath $FilePath -Encoding $Encoding -Force
    Write-Log "Converted markdown file: $FilePath"
}

function Fix-MarkdownFormatting {
    param([string]$FilePath)
    
    Write-Log "Fixing markdown formatting: $FilePath"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would fix: $FilePath"
        return
    }
    
    $content = Get-Content -Path $FilePath -Raw -Encoding $Encoding
    
    # Fix all markdown issues
    $content = $content -replace '(?<!\n)(^#+\s)', "`n`$&"
    $content = $content -replace '(^#+\s.*$)(?<!\n)', '$&`n'
    $content = $content -replace '(?<!\n)(^\s*[-*+]\s)', "`n`$&"
    $content = $content -replace '(^\s*[-*+]\s.*$)(?<!\n)', '$&`n'
    $content = $content -replace '(?<!\n)(```\w*)', "`n`$&"
    $content = $content -replace '(```\w*.*?```)(?<!\n)', '$&`n'
    $content = $content -replace '```\s*$', '```\nbash'
    $content = $content -replace '```\s*$', '```\nbatch'
    $content = $content -replace '```\s*$', '```\npowershell'
    
    # Save fixed file
    $content | Out-File -FilePath $FilePath -Encoding $Encoding -Force
    Write-Log "Fixed markdown formatting: $FilePath"
}

function Convert-AllFiles {
    Write-Log "Starting conversion process..."
    
    # Convert batch files
    $batchFiles = Get-ChildItem -Path $ScriptDir -Filter "*.bat" -File
    Write-Log "Found $($batchFiles.Count) batch files to convert"
    
    foreach ($file in $batchFiles) {
        Convert-BatchFile -FilePath $file.FullName
    }
    
    # Convert markdown files
    $mdFiles = Get-ChildItem -Path $ScriptDir -Filter "*.md" -File
    Write-Log "Found $($mdFiles.Count) markdown files to convert"
    
    foreach ($file in $mdFiles) {
        Convert-MarkdownFile -FilePath $file.FullName
    }
    
    Write-Log "Conversion process completed"
}

function Fix-AllMarkdownFiles {
    Write-Log "Starting markdown fixing process..."
    
    $mdFiles = Get-ChildItem -Path $ScriptDir -Filter "*.md" -File
    Write-Log "Found $($mdFiles.Count) markdown files to fix"
    
    foreach ($file in $mdFiles) {
        Fix-MarkdownFormatting -FilePath $file.FullName
    }
    
    Write-Log "Markdown fixing process completed"
}

function Restore-FromBackup {
    if (-not (Test-Path $BackupDir)) {
        Write-Log "No backup directory found!"
        Write-Host "❌ No backup found!" -ForegroundColor Red
        return
    }
    
    Write-Log "Restoring files from backup..."
    
    # Restore batch files
    $backupBatchFiles = Get-ChildItem -Path $BackupDir -Filter "*.bat" -File
    foreach ($file in $backupBatchFiles) {
        $originalPath = Join-Path $ScriptDir $file.Name
        if (Test-Path $originalPath) {
            Copy-Item -Path $file.FullName -Destination $originalPath -Force
            Write-Log "Restored: $($file.Name)"
        }
    }
    
    # Restore markdown files
    $backupMdFiles = Get-ChildItem -Path $BackupDir -Filter "*.md" -File
    foreach ($file in $backupMdFiles) {
        $originalPath = Join-Path $ScriptDir $file.Name
        if (Test-Path $originalPath) {
            Copy-Item -Path $file.FullName -Destination $originalPath -Force
            Write-Log "Restored: $($file.Name)"
        }
    }
    
    Write-Log "Restore process completed"
    Write-Host "✅ Files restored successfully!" -ForegroundColor Green
}

# Main execution
try {
    Write-Host "🌍 KNOX Language Converter" -ForegroundColor Cyan
    Write-Host "═════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    
    switch ($Mode.ToLower()) {
        "all" {
            if (-not $Force) {
                Write-Host "⚠️  This will convert ALL files from Arabic to English" -ForegroundColor Yellow
                Write-Host "⚠️  A backup will be created automatically" -ForegroundColor Yellow
                Write-Host ""
                $confirm = Read-Host "Are you sure you want to continue? (y/N)"
                if ($confirm -notmatch '^[Yy]') {
                    Write-Host "Operation cancelled." -ForegroundColor Red
                    exit
                }
            }
            
            Create-Backup
            Convert-AllFiles
            Fix-AllMarkdownFiles
            
            Write-Host ""
            Write-Host "✅ Conversion completed successfully!" -ForegroundColor Green
            Write-Host "📊 Check the log file for details: $LogFile" -ForegroundColor Cyan
        }
        
        "batch" {
            Create-Backup
            Convert-AllFiles
            Write-Host "✅ Batch files converted successfully!" -ForegroundColor Green
        }
        
        "markdown" {
            Create-Backup
            Convert-MarkdownFile -FilePath (Join-Path $ScriptDir "README.MD")
            Fix-MarkdownFormatting -FilePath (Join-Path $ScriptDir "README.MD")
            Write-Host "✅ Markdown files converted successfully!" -ForegroundColor Green
        }
        
        "fix" {
            Create-Backup
            Fix-AllMarkdownFiles
            Write-Host "✅ Markdown formatting fixed successfully!" -ForegroundColor Green
        }
        
        "restore" {
            Restore-FromBackup
        }
        
        default {
            Write-Host "❌ Invalid mode: $Mode" -ForegroundColor Red
            Write-Host ""
            Write-Host "Available modes:" -ForegroundColor Yellow
            Write-Host "  all     - Convert all files (default)" -ForegroundColor White
            Write-Host "  batch   - Convert batch files only" -ForegroundColor White
            Write-Host "  markdown - Convert markdown files only" -ForegroundColor White
            Write-Host "  fix     - Fix markdown formatting only" -ForegroundColor White
            Write-Host "  restore - Restore from backup" -ForegroundColor White
            exit 1
        }
    }
    
} catch {
    Write-Log "ERROR: $($_.Exception.Message)"
    Write-Host "❌ Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
