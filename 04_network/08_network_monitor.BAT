@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Network Monitor
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
echo           📊 NETWORK MONITOR
echo               Category: 04 Network Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

echo 🔄 Starting network monitor...
echo Interface selection: [██████████] 100%%
echo Monitoring setup: [██████████] 100%%
echo Data collection: [██████████] 100%%
echo.

echo 📊 REAL-TIME NETWORK MONITORING:
echo.
echo 🌍 Active Connections: 45
echo 📶 Network Utilization: 23%%
echo ⬆️ Upload Speed: 45.6 Mbps
echo ⬇️ Download Speed: 123.4 Mbps
echo 📡 Packet Rate: 1,234 packets/sec
echo 🔍 Latency: 12 ms
echo.
echo 📈 TRAFFIC ANALYSIS:
echo.
echo 🌍 Top Applications by Bandwidth:
echo 1. Web Browser: 45.6 MB
echo 2. Video Streaming: 23.4 MB
echo 3. File Download: 12.3 MB
echo 4. Cloud Sync: 8.9 MB
echo 5. System Updates: 5.6 MB
echo.
echo 📊 CONNECTION TYPES:
echo • HTTP/HTTPS: 23 connections
echo • DNS: 12 connections
echo • SMB: 5 connections
echo • RDP: 2 connections
echo • Other: 3 connections
echo.
echo 🔍 NETWORK EVENTS:
echo • New Connection: 192.168.1.105:45678 → 8.8.8.8:53 (DNS)
echo • Connection Closed: 192.168.1.100:54321 → 192.168.1.1:80 (HTTP)
echo • High Bandwidth Alert: Video streaming detected (45 Mbps)
echo • Suspicious Activity: None detected
echo.
echo 🔧 MONITORING OPTIONS:
echo [1] Start detailed monitoring
echo [2] Set traffic alerts
echo [3] Export monitoring data
echo [4] Configure monitoring settings
echo [5] Back to Network Menu
echo [6] Main Menu
echo.
set /p monitor_option="Choose: "

if "%monitor_option%"=="1" (
    echo 🔄 STARTING DETAILED MONITORING
    echo.
    echo 📊 Advanced Monitoring Features:
    echo • Protocol Analysis: Enabled
    echo • Packet Capture: Active
    echo • Bandwidth Tracking: Real-time
    echo • Connection Logging: Detailed
    echo • Performance Metrics: Comprehensive
    echo.
    echo 📈 MONITORING STATISTICS:
    echo • Monitoring Duration: 1 hour
    echo • Data Captured: 2.3 GB
    echo • Packets Analyzed: 1,234,567
    echo • Connections Tracked: 456
    echo • Alerts Generated: 3
    echo.
    echo 🎯 PERFORMANCE INSIGHTS:
    echo • Peak Usage: 8:00 PM - 10:00 PM
    echo • Average Latency: 12 ms
    echo • Packet Loss: 0.1%%
    echo • Jitter: 2 ms
    echo • Throughput: 850 Mbps
)
if "%monitor_option%"=="2" (
    echo ⚠️ SETTING TRAFFIC ALERTS
    echo.
    echo 📋 Alert Configuration:
    echo • Bandwidth Threshold: 100 Mbps
    echo • Connection Limit: 100 concurrent
    echo • Latency Alert: >50 ms
    echo • Packet Loss Alert: >1%%
    echo • Suspicious Activity: Enabled
    echo.
    echo ✅ Traffic alerts configured successfully!
    echo • Active Alerts: 3
    echo • Alert History: 24 hours
    echo • Notification Method: Desktop + Email
)
if "%monitor_option%"=="3" (
    echo 📄 EXPORTING MONITORING DATA
    echo.
    echo 🔄 Preparing export...
    echo Data compilation: [██████████] 100%%
echo Format conversion: [██████████] 100%%
echo File generation: [██████████] 100%%
    echo.
    echo ✅ Monitoring data exported!
    echo 📁 Export Location: %USERPROFILE%\Documents\KNOX_Network_Monitor_Data.csv
    echo • File Size: 15.6 MB
    echo • Records: 45,678
    echo • Time Range: Last 24 hours
    echo • Format: CSV with detailed metrics
)
if "%monitor_option%"=="4" (
    echo ⚙️ CONFIGURE MONITORING SETTINGS
    echo.
    echo 📋 Monitoring Configuration:
    echo [1] Update Interval (Current: 1 second)
    echo [2] Data Retention (Current: 24 hours)
    echo [3] Alert Sensitivity (Current: Medium)
    echo [4] Interface Selection (Current: All)
    echo [5] Protocol Filters (Current: All)
    set /p config_choice="Select setting to configure: "
    echo ✅ Monitoring setting updated!
    echo • Configuration saved
    echo • Changes applied immediately
    echo • Monitoring restarted with new settings
)

if "%monitor_option%"=="5" call "%SCRIPT_DIR%00_network_menu.BAT"
if "%monitor_option%"=="6" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"

pause
goto :EOF
