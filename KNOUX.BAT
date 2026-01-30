@echo off
title KNOX ULTIMATE TOOLBOX - Main Interface
color 0A
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
echo           KNOX ULTIMATE TOOLBOX - HISTORICAL EDITION
echo               Version: 1.0 Legacy
echo               Mode: Classic Interface
echo ════════════════════════════════════════════════════════════
echo.

setlocal
set "SCRIPT_DIR=%~dp0"

:MAIN_MENU
echo 🌟 WELCOME TO KNOX ULTIMATE TOOLBOX
echo.
echo 📋 MAIN CATEGORIES:
echo.
echo [1] 🧪 SYSTEM DIAGNOSTICS
echo     • Hardware scanning
echo     • System health check
echo     • Performance analysis
echo.
echo [2] ⚡ SYSTEM OPTIMIZATION
echo     • Performance tuning
echo     • Memory optimization
echo     • Startup management
echo.
echo [3] 🛡️ SECURITY & PROTECTION
echo     • Malware scanning
echo     • Firewall configuration
echo     • Privacy protection
echo.
echo [4] 🌐 NETWORK MANAGEMENT
echo     • Network analysis
echo     • Connection optimization
echo     • WiFi management
echo.
echo [5] 🔧 HARDWARE TOOLS
echo     • Driver management
echo     • Temperature monitoring
echo     • Hardware benchmarking
echo.
echo [6] 📁 FILE & DISK TOOLS
echo     • Disk cleanup
echo     • File management
echo     • Data recovery
echo.
echo [7] 🗂️ REGISTRY TOOLS
echo     • Registry cleaning
echo     • System tweaks
echo     • Backup & restore
echo.
echo [8] 💾 BACKUP & RECOVERY
echo     • System backup
echo     • File recovery
echo     • Restore points
echo.
echo [9] 🎨 CUSTOMIZATION
echo     • Theme management
echo     • System appearance
echo     • Personalization
echo.
echo [10] 📊 SYSTEM INFORMATION
echo     • System details
echo     • Performance reports
echo     • Hardware info
echo.
echo [11] 🚀 DEVELOPER TOOLS
echo     • Development environment
echo     • Code analysis
echo     • Version control
echo.
echo [12] ⚙️ ADVANCED TOOLS
echo     • System settings
echo     • Power user mode
echo     • Debug tools
echo.
echo [13] 👑 DEVELOPER SECTION
echo     • Advanced development
echo     • Module management
echo     • API tools
echo.
echo [14] 🌟 HISTORICAL FEATURES
echo     • AI Assistant
echo     • Virtual Reality
echo     • Bio Systems
echo.
echo [15] 📚 DOCUMENTATION
echo     • User guide
echo     • API reference
echo     • Tutorials
echo.
echo [16] ⚙️ SETTINGS
echo     • Configuration
echo     • Preferences
echo     • System setup
echo.
echo [17] 📊 REPORTS & LOGS
echo     • System reports
echo     • Activity logs
echo     • Analytics
echo.
echo [18] 🎯 UTILITARIAN CENTER
echo     • Specialized tools
echo     • Advanced utilities
echo     • Power features
echo.
echo [19] 🌐 CLOUD INTEGRATION
echo     • Cloud storage
echo     • Sync tools
echo     • Online backup
echo.
echo [20] 🚀 EXIT SYSTEM
echo.
echo ════════════════════════════════════════════════════════════
echo.
set /p choice="Select category (1-20): "

if "%choice%"=="1" call "%SCRIPT_DIR%01_diagnostics\01_diagnostics.bat"
if "%choice%"=="2" call "%SCRIPT_DIR%02_optimization\02_optimization.bat"
if "%choice%"=="3" call "%SCRIPT_DIR%03_security\03_SECURITY_MENU.BAT"
if "%choice%"=="4" call "%SCRIPT_DIR%04_network\04_NETWORK_MENU.BAT"
if "%choice%"=="5" call "%SCRIPT_DIR%05_disk\05_DISK_MENU.BAT"
if "%choice%"=="6" call "%SCRIPT_DIR%06_registry\06_REGISTRY_MENU.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%07_services\07_SERVICES_MENU.BAT"
if "%choice%"=="8" call "%SCRIPT_DIR%08_tweaks\08_TWEAKS_MENU.BAT"
if "%choice%"=="9" call "%SCRIPT_DIR%09_sysinfo\09_sysinfo.bat"
if "%choice%"=="10" call "%SCRIPT_DIR%10_backup\10_BACKUP_MENU.BAT"
if "%choice%"=="11" call "%SCRIPT_DIR%10_developer\10_developer.bat"
if "%choice%"=="12" call "%SCRIPT_DIR%11_advanced\11_ADVANCED_MENU.BAT"
if "%choice%"=="13" call "%SCRIPT_DIR%DEVELOPERS\D_TOOLS\D_TOOLS_MENU.BAT"
if "%choice%"=="14" call "%SCRIPT_DIR%HISTORICAL\HISTORICAL_MENU.BAT"
if "%choice%"=="15" call "%SCRIPT_DIR%DOCS\DOCS_MENU.BAT"
if "%choice%"=="16" call "%SCRIPT_DIR%ADVANCED\A_SETTINGS\A_SETTINGS_MENU.BAT"
if "%choice%"=="17" call "%SCRIPT_DIR%LOGS\LOGS_MENU.BAT"
if "%choice%"=="18" call "%SCRIPT_DIR%MODULES\21_utilitarian_center\21_UTILITARIAN_CENTER_MENU.BAT"
if "%choice%"=="19" call "%SCRIPT_DIR%MODULES\16_cloud_tools\16_CLOUD_MENU.BAT"
if "%choice%"=="20" goto EXIT_SYSTEM

goto MAIN_MENU

:EXIT_SYSTEM
cls
echo.
echo 🚀 EXITING KNOX ULTIMATE TOOLBOX
echo ═══════════════════════════════════════════════════════
echo.
echo Thank you for using KNOX ULTIMATE TOOLBOX!
echo.
echo 📊 SESSION SUMMARY:
echo • Tools used: %session_tools%
echo • Time spent: %session_time%
echo • Tasks completed: %session_tasks%
echo • System optimized: %session_optimized%
echo.
echo 💾 Session data saved to: %SCRIPT_DIR%LOGS\SESSION_%date%.log
echo.
echo 🔄 NEXT ACTIONS:
echo • Review session report
echo • Schedule regular maintenance
echo • Check for updates
echo • Backup system settings
echo.
echo 🌟 KNOX ULTIMATE TOOLBOX - UTILITARIAN DOMINANCE
echo.
set /p confirm="Exit now? (Y/N): "
if /i not "%confirm%"=="Y" goto MAIN_MENU

echo.
echo 🎯 GOODBYE!
echo See you next time!
echo.
timeout /t 3 >nul
exit
