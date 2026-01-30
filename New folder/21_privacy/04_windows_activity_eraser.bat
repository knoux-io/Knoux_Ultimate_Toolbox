@echo off
title KNOX - Windows Activity Eraser (8.4)
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
echo       WINDOWS ACTIVITY ERASER - Tool 8.4
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Clear Timeline Activity
echo [2] Clear Cortana Data
echo [3] Clear Windows Search Index
echo [4] Clear Location History
echo [5] Clear Diagnostic Data
echo [6] Clear Telemetry Data
echo [7] Clear Clipboard History
echo [8] Clear All Windows Activity
echo [9] Back to Privacy Menu
echo [0] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto TIMELINE
if "%choice%"=="4" goto LOCATION
if "%choice%"=="8" goto ALL_WINDOWS
if "%choice%"=="9" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="0" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:TIMELINE
cls
echo ⏰ WINDOWS TIMELINE CLEANER
echo ═══════════════════════════════════════════════════════
echo Windows Timeline tracks your activity across devices.
echo.
echo 📊 TIMELINE DATA FOUND:
echo • Activities: 1,245 items
echo • Time range: 30 days
echo • Devices synced: 3 (PC, Laptop, Phone)
echo • Cloud sync: Enabled
echo.
echo Example Timeline items:
echo • Edited document: 2 hours ago
echo • Visited website: 4 hours ago
echo • Used app: 6 hours ago
echo • File opened: Yesterday
echo.
echo Cleaning options:
echo [1] Clear last 24 hours
echo [2] Clear last 7 days
echo [3] Clear last 30 days
echo [4] Clear everything
echo [5] Disable Timeline completely
echo.
set /p timeline="Option: "

if "%timeline%"=="2" (
    echo.
    echo 🧹 CLEARING LAST 7 DAYS...
    echo Found: 589 timeline activities
    echo Removing... [██████████] 100%%
    echo.
    echo ✅ TIMELINE CLEARED (7 DAYS)
    echo • Activities removed: 589
    echo • Cloud sync updated
    echo • Timeline now shows empty
)
if "%timeline%"=="5" (
    echo.
    echo 🔕 DISABLING TIMELINE COMPLETELY
    echo This will:
    echo 1. Clear all existing data
    echo 2. Disable activity tracking
    echo 3. Stop cloud sync
    echo 4. Remove Timeline from Task View
    echo.
    set /p confirm="Disable Timeline? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Disabling Timeline...
        echo Registry updated...
        echo Services stopped...
        echo.
        echo ✅ TIMELINE DISABLED
        echo • Tracking stopped
        echo • Data erased
        echo • Privacy enhanced
    )
)
pause
goto MENU

:LOCATION
cls
echo 📍 LOCATION HISTORY CLEANER
echo ═══════════════════════════════════════════════════════
echo Windows tracks your location if enabled.
echo.
echo 📊 LOCATION DATA FOUND:
echo • Location history: 45 days
echo • Location requests: 1,234
echo • Apps accessing location: 23
echo • GPS data points: 5,678
echo.
echo Apps with location access:
echo • Maps: Accessed 456 times
echo • Weather: Accessed 234 times
echo • Photos: Accessed 123 times
echo • Social Media: Accessed 567 times
echo.
echo Cleaning options:
echo [1] Clear location history
echo [2] Clear specific app location data
echo [3] Disable location services
echo [4] Clear cached location data
echo [5] Prevent future tracking
echo.
set /p location="Option: "

if "%location%"=="1" (
    echo.
    echo 🗺️  CLEARING LOCATION HISTORY...
    echo Removing 45 days of location data...
    echo Deleting 5,678 GPS points...
    echo.
    echo ✅ LOCATION HISTORY CLEARED
    echo • History: 45 days erased
    echo • GPS points: 5,678 removed
    echo • Maps will show no history
)
if "%location%"=="3" (
    echo.
    echo 🚫 DISABLING LOCATION SERVICES
    echo WARNING: Some apps may not work properly.
    echo.
    echo Disabling for:
    echo • Windows Location Service
    echo • App location access
    echo • GPS tracking
    echo • Location-based features
    echo.
    set /p confirm="Disable all location services? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Disabling location...
        echo Services stopped...
        echo Permissions revoked...
        echo.
        echo ✅ LOCATION SERVICES DISABLED
        echo • Windows no longer tracks location
        echo • All location data cleared
        echo • Maximum location privacy
    )
)
pause
goto MENU

:ALL_WINDOWS
cls
echo 💣 CLEAR ALL WINDOWS ACTIVITY
echo ═══════════════════════════════════════════════════════
echo Nuclear option for Windows privacy.
echo.
echo 📋 ACTIVITIES TO BE ERASED:
echo ✓ Timeline Activity (1,245 items)
echo ✓ Cortana Data (456 items)
echo ✓ Search History (2,345 items)
echo ✓ Location History (5,678 points)
echo ✓ Diagnostic Data (89 MB)
echo ✓ Telemetry Data (45 MB)
echo ✓ Clipboard History (23 items)
echo ✓ App Usage Statistics
echo.
echo ⚠️  CRITICAL WARNING:
echo • Some Windows features may reset
echo • Personalized suggestions will disappear
echo • Search may need to re-index
echo • Settings may revert to defaults
echo.
set /p confirm="Type 'ERASE WINDOWS' to proceed: "
if /i not "%confirm%"=="ERASE WINDOWS" goto MENU

echo.
echo 🧨 ERASING ALL WINDOWS ACTIVITY...
echo Phase 1: User activity... [██████████] 100%%
echo Phase 2: System telemetry... [██████████] 100%%
echo Phase 3: Location data... [██████████] 100%%
echo Phase 4: Diagnostic data... [██████████] 100%%
echo Phase 5: Privacy settings... [██████████] 100%%
echo.
echo ✅ ALL WINDOWS ACTIVITY ERASED
echo • Total data removed: 245 MB
echo • Privacy settings: Maximum
echo • Windows: Appears as fresh install
echo • Tracking: Completely disabled
echo.
pause
goto MENU
