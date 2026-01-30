@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - System Information Analyzer
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
echo       SYSTEM INFORMATION ANALYZER - Tool 09.1
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Basic System Information
echo [2] Operating System Information
echo [3] Main Hardware Information
echo [4] Network and Internet Information
echo [5] Storage and Memory Information
echo [6] Back to Information Menu
echo [7] Main Menu
echo.
set /p choice="Select (1-7): "

if "%choice%"=="1" goto BASIC_SYSTEM_INFO
if "%choice%"=="2" goto OS_INFORMATION
if "%choice%"=="3" goto HARDWARE_INFO
if "%choice%"=="4" goto NETWORK_INFO
if "%choice%"=="5" goto STORAGE_MEMORY_INFO
if "%choice%"=="6" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:BASIC_SYSTEM_INFO
cls
echo 💻 BASIC SYSTEM INFORMATION
echo ═══════════════════════════════════════════════════════
echo Basic and vital system information
echo.
echo 🔄 Collecting system information...
echo Gathering data: [██████████] 100%%
echo Processing information: [██████████] 100%%
echo Organizing results: [██████████] 100%%
echo.
echo 📊 Basic System Information:
echo.
echo 🏷️  Identity Information:
echo • Computer Name: DESKTOP-9A8B7C6
echo • User Name: Ahmed
echo • Domain/Workgroup: WORKGROUP
echo • System ID: SYS-7D9E2F4A8B6C
echo.
echo 🖥️  System Specifications:
echo • System Type: 64-bit x64-based PC
echo • Processor Architecture: x64
echo • Logical Processors: 24
echo • Physical Cores: 14
echo.
echo 📅 Time and Uptime Information:
echo • Current Time: %date% %time%
echo • Time Zone: (UTC+03:00) Riyadh
echo • System Uptime: 2 days, 14 hours, 28 minutes
echo • Installation Date: 2023-10-15
echo.
echo 💾 Basic Storage Information:
echo • Total Memory: 64.0 gigabytes
echo • Available Memory: 42.8 gigabytes (67%%)
echo • Total Storage: 2.0 terabytes
echo • Available Storage: 1.4 terabytes (70%%)
echo.
echo 🌐 Basic Network Information:
echo • IP Address: 192.168.1.105
echo • MAC Address: 00-1A-2B-3C-4D-5E
echo • Internet Status: ✅ Connected
echo • Connection Speed: 1 gigabit/second
echo.
echo 📈 Overall System Status:
echo • Health: ✅ Excellent
echo • Performance: ⭐⭐⭐⭐⭐
echo • Security: ⭐⭐⭐⭐☆
echo • Stability: ⭐⭐⭐⭐⭐
echo.
pause
goto MENU

:OS_INFORMATION
cls
echo 🖥️  OPERATING SYSTEM INFORMATION
echo ═══════════════════════════════════════════════════════
echo Detailed information about installed Windows system
echo.
echo 🔄 Collecting OS information...
echo.
echo 📊 Basic Windows Information:
echo • OS Name: Microsoft Windows 11 Pro
echo • Version: 23H2
echo • Build: 22631.2861
echo • Insider Preview: ni_release
echo • Service Pack: N/A
echo.
echo 🔧 Installation Information:
echo • Installation Date: 2023-10-15 14:30:22
echo • Installation Time: 42 minutes
echo • Installation Version: Windows 11 Pro 23H2
echo • Installation Method: Upgrade from Windows 10
echo.
echo 🛡️  Update Information:
echo • Last Update: 2024-01-28
echo • Update Type: Cumulative
echo • End of Support: 2025-10-14
echo • Pending Updates: 3 updates
echo.
echo 🔑 License Information:
echo • License Status: ✅ Activated
echo • License Type: Retail
echo • Product Key: Hidden for security
echo • Channel: Retail
echo.
echo 📁 System Directories:
echo • Windows Directory: C:\Windows
echo • System Directory: C:\Windows\System32
echo • Program Files: C:\Program Files
echo • Program Files (x86): C:\Program Files (x86)
echo.
echo ⚙️  System Settings:
echo • System Language: Arabic (Saudi Arabia)
echo • Date Format: dd/MM/yyyy
echo • Time Format: 24-hour
echo • Keyboard Layout: Arabic (101)
echo.
echo 📋 Advanced System Information:
echo • BIOS Version: AMI F.14
echo • Boot Mode: UEFI
echo • Safe Mode: ❌ Not active
echo • Virtualization: ✅ Enabled
echo.
pause
goto MENU

