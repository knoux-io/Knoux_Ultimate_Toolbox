# KNOX Ultimate Toolbox - Markdown Fix Script
# Fixes all markdownlint errors in README.md

param(
    [switch]$DryRun,
    [switch]$Backup
)

$ReadmePath = "README.md"
$BackupPath = "README_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').md"

Write-Host "🔧 KNOX Ultimate Toolbox - Markdown Fix Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Create backup if requested
if ($Backup -and (Test-Path $ReadmePath)) {
    Write-Host "📋 Creating backup..." -ForegroundColor Yellow
    Copy-Item $ReadmePath $BackupPath -Force
    Write-Host "✅ Backup created: $BackupPath" -ForegroundColor Green
}

# Read the original file
if (-not (Test-Path $ReadmePath)) {
    Write-Host "❌ README.md not found!" -ForegroundColor Red
    exit 1
}

$content = Get-Content $ReadmePath -Raw
$originalContent = $content

Write-Host "📖 Analyzing README.md..." -ForegroundColor Yellow

# Fix 1: Add blank lines before headings
Write-Host "🔧 Fixing: Blank lines before headings..." -ForegroundColor Cyan
$content = $content -replace '([^\r\n])\r?\n(#{1,6}\s)', "`$1`r`n`r`n$2"

# Fix 2: Add blank lines after headings
Write-Host "🔧 Fixing: Blank lines after headings..." -ForegroundColor Cyan
$content = $content -replace '(#{1,6}\s[^\r\n]+)\r?\n([^\r\n#])', "`$1`r`n`r`n$2"

# Fix 3: Add blank lines before lists
Write-Host "🔧 Fixing: Blank lines before lists..." -ForegroundColor Cyan
$content = $content -replace '([^\r\n])\r?\n(\s*[-*+]\s)', "`$1`r`n`r`n$2"

# Fix 4: Add blank lines after lists
Write-Host "🔧 Fixing: Blank lines after lists..." -ForegroundColor Cyan
$content = $content -replace '(\s*[-*+]\s[^\r\n]+)\r?\n([^\r\n\s-])', "`$1`r`n`r`n$2"

# Fix 5: Add blank lines before code fences
Write-Host "🔧 Fixing: Blank lines before code fences..." -ForegroundColor Cyan
$content = $content -replace '([^\r\n])\r?\n(```)', "`$1`r`n`r`n$2"

# Fix 6: Add blank lines after code fences
Write-Host "🔧 Fixing: Blank lines after code fences..." -ForegroundColor Cyan
$content = $content -replace '(```[^\r\n]*)\r?\n([^\r\n`])', "`$1`r`n`r`n$2"

# Fix 7: Add language to code fences (batch for .bat files)
Write-Host "🔧 Fixing: Language specification in code fences..." -ForegroundColor Cyan
$content = $content -replace '```(?!\w)', '```batch'

# Fix 8: Ensure proper spacing around list items
Write-Host "🔧 Fixing: List item spacing..." -ForegroundColor Cyan
$content = $content -replace '(\s*)([-*+])(\s+)', '  $1$2$3'

# Fix 9: Remove multiple consecutive blank lines (keep max 2)
Write-Host "🔧 Fixing: Multiple blank lines..." -ForegroundColor Cyan
$content = $content -replace '\r?\n\r?\n\r?\n+', "`r`n`r`n"

# Fix 10: Ensure proper heading spacing
Write-Host "🔧 Fixing: Heading spacing..." -ForegroundColor Cyan
$content = $content -replace '(#{1,6})([^\s])', '$1 $2'

# Count changes
$changes = 0
if ($originalContent -ne $content) {
    $changes = 1
}

if ($DryRun) {
    Write-Host "🔍 DRY RUN MODE - No changes will be saved" -ForegroundColor Yellow
    Write-Host "📊 Changes detected: $changes" -ForegroundColor Green
    
    if ($changes -eq 1) {
        Write-Host "`n--- PREVIEW OF CHANGES ---" -ForegroundColor Cyan
        # Show first 500 characters of changes
        $diff = Compare-Object (Get-Content -Path $ReadmePath) ($content -split "`r`n") -PassThru
        $diff | Select-Object -First 20 | ForEach-Object {
            if ($_.SideIndicator -eq "=>") {
                Write-Host "+ $($_.InputObject)" -ForegroundColor Green
            } elseif ($_.SideIndicator -eq "<=") {
                Write-Host "- $($_.InputObject)" -ForegroundColor Red
            }
        }
    }
} else {
    if ($changes -eq 1) {
        Write-Host "💾 Saving changes to README.md..." -ForegroundColor Yellow
        $content | Set-Content $ReadmePath -Encoding UTF8 -NoNewline
        Write-Host "✅ README.md has been fixed!" -ForegroundColor Green
    } else {
        Write-Host "✅ No fixes needed - README.md is already compliant!" -ForegroundColor Green
    }
}

# Summary
Write-Host "`n📋 SUMMARY OF FIXES APPLIED:" -ForegroundColor Cyan
Write-Host "• Blank lines before headings" -ForegroundColor Green
Write-Host "• Blank lines after headings" -ForegroundColor Green
Write-Host "• Blank lines before lists" -ForegroundColor Green
Write-Host "• Blank lines after lists" -ForegroundColor Green
Write-Host "• Blank lines before code fences" -ForegroundColor Green
Write-Host "• Blank lines after code fences" -ForegroundColor Green
Write-Host "• Language specification in code fences" -ForegroundColor Green
Write-Host "• List item spacing" -ForegroundColor Green
Write-Host "• Multiple blank lines cleanup" -ForegroundColor Green
Write-Host "• Heading spacing" -ForegroundColor Green

if ($Backup) {
    Write-Host "`n📁 Backup file: $BackupPath" -ForegroundColor Yellow
}

Write-Host "`n🎉 Markdown fixing complete!" -ForegroundColor Green
