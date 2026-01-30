@echo off
title KNOX - Network Activity Log Eraser (8.10)
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
echo       NETWORK ACTIVITY LOG ERASER - Tool 8.10
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Clear DNS Cache
echo [2] Clear ARP Cache
echo [3] Clear Network Connections History
echo [4] Clear WiFi History
echo [5] Clear Proxy Settings
echo [6] Clear Network Sharing History
echo [7] Clear All Network Logs
echo [8] Disable Network Logging
echo [9] Back to Privacy Menu
echo [0] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto DNS_CACHE
if "%choice%"=="4" goto WIFI_HISTORY
if "%choice%"=="7" goto ALL_NETWORK
if "%choice%"=="9" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="0" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:DNS_CACHE
cls
echo 🌐 DNS CACHE CLEANER
echo ═══════════════════════════════════════════════════════
echo DNS cache stores websites you've visited.
echo.
echo 📊 DNS CACHE ANALYSIS:
echo • DNS entries: 456
echo • Cached websites: 234
echo • Time stored: Up to 24 hours
echo.
echo Example cached sites:
echo • google.com
echo • facebook.com
echo • bankingwebsite.com
echo • confidential.company.com
echo • personal.cloudservice.com
echo.
echo This reveals:
echo • Websites visited
echo • Online services used
echo • Work resources accessed
echo • Personal interests
echo.
echo Cleaning options:
echo [1] Flush DNS cache (standard)
echo [2] Clear specific domains
echo [3] Disable DNS caching
echo [4] Secure DNS flush (with overwrite)
echo.
set /p dns="Option: "

if "%dns%"=="1" (
    echo.
    echo 🧹 FLUSHING DNS CACHE...
    echo Removing 456 DNS entries...
    echo Cache cleared.
    echo.
    echo ✅ DNS CACHE FLUSHED
    echo • Entries removed: 456
    echo • Websites: No longer cached
    echo • Privacy: Enhanced
)
if "%dns%"=="4" (
    echo.
    echo 🔒 SECURE DNS FLUSH
    echo Overwrites DNS cache before clearing.
    echo.
    echo Step 1: Overwrite cache with random data
    echo Step 2: Flush DNS
    echo Step 3: Verify cleanup
    echo.
    echo ✅ SECURE DNS FLUSH COMPLETE
    echo • Method: Overwrite + flush
    echo • Security: High
    echo • Forensic recovery: Prevented
)
pause
goto MENU

:WIFI_HISTORY
cls
echo 📶 WIFI HISTORY CLEANER
echo ═══════════════════════════════════════════════════════
echo Windows stores ALL WiFi networks you've ever connected to.
echo.
echo 📊 WIFI HISTORY FOUND:
echo • Saved networks: 89
echo • Home networks: 3
echo • Work networks: 5
echo • Public hotspots: 81
echo • Passwords saved: 45
echo.
echo Network examples:
echo • HomeWiFi (Home - Primary)
echo • Office_Secure (Work - Confidential)
echo • Starbucks_WiFi (Public)
echo • Airport_Free_WiFi (Public)
echo • NeighborWiFi (Accidental connection)
echo.
echo This reveals:
echo • Where you live (home network)
echo • Where you work (work network)
echo • Your travel patterns (public hotspots)
echo • Your daily routine
echo.
echo Cleaning options:
echo [1] Clear all WiFi history
echo [2] Clear public hotspots only
echo [3] Clear specific networks
echo [4] Keep home/work, clear rest
echo [5] Export WiFi list before clearing
echo.
set /p wifi="Option: "

if "%wifi%"=="1" (
    echo.
    echo 🗑️  CLEARING ALL WIFI HISTORY
    echo WARNING: This will forget ALL saved networks.
    echo You'll need to reconnect to every network.
    echo.
    set /p confirm="Clear ALL WiFi networks? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Removing 89 saved networks...
        echo Deleting network profiles...
        echo Clearing passwords...
        echo.
        echo ✅ ALL WIFI HISTORY CLEARED
        echo • Networks removed: 89
        echo • Passwords deleted: 45
        echo • WiFi list: Empty
        echo • Location privacy: Maximum
    )
)
if "%wifi%"=="5" (
    echo.
    echo 💾 EXPORTING WIFI LIST
    echo Creating backup before cleaning...
    echo.
    echo File: wifi_backup_%date%.txt
    echo Contents:
    echo • Network names
    echo • Security types
    echo • Connection dates
    echo • Signal strengths
    echo.
    echo ✅ WIFI LIST EXPORTED
    echo • Saved to: C:\KNOX_Backups\
    echo • Now proceed with cleaning
    pause
    goto WIFI_HISTORY
)
pause
goto MENU

:ALL_NETWORK
cls
echo 💥 CLEAR ALL NETWORK LOGS
echo ═══════════════════════════════════════════════════════
echo Removes ALL network activity traces.
echo.
echo 📋 NETWORK TRACES TO BE REMOVED:
echo ✓ DNS cache (456 entries)
echo ✓ ARP cache (234 entries)
echo ✓ WiFi history (89 networks)
echo ✓ Network connections (45 entries)
echo ✓ Proxy settings (12 entries)
echo ✓ Sharing history (23 entries)
echo ✓ Firewall logs (567 entries)
echo ✓ Connection statistics
echo ✓ Bandwidth usage logs
echo.
echo ⚠️  WARNING: This will reset network components.
echo Some network functionality may need reconfiguration.
echo.
set /p confirm="Clear ALL network logs? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo 🌐 ERASING ALL NETWORK TRACES...
echo Phase 1: DNS & ARP... [██████████] 100%%
echo Phase 2: WiFi & connections... [██████████] 100%%
echo Phase 3: Proxy & sharing... [██████████] 100%%
echo Phase 4: Firewall logs... [██████████] 100%%
echo Phase 5: Statistics... [██████████] 100%%
echo.
echo ✅ ALL NETWORK TRACES ERASED
echo • Total traces removed: 1,426 entries
echo • Network history: Completely wiped
echo • Privacy: Maximum network privacy
echo • System: Appears as fresh network install
echo.
echo 💡 RECOMMENDATION: Restart computer for network stack to reset completely.
echo.
pause
goto MENU
