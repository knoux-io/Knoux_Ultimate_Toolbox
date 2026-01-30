@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Network Tools Menu
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
echo           🌐 NETWORK TOOLS
echo               Category: 04 Network Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Network Connection Analyzer
echo [2] Network Speed Test
echo [3] Network Scanner
echo [4] IP Configuration Manager
echo [5] DNS Tools
echo [6] WiFi Analyzer
echo [7] Port Scanner
echo [8] Network Monitor
echo [9] Network Troubleshooter
echo [10] Back to Main Menu
echo.
set /p choice="Select option (1-10): "

if "%choice%"=="1" call "%SCRIPT_DIR%01_network_analyzer.BAT"
if "%choice%"=="2" call "%SCRIPT_DIR%02_speed_test.BAT"
if "%choice%"=="3" call "%SCRIPT_DIR%03_network_scanner.BAT"
if "%choice%"=="4" call "%SCRIPT_DIR%04_ip_manager.BAT"
if "%choice%"=="5" call "%SCRIPT_DIR%05_dns_tools.BAT"
if "%choice%"=="6" call "%SCRIPT_DIR%06_wifi_analyzer.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%07_port_scanner.BAT"
if "%choice%"=="8" call "%SCRIPT_DIR%08_network_monitor.BAT"
if "%choice%"=="9" call "%SCRIPT_DIR%09_network_troubleshooter.BAT"
if "%choice%"=="10" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU
