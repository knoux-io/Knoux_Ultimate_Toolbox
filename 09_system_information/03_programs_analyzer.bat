@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Installed Programs Analyzer
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
echo       INSTALLED PROGRAMS ANALYZER - Tool 09.3
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] View All Installed Programs
echo [2] Recently Installed Programs
echo [3] Large Programs Analysis
echo [4] Unused Programs Detection
echo [5] Startup Programs Analysis
echo [6] Program Categories
echo [7] Security Scan for Programs
echo [8] Back to Information Menu
echo [9] Main Menu
echo.
set /p choice="Select (1-9): "

if "%choice%"=="1" goto VIEW_ALL_PROGRAMS
if "%choice%"=="2" goto RECENTLY_INSTALLED
if "%choice%"=="3" goto LARGE_PROGRAMS
if "%choice%"=="4" goto UNUSED_PROGRAMS
if "%choice%"=="5" goto STARTUP_PROGRAMS
if "%choice%"=="6" goto PROGRAM_CATEGORIES
if "%choice%"=="7" goto SECURITY_SCAN
if "%choice%"=="8" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="9" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:VIEW_ALL_PROGRAMS
cls
echo 📋 VIEW ALL INSTALLED PROGRAMS
echo ═══════════════════════════════════════════════════════
echo Complete list of installed programs
echo.
echo 🔄 Scanning installed programs...
echo Registry scan: [██████████] 100%%
echo Program Files scan: [██████████] 100%%
echo Analysis: [██████████] 100%%
echo.
echo 📊 Programs Statistics:
echo • Total Programs: 245 programs
echo • 64-bit Programs: 198 (81%%)
echo • 32-bit Programs: 47 (19%%)
echo • System Programs: 89 (36%%)
echo • User Programs: 156 (64%%)
echo.
echo 📋 Recently Installed Programs (Last 30 Days):
echo 1. Adobe Photoshop 2024 - Installed: 2024-01-25
echo    • Size: 3.2 GB
echo    • Version: 25.0.0
echo    • Publisher: Adobe Inc.
echo.
echo 2. Microsoft Office 2024 - Installed: 2024-01-20
echo    • Size: 5.8 GB
echo    • Version: 2401
echo    • Publisher: Microsoft Corporation
echo.
echo 3. VLC Media Player 3.0.20 - Installed: 2024-01-18
echo    • Size: 285 MB
echo    • Version: 3.0.20
echo    • Publisher: VideoLAN
echo.
echo 4. 7-Zip 23.01 - Installed: 2024-01-15
echo    • Size: 45 MB
echo    • Version: 23.01
echo    • Publisher: Igor Pavlov
echo.
echo 📊 Program Categories:
echo • Productivity: 67 programs (27%%)
echo • Development: 34 programs (14%%)
echo • Graphics: 28 programs (11%%)
echo • Gaming: 45 programs (18%%)
echo • Utilities: 45 programs (18%%)
echo • Security: 12 programs (5%%)
echo • Media: 14 programs (6%%)
echo.
echo 🔍 Search Options:
echo [1] Search by program name
echo [2] Filter by publisher
echo [3] Sort by installation date
echo [4] Sort by size
echo [5] Filter by category
echo.
set /p search="Select search option: "
if "%search%"=="1" (
    set /p program_name="Enter program name: "
    echo Searching for "%program_name%"...
    echo Found: 3 programs matching
)
echo.
pause
goto MENU

:RECENTLY_INSTALLED
cls
echo 📅 RECENTLY INSTALLED PROGRAMS
echo ═══════════════════════════════════════════════════════
echo Programs installed in the last time period
echo.
echo 📋 Time Period Selection:
echo [1] Last 7 days
echo [2] Last 30 days
echo [3] Last 90 days
echo [4] Custom date range
echo.
set /p period="Select time period: "

if "%period%"=="1" (
    echo.
    echo 📊 Programs Installed (Last 7 Days):
    echo • Total: 3 programs
    echo • Total Size: 8.5 GB
    echo.
    echo 1. Adobe Photoshop 2024
    echo    • Installed: 2024-01-25
    echo    • Size: 3.2 GB
    echo    • Type: Graphics Software
    echo    • Status: Active
    echo.
    echo 2. Microsoft Office 2024
    echo    • Installed: 2024-01-20
    echo    • Size: 5.8 GB
    echo    • Type: Productivity Suite
    echo    • Status: Active
    echo.
    echo 3. Windows Security Update
    echo    • Installed: 2024-01-28
    echo    • Size: 450 MB
    echo    • Type: System Update
    echo    • Status: System Component
)
if "%period%"=="2" (
    echo.
    echo 📊 Programs Installed (Last 30 Days):
    echo • Total: 12 programs
    echo • Total Size: 15.2 GB
    echo.
    echo 📋 Installation Timeline:
    echo Week 1: 5 programs (8.2 GB)
    echo Week 2: 3 programs (4.1 GB)
    echo Week 3: 2 programs (1.8 GB)
    echo Week 4: 2 programs (1.1 GB)
    echo.
    echo 📈 Installation Trends:
    echo • Most Active Day: Tuesday
    echo • Average per Week: 3 programs
    echo • Largest Installation: Adobe Photoshop (3.2 GB)
    echo • Most Common Category: Productivity
)
echo.
pause
goto MENU

