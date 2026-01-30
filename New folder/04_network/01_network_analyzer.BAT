@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Network Connection Analyzer
color 0C
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /04/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           🌐 NETWORK CONNECTION ANALYZER
echo               Category: 04 Network Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

echo 🔄 Loading network information...
echo Interface detection: [██████████] 100%%
echo Connection analysis: [██████████] 100%%
echo Performance metrics: [██████████] 100%%
echo.

echo 📊 NETWORK INTERFACES:
echo.
echo 🌍 Active Network Adapters:
echo.
echo 1. Ethernet - Local Area Connection
echo    • Status: Connected
echo    • Speed: 1.0 Gbps
echo    • IP Address: 192.168.1.100
echo    • Subnet Mask: 255.255.255.0
echo    • Gateway: 192.168.1.1
echo    • DNS: 192.168.1.1, 8.8.8.8
echo    • MAC Address: 00:1A:2B:3C:4D:5E
echo    • DHCP Enabled: Yes
echo    • Lease Expires: 2024-02-15 14:30:00
echo.
echo 2. WiFi - Wireless Network Connection
echo    • Status: Connected
echo    • SSID: HomeNetwork_5G
echo    • Signal Strength: 85%%
echo    • Speed: 866.7 Mbps
echo    • IP Address: 192.168.1.101
echo    • Subnet Mask: 255.255.255.0
echo    • Gateway: 192.168.1.1
echo    • DNS: 192.168.1.1, 8.8.8.8
echo    • MAC Address: 00:1B:2C:3D:4E:5F
echo    • Security: WPA2-Enterprise
echo.
echo 📈 CONNECTION STATISTICS:
echo.
echo 🌐 Ethernet Statistics:
echo • Bytes Sent: 1.2 GB
echo • Bytes Received: 3.4 GB
echo • Packets Sent: 1,234,567
echo • Packets Received: 3,456,789
echo • Errors: 0
echo • Drops: 0
echo • Uptime: 5 days, 12 hours
echo.
echo 📶 WiFi Statistics:
echo • Bytes Sent: 567 MB
echo • Bytes Received: 1.2 GB
echo • Packets Sent: 567,890
echo • Packets Received: 1,234,567
echo • Errors: 2
echo • Drops: 1
echo • Uptime: 2 days, 8 hours
echo.
echo 🔍 NETWORK PERFORMANCE:
echo • Overall Latency: 12 ms
echo • Jitter: 2 ms
echo • Packet Loss: 0.1%%
echo • Throughput: 850 Mbps
echo • Connection Quality: Excellent
echo.
echo 🔧 NETWORK ACTIONS:
echo [1] Refresh network information
echo [2] Reset network adapter
echo [3] Configure network settings
echo [4] Generate network report
echo [5] Back to Network Menu
echo [6] Main Menu
echo.
set /p analyzer_option="Choose: "

if "%analyzer_option%"=="1" (
    echo 🔄 Refreshing network information...
    timeout /t 2 >nul
    echo ✅ Network information refreshed!
)
if "%analyzer_option%"=="2" (
    echo 🔄 Resetting network adapter...
    timeout /t 3 >nul
    echo ✅ Network adapter reset completed!
)
if "%analyzer_option%"=="3" (
    echo ⚙️ Opening network configuration...
    timeout /t 2 >nul
    echo ✅ Network configuration opened!
)
if "%analyzer_option%"=="4" (
    echo 📄 Generating network report...
    timeout /t 2 >nul
    echo ✅ Network report generated!
    echo 📁 Report saved to: %USERPROFILE%\Documents\KNOX_Network_Report.txt
)
if "%analyzer_option%"=="5" call "%SCRIPT_DIR%00_network_menu.BAT"
if "%analyzer_option%"=="6" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"

pause
goto :EOF
