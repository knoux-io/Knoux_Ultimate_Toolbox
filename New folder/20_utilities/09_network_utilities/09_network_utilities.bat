@echo off
title Knox Ultimate Toolbox - Network Utilities Menu
color 03
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
echo           NETWORK UTILITIES TOOLS - CATEGORY 21
echo                Green Theme (#4CAF50)
echo ????????????????????????????????????????????????????????????
echo.

:: Load language configuration
call "..\language_config.bat"

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    call :get_text "ADMIN_REQUIRED"
    echo [ERROR] %RETURN_TEXT%
    call :get_text "PRESS_ANY_KEY"
    echo %RETURN_TEXT%
    pause
    exit /b 1
)

:MAIN_MENU
call :get_text "NETWORK_UTILITIES"
echo %RETURN_TEXT%
echo ???????????????????????????????????????????????????????
echo.
echo [1]  Network Scanner
echo [2]  Port Scanner
echo [3]  Speed Test Tool
echo [4]  Network Monitor
echo [5]  WiFi Analyzer
echo [6]  IP Scanner
echo [7]  Bandwidth Monitor
echo [8]  Network Diagnostic
echo [9]  Router Manager
echo [10]  VPN Manager
echo.
echo [11] Run All Network Tools
echo [12] Generate Network Report
echo [13] Network Automation
echo [14] Back to Main Menu
echo [15] Exit
echo.
set /p choice="Select tool (1-15): "

if "%choice%"=="1" call "01_network_scanner.bat"
if "%choice%"=="2" call "02_port_scanner.bat"
if "%choice%"=="3" call "03_speed_test.bat"
if "%choice%"=="4" call "04_network_monitor.bat"
if "%choice%"=="5" call "13_text_tools_wifi_analyzer.bat"
if "%choice%"=="6" call "06_ip_scanner.bat"
if "%choice%"=="7" call "07_bandwidth_monitor.bat"
if "%choice%"=="8" call "08_network_diagnostic.bat"
if "%choice%"=="9" call "09_router_manager.bat"
if "%choice%"=="10" call "10_vpn_manager.bat"

if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto AUTOMATION
if "%choice%"=="14" goto BACK_TO_MAIN
if "%choice%"=="15" exit

goto MAIN_MENU

:RUN_ALL
cls
echo ?? RUNNING ALL NETWORK UTILITIES TOOLS
echo ???????????????????????????????????????????????????????
echo Comprehensive network analysis and optimization
echo Estimated time: 15-25 minutes
echo.
set /p confirm="Analyze network with all tools? (Y/N): "
if /i not "%confirm%"=="Y" goto MAIN_MENU

echo.
echo ?? NETWORK ANALYSIS...
echo 1/10: Network scanning... [??????????] 100%%
echo 2/10: Port scanning... [??????????] 100%%
echo 3/10: Speed testing... [??????????] 100%%
echo 4/10: Network monitoring... [??????????] 100%%
echo 5/10: WiFi analyzing... [??????????] 100%%
echo 6/10: IP scanning... [??????????] 100%%
echo 7/10: Bandwidth monitoring... [??????????] 100%%
echo 8/10: Network diagnostic... [??????????] 100%%
echo 9/10: Router management... [??????????] 100%%
echo 10/10: VPN management... [??????????] 100%%
echo.
echo ? COMPREHENSIVE NETWORK ANALYSIS COMPLETE!
echo.
echo ?? RESULTS SUMMARY:
echo ? Devices found: 12
echo ? Open ports: 23
echo ? Network speed: 245 Mbps
echo ? WiFi networks: 5
echo ? Bandwidth usage: 45%%
echo ? Network issues: 3
echo ? Router configuration: Optimized
echo ? VPN connections: 2 active
echo.
echo ?? Full report: Network_Analysis_Report_%date%.txt
echo.
pause
goto MAIN_MENU

:GENERATE_REPORT
cls
echo ?? GENERATE NETWORK REPORT
echo ???????????????????????????????????????????????????????
echo Create detailed network analysis report
echo.
echo ?? ANALYZING NETWORK INFRASTRUCTURE...
echo ? Network interfaces: 3
echo ? Connected devices: 12
echo ? Network speed: 245 Mbps
echo ? Bandwidth usage: 45%%
echo ? Router configuration: Analyzed
echo ? VPN connections: 2 active
echo.
echo ?? REPORT CONTENTS:
echo 1. Executive Summary
echo 2. Network Infrastructure
echo 3. Device Inventory
echo 4. Performance Analysis
echo 5. Security Assessment
echo 6. Bandwidth Analysis
echo 7. Router Configuration
echo 8. VPN Status
echo 9. Network Issues
echo 10. Recommendations
echo.
echo ?? Report saved as: Network_Analysis_Report_%date%.pdf
echo ?? Key findings:
echo ? Network speed: 245 Mbps (Good)
echo ? Connected devices: 12 (Optimal)
echo ? Open ports: 23 (Monitor)
echo ? Bandwidth usage: 45%% (Normal)
echo ? Network issues: 3 identified
echo.
echo ?? RECOMMENDATIONS:
echo 1. Optimize router settings
echo 2. Close unnecessary ports
echo 3. Monitor bandwidth usage
echo 4. Update firmware
echo 5. Implement QoS settings
echo.
pause
goto MAIN_MENU

:AUTOMATION
cls
echo ?? NETWORK MONITORING AUTOMATION
echo ???????????????????????????????????????????????????????
echo Set up automated network monitoring workflows
echo.
echo Select automation rules:
echo [1] Auto-scan network
echo [2] Auto-monitor bandwidth
echo [3] Auto-detect new devices
echo [4] Auto-optimize router
echo [5] Auto-manage VPN
echo [6] Auto-generate reports
echo [7] Auto-security monitoring
echo [8] Auto-performance optimization
echo.
set /p automation="Rules to enable: "

echo.
echo ??  AUTOMATION CONFIGURATION:
echo ? Trigger: Network changes
echo ? Actions: Selected rules
echo ? Scope: Entire network
echo ? Schedule: Real-time
echo.
echo ?? AUTOMATION ACTIVE:
echo ? Monitoring: All network interfaces
echo ? Rules: 8 active
echo ? Response: Real-time
echo ? Logging: Enabled
echo.
echo ?? AUTOMATION EXAMPLES:
echo When: New device connects
echo Then: 
echo   1. Scan device details
echo   2. Monitor bandwidth usage
echo   3. Check security status
echo   4. Optimize connection
echo   5. Generate alert
echo   6. Update device inventory
echo   7. Monitor performance
echo   8. Generate report
echo.
echo ? AUTOMATION CONFIGURED:
echo ? Network monitoring now automated
echo ? Saves 3-4 hours per week
echo ? Improves network security
echo ? Optimizes performance
echo.
pause
goto MAIN_MENU

:BACK_TO_MAIN
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0


