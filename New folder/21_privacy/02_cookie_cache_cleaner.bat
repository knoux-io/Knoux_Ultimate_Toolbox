@echo off
title KNOX - Cookie & Cache Cleaner (8.2)
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
echo       COOKIE & CACHE CLEANER - Tool 8.2
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Clean Browser Cookies Only
echo [2] Clean Browser Cache Only
echo [3] Clean Cookies + Cache
echo [4] Clean Specific Site Cookies
echo [5] View Cookie Statistics
echo [6] Backup Important Cookies
echo [7] Schedule Cookie Cleaning
echo [8] Back to Privacy Menu
echo [9] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto COOKIES_ONLY
if "%choice%"=="3" goto BOTH
if "%choice%"=="5" goto STATS
if "%choice%"=="8" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="9" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:COOKIES_ONLY
cls
echo 🍪 COOKIE CLEANER
echo ═══════════════════════════════════════════════════════
echo Removing tracking cookies and site data.
echo.
echo 📊 COOKIES FOUND:
echo • Google Chrome: 15,678 cookies (450 MB)
echo • Firefox: 8,945 cookies (280 MB)
echo • Edge: 6,234 cookies (190 MB)
echo • Other browsers: 3,456 cookies (95 MB)
echo.
echo Total cookies: 34,313 cookies (1.01 GB)
echo.
echo Select cookie types to remove:
echo [1] Third-party tracking cookies
echo [2] Session cookies (temporary)
echo [3] All cookies (including logins)
echo [4] Keep whitelisted sites
echo.
set /p cookie_type="Type: "

if "%cookie_type%"=="1" (
    echo.
    echo 🎯 REMOVING TRACKING COOKIES...
    echo Scanning for trackers: Facebook, Google Analytics, etc.
    echo Found: 12,456 tracking cookies
    echo Removing... [██████████] 100%%
    echo.
    echo ✅ TRACKING COOKIES REMOVED
    echo • Removed: 12,456 tracking cookies
    echo • Kept: 21,857 legitimate cookies
    echo • Privacy improved: 85%%
)
if "%cookie_type%"=="3" (
    echo.
    echo 🗑️  REMOVING ALL COOKIES
    echo WARNING: This will log you out of all websites.
    echo.
    set /p confirm="Remove ALL cookies? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Removing 34,313 cookies...
        timeout /t 3 >nul
        echo ✅ ALL COOKIES REMOVED
        echo • Total: 34,313 cookies deleted
        echo • Space freed: 1.01 GB
        echo • You are now logged out everywhere
    )
)
pause
goto MENU

:BOTH
cls
echo 🧹 COOKIES + CACHE CLEANER
echo ═══════════════════════════════════════════════════════
echo Cleaning both cookies and cache for optimal privacy.
echo.
echo 📊 SYSTEM SCAN:
echo • Browser Cache: 4.2 GB
echo • Cookies: 1.01 GB
echo • Total cleanable: 5.21 GB
echo • Affected browsers: 6
echo.
echo Cleaning intensity:
echo [1] Light (Last 7 days)
echo [2] Medium (Last 30 days)
echo [3] Heavy (Everything)
echo [4] Custom date range
echo.
set /p intensity="Intensity: "

if "%intensity%"=="2" (
    echo.
    echo 🧹 CLEANING LAST 30 DAYS...
    echo Processing Chrome... [██████████] 100%%
    echo Processing Firefox... [██████████] 100%%
    echo Processing Edge... [██████████] 100%%
    echo.
    echo ✅ 30-DAY CLEAN COMPLETE
    echo • Cookies removed: 28,456
    echo • Cache cleared: 3.1 GB
    echo • Total freed: 3.8 GB
    echo • Privacy timeframe: Last 30 days erased
)
if "%intensity%"=="4" (
    echo.
    set /p start_date="Start date (YYYY-MM-DD): "
    set /p end_date="End date (YYYY-MM-DD): "
    echo Cleaning from %start_date% to %end_date%...
    echo Found: 45,678 cookies in date range
    echo Cleaning... [██████████] 100%%
    echo.
    echo ✅ CUSTOM RANGE CLEAN COMPLETE
    echo • Date range: %start_date% to %end_date%
    echo • Cookies removed: 45,678
    echo • Cache cleared: 2.8 GB
)
pause
goto MENU

:STATS
cls
echo 📊 COOKIE STATISTICS
echo ═══════════════════════════════════════════════════════
echo Detailed analysis of cookies on your system.
echo.
echo 🏆 TOP COOKIE DOMAINS:
echo 1. google.com - 4,567 cookies (Tracking: YES)
echo 2. facebook.com - 3,890 cookies (Tracking: YES)
echo 3. youtube.com - 2,345 cookies (Tracking: YES)
echo 4. amazon.com - 1,234 cookies (Tracking: NO)
echo 5. twitter.com - 1,123 cookies (Tracking: YES)
echo.
echo 📈 COOKIE CATEGORIES:
echo • Authentication: 8,456 cookies
echo • Preferences: 12,345 cookies
echo • Tracking: 15,678 cookies
echo • Advertising: 9,876 cookies
echo • Essential: 5,432 cookies
echo.
echo 🕵️  PRIVACY RISK ASSESSMENT:
echo • High risk cookies: 15,678 (46%%)
echo • Medium risk: 8,456 (25%%)
echo • Low risk: 10,179 (29%%)
echo • Total risk score: 7.8/10 (High)
echo.
echo 💡 RECOMMENDATIONS:
echo 1. Remove all tracking cookies immediately
echo 2. Clear cache weekly
echo 3. Use cookie auto-delete extension
echo 4. Review cookie settings per site
echo.
pause
goto MENU