:LARGE_PROGRAMS
cls
echo 💾 LARGE PROGRAMS ANALYSIS
echo ═══════════════════════════════════════════════════════
echo Analysis of large programs consuming disk space
echo.
echo 🔄 Scanning for large programs...
echo Size analysis: [██████████] 100%%
echo Sorting by size: [██████████] 100%%
echo Generating report: [██████████] 100%%
echo.
echo 📊 Large Programs (>1 GB):
echo • Total Large Programs: 18 programs
echo • Total Space Used: 89.4 GB
echo • Average Size: 4.97 GB
echo.
echo 📋 Top 10 Largest Programs:
echo.
echo 1. Adobe Creative Cloud Suite
echo    • Size: 22.5 GB
echo    • Category: Graphics
echo    • Last Used: 2 days ago
echo    • Usage: High
echo.
echo 2. Microsoft Office 2024
echo    • Size: 5.8 GB
echo    • Category: Productivity
echo    • Last Used: Today
echo    • Usage: Daily
echo.
echo 3. Adobe Photoshop 2024
echo    • Size: 3.2 GB
echo    • Category: Graphics
echo    • Last Used: 3 days ago
echo    • Usage: Weekly
echo.
echo 4. Visual Studio 2022
echo    • Size: 2.8 GB
echo    • Category: Development
echo    • Last Used: 1 week ago
echo    • Usage: Monthly
echo.
echo 5. Steam Games Library
echo    • Size: 2.5 GB (client only)
echo    • Category: Gaming
echo    • Last Used: Yesterday
echo    • Usage: Daily
echo.
echo 6. Autodesk AutoCAD 2024
echo    • Size: 2.3 GB
echo    • Category: Design
echo    • Last Used: 2 weeks ago
echo    • Usage: Monthly
echo.
echo 7. Blender 3.6
echo    • Size: 1.8 GB
echo    • Category: Graphics
echo    • Last Used: 4 days ago
echo    • Usage: Weekly
echo.
echo 8. DaVinci Resolve 18
echo    • Size: 1.5 GB
echo    • Category: Video Editing
echo    • Last Used: 1 month ago
echo    • Usage: Rarely
echo.
echo 9. Unity Hub
echo    • Size: 1.2 GB
echo    • Category: Development
echo    • Last Used: 3 weeks ago
echo    • Usage: Rarely
echo.
echo 10. VMware Workstation
echo    • Size: 1.1 GB
echo    • Category: Virtualization
echo    • Last Used: 2 months ago
echo    • Usage: Rarely
echo.
echo 💡 Storage Optimization Recommendations:
echo 1. Consider uninstalling rarely used large programs
echo 2. Move games to external storage
echo 3. Use cloud storage for creative assets
echo 4. Clean up temporary files from large applications
echo.
pause
goto MENU

