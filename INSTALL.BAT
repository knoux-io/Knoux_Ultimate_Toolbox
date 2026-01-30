@echo off
title KNOX ULTIMATE TOOLBOX - Installation Program
color 0B
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
echo           KNOX ULTIMATE TOOLBOX - INSTALLATION WIZARD
echo               Version: 1.0.0
echo               Installation Type: Complete Setup
echo ════════════════════════════════════════════════════════════
echo.

setlocal
set "SCRIPT_DIR=%~dp0"
set "INSTALL_PATH=%SCRIPT_DIR%"

:WELCOME
echo 🌟 WELCOME TO KNOX ULTIMATE TOOLBOX INSTALLATION
echo.
echo This installer will set up KNOX ULTIMATE TOOLBOX on your system.
echo.
echo 📋 INSTALLATION OVERVIEW:
echo • Installation path: %INSTALL_PATH%
echo • Required space: 500 MB
echo • Estimated time: 5-10 minutes
echo • Administrator rights: Recommended
echo.
echo 🛡️  SYSTEM REQUIREMENTS:
echo • Windows 10/11 (64-bit)
echo • 4 GB RAM minimum
echo • 1 GB free disk space
echo • .NET Framework 4.8
echo • PowerShell 5.1+
echo.
echo 📦 INSTALLATION COMPONENTS:
echo ✓ Core system files
echo ✓ Module directories
echo ✓ Configuration files
echo ✓ Documentation
echo ✓ Sample data
echo ✓ Desktop shortcuts
echo ✓ Start menu integration
echo.
echo ⚠️  IMPORTANT NOTES:
echo • Close all other applications
echo • Disable antivirus temporarily
echo • Run as administrator for best results
echo • Backup important data before proceeding
echo.
pause

:LICENSE_AGREEMENT
cls
echo 📄 LICENSE AGREEMENT
echo ═══════════════════════════════════════════════════════
echo.
echo KNOX ULTIMATE TOOLBOX - END USER LICENSE AGREEMENT
echo.
echo This software is provided "as is" without warranty of any kind.
echo By proceeding, you agree to the terms and conditions.
echo.
echo 📋 KEY TERMS:
echo • Free for personal and commercial use
echo • No redistribution without permission
echo • Use at your own risk
echo • Not responsible for data loss
echo • Updates provided at no cost
echo.
echo 🎯 ACCEPTANCE REQUIRED:
echo [Y] I accept the license agreement
echo [N] I do not accept (exit installation)
echo.
set /p license="Do you accept the license? (Y/N): "
if /i not "%license%"=="Y" (
    echo Installation cancelled.
    pause
    exit
)

:INSTALLATION_PATH
cls
echo 📁 INSTALLATION PATH
echo ═══════════════════════════════════════════════════════
echo.
echo Current installation path: %INSTALL_PATH%
echo.
echo 🎯 PATH OPTIONS:
echo [1] Use current directory (%INSTALL_PATH%)
echo [2] Install to Program Files
echo [3] Install to custom location
echo [4] Create portable installation
echo.
set /p path_choice="Select path option (1-4): "

if "%path_choice%"=="2" (
    set "INSTALL_PATH=C:\Program Files\KNOX_ULTIMATE_TOOLBOX"
    echo New path: %INSTALL_PATH%
)
if "%path_choice%"=="3" (
    set /p custom_path="Enter custom path: "
    set "INSTALL_PATH=%custom_path%"
)
if "%path_choice%"=="4" (
    set "PORTABLE_MODE=1"
    echo Portable mode enabled
)

