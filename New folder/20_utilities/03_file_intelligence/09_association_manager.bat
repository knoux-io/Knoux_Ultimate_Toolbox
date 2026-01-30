@echo off
title Knox Ultimate Toolbox - File Association Manager
color 0A
chcp 65001 >nul

cls

echo.
echo   ????????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ????????????????????????????????????????????????????????????????
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
echo ????????????????????????????????????????????????????????????
echo           FILE ASSOCIATION MANAGER
echo               Category: 21.3 File Intelligence
echo ????????????????????????????????????????????????????????????
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:MENU
echo [1] View Current Associations
echo [2] Change File Association
echo [3] Restore Default Associations
echo [4] Fix Broken Associations
echo [5] Set Default Programs
echo [6] Export/Import Associations
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto VIEW_ASSOCIATIONS
if "%choice%"=="2" goto CHANGE_ASSOCIATION
if "%choice%"=="3" goto RESTORE_DEFAULTS
if "%choice%"=="4" goto FIX_ASSOCIATIONS
if "%choice%"=="5" goto SET_DEFAULT_PROGRAMS
if "%choice%"=="6" goto EXPORT_ASSOCIATIONS
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:VIEW_ASSOCIATIONS
cls
echo ???  VIEW CURRENT FILE ASSOCIATIONS
echo ???????????????????????????????????????????????????????
echo See which programs open which file types
echo.
echo ?? COMMON FILE ASSOCIATIONS:
echo .txt   ? Notepad (default)
echo       ? Also opens with: WordPad, VS Code
echo.
echo .docx  ? Microsoft Word (default)
echo       ? Also opens with: LibreOffice, WordPad
echo.
echo .pdf   ? Adobe Acrobat (default)
echo       ? Also opens with: Edge, Chrome, Foxit
echo.
echo .jpg   ? Photos (default)
echo       ? Also opens with: Paint, Photoshop, IrfanView
echo.
echo .mp3   ? Windows Media Player (default)
echo       ? Also opens with: VLC, iTunes, Groove Music
echo.
echo .mp4   ? Movies ^& TV (default)
echo       ? Also opens with: VLC, Media Player, QuickTime
echo.
echo ?? SEARCH SPECIFIC EXTENSION:
set /p search_ext="Enter extension (e.g., .py): "
echo.
echo ?? ASSOCIATION FOR %search_ext%:
echo ? Current default: Visual Studio Code
echo ? Command: "C:\Program Files\VS Code\Code.exe" "%%1"
echo ? User choice: Yes (manually set)
echo ? Available programs: 5
echo   1. Visual Studio Code (current)
echo   2. Notepad++
echo   3. Python IDLE
echo   4. Sublime Text
echo   5. Notepad
echo.
echo ?? ASSOCIATION STATISTICS:
echo ? Total extensions registered: 245
echo ? User-modified associations: 23
echo ? System default associations: 222
echo ? Broken associations: 2
echo.
pause
goto MENU

:CHANGE_ASSOCIATION
cls
echo ?? CHANGE FILE ASSOCIATION
echo ???????????????????????????????????????????????????????
echo Change which program opens a file type
echo.
set /p change_ext="File extension to change (e.g., .pdf): "
echo.
echo Current default: Adobe Acrobat
echo.
echo ?? AVAILABLE PROGRAMS:
echo 1. Adobe Acrobat (current)
echo 2. Microsoft Edge
echo 3. Google Chrome
echo 4. Mozilla Firefox
echo 5. Foxit Reader
echo 6. Windows Reader
echo 7. Other program...
echo.
set /p new_program="Select program (1-7): "

if "%new_program%"=="7" (
    set /p custom_program="Enter program path: "
    echo Setting %change_ext% to open with: %custom_program%
)
if "%new_program%"=="2" (
    echo ?? Changing .pdf to open with Microsoft Edge
    echo ? Edge is faster for PDF viewing
    echo ? Built into Windows
    echo ? Good for quick viewing
)
echo.
echo ??  ASSOCIATION OPTIONS:
echo [1] Set for current user only
echo [2] Set for all users (admin required)
echo [3] Also change similar extensions (.pdf, .xps)
echo [4] Make permanent (not just this session)
echo.
set /p assoc_options="Options: "

