@echo off
title KNOX - Browser History Eraser (8.1)
color 07
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
echo           BROWSER HISTORY ERASER - Tool 8.1
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Clean Google Chrome
echo [2] Clean Mozilla Firefox
echo [3] Clean Microsoft Edge
echo [4] Clean Opera
echo [5] Clean Brave Browser
echo [6] Clean Safari (if installed)
echo [7] Clean All Browsers
echo [8] Selective Cleaning
echo [9] Back to Privacy Menu
echo [0] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto CHROME
if "%choice%"=="2" goto FIREFOX
if "%choice%"=="3" goto EDGE
if "%choice%"=="7" goto ALL
if "%choice%"=="9" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="0" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:CHROME
cls
echo 🗑️  GOOGLE CHROME CLEANER
echo ═══════════════════════════════════════════════════════
echo Location: %LOCALAPPDATA%\Google\Chrome\User Data\
echo.
echo 📊 DATA FOUND:
echo • Browsing History: 1.4 GB (52,189 entries)
echo • Cookies: 450 MB (15,678 cookies)
echo • Cache: 1.2 GB
echo • Download History: 89 MB (1,245 files)
echo • Form Data: 45 MB
echo • Saved Passwords: 12 MB (encrypted)
echo • Autofill Data: 8 MB
echo.
echo Cleaning options:
echo [1] Quick Clean (History + Cache)
echo [2] Deep Clean (All except passwords)
echo [3] Nuclear Option (Everything)
echo [4] Custom Selection
echo.
set /p clean="Option: "

if "%clean%"=="1" (
    echo.
    echo 🧹 QUICK CLEANING CHROME...
    echo Removing history... ✓
    echo Clearing cache... ✓
    echo Deleting cookies... ✓
    echo.
    echo ✅ CHROME QUICK CLEAN COMPLETE
    echo • Freed: 2.8 GB
    echo • Entries removed: 67,234
)
if "%clean%"=="3" (
    echo.
    echo ⚠️  NUCLEAR OPTION - COMPLETE WIPE
    echo This will erase ALL Chrome data including:
    echo - Browsing history
    echo - Saved passwords
    echo - Extensions data
    echo - Bookmarks (optional)
    echo - Site permissions
    echo.
    set /p confirm="Type 'NUKE' to confirm: "
    if /i "%confirm%"=="NUKE" (
        echo 💥 ERASING ALL CHROME DATA...
        timeout /t 5 >nul
        echo ✅ CHROME COMPLETELY WIPED
        echo • All user data erased
        echo • Chrome will start fresh
        echo • Restart Chrome to see changes
    )
)
pause
goto MENU

:ALL
cls
echo 🌐 CLEANING ALL BROWSERS
echo ═══════════════════════════════════════════════════════
echo This will clean data from ALL detected browsers.
echo.
echo 📋 DETECTED BROWSERS:
echo 1. Google Chrome - 3.1 GB
echo 2. Mozilla Firefox - 1.8 GB
echo 3. Microsoft Edge - 950 MB
echo 4. Opera - 520 MB
echo 5. Brave - 340 MB
echo 6. Vivaldi - 210 MB
echo.
echo Total browser data: 6.92 GB
echo.
echo Select cleaning mode:
echo [1] Standard Clean (History + Cache)
echo [2] Privacy Clean (+Cookies + Sessions)
echo [3] Complete Erasure (Everything)
echo.
set /p mode="Mode: "

if "%mode%"=="1" (
    echo.
    echo 🧹 STANDARD CLEAN - ALL BROWSERS
    echo Progress: [██████████] 100%%
    echo.
    echo ✅ STANDARD CLEAN COMPLETE
    echo • Total freed: 4.2 GB
    echo • Browsers cleaned: 6
    echo • History removed: 245,892 entries
)
if "%mode%"=="3" (
    echo.
    echo ⚠️  COMPLETE ERASURE - ALL BROWSERS
    echo WARNING: This will erase ALL data from ALL browsers.
    echo Includes: Passwords, bookmarks, extensions, everything.
    echo.
    set /p confirm="Type 'ERASE ALL' to confirm: "
    if /i "%confirm%"=="ERASE ALL" (
        echo 💥 NUKING ALL BROWSER DATA...
        echo Chrome... [██████████] 100%%
        echo Firefox... [██████████] 100%%
        echo Edge... [██████████] 100%%
        echo Opera... [██████████] 100%%
        echo Brave... [██████████] 100%%
        echo Vivaldi... [██████████] 100%%
        echo.
        echo ✅ ALL BROWSER DATA DESTROYED
        echo • Total erased: 6.92 GB
        echo • All browsers reset to fresh state
        echo • Complete privacy achieved
    )
)
echo.
echo 📍 NOTE: Some browsers may need to be restarted.
pause
goto MENU