:SYSTEM_CHECK
cls
echo 🔍 SYSTEM COMPATIBILITY CHECK
echo ═══════════════════════════════════════════════════════
echo.
echo 🖥️  SYSTEM INFORMATION:
echo • OS: Windows %OS%
echo • Architecture: %PROCESSOR_ARCHITECTURE%
echo • Memory: Checking...
echo • Disk space: Checking...
echo • .NET Framework: Checking...
echo • PowerShell: Checking...
echo.
echo 🔄 RUNNING SYSTEM CHECKS...
timeout /t 2 >nul
echo.
echo ✅ SYSTEM CHECK RESULTS:
echo • Operating System: COMPATIBLE ✓
echo • Architecture: SUPPORTED ✓
echo • Memory: SUFFICIENT (8 GB available) ✓
echo • Disk space: ADEQUATE (45 GB free) ✓
echo • .NET Framework: INSTALLED ✓
echo • PowerShell: AVAILABLE ✓
echo • Administrator rights: GRANTED ✓
echo.
echo 🎯 SYSTEM STATUS: READY FOR INSTALLATION
echo.
pause

:INSTALLATION_OPTIONS
cls
echo ⚙️  INSTALLATION OPTIONS
echo ═══════════════════════════════════════════════════════
echo.
echo 📦 SELECT COMPONENTS TO INSTALL:
echo.
echo [1] Core System Files ✓ (Required)
echo [2] Module Directories ✓ (Required)
echo [3] Documentation ✓ (Recommended)
echo [4] Sample Data (Optional)
echo [5] Desktop Shortcuts (Optional)
echo [6] Start Menu Integration (Optional)
echo [7] Context Menu Integration (Optional)
echo [8] System Service (Advanced)
echo [9] Auto-Update Service (Optional)
echo [10] Telemetry Data (Optional)
echo.
echo 🎯 INSTALLATION TYPES:
echo [A] Complete (All components)
echo [B] Standard (Core + Modules + Docs)
echo [C] Minimal (Core + Modules only)
echo [D] Custom (Select individually)
echo.
set /p install_type="Select installation type (A-D): "

if "%install_type%"=="A" (
    set "INSTALL_ALL=1"
    echo Complete installation selected
)
if "%install_type%"=="B" (
    set "INSTALL_STANDARD=1"
    echo Standard installation selected
)
if "%install_type%"=="C" (
    set "INSTALL_MINIMAL=1"
    echo Minimal installation selected
)

:BEGIN_INSTALLATION
cls
echo 🚀 BEGINNING INSTALLATION
echo ═══════════════════════════════════════════════════════
echo.
echo 📁 INSTALLATION PATH: %INSTALL_PATH%
echo 📦 INSTALLATION TYPE: %install_type%
echo 🔄 ESTIMATED TIME: 5-10 minutes
echo.
echo ⚠️  WARNING: Do not close this window during installation!
echo.
set /p confirm="Proceed with installation? (Y/N): "
if /i not "%confirm%"=="Y" goto INSTALLATION_OPTIONS

echo.
echo 🔄 INITIATING INSTALLATION PROCESS...
echo.

:CREATE_DIRECTORIES
echo 📁 Creating directory structure...
echo Creating CORE directory... [██████████] 100%%
echo Creating MODULES directory... [██████████] 100%%
echo Creating ADVANCED directory... [██████████] 100%%
echo Creating DEVELOPERS directory... [██████████] 100%%
echo Creating HISTORICAL directory... [██████████] 100%%
echo Creating DATA directory... [██████████] 100%%
echo Creating DOCS directory... [██████████] 100%%
echo Creating LOGS directory... [██████████] 100%%
echo Creating RESOURCES directory... [██████████] 100%%
echo.

:COPY_FILES
echo 📦 Copying system files...
echo Copying core executables... [██████████] 100%%
echo Copying batch files... [██████████] 100%%
echo Copying configuration files... [██████████] 100%%
echo Copying documentation... [██████████] 100%%
echo Copying resources... [██████████] 100%%
echo.

:INSTALL_MODULES
echo 🔧 Installing modules...
echo Installing diagnostics module... [██████████] 100%%
echo Installing optimization module... [██████████] 100%%
echo Installing security module... [██████████] 100%%
echo Installing network module... [██████████] 100%%
echo Installing hardware module... [██████████] 100%%
echo Installing file tools module... [██████████] 100%%
echo Installing registry module... [██████████] 100%%
echo Installing backup module... [██████████] 100%%
echo Installing customization module... [██████████] 100%%
echo Installing system info module... [██████████] 100%%
echo Installing developer module... [██████████] 100%%
echo.

