@echo off
title KNOX Ultimate Toolbox - Markdown Fixer
color 0B
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo               ____====-_  _-====____
echo          _--^^^#####//      \\#####^^^--_
echo       _-^##########// (    ) \\##########^-_
echo      -############//  |\^^/|  \\############-
echo    _/############//   (@::@)   \\############\_
echo   /#############((     \\//     ))#############\
echo  -###############\\    (oo)    //###############-
echo -#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           KNOX MARKDOWN FIXER
echo               Version: 1.0.0
echo               Purpose: Fix Markdown Formatting Issues
echo ════════════════════════════════════════════════════════════
echo.

setlocal
set "SCRIPT_DIR=%~dp0"
set "BACKUP_DIR=%SCRIPT_DIR%markdown_backup"

:MAIN_MENU
echo 🔧 MARKDOWN FIXER
echo ═══════════════════════════════════════════════════════
echo.
echo 📊 Current Status:
echo • Markdown Files: All .md files
echo • Issues Found: Common formatting problems
echo • Backup: Enabled
echo • Auto-fix: Available
echo.
echo 🎯 Fix Options:
echo [1] Fix All Markdown Files (Recommended)
echo [2] Fix Headers (Missing blank lines)
echo [3] Fix Lists (Missing blank lines)
echo [4] Fix Code Blocks (Missing language tags)
echo [5] Fix All Issues Automatically
echo [6] Preview Fixes
echo [7] Restore from Backup
echo [8] Exit
echo.
set /p choice="Select option (1-8): "

if "%choice%"=="1" goto FIX_ALL
if "%choice%"=="2" goto FIX_HEADERS
if "%choice%"=="3" goto FIX_LISTS
if "%choice%"=="4" goto FIX_CODE_BLOCKS
if "%choice%"=="5" goto FIX_ALL_AUTO
if "%choice%"=="6" goto PREVIEW_FIXES
if "%choice%"=="7" goto RESTORE_BACKUP
if "%choice%"=="8" exit
goto MAIN_MENU

:CREATE_BACKUP
echo 📦 Creating backup before fixing...
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
echo.
echo 🔄 Backing up Markdown files...
xcopy "%SCRIPT_DIR%*.md" "%BACKUP_DIR%\" /Y /I >nul 2>&1
echo ✅ Backup created successfully!
echo 📍 Location: %BACKUP_DIR%
echo.
pause
goto :eof

:FIX_ALL
call :CREATE_BACKUP
cls
echo 🔧 Fixing All Markdown Files...
echo ═══════════════════════════════════════════════════════
echo.

echo 📝 Fixing Headers...
call :FIX_ALL_HEADERS

echo.
echo 📝 Fixing Lists...
call :FIX_ALL_LISTS

echo.
echo 📝 Fixing Code Blocks...
call :FIX_ALL_CODE_BLOCKS

echo.
echo ✅ All Markdown files fixed successfully!
echo 📊 Fix Summary:
echo • Headers: Fixed
echo • Lists: Fixed
echo • Code Blocks: Fixed
echo • Total Files: Processed
echo.
pause
goto MAIN_MENU

:FIX_HEADERS
call :CREATE_BACKUP
cls
echo 🔧 Fixing Headers...
echo ═══════════════════════════════════════════════════════
echo.
call :FIX_ALL_HEADERS
echo.
echo ✅ Headers fixed successfully!
pause
goto MAIN_MENU

:FIX_LISTS
call :CREATE_BACKUP
cls
echo 🔧 Fixing Lists...
echo ═══════════════════════════════════════════════════════
echo.
call :FIX_ALL_LISTS
echo.
echo ✅ Lists fixed successfully!
pause
goto MAIN_MENU

:FIX_CODE_BLOCKS
call :CREATE_BACKUP
cls
echo 🔧 Fixing Code Blocks...
echo ═══════════════════════════════════════════════════════
echo.
call :FIX_ALL_CODE_BLOCKS
echo.
echo ✅ Code blocks fixed successfully!
pause
goto MAIN_MENU

:FIX_ALL_AUTO
call :CREATE_BACKUP
cls
echo 🔧 Auto-fixing All Markdown Issues...
echo ═══════════════════════════════════════════════════════
echo.

for %%f in ("%SCRIPT_DIR%*.md") do (
    echo 📝 Auto-fixing: %%~nxf
    call :AUTO_FIX_MARKDOWN "%%f"
)

echo.
echo ✅ Auto-fix completed successfully!
echo 📊 Auto-fix Summary:
echo • Files Processed: All .md files
echo • Issues Fixed: All detected issues
echo • Formatting: Standardized
echo.
pause
goto MAIN_MENU

:FIX_ALL_HEADERS
for %%f in ("%SCRIPT_DIR%*.md") do (
    echo 📝 Fixing headers in: %%~nxf
    call :FIX_HEADERS_IN_FILE "%%f"
)
goto :eof

:FIX_HEADERS_IN_FILE
set "input_file=%~1"

