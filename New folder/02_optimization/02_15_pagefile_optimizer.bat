@echo off
chcp 65001 >nul
title Pagefile Optimizer Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Pagefile Optimizer Tool                     ║
echo ║              Knoux Ultimate Toolbox                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Pagefile Optimizer                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Current Pagefile Settings
echo [2] Automatic Pagefile Management
echo [3] Custom Pagefile Size
echo [4] Optimize for SSD
echo [5] Optimize for HDD
echo [6] Move Pagefile to Different Drive
echo [7] Disable Pagefile (Not Recommended)
echo [8] Clear Pagefile at Shutdown
echo [0] Exit
echo.
set /p choice="Select an option [0-8]: "

if "%choice%"=="1" goto check_settings
if "%choice%"=="2" goto auto_management
if "%choice%"=="3" goto custom_size
if "%choice%"=="4" goto optimize_ssd
if "%choice%"=="5" goto optimize_hdd
if "%choice%"=="6" goto move_pagefile
if "%choice%"=="7" goto disable_pagefile
if "%choice%"=="8" goto clear_shutdown
if "%choice%"=="0" goto exit
goto menu

:check_settings
echo.
echo [INFO] Current pagefile settings...
echo.

:: Display current pagefile settings
wmic computersystem get Name,AutomaticManagedPagefile /format:list
echo.
wmic pagefileset get Name,InitialSize,MaximumSize /format:list
echo.

:: Display disk space information
echo [INFO] Disk space information:
wmic logicaldisk get Caption,Size,FreeSpace /format:list

pause
goto menu

:auto_management
echo.
echo [INFO] Setting automatic pagefile management...
echo.

:: Enable automatic pagefile management
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True
if %errorLevel% equ 0 (
    echo [SUCCESS] Automatic pagefile management enabled
) else (
    echo [ERROR] Failed to enable automatic pagefile management
)

pause
goto menu

:custom_size
echo.
echo [INFO] Setting custom pagefile size...
echo.

:: Get system memory information
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value ^| find "="') do set total_memory=%%a
set /a recommended_size=%total_memory:~0,-9% * 1024 * 1.5

echo [INFO] Recommended pagefile size: %recommended_size% MB
echo.

set /p initial_size="Enter initial size (MB): "
set /p maximum_size="Enter maximum size (MB): "

if "%initial_size%"=="" set initial_size=%recommended_size%
if "%maximum_size%"=="" set maximum_size=%recommended_size%

:: Disable automatic management first
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

:: Set custom pagefile size
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%initial_size%,MaximumSize=%maximum_size%
if %errorLevel% equ 0 (
    echo [SUCCESS] Custom pagefile size set
) else (
    echo [ERROR] Failed to set custom pagefile size
)

pause
goto menu

:optimize_ssd
echo.
echo [INFO] Optimizing pagefile for SSD...
echo.

:: Disable automatic management
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

:: Set smaller pagefile for SSD (1x RAM)
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value ^| find "="') do set total_memory=%%a
set /a ssd_size=%total_memory:~0,-9% * 1024

wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%ssd_size%,MaximumSize=%ssd_size%

:: Optimize SSD settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Pagefile optimized for SSD
pause
goto menu

:optimize_hdd
echo.
echo [INFO] Optimizing pagefile for HDD...
echo.

:: Disable automatic management
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

:: Set larger pagefile for HDD (1.5x RAM)
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value ^| find "="') do set total_memory=%%a
set /a hdd_size=%total_memory:~0,-9% * 1024 * 1.5

wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%hdd_size%,MaximumSize=%hdd_size%

:: Optimize HDD settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Pagefile optimized for HDD
pause
goto menu

:move_pagefile
echo.
echo [INFO] Moving pagefile to different drive...
echo.

:: Display available drives
echo Available drives:
wmic logicaldisk get Caption,DriveType,Size,FreeSpace /format:list | findstr "Caption"
echo.

set /p target_drive="Enter target drive letter (e.g., D): "
if "%target_drive%"=="" goto menu

:: Disable automatic management
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

:: Remove existing pagefile
wmic pagefileset where name="C:\\pagefile.sys" delete

:: Create new pagefile on target drive
wmic pagefileset create name="%target_drive%:\\pagefile.sys"
if %errorLevel% equ 0 (
    echo [SUCCESS] Pagefile moved to drive %target_drive%
) else (
    echo [ERROR] Failed to move pagefile
)

pause
goto menu

:disable_pagefile
echo.
echo [WARNING] Disabling pagefile is NOT RECOMMENDED!
echo [WARNING] This may cause system instability!
set /p confirm="Are you absolutely sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling pagefile...
echo.

:: Disable automatic management
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

:: Delete pagefile
wmic pagefileset where name="C:\\pagefile.sys" delete
if %errorLevel% equ 0 (
    echo [SUCCESS] Pagefile disabled
) else (
    echo [ERROR] Failed to disable pagefile
)

pause
goto menu

:clear_shutdown
echo.
echo [INFO] Configuring pagefile clearing at shutdown...
echo.

set /p choice="Clear pagefile at shutdown? [Y/N]: "
if /i "%choice%"=="Y" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Pagefile will be cleared at shutdown
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Pagefile will not be cleared at shutdown
)

pause
goto menu

:exit
echo.
echo [INFO] Pagefile Optimizer closed
exit /b 0