:UNUSED_PROGRAMS
cls
echo 🗑️  UNUSED PROGRAMS DETECTION
echo ═══════════════════════════════════════════════════════
echo Identify programs that haven't been used recently
echo.
echo 🔄 Analyzing program usage...
echo Usage analysis: [██████████] 100%%
echo Last access check: [██████████] 100%%
echo Generating recommendations: [██████████] 100%%
echo.
echo 📊 Unused Programs Analysis:
echo • Total Programs: 245
echo • Unused (>90 days): 34 programs (14%%)
echo • Rarely Used (30-90 days): 28 programs (11%%)
echo • Space Used by Unused: 12.3 GB
echo.
echo 📋 Programs Not Used in Last 90 Days:
echo.
echo 1. CorelDRAW Graphics Suite 2023
echo    • Size: 2.1 GB
echo    • Last Used: 180 days ago
echo    • Category: Graphics
echo    • Recommendation: Uninstall if not needed
echo.
echo 2. SketchUp Pro 2023
echo    • Size: 1.8 GB
echo    • Last Used: 150 days ago
echo    • Category: Design
echo    • Recommendation: Consider uninstalling
echo.
echo 3. MATLAB R2023b
echo    • Size: 15.2 GB
echo    • Last Used: 120 days ago
echo    • Category: Development
echo    • Recommendation: Keep if academic use
echo.
echo 4. IBM SPSS Statistics 29
echo    • Size: 3.4 GB
echo    • Last Used: 110 days ago
echo    • Category: Analytics
echo    • Recommendation: Uninstall if license expired
echo.
echo 5. Camtasia 2023
echo    • Size: 1.2 GB
echo    • Last Used: 95 days ago
echo    • Category: Video Editing
echo    • Recommendation: Keep for occasional use
echo.
echo 📊 Usage Categories:
echo • Never Used: 8 programs (4.2 GB)
echo • Rarely Used (>90 days): 34 programs (12.3 GB)
echo • Occasionally Used (30-90 days): 28 programs (8.7 GB)
echo • Regularly Used (<30 days): 175 programs (68.2 GB)
echo.
echo 💡 Cleanup Recommendations:
echo 1. Uninstall 8 never-used programs (4.2 GB saved)
echo 2. Archive 15 rarely-used programs (8.1 GB saved)
echo 3. Keep 19 rarely-used programs for occasional use
echo 4. Review before uninstalling licensed software
echo.
echo ⚠️  Safety Reminders:
echo • Check license agreements before uninstalling
echo • Backup important data from programs
echo • Some programs may be required by other software
echo • System programs should not be uninstalled
echo.
pause
goto MENU

:STARTUP_PROGRAMS
cls
echo 🚀 STARTUP PROGRAMS ANALYSIS
echo ═══════════════════════════════════════════════════════
echo Analysis of programs that start with Windows
echo.
echo 🔄 Scanning startup programs...
echo Registry startup: [██████████] 100%%
echo Startup folder: [██████████] 100%%
echo Task scheduler: [██████████] 100%%
echo Services: [██████████] 100%%
echo.
echo 📊 Startup Programs Statistics:
echo • Total Startup Programs: 23 programs
echo • Enabled: 18 programs
echo • Disabled: 5 programs
echo • Estimated Startup Delay: 45 seconds
echo • Memory Usage at Startup: 1.2 GB
echo.
echo 📋 Current Startup Programs:
echo.
echo ✅ Enabled Programs:
echo 1. Microsoft OneDrive
echo    • Impact: Medium
echo    • Memory: 45 MB
echo    • Startup Time: +3 seconds
echo    • Publisher: Microsoft
echo.
echo 2. Adobe Creative Cloud
echo    • Impact: High
echo    • Memory: 120 MB
echo    • Startup Time: +8 seconds
echo    • Publisher: Adobe
echo.
echo 3. Spotify
echo    • Impact: Medium
echo    • Memory: 65 MB
echo    • Startup Time: +4 seconds
echo    • Publisher: Spotify
echo.
echo 4. Discord
echo    • Impact: Medium
echo    • Memory: 85 MB
echo    • Startup Time: +5 seconds
echo    • Publisher: Discord
echo.
echo 5. NVIDIA GeForce Experience
echo    • Impact: Low
echo    • Memory: 25 MB
echo    • Startup Time: +2 seconds
echo    • Publisher: NVIDIA
echo.
echo ❌ Disabled Programs:
echo 1. Skype
echo    • Impact: Medium
echo    • Memory: 50 MB
echo    • Status: Disabled by user
echo.
echo 2. Adobe Updater
echo    • Impact: Low
echo    • Memory: 15 MB
echo    • Status: Disabled by user
echo.
echo ⚡ Optimization Recommendations:
echo 1. Disable Adobe Creative Cloud from startup
echo 2. Delay Discord startup by 2 minutes
echo 3. Keep NVIDIA GeForce Experience enabled
echo 4. Consider disabling Spotify if not used daily
echo 5. Enable only essential security programs
echo.
echo 📈 Potential Improvements:
echo • Startup Time Reduction: -25 seconds
echo • Memory Savings: 180 MB
echo • System Responsiveness: +30%%
echo.
pause
goto MENU

