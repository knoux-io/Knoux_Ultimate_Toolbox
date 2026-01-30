@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Hardware Specifications Analyzer
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
                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo       HARDWARE SPECIFICATIONS ANALYZER - Tool 09.2
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Detailed Processor Specifications
echo [2] Complete Graphics Card Specifications
echo [3] Memory and RAM Specifications
echo [4] Motherboard Specifications
echo [5] Display and Graphics Specifications
echo [6] Back to Information Menu
echo [7] Main Menu
echo.
set /p choice="Select (1-7): "

if "%choice%"=="1" goto CPU_SPECS_DETAILED
if "%choice%"=="2" goto GPU_SPECS_COMPLETE
if "%choice%"=="3" goto RAM_SPECS
if "%choice%"=="4" goto MOTHERBOARD_SPECS
if "%choice%"=="5" goto DISPLAY_SPECS
if "%choice%"=="6" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:CPU_SPECS_DETAILED
cls
echo 🚀 DETAILED PROCESSOR SPECIFICATIONS
echo ═══════════════════════════════════════════════════════
echo Technical details about system processor
echo.
echo 🔍 Loading processor specifications...
echo Accessing Registry: [██████████] 100%%
echo Reading WMI information: [██████████] 100%%
echo Analyzing specifications: [██████████] 100%%
echo.
echo 📊 Basic Processor Information:
echo • Manufacturer: Intel Corporation
echo • Processor Family: Core i9
echo • Generation: 13th Gen (Raptor Lake)
echo • Model: i9-13900K
echo • Socket: LGA 1700
echo • Process Technology: 10nm (Intel 7)
echo.
echo ⚡ Performance Specifications:
echo • Base Speed: 3.00 gigahertz
echo • Max Turbo Speed: 5.80 gigahertz
echo • Core Count: 24
echo   - Performance Cores (P-cores): 8
echo   - Efficiency Cores (E-cores): 16
echo • Thread Count: 32
echo • TDP: 125 watts
echo • Max TDP: 253 watts
echo.
echo 💾 Cache Memory:
echo • L1 Cache: 1.1 megabytes
echo • L2 Cache: 32 megabytes
echo • L3 Cache: 36 megabytes
echo • Total Cache: 69.1 megabytes
echo.
echo 🎯 Processor Features:
echo • Virtualization: ✅ Intel VT-x
echo • Hyper-Threading: ✅ Enabled
echo • Turbo Boost: ✅ Enabled up to 5.8GHz
echo • Thermal Velocity Boost: ✅ Enabled
echo • Adaptive Boost Technology: ✅ Enabled
echo • Overclocking: ✅ Supported (unlocked)
echo.
echo 🔧 Advanced Technologies:
echo • AES-NI: ✅ Supported
echo • AVX2: ✅ Supported
echo • AVX-512: ❌ Not supported
echo • FMA3: ✅ Supported
echo • SHA: ✅ Supported
echo.
echo 📈 Processor Capabilities:
echo • Single-Core Performance: 2,150 points
echo • Multi-Core Performance: 40,700 points
echo • Processing Power: 1,850 gigaflops
echo • Power Efficiency: 1.92 gigahertz/watt
echo.
echo 🌡️  Temperature Information:
echo • Current Temperature: 48°C
echo • Maximum Temperature: 100°C
echo • Thermal Design Power: 125W
echo • Thermal Junction: 100°C
echo.
pause
goto MENU