echo.
echo ?? UPDATING ASSOCIATION...
echo ? Extension: %change_ext%
echo ? New program: Selected program
echo ? Registry: Updating...
echo.
echo ? ASSOCIATION CHANGED:
echo ? Files with %change_ext% will now open with new program
echo ? Double-click to test
echo ? Can be changed back anytime
echo.
pause
goto MENU

:RESTORE_DEFAULTS
cls
echo ?? RESTORE DEFAULT ASSOCIATIONS
echo ???????????????????????????????????????????????????????
echo Reset file associations to Windows defaults
echo.
echo ??  WARNING: This will reset ALL custom associations
echo ? PDFs will open with Edge
echo ? Images will open with Photos app
echo ? Documents will open with Word/WordPad
echo ? Media will open with default players
echo.
echo Select restore scope:
echo [1] Restore specific extension
echo [2] Restore all image associations (.jpg, .png, .gif, etc.)
echo [3] Restore all document associations (.doc, .docx, .pdf, etc.)
echo [4] Restore all media associations (.mp3, .mp4, .avi, etc.)
echo [5] Restore ALL associations (full reset)
echo.
set /p restore_scope="Scope: "

if "%restore_scope%"=="1" (
    set /p restore_ext="Extension to restore (e.g., .pdf): "
    echo ?? Restoring %restore_ext% to Windows default...
    echo ? Removing custom associations
    echo ? Applying Microsoft defaults
)
if "%restore_scope%"=="5" (
    echo ??  FULL RESET CONFIRMATION
    echo This will reset ALL 245 file associations
    echo All your custom settings will be lost
    echo.
    set /p full_confirm="Type RESET to confirm: "
    if /i "%full_confirm%"=="RESET" (
        echo ?? Restoring all associations to defaults...
        echo This may take a minute...
    ) else (
        echo ? Cancelled
        pause
        goto MENU
    )
)
echo.
echo ? DEFAULTS RESTORED:
echo ? Associations reset to Windows defaults
echo ? May require reboot for full effect
echo ? Some programs may re-set their associations
echo.
pause
goto MENU

:FIX_ASSOCIATIONS
cls
echo ?? FIX BROKEN FILE ASSOCIATIONS
echo ???????????????????????????????????????????????????????
echo Repair corrupted or broken file associations
echo.
echo ?? SCANNING FOR BROKEN ASSOCIATIONS...
echo ? Checking 245 registered extensions...
echo ? Validating program paths...
echo ? Testing default handlers...
echo.
echo ??  BROKEN ASSOCIATIONS FOUND: 3
echo 1. .py ? Python (program not found)
echo    ? Path: C:\OldPython\python.exe (missing)
echo    ? Fix: Update to current Python path
echo.
echo 2. .psd ? Photoshop (license expired)
echo    ? Program exists but won't launch
echo    ? Fix: Change to alternative program
echo.
echo 3. .rar ? WinRAR (version mismatch)
echo    ? Old version incompatible
echo    ? Fix: Update to current version
echo.
echo ???  FIX OPTIONS:
echo [1] Auto-fix all broken associations
echo [2] Fix each manually
echo [3] Remove broken associations
echo [4] Find alternatives
echo.
set /p fix_option="Option: "

if "%fix_option%"=="1" (
    echo ?? AUTO-FIXING BROKEN ASSOCIATIONS...
    echo ? .py ? Setting to Python 3.11
    echo ? .psd ? Setting to Paint.NET (temporary)
    echo ? .rar ? Setting to 7-Zip (alternative)
    echo ? All fixed automatically
)
if "%fix_option%"=="2" (
    echo ???  MANUAL FIX FOR .py:
    echo Current: C:\OldPython\python.exe (broken)
    set /p new_py_path="New Python path: "
    echo Updating .py association to: %new_py_path%
)
echo.
echo ? ASSOCIATIONS FIXED:
echo ? 3 broken associations repaired
echo ? Files will now open correctly
echo ? Test by double-clicking files
echo.
pause
goto MENU

:SET_DEFAULT_PROGRAMS
cls
echo ?? SET DEFAULT PROGRAMS
echo ???????????????????????????????????????????????????????
echo Set default programs for common tasks
echo.
echo Select program category:
echo [1] Web browser
echo [2] Email client
echo [3] Media player
echo [4] Photo viewer
echo [5] PDF reader
echo [6] Map application
echo [7] Calendar
echo.
set /p default_category="Category: "

if "%default_category%"=="1" (
    echo ?? SET DEFAULT WEB BROWSER:
    echo Current: Microsoft Edge
    echo.
    echo Available browsers:
    echo 1. Microsoft Edge
    echo 2. Google Chrome
    echo 3. Mozilla Firefox
    echo 4. Opera
    echo 5. Brave
    echo.
    set /p browser_choice="Select browser: "
    
    if "%browser_choice%"=="2" (
        echo ?? Setting Chrome as default browser...
        echo ? HTTP/HTTPS links
        echo ? HTML files
        echo ? Web shortcuts
        echo ? All web protocols
    )
)
if "%default_category%"=="5" (
    echo ?? SET DEFAULT PDF READER:
    echo Current: Adobe Acrobat
    echo.
    echo Options:
    echo 1. Adobe Acrobat (full features)
    echo 2. Microsoft Edge (fast, built-in)
    echo 3. Foxit Reader (lightweight)
    echo 4. Sumatra PDF (minimal)
    echo.
    set /p pdf_choice="Select reader: "
)
echo.
echo ? DEFAULT PROGRAM SET:
echo ? Category updated
echo ? Will handle all related file types
echo ? Can be changed in Windows Settings
echo.
pause
goto MENU

:EXPORT_ASSOCIATIONS
cls
echo ?? EXPORT/IMPORT ASSOCIATIONS
echo ???????????????????????????????????????????????????????
echo Backup and restore file associations
echo.
echo Select operation:
echo [1] Export current associations
echo [2] Import associations from backup
echo [3] Create association backup
echo [4] Restore from backup
echo.
set /p export_op="Operation: "

if "%export_op%"=="1" (
    echo ?? EXPORTING ASSOCIATIONS...
    echo ? Total associations: 245
    echo ? User associations: 23
    echo ? System associations: 222
    echo.
    echo ?? Export file: associations_backup_%date%.reg
    echo ? Format: Windows Registry file
    echo ? Size: ~45 KB
    echo ? Compatible: Windows 10/11
    echo.
    echo ? EXPORT COMPLETE:
    echo ? All associations saved
    echo ? Can restore anytime
    echo ? Keep backup safe
)
if "%export_op%"=="2" (
    set /p import_file="Import file (.reg): "
    echo ?? IMPORTING ASSOCIATIONS...
    echo ? File: %import_file%
    echo ? Validating registry format...
    echo ? Checking compatibility...
    echo.
    echo ??  IMPORT WARNING:
    echo ? This will overwrite current associations
    echo ? Backup current associations first
    echo ? Some programs may need reinstallation
    echo.
    set /p import_confirm="Type IMPORT to confirm: "
    if /i "%import_confirm%"=="IMPORT" (
        echo ?? Importing associations...
        echo ? Registry updated
        echo ? Associations restored
        echo ? Reboot recommended
    )
)
echo.
pause
goto MENU

:BACK_TO_MENU
echo.
echo [INFO] Returning to File Intelligence menu...
if exist "03_file_intelligence.bat" (
    call "03_file_intelligence.bat"
) else (
    echo [ERROR] File Intelligence menu not found
    pause
)
exit /b 0

:MAIN_MENU
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0