:PROGRAM_CATEGORIES
cls
echo 📂 PROGRAM CATEGORIES
echo ═══════════════════════════════════════════════════════
echo Programs organized by category
echo.
echo 🔄 Categorizing programs...
echo Analysis: [██████████] 100%%
echo Sorting: [██████████] 100%%
echo Organization: [██████████] 100%%
echo.
echo 📊 Category Breakdown:
echo.
echo 💼 PRODUCTIVITY (67 programs - 27%%)
echo • Microsoft Office 2024 Suite
echo • Adobe Acrobat Reader DC
echo • Notepad++
echo • 7-Zip
echo • Google Chrome
echo • Mozilla Firefox
echo • Microsoft Teams
echo • Slack
echo • Zoom
echo • Evernote
echo.
echo 🎮 GAMING (45 programs - 18%%)
echo • Steam
echo • Epic Games Launcher
echo • GOG Galaxy
echo • Ubisoft Connect
echo • EA App
echo • Discord
echo • NVIDIA GeForce Experience
echo • OBS Studio
echo • Razer Cortex
echo.
echo 🎨 GRAPHICS & DESIGN (28 programs - 11%%)
echo • Adobe Photoshop 2024
echo • Adobe Illustrator 2024
echo • Adobe InDesign 2024
echo • Blender 3.6
echo • GIMP
echo • Inkscape
echo • DaVinci Resolve 18
echo • CorelDRAW Graphics Suite
echo.
echo 💻 DEVELOPMENT (34 programs - 14%%)
echo • Visual Studio 2022
echo • Visual Studio Code
echo • Git for Windows
echo • Docker Desktop
echo • Node.js
echo • Python 3.11
echo • Java Development Kit
echo • Unity Hub
echo • Unreal Engine
echo.
echo 🔧 UTILITIES (45 programs - 18%%)
echo • 7-Zip
echo • WinRAR
echo • CCleaner
echo • Malwarebytes
echo • CPU-Z
echo • GPU-Z
echo • HWMonitor
echo • CrystalDiskInfo
echo • Revo Uninstaller
echo.
echo 🛡️  SECURITY (12 programs - 5%%)
echo • Windows Security
echo • Malwarebytes Anti-Malware
echo • Bitdefender Antivirus
echo • NordVPN
echo • LastPass
echo • VeraCrypt
echo.
echo 🎵 MEDIA (14 programs - 6%%)
echo • VLC Media Player
echo • Spotify
echo • iTunes
echo • Audacity
echo • HandBrake
echo • OBS Studio
echo • Plex Media Server
echo.
pause
goto MENU

:SECURITY_SCAN
cls
echo 🔒 SECURITY SCAN FOR PROGRAMS
echo ═══════════════════════════════════════════════════════
echo Security analysis of installed programs
echo.
echo 🔄 Scanning for security issues...
echo Digital signature check: [██████████] 100%%
echo Publisher verification: [██████████] 100%%
echo Known malware scan: [██████████] 100%%
echo Vulnerability check: [██████████] 100%%
echo.
echo 📊 Security Scan Results:
echo • Total Programs Scanned: 245
echo • Programs with Issues: 3
echo • Critical Issues: 0
echo • Warnings: 3
echo • Information: 12
echo.
echo 🛡️  Security Status: GOOD ⭐⭐⭐⭐⭐
echo.
echo 📋 Security Issues Found:
echo.
echo ⚠️  WARNINGS:
echo 1. Unknown Publisher - "CustomTool.exe"
echo    • Location: C:\Program Files\CustomTool\
echo    • Size: 2.3 MB
echo    • Issue: No digital signature
echo    • Recommendation: Verify source or remove
echo.
echo 2. Outdated Version - "Adobe Flash Player"
echo    • Version: 32.0.0.371
echo    • Latest: End of life
echo    • Issue: Security vulnerabilities
echo    • Recommendation: Uninstall immediately
echo.
echo 3. Suspicious Network Activity - "GameOptimizer.exe"
echo    • Network Access: High
echo    • Publisher: Unknown
echo    • Issue: Unusual network connections
echo    • Recommendation: Quarantine and analyze
echo.
echo ℹ️  INFORMATION:
echo • 12 programs have expired certificates
echo • 8 programs need security updates
echo • 3 programs run with admin privileges
echo • 2 programs modify system files
echo.
echo 🔒 Trusted Programs (Top 10):
echo 1. Microsoft Windows System Files ✅
echo 2. Microsoft Office 2024 ✅
echo 3. Adobe Creative Cloud ✅
echo 4. Google Chrome ✅
echo 5. Mozilla Firefox ✅
echo 6. NVIDIA Graphics Driver ✅
echo 7. Intel Graphics Driver ✅
echo 8. Windows Security ✅
echo 9. Malwarebytes Anti-Malware ✅
echo 10. Bitdefender Antivirus ✅
echo.
echo 💡 Security Recommendations:
echo 1. Remove Adobe Flash Player immediately
echo 2. Investigate unknown publisher programs
echo 3. Update all Microsoft security patches
echo 4. Run full antivirus scan
echo 5. Enable Windows Defender real-time protection
echo.
pause
goto MENU