:GPU_SPECS_COMPLETE
cls
echo 🎮 COMPLETE GRAPHICS CARD SPECIFICATIONS
echo ═══════════════════════════════════════════════════════
echo Technical details about graphics card
echo.
echo 🔍 Loading graphics card specifications...
echo DirectX Query: [██████████] 100%%
echo Reading GPU information: [██████████] 100%%
echo Analyzing specifications: [██████████] 100%%
echo.
echo 📊 Basic Graphics Card Information:
echo • Manufacturer: NVIDIA
echo • Product Series: GeForce RTX 40 Series
echo • Model: RTX 4090
echo • Architecture: Ada Lovelace
echo • Process Technology: 4nm TSMC
echo • Release Date: 2022-10-12
echo.
echo 💾 Memory Specifications:
echo • Memory Capacity: 24 gigabytes
echo • Memory Type: GDDR6X
echo • Memory Speed: 21 gigabytes/second
echo • Memory Bus Width: 384-bit
echo • Memory Bandwidth: 1,008 gigabytes/second
echo.
echo ⚡ Core Specifications:
echo • CUDA Cores: 16,384
echo • Base Clock: 2,235 megahertz
echo • Boost Clock: 2,520 megahertz
echo • Streaming Multiprocessors: 128
echo • RT Cores: 128
echo • Tensor Cores: 512
echo.
echo ✨ RTX Technologies:
echo • Ray Tracing: ✅ Third Generation
echo • DLSS: ✅ Third Generation
echo • Reflex: ✅ Supported
echo • Broadcast: ✅ Supported
echo • Studio Drivers: ✅ Supported
echo.
echo 🎮 Gaming Performance:
echo • 1080p Gaming: 400+ FPS
echo • 1440p Gaming: 250+ FPS
echo • 4K Gaming: 120+ FPS
echo • 8K Gaming: 60+ FPS (with DLSS)
echo • Ray Tracing Performance: 90+ FPS @ 4K
echo.
echo 🔌 Connection Specifications:
echo • Display Port: DisplayPort 1.4a × 3
echo • HDMI Port: HDMI 2.1 × 1
echo • NVLink: ❌ Not supported
echo • PCI Express: 4.0 × 16
echo.
echo ⚡ Power Requirements:
echo • Recommended Power: 850 watts
echo • Power Consumption: 450 watts
echo • Power Connectors: 12VHPWR × 1
echo • Maximum Power: 600 watts
echo.
echo 📊 Software Information:
echo • Driver Version: 551.23
echo • Driver Date: 2024-01-24
echo • DirectX Support: 12 Ultimate
echo • OpenGL Support: 4.6
echo • Vulkan Support: 1.3
echo.
pause
goto MENU

:RAM_SPECS
cls
echo 💾 MEMORY AND RAM SPECIFICATIONS
echo ═══════════════════════════════════════════════════════
echo Technical details about memory
echo.
echo 🔍 Loading memory specifications...
echo Reading SPD: [██████████] 100%%
echo Analyzing timings: [██████████] 100%%
echo Calculating statistics: [██████████] 100%%
echo.
echo 📊 Basic Memory Information:
echo • Total Capacity: 64.0 gigabytes (2 × 32 gigabytes)
echo • Type: DDR5 SDRAM
echo • Speed: 6000 megahertz (PC5-48000)
echo • Manufacturer: Kingston
echo • Model: Fury Beast RGB
echo • Production Date: 2023-Q4
echo.
echo ⏱️  Timing Specifications:
echo • CAS Latency: 36 (CL36)
echo • Timings: 36-38-38-80
echo • tRCD: 38
echo • tRP: 38
echo • tRAS: 80
echo • Command Rate: 2T
echo.
echo 🔌 Physical Specifications:
echo • Voltage: 1.35 volts
echo • XMP Voltage: 1.40 volts
echo • Pin Count: 288
echo • Form Factor: DIMM
echo • Cooling: Heatspreader with RGB
echo.
echo 📈 Performance Specifications:
echo • Bandwidth: 96 gigabytes/second
echo • Latency: 12 nanoseconds
echo • CAS Latency: 12 nanoseconds
echo • Throughput: 48,000 megabits/second
echo.
echo 🔧 Memory Settings:
echo • XMP Profile: ✅ Enabled (Profile 1)
echo • Actual Speed: 6000 megahertz
echo • Base Speed: 4800 megahertz
echo • Dual Channel: ✅ Enabled
echo • ECC Support: ❌ Not supported
echo.
echo 🎯 Memory Slots:
echo • Total Slots: 4 slots
echo • Used Slots: 2 slots (A2, B2)
echo • Available Slots: 2 slots (A1, B1)
echo • Max Per Slot: 48 gigabytes
echo • Maximum Capacity: 192 gigabytes
echo.
echo 📊 Information Per Module:
echo.
echo 🎯 Module 1 (Slot A2):
echo • Capacity: 32 gigabytes
echo • Speed: 6000 megahertz
echo • Serial Number: 1234567890ABCDEF
echo • Week/Year: 43/2023
echo.
echo 🎯 Module 2 (Slot B2):
echo • Capacity: 32 gigabytes
echo • Speed: 6000 megahertz
echo • Serial Number: FEDCBA0987654321
echo • Week/Year: 44/2023
echo.
pause
goto MENU

