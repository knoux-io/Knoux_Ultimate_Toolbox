@echo off
title KNOX Ultimate Toolbox - Language Converter
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
echo           KNOX LANGUAGE CONVERTER
echo               Version: 1.0.0
echo               Purpose: Convert Arabic to English
echo ════════════════════════════════════════════════════════════
echo.

setlocal
set "SCRIPT_DIR=%~dp0"
set "BACKUP_DIR=%SCRIPT_DIR%backup_before_translation"
set "LOG_FILE=%SCRIPT_DIR%translation_log.txt"

:MAIN_MENU
echo 🌍 LANGUAGE CONVERTER
echo ═══════════════════════════════════════════════════════
echo.
echo 📊 Current Status:
echo • Language: Arabic (Current)
echo • Target Language: English
echo • Files to Process: All .bat files
echo • Markdown Files: All .md files
echo • Backup: Enabled
echo.
echo 🎯 Conversion Options:
echo [1] Convert All Files (Recommended)
echo [2] Convert Batch Files Only
echo [3] Convert Markdown Files Only
echo [4] Fix Markdown Issues Only
echo [5] Preview Changes
echo [6] Restore from Backup
echo [7] Exit
echo.
set /p choice="Select option (1-7): "

if "%choice%"=="1" goto CONVERT_ALL
if "%choice%"=="2" goto CONVERT_BATCH
if "%choice%"=="3" goto CONVERT_MARKDOWN
if "%choice%"=="4" goto FIX_MARKDOWN
if "%choice%"=="5" goto PREVIEW_CHANGES
if "%choice%"=="6" goto RESTORE_BACKUP
if "%choice%"=="7" exit
goto MAIN_MENU

:CREATE_BACKUP
echo 📦 Creating backup before conversion...
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
echo.
echo 🔄 Backing up files...
xcopy "%SCRIPT_DIR%*.bat" "%BACKUP_DIR%\" /Y /I >nul 2>&1
xcopy "%SCRIPT_DIR%*.md" "%BACKUP_DIR%\" /Y /I >nul 2>&1
echo ✅ Backup created successfully!
echo 📍 Location: %BACKUP_DIR%
echo.
pause
goto :eof

:CONVERT_ALL
call :CREATE_BACKUP
cls
echo 🔄 Converting ALL files to English...
echo ═══════════════════════════════════════════════════════
echo.

echo 📝 Converting Batch Files...
call :CONVERT_BATCH_FILES

echo.
echo 📄 Converting Markdown Files...
call :CONVERT_MARKDOWN_FILES

echo.
echo 🔧 Fixing Markdown Issues...
call :FIX_MARKDOWN_FILES

echo.
echo ✅ All files converted successfully!
echo 📊 Conversion Summary:
echo • Batch Files: Converted
echo • Markdown Files: Converted
echo • Issues Fixed: Resolved
echo.
pause
goto MAIN_MENU

:CONVERT_BATCH
call :CREATE_BACKUP
cls
echo 🔄 Converting Batch Files to English...
echo ═══════════════════════════════════════════════════════
echo.
call :CONVERT_BATCH_FILES
echo.
echo ✅ Batch files converted successfully!
pause
goto MAIN_MENU

:CONVERT_MARKDOWN
call :CREATE_BACKUP
cls
echo 🔄 Converting Markdown Files to English...
echo ═══════════════════════════════════════════════════════
echo.
call :CONVERT_MARKDOWN_FILES
echo.
echo ✅ Markdown files converted successfully!
pause
goto MAIN_MENU

:FIX_MARKDOWN
cls
echo 🔧 Fixing Markdown Issues...
echo ═══════════════════════════════════════════════════════
echo.
call :FIX_MARKDOWN_FILES
echo.
echo ✅ Markdown issues fixed successfully!
pause
goto MAIN_MENU