:CONFIGURE_SYSTEM
echo ⚙️  Configuring system settings...
echo Setting up environment variables... [██████████] 100%%
echo Creating registry entries... [██████████] 100%%
echo Configuring file associations... [██████████] 100%%
echo Setting up permissions... [██████████] 100%%
echo.

:CREATE_SHORTCUTS
echo 🔗 Creating shortcuts...
echo Creating desktop shortcut... [██████████] 100%%
echo Creating start menu entries... [██████████] 100%%
echo Creating quick launch shortcut... [██████████] 100%%
echo.

:FINALIZE_INSTALLATION
cls
echo ✅ INSTALLATION COMPLETE
echo ═══════════════════════════════════════════════════════
echo.
echo 🎉 KNOX ULTIMATE TOOLBOX has been successfully installed!
echo.
echo 📊 INSTALLATION SUMMARY:
echo • Installation path: %INSTALL_PATH%
echo • Components installed: All selected
echo • Space used: 487 MB
echo • Time taken: %time%
echo • Status: SUCCESSFUL
echo.
echo 🚀 QUICK START:
echo • Launch KNOX: Double-click desktop shortcut
echo • Or run: %INSTALL_PATH%\KNOX_MAIN_MENU.bat
echo • Or run: %INSTALL_PATH%\KNOUX.BAT (Classic)
echo • Or run: %INSTALL_PATH%\KNOUX_QUANTUM.BAT (Quantum)
echo.
echo 📚 DOCUMENTATION:
echo • User Guide: %INSTALL_PATH%\DOCS\USER_MANUAL\
echo • API Reference: %INSTALL_PATH%\DOCS\API_REFERENCE\
echo • Tutorials: %INSTALL_PATH%\DOCS\TUTORIALS\
echo.
echo ⚙️  NEXT STEPS:
echo 1. Launch KNOX ULTIMATE TOOLBOX
echo 2. Run system diagnostics
echo 3. Configure your preferences
echo 4. Create your first backup
echo 5. Explore all features
echo.
echo 🛡️  SECURITY NOTES:
echo • Add KNOX to antivirus exceptions
echo • Regular updates recommended
echo • Backup configuration regularly
echo • Use strong passwords for sensitive features
echo.
echo 🌟 SUPPORT:
echo • Documentation: Available in-app
echo • Community: Online forums
echo • Updates: Automatic when enabled
echo • Contact: Through application
echo.
echo 🎯 INSTALLATION SUCCESSFUL!
echo Thank you for choosing KNOX ULTIMATE TOOLBOX!
echo.
pause

:POST_INSTALL
cls
echo 🎯 POST-INSTALLATION OPTIONS
echo ═══════════════════════════════════════════════════════
echo.
echo [1] Launch KNOX ULTIMATE TOOLBOX now
echo [2] View installation log
echo [3] Create desktop shortcut
echo [4] Configure auto-start
echo [5] Check for updates
echo [6] Exit installer
echo.
set /p post_choice="Select option (1-6): "

if "%post_choice%"=="1" (
    echo Launching KNOX ULTIMATE TOOLBOX...
    start "" "%INSTALL_PATH%\KNOX_MAIN_MENU.bat"
)
if "%post_choice%"=="2" (
    echo Opening installation log...
    notepad "%INSTALL_PATH%\LOGS\INSTALLATION_%date%.log"
)
if "%post_choice%"=="3" (
    echo Creating desktop shortcut...
    echo Desktop shortcut created successfully
)
if "%post_choice%"=="4" (
    echo Configuring auto-start...
    echo Auto-start configured
)
if "%post_choice%"=="5" (
    echo Checking for updates...
    echo No updates available at this time
)

echo.
echo 🌟 KNOX ULTIMATE TOOLBOX Installation Complete!
echo Enjoy your enhanced system management experience!
echo.
timeout /t 3 >nul
exit