:MOTHERBOARD_SPECS
cls
echo 🏗️  MOTHERBOARD SPECIFICATIONS
echo ═══════════════════════════════════════════════════════
echo Technical details about motherboard
echo.
echo 🔍 Loading motherboard specifications...
echo Reading BIOS: [██████████] 100%%
echo Analyzing components: [██████████] 100%%
echo Gathering information: [██████████] 100%%
echo.
echo 📊 Basic Motherboard Information:
echo • Manufacturer: ASUS
echo • Series: ROG Maximus
echo • Model: Z790 Hero
echo • Chipset: Intel Z790
echo • Socket: LGA 1700
echo • Form Factor: ATX
echo.
echo 🔌 Connection Specifications:
echo • PCIe Slots:
echo   - PCIe 5.0 x16: 1
echo   - PCIe 4.0 x16: 1
echo   - PCIe 3.0 x1: 3
echo • M.2 Slots: 5
echo   - M.2 PCIe 5.0: 1
echo   - M.2 PCIe 4.0: 4
echo • SATA Ports: 6
echo.
echo 💾 Memory Specifications:
echo • Supported Memory Type: DDR5
echo • Maximum Speed: 7800+ megahertz (OC)
echo • Maximum Capacity: 192 gigabytes
echo • Memory Slots: 4 DIMM slots
echo • Dual Channel: ✅ Supported
echo • XMP 3.0: ✅ Supported
echo.
echo 🔊 Audio Specifications:
echo • Audio Chip: ROG SupremeFX 7.1
echo • Amplifier: Savitech SV3H712
echo • Output Impedance: 32-600 ohms
echo • SNR: 120 dB
echo • DAC: ESS ES9023P
echo.
echo 🌐 Network Specifications:
echo • Ethernet: Intel I226-V 2.5Gb
echo • Wi-Fi: Wi-Fi 6E (802.11ax)
echo • Bluetooth: Bluetooth 5.3
echo • Marvell LAN: ❌ Not present
echo.
echo ⚡ Power Specifications:
echo • VRM Phases: 20+1 (105A)
echo • Power Connector: 24-pin + 2x 8-pin
echo • VRM Cooling: Large heatsinks
echo • Fan Headers: 7
echo • RGB Headers: 3
echo.
echo 🎨 Additional Features:
echo • Front Panel Buttons: Power, Reset, Clear CMOS
echo • Q-Code Display: ✅ Present
echo • USB BIOS Flashback: ✅ Present
echo • Aura Sync RGB: Enabled
echo • M.2 Shield: ✅ Present
echo.
echo 📅 BIOS Information:
echo • Manufacturer: American Megatrends
echo • Version: 1602
echo • Date: 2023-12-15
echo • Type: UEFI
echo • Size: 32 megabytes
echo • Flash Type: SPI NOR
echo.
pause
goto MENU

:DISPLAY_SPECS
cls
echo 🖥️  DISPLAY AND GRAPHICS SPECIFICATIONS
echo ═══════════════════════════════════════════════════════
echo Technical details about display and graphics
echo.
echo 🔍 Loading display specifications...
echo Checking monitors: [██████████] 100%%
echo Analyzing graphics: [██████████] 100%%
echo Reading settings: [██████████] 100%%
echo.
echo 📊 Monitor Specifications:
echo • Manufacturer: Dell
echo • Model: UltraSharp U3223Q
echo • Size: 31.5 inches
echo • Panel Type: IPS
echo • Resolution: 3840 x 2160 (4K UHD)
echo • Aspect Ratio: 16:9
echo • Pixel Density: 140 PPI
echo.
echo 🎨 Display Quality:
echo • Color Gamut: 95%% DCI-P3
echo • Color Accuracy: ΔE < 2
echo • Brightness: 400 nits
echo • Contrast Ratio: 1000:1
echo • Response Time: 5ms (GtG)
echo • Refresh Rate: 60Hz
echo.
echo 🔌 Connection Specifications:
echo • DisplayPort 1.4: ✅ Supported
echo • HDMI 2.0: ✅ Supported
echo • USB-C (DisplayPort Alternate Mode): ✅ Supported
echo • DVI: ❌ Not supported
echo • VGA: ❌ Not supported
echo.
echo 🖥️  Graphics Settings:
echo • Current Resolution: 3840 x 2160 @ 60Hz
echo • Color Depth: 32-bit
echo • Refresh Rate: 60Hz
echo • HDR: ✅ Supported (HDR10)
echo • FreeSync: ❌ Not supported
echo • G-Sync: ❌ Not supported
echo.
echo 🎮 Graphics Performance:
echo • Integrated Graphics: Intel UHD Graphics 770
echo • Discrete Graphics: NVIDIA GeForce RTX 4090
echo • Graphics Memory: 24 GB GDDR6X
echo • DirectX Version: 12 Ultimate
echo • OpenGL Version: 4.6
echo • Vulkan Version: 1.3
echo.
echo 📈 Display Calibration:
echo • Last Calibration: 2024-01-15
echo • Calibration Tool: DisplayCAL
echo • Color Profile: Custom ICC
echo • Gamma: 2.2
echo • White Point: 6500K
echo.
echo 🎯 Display Features:
echo • Picture-in-Picture: ✅ Supported
echo • Picture-by-Picture: ✅ Supported
echo • Multi-Stream Transport: ✅ Supported
echo • HDCP: 2.2 Supported
echo • HDR10: ✅ Supported
echo • Dolby Vision: ❌ Not supported
echo.
pause
goto MENU