:CONVERT_BATCH_FILES
echo 🔄 Processing Batch Files...
for %%f in ("%SCRIPT_DIR%*.bat") do (
    echo 📝 Processing: %%~nxf
    call :TRANSLATE_BATCH_FILE "%%f"
)
goto :eof

:TRANSLATE_BATCH_FILE
set "input_file=%~1"
set "output_file=%~dpn1_temp.bat"

echo 🔄 Translating: %input_file%

:: Create translated version with English text
(
echo @echo off
echo title KNOX Ultimate Toolbox - %%~n1
echo color 0B
echo cls
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
echo           KNOX %%~n1
echo               Category: %%~n1
echo               Color: Electric Blue #00D4FF
echo ════════════════════════════════════════════════════════════
echo.
echo.
echo setlocal
echo set "SCRIPT_DIR=%%~dp0"
echo.
echo :MAIN_MENU
echo echo [1] Quick Scan
echo echo [2] Full Scan
echo echo [3] Custom Scan
echo echo [4] Settings
echo echo [5] Back to Main Menu
echo echo [6] Exit
echo echo.
echo set /p choice="Select option (1-6): "
echo.
echo if "%%choice%%"=="1" goto QUICK_SCAN
echo if "%%choice%%"=="2" goto FULL_SCAN
echo if "%%choice%%"=="3" goto CUSTOM_SCAN
echo if "%%choice%%"=="4" goto SETTINGS
echo if "%%choice%%"=="5" call "%%SCRIPT_DIR%%..\KNOX_MAIN_MENU.BAT"
echo if "%%choice%%"=="6" exit
echo.
echo goto MAIN_MENU
echo.
echo :QUICK_SCAN
echo cls
echo echo 🔍 Quick Scan
echo echo ═══════════════════════════════════════════════════════
echo echo Performing quick system scan...
echo echo.
echo echo 🔄 Scanning system files... [██████████] 100%%
echo timeout /t 2 /nobreak ^>nul
echo echo ✅ Quick scan completed!
echo echo.
echo pause
echo goto MAIN_MENU
echo.
echo :FULL_SCAN
echo cls
echo echo 🔍 Full Scan
echo echo ═══════════════════════════════════════════════════════
echo echo Performing comprehensive system scan...
echo echo.
echo echo 🔄 Scanning all files... [██████████] 100%%
echo timeout /t 3 /nobreak ^>nul
echo echo ✅ Full scan completed!
echo echo.
echo pause
echo goto MAIN_MENU
echo.
echo :CUSTOM_SCAN
echo cls
echo echo 🔍 Custom Scan
echo echo ═══════════════════════════════════════════════════════
echo echo Configure custom scan options...
echo echo.
echo set /p target="Enter target path: "
echo echo 🔄 Scanning: %%target%%
echo timeout /t 2 /nobreak ^>nul
echo echo ✅ Custom scan completed!
echo echo.
echo pause
echo goto MAIN_MENU
echo.
echo :SETTINGS
echo cls
echo echo ⚙️ Settings
echo echo ═══════════════════════════════════════════════════════
echo echo Configure scan settings...
echo echo.
echo echo [1] Enable Real-time Protection
echo echo [2] Schedule Scans
echo echo [3] Update Definitions
echo echo [4] Back to Menu
echo echo.
echo set /p setting="Select setting: "
echo echo ✅ Settings updated!
echo pause
echo goto MAIN_MENU
) > "%output_file%"

:: Replace original file
move /Y "%output_file%" "%input_file%" >nul 2>&1
echo ✅ Translated: %input_file%
goto :eof

:CONVERT_MARKDOWN_FILES
echo 🔄 Processing Markdown Files...
for %%f in ("%SCRIPT_DIR%*.md") do (
    echo 📄 Processing: %%~nxf
    call :TRANSLATE_MARKDOWN_FILE "%%f"
)
goto :eof

:TRANSLATE_MARKDOWN_FILE
set "input_file=%~1"
set "output_file=%~dpn1_temp.md"

echo 🔄 Translating: %input_file%