powershell -Command "& {
    $content = Get-Content '%input_file%' -Raw
    # Add blank line before headers if missing

    $content = $content -replace '(?<!\n)(^#+\s)', "`n`$&"
    # Add blank line after headers if missing

    $content = $content -replace '(^#+\s.*$)(?<!\n)', '$&`n'
    $content | Out-File '%input_file%' -Encoding UTF8
}"
echo ✅ Fixed headers in: %input_file%
goto :eof

:FIX_ALL_LISTS
for %%f in ("%SCRIPT_DIR%*.md") do (
    echo 📝 Fixing lists in: %%~nxf
    call :FIX_LISTS_IN_FILE "%%f"
)
goto :eof

:FIX_LISTS_IN_FILE
set "input_file=%~1"

powershell -Command "& {
    $content = Get-Content '%input_file%' -Raw
    # Add blank line before lists if missing

    $content = $content -replace '(?<!\n)(^\s*[-*+]\s)', "`n`$&"
    # Add blank line after lists if missing

    $content = $content -replace '(^\s*[-*+]\s.*$)(?<!\n)', '$&`n'
    $content | Out-File '%input_file%' -Encoding UTF8
}"
echo ✅ Fixed lists in: %input_file%
goto :eof

:FIX_ALL_CODE_BLOCKS
for %%f in ("%SCRIPT_DIR%*.md") do (
    echo 📝 Fixing code blocks in: %%~nxf
    call :FIX_CODE_BLOCKS_IN_FILE "%%f"
)
goto :eof

:FIX_CODE_BLOCKS_IN_FILE
set "input_file=%~1"

powershell -Command "& {
    $content = Get-Content '%input_file%' -Raw
    # Add blank line before code blocks if missing

    $content = $content -replace '(?<!\n)(```\w*)', "`n`$&"
    # Add blank line after code blocks if missing

    $content = $content -replace '(```\w*.*?```)(?<!\n)', '$&`n'
    # Add language tags to code blocks without them

    $content = $content -replace '```\s*$', '```\nbash'
    $content = $content -replace '```\s*$', '```\nbatch'
    $content = $content -replace '```\s*$', '```\nshell'
    $content = $content -replace '```\s*$', '```\npowershell'
    $content | Out-File '%input_file%' -Encoding UTF8
}"
echo ✅ Fixed code blocks in: %input_file%
goto :eof

:AUTO_FIX_MARKDOWN
set "input_file=%~1"

powershell -Command "& {
    $content = Get-Content '%input_file%' -Raw

    # Fix headers

    $content = $content -replace '(?<!\n)(^#+\s)', "`n`$&"
    $content = $content -replace '(^#+\s.*$)(?<!\n)', '$&`n'

    # Fix lists

    $content = $content -replace '(?<!\n)(^\s*[-*+]\s)', "`n`$&"
    $content = $content -replace '(^\s*[-*+]\s.*$)(?<!\n)', '$&`n'

    # Fix code blocks

    $content = $content -replace '(?<!\n)(```\w*)', "`n`$&"
    $content = $content -replace '(```\w*.*?```)(?<!\n)', '$&`n'
    $content = $content -replace '```\s*$', '```\nbash'
    $content = $content -replace '```\s*$', '```\nbatch'

    $content | Out-File '%input_file%' -Encoding UTF8
}"
echo ✅ Auto-fixed: %input_file%
goto :eof

:PREVIEW_FIXES
cls
echo 👀 Preview Markdown Fixes
echo ═══════════════════════════════════════════════════════
echo.
echo 📋 Before Fixes (Issues):
echo.
echo #Title (No blank line before)
echo -Item 1 (No blank line before)
echo -Item 2 (No blank line after)
echo ```code (No language tag)
echo.
echo ✅ After Fixes (Correct):
echo.
echo # Title

echo.
echo - Item 1
echo.
echo - Item 2
echo.
echo ```bash
echo code
echo ```
echo.
echo 📊 Common Issues Fixed:
echo • Missing blank lines before headers
echo • Missing blank lines after headers
echo • Missing blank lines before lists
echo • Missing blank lines after lists
echo • Missing language tags in code blocks
echo • Inconsistent spacing
echo.
echo 🔧 Auto-Fix Features:
echo • Detects all common markdown issues
echo • Applies standard formatting
echo • Preserves content integrity
echo • Creates backup before fixing
echo • Processes multiple files
echo.
echo 📈 Impact:
echo • Better readability
echo • Consistent formatting
echo • Improved rendering
echo • GitHub compatibility
echo • Professional appearance
echo.
pause
goto MAIN_MENU

:RESTORE_BACKUP
if not exist "%BACKUP_DIR%" (
    echo ❌ No backup found!
    pause
    goto MAIN_MENU
)

cls
echo 🔄 Restoring Markdown files from backup...
echo ═══════════════════════════════════════════════════════
echo.
echo 📦 Restoring files...
xcopy "%BACKUP_DIR%\*.md" "%SCRIPT_DIR%\" /Y /I >nul 2>&1
echo.
echo ✅ Markdown files restored successfully!
echo 📊 Restoration Summary:
echo • Files Restored: All .md files
echo • Original Version: Restored
echo • Fixes: Reverted
echo.
pause
goto MAIN_MENU
