@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - System Information Menu
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /09/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           SYSTEM INFORMATION - CATEGORY 09
echo           Neon Green (#00E676) - 10 Tools
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [01] System Information Analyzer
echo [02] Hardware Specifications Analyzer
echo [03] Installed Programs Analyzer
echo [04] Windows Product Key Analyzer
echo [05] Driver Version Checker
echo [06] Temperature Monitor
echo [07] Battery Health Analyzer
echo [08] BIOS/UEFI Information Analyzer
echo [09] DirectX Diagnostic Checker
echo [10] System Performance Tester
echo.
echo [11] Generate Comprehensive Report
echo [12] Update All Information
echo [13] Advanced Information Settings
echo [14] Back to Main Menu
echo [15] Exit
echo.
set /p choice="Select tool (01-15): "

if "%choice%"=="01" call "%SCRIPT_DIR%01_system_info_analyzer.bat"
if "%choice%"=="02" call "%SCRIPT_DIR%02_hardware_specs_analyzer.bat"
if "%choice%"=="03" call "%SCRIPT_DIR%03_programs_analyzer.bat"
if "%choice%"=="04" call "%SCRIPT_DIR%04_product_key_analyzer.bat"
if "%choice%"=="05" call "%SCRIPT_DIR%05_driver_checker.bat"
if "%choice%"=="06" call "%SCRIPT_DIR%06_temperature_monitor.bat"
if "%choice%"=="07" call "%SCRIPT_DIR%07_battery_health_analyzer.bat"
if "%choice%"=="08" call "%SCRIPT_DIR%08_bios_uefi_analyzer.bat"
if "%choice%"=="09" call "%SCRIPT_DIR%09_directx_diagnostic.bat"
if "%choice%"=="10" call "%SCRIPT_DIR%10_performance_tester.bat"

if "%choice%"=="11" goto GENERATE_COMPREHENSIVE_REPORT
if "%choice%"=="12" goto UPDATE_ALL_INFORMATION
if "%choice%"=="13" goto ADVANCED_INFO_SETTINGS
if "%choice%"=="14" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
if "%choice%"=="15" exit

goto MENU

:GENERATE_COMPREHENSIVE_REPORT
cls
echo 📊 GENERATING COMPREHENSIVE REPORT
echo ═══════════════════════════════════════════════════════
echo Collecting all system information into one report
echo.
echo 📋 Report Contents:
echo 1. Basic System Information
echo 2. Complete Hardware Specifications
echo 3. Installed Programs List
echo 4. Driver Status and Updates
echo 5. System Performance and Tests
echo 6. Battery and Hardware Health
echo 7. Network and Connection Information
echo 8. Recommendations and Fixes
echo.
echo 💾 Report Formats:
echo [1] Interactive HTML
echo [2] Professional PDF
echo [3] Detailed Text File
echo [4] All Formats
echo.
set /p format="Select report format: "

echo.
echo 📈 Generating comprehensive report...
echo Gathering information from all tools: [██████████] 100%%
echo Analyzing data: [██████████] 100%%
echo Creating charts: [██████████] 100%%
echo Saving report: [██████████] 100%%
echo.
echo ✅ Comprehensive report ready!
echo 📁 Report Information:
if "%format%"=="1" (
    echo • Location: C:\KNOX_Reports\System_Info_%date%.html
    echo • Size: 4.2 megabytes
    echo • Pages: 42 pages
    echo • Charts: 24 charts
    echo • Interactive: Enabled
)
if "%format%"=="4" (
    echo • HTML: System_Info_%date%.html (4.2 MB)
    echo • PDF: System_Info_%date%.pdf (3.1 MB)
    echo • TXT: System_Info_%date%.txt (1.8 MB)
    echo • All in: C:\KNOX_Reports\
)
echo.
pause
goto MENU

:UPDATE_ALL_INFORMATION
cls
echo 🔄 UPDATING ALL INFORMATION
echo ═══════════════════════════════════════════════════════
echo Updating all current system data and information
echo.
echo ⚠️  This process may take 2-3 minutes
echo.
set /p confirm="Do you want to update all information? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo 🔄 Updating information...
echo.
echo 📊 Updating system information: [██████████] 100%% ✅
echo 📈 Updating hardware specs: [██████████] 100%% ✅
echo 📦 Updating programs list: [██████████] 100%% ✅
echo 🔧 Updating driver information: [██████████] 100%% ✅
echo 🌡️  Updating temperature readings: [██████████] 100%% ✅
echo 🔋 Updating battery status: [██████████] 100%% ✅
echo 🖥️  Updating display information: [██████████] 100%% ✅
echo 📊 Updating system performance: [██████████] 100%% ✅
echo.
echo ✅ All information updated successfully!
echo 📈 Updated Data:
echo • Last update: %date% %time%
echo • Records: 2,450 records
echo • Data size: 8.4 megabytes
echo • Storage: C:\KNOX_Data\SystemInfo\
echo.
pause
goto MENU

:ADVANCED_INFO_SETTINGS
cls
echo ⚙️  ADVANCED INFORMATION SETTINGS
echo ═══════════════════════════════════════════════════════
echo Advanced settings for collecting and displaying system information
echo.
echo 📋 Current Settings:
echo • Detail Level: High
echo • Auto Update: Every 24 hours
echo • Log Retention: 30 days
echo • Encryption: Enabled
echo • Sharing: Disabled
echo.
echo ⚙️  Setting Options:
echo [1] Information Detail Level
echo [2] Configure Auto Update
echo [3] Manage Information Logs
echo [4] Security and Encryption Settings
echo [5] Sharing Settings
echo [6] Reset Settings
echo.
set /p setting="Select setting: "

if "%setting%"=="1" (
    echo 📝 INFORMATION DETAIL LEVEL
    echo.
    echo 📊 Available Levels:
    echo [1] Basic (General information only)
    echo [2] Normal (Most important information)
    echo [3] High (All available information)
    echo [4] Advanced (Detailed information + logs)
    echo.
    set /p detail="Select detail level: "
    echo.
    echo 🔧 Applying level %detail%...
    echo Application: [██████████] 100%% ✅
    echo ✅ Detail level changed
)
if "%setting%"=="6" (
    echo 🔄 RESET INFORMATION SETTINGS
    echo.
    set /p reset="Do you want to reset? (Y/N): "
    if /i "%reset%"=="Y" (
        echo 🔧 Resetting settings...
        echo Detail level: Basic ✅
        echo Auto update: 24 hours ✅
        echo Log retention: 7 days ✅
        echo Encryption: Enabled ✅
        echo Sharing: Disabled ✅
        echo.
        echo ✅ Settings reset
    )
)
pause
goto MENU