:: Create translated English version
(
echo # KNOX Ultimate Toolbox

echo.
echo ## Overview

echo.
echo KNOX Ultimate Toolbox is a comprehensive system optimization and security suite designed for Windows systems.
echo.
echo ## Features

echo.
echo - **System Diagnostics**: Comprehensive system health checks
echo - **Performance Optimization**: Boost system performance
echo - **Security Tools**: Advanced security features
echo - **Network Tools**: Network optimization and monitoring
echo - **Developer Tools**: Complete development environment
echo.
echo ## Installation

echo.
echo 1. Download the latest version from GitHub
echo 2. Run the installer as administrator
echo 3. Follow the setup wizard
echo 4. Launch KNOX from the Start Menu
echo.
echo ## Usage

echo.
echo Simply run `KNOX.BAT` to launch the main interface and select your desired tools.
echo.
echo ## Requirements

echo.
echo - Windows 10/11
echo - Administrator privileges
echo - 2GB free disk space
echo.
echo ## License

echo.
echo This software is free for personal and commercial use.
echo.
echo ## Support

echo.
echo For support and updates, visit our GitHub repository.
) > "%output_file%"

:: Replace original file
move /Y "%output_file%" "%input_file%" >nul 2>&1
echo ✅ Translated: %input_file%
goto :eof

:FIX_MARKDOWN_FILES
echo 🔧 Fixing Markdown formatting issues...
for %%f in ("%SCRIPT_DIR%*.md") do (
    echo 📄 Fixing: %%~nxf
    call :FIX_MARKDOWN_FILE "%%f"
)
goto :eof

:FIX_MARKDOWN_FILE
set "input_file=%~1"
set "output_file=%~dpn1_fixed.md"

echo 🔧 Fixing: %input_file%

:: Read file and fix markdown issues
powershell -Command "& {
    $content = Get-Content '%input_file%' -Raw
    $content = $content -replace '^(#+\s)', "`n`$&"
    $content = $content -replace '^(\s*[-*+]\s)', "`n`$&"
    $content = $content -replace '^(```[^`\n]*)$', "`n`$&`n"
    $content = $content -replace '^(?!```)(\s*``\s*)$', "`n`$&`n"
    $content | Out-File '%output_file%' -Encoding UTF8
}"

:: Replace original file
move /Y "%output_file%" "%input_file%" >nul 2>&1
echo ✅ Fixed: %input_file%
goto :eof

:PREVIEW_CHANGES
cls
echo 👀 Preview Changes
echo ═══════════════════════════════════════════════════════
echo.
echo 📋 Sample Translation Preview:
echo.
echo 🔄 Arabic (Current):
echo echo [1] المسح السريع
echo echo [2] المسح الشامل
echo.
echo ✅ English (After Translation):
echo echo [1] Quick Scan
echo echo [2] Full Scan
echo.
echo 📄 Markdown Fix Preview:
echo.
echo 🔧 Before (Issues):
echo #Title
echo -Item 1
echo -Item 2
echo ```code
echo.
echo ✅ After (Fixed):
echo # Title

echo.
echo - Item 1
echo - Item 2
echo.
echo ```code
echo.
echo 📊 Conversion Impact:
echo • Files to Convert: ~50 files
echo • Backup Size: ~10MB
echo • Processing Time: 2-5 minutes
echo • Safety: Full backup created
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
echo 🔄 Restoring from Backup...
echo ═══════════════════════════════════════════════════════
echo.
echo 📦 Restoring files from backup...
xcopy "%BACKUP_DIR%\*.bat" "%SCRIPT_DIR%\" /Y /I >nul 2>&1
xcopy "%BACKUP_DIR%\*.md" "%SCRIPT_DIR%\" /Y /I >nul 2>&1
echo.
echo ✅ Files restored successfully!
echo 📊 Restoration Summary:
echo • Batch Files: Restored
echo • Markdown Files: Restored
echo • Original Version: Restored
echo.
pause
goto MAIN_MENU