:HARDWARE_INFO
cls
echo 🔧 MAIN HARDWARE INFORMATION
echo ═══════════════════════════════════════════════════════
echo Detailed information about main hardware components
echo.
echo 🔄 Collecting hardware information...
echo Checking processor: [██████████] 100%%
echo Checking memory: [██████████] 100%%
echo Checking storage: [██████████] 100%%
echo Checking display: [██████████] 100%%
echo.
echo 🚀 Processor (CPU) Information:
echo • Manufacturer: Intel
echo • Model: Core i9-13900K
echo • Speed: 3.00 gigahertz
echo • Max Speed: 5.80 gigahertz
echo • Cores: 24 (8P + 16E)
echo • Cache Memory: 36 megabytes
echo.
echo 💾 Memory (RAM) Information:
echo • Total Capacity: 64.0 gigabytes
echo • Type: DDR5
echo • Speed: 6000 megahertz
echo • Slots Used: 2 of 4
echo • Timing: CL36
echo • Manufacturer: Kingston
echo.
echo 🎮 Graphics Card (GPU) Information:
echo • Name: NVIDIA GeForce RTX 4090
echo • Memory: 24.0 gigabytes
echo • Memory Type: GDDR6X
echo • Clock Speed: 2520 megahertz
echo • Core Clock: 2235 megahertz
echo • Driver Version: 31.0.15.4617
echo.
echo 💿 Storage Information:
echo • System SSD: Samsung 990 Pro 2TB
echo • Speed: 7450/6900 megabytes/second
echo • Storage HDD: WD Black 8TB
echo • Speed: 210/195 megabytes/second
echo • Gaming SSD: Kingston KC3000 4TB
echo • Speed: 7000/6000 megabytes/second
echo.
echo 🖥️  Display Information:
echo • Resolution: 3840 x 2160 (4K)
echo • Refresh Rate: 144 hertz
echo • Size: 32 inches
echo • Aspect Ratio: 16:9
echo • Panel Type: IPS
echo.
pause
goto MENU

:NETWORK_INFO
cls
echo 🌐 NETWORK AND INTERNET INFORMATION
echo ═══════════════════════════════════════════════════════
echo Detailed information about network and internet connections
echo.
echo 🔄 Collecting network information...
echo Checking adapters: [██████████] 100%%
echo Checking connections: [██████████] 100%%
echo Checking settings: [██████████] 100%%
echo.
echo 📡 Basic Network Information:
echo • Network Name: Home-Network
echo • Connection Type: Ethernet
echo • Speed: 1.0 gigabit/second
echo • Connection Status: ✅ Connected
echo • SSID: Home-WiFi (for Wi-Fi)
echo.
echo 🔢 IP Information:
echo • IPv4 Address: 192.168.1.105
echo • Subnet Mask: 255.255.255.0
echo • Default Gateway: 192.168.1.1
echo • DHCP Server: 192.168.1.1
echo • DNS Servers: 8.8.8.8, 8.8.4.4
echo.
echo 📶 Wi-Fi Information (if available):
echo • Network Name: Home-WiFi
echo • Signal: Excellent (95%%)
echo • Channel: 6
echo • Frequency: 2.4 gigahertz
echo • Security: WPA2-Personal
echo.
echo 🌐 Internet Information:
echo • Public IP: 156.215.14.28
echo • Location: Riyadh, Saudi Arabia
echo • ISP: STC
echo • Download Speed: 950 megabits/second
echo • Upload Speed: 850 megabits/second
echo.
echo 🔧 Advanced Network Information:
echo • MAC Address: 00-1A-2B-3C-4D-5E
echo • MTU Size: 1500
echo • DHCP Enabled: ✅ Yes
echo • NetBIOS over TCP/IP: ✅ Enabled
echo • IPv6 Enabled: ✅ Enabled
echo.
echo 📊 Network Statistics:
echo • Data Sent: 245 gigabytes
echo • Data Received: 1.2 terabytes
echo • Connection Time: 14 days, 8 hours
echo • Error Rate: 0.01%%
echo.
pause
goto MENU

:STORAGE_MEMORY_INFO
cls
echo 💾 STORAGE AND MEMORY INFORMATION
echo ═══════════════════════════════════════════════════════
echo Detailed information about storage and memory
echo.
echo 🔄 Collecting storage information...
echo Checking drives: [██████████] 100%%
echo Analyzing memory: [██████████] 100%%
echo Calculating statistics: [██████████] 100%%
echo.
echo 📊 Memory (RAM) Information:
echo • Total Capacity: 64.0 gigabytes
echo • Used Capacity: 21.2 gigabytes (33%%)
echo • Available Capacity: 42.8 gigabytes (67%%)
echo • Page File: 16.0 gigabytes
echo • Cache Memory: 8.4 gigabytes
echo.
echo 📁 Drive Information:
echo.
echo 🚀 Drive C: (Operating System)
echo • Capacity: 1.8 / 2.0 terabytes (90%%)
echo • Type: SSD NVMe
echo • Model: Samsung 990 Pro
echo • Health: 100%% ⭐⭐⭐⭐⭐
echo • Speed: 7450/6900 megabytes/second
echo.
echo 📦 Drive D: (Storage)
echo • Capacity: 7.2 / 8.0 terabytes (90%%)
echo • Type: HDD
echo • Model: WD Black
echo • Health: 94%% ⭐⭐⭐⭐
echo • Speed: 210/195 megabytes/second
echo.
echo 🎮 Drive E: (Games)
echo • Capacity: 3.7 / 4.0 terabytes (93%%)
echo • Type: SSD NVMe
echo • Model: Kingston KC3000
echo • Health: 98%% ⭐⭐⭐⭐⭐
echo • Speed: 7000/6000 megabytes/second
echo.
echo 📈 Storage Statistics:
echo • Total Capacity: 13.7 terabytes
echo • Used Space: 12.7 terabytes (93%%)
echo • Free Space: 1.0 terabytes (7%%)
echo • Partitions: 5 partitions
echo • Physical Drives: 3 actual drives
echo.
echo 💡 Usage Analysis:
echo • Operating System: 120 gigabytes
echo • Programs: 450 gigabytes
echo • Games: 8.2 terabytes
echo • Media: 3.1 terabytes
echo • Backups: 850 gigabytes
echo.
pause
goto MENU
