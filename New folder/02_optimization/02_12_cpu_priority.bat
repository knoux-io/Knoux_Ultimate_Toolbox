@echo off
chcp 65001 >nul
title CPU Priority Optimizer - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  CPU Priority Optimizer                      ║
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
echo ║                  CPU Priority Optimizer                      ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Optimize for Gaming
echo [2] Optimize for Productivity
echo [3] Optimize for Multimedia
echo [4] Optimize for Background Tasks
echo [5] Set Custom CPU Priority
echo [6] Reset to Default
echo [7] Current CPU Settings
echo [8] Process Priority Manager
echo [0] Exit
echo.
set /p choice="Select an option [0-8]: "

if "%choice%"=="1" goto gaming_optimize
if "%choice%"=="2" goto productivity_optimize
if "%choice%"=="3" goto multimedia_optimize
if "%choice%"=="4" goto background_optimize
if "%choice%"=="5" goto custom_priority
if "%choice%"=="6" goto reset_default
if "%choice%"=="7" goto current_settings
if "%choice%"=="8" goto process_manager
if "%choice%"=="0" goto exit
goto menu

:gaming_optimize
echo.
echo [INFO] Optimizing CPU for gaming performance...
echo.

:: Set power plan to High Performance
echo [1/4] Setting power plan to High Performance...
powercfg /setactive SCHEME_MIN

:: Optimize CPU scheduling
echo [2/4] Optimizing CPU scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul

:: Optimize system responsiveness
echo [3/4] Optimizing system responsiveness...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul

:: Optimize gaming services
echo [4/4] Optimizing gaming services...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Scheduling Category /t REG_SZ /d "High" /f >nul

echo [SUCCESS] CPU optimized for gaming
pause
goto menu

:productivity_optimize
echo.
echo [INFO] Optimizing CPU for productivity...
echo.

:: Set power plan to Balanced
echo [1/4] Setting power plan to Balanced...
powercfg /setactive SCHEME_BALANCED

:: Optimize for foreground applications
echo [2/4] Optimizing for foreground applications...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 26 /f >nul

:: Optimize system responsiveness
echo [3/4] Optimizing system responsiveness...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f >nul

:: Optimize office applications
echo [4/4] Optimizing office applications...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Office" /v Priority /t REG_DWORD /d 2 /f >nul

echo [SUCCESS] CPU optimized for productivity
pause
goto menu

:multimedia_optimize
echo.
echo [INFO] Optimizing CPU for multimedia...
echo.

:: Set power plan to Balanced
echo [1/4] Setting power plan to Balanced...
powercfg /setactive SCHEME_BALANCED

:: Optimize for multimedia applications
echo [2/4] Optimizing for multimedia applications...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 28 /f >nul

:: Optimize multimedia system profile
echo [3/4] Optimizing multimedia system profile...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 30 /f >nul

:: Optimize multimedia tasks
echo [4/4] Optimizing multimedia tasks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v Priority /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Video" /v Priority /t REG_DWORD /d 6 /f >nul

echo [SUCCESS] CPU optimized for multimedia
pause
goto menu

:background_optimize
echo.
echo [INFO] Optimizing CPU for background tasks...
echo.

:: Set power plan to Balanced
echo [1/4] Setting power plan to Balanced...
powercfg /setactive SCHEME_BALANCED

:: Optimize for background processes
echo [2/4] Optimizing for background processes...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 18 /f >nul

:: Optimize background services
echo [3/4] Optimizing background services...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 50 /f >nul

:: Optimize background tasks
echo [4/4] Optimizing background tasks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Background" /v Priority /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] CPU optimized for background tasks
pause
goto menu

:custom_priority
echo.
echo [INFO] Setting custom CPU priority...
echo.

echo Available priority levels:
echo [1] Realtime (24)
echo [2] High (13)
echo [3] Above Normal (10)
echo [4] Normal (8)
echo [5] Below Normal (6)
echo [6] Low (4)
echo.

set /p priority_level="Select priority level [1-6]: "

if "%priority_level%"=="1" set priority_value=24
if "%priority_level%"=="2" set priority_value=13
if "%priority_level%"=="3" set priority_value=10
if "%priority_level%"=="4" set priority_value=8
if "%priority_level%"=="5" set priority_value=6
if "%priority_level%"=="6" set priority_value=4

if "%priority_value%"=="" goto menu

:: Apply custom priority
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d %priority_value% /f >nul

echo [SUCCESS] Custom CPU priority set to %priority_value%
pause
goto menu

:reset_default
echo.
echo [INFO] Resetting CPU settings to default...
echo.

:: Reset power plan
echo [1/3] Resetting power plan to Balanced...
powercfg /setactive SCHEME_BALANCED

:: Reset priority control
echo [2/3] Resetting priority control...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 2 /f >nul

:: Reset system responsiveness
echo [3/3] Resetting system responsiveness...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f >nul

echo [SUCCESS] CPU settings reset to default
pause
goto menu

:current_settings
echo.
echo [INFO] Current CPU settings:
echo.

echo Power Plan:
powercfg /getactivescheme | findstr "Scheme GUID"
echo.

echo Priority Control:
reg query "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation 2>nul
echo.

echo System Responsiveness:
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness 2>nul
echo.

echo CPU Information:
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed /format:list

pause
goto menu

:process_manager
echo.
echo [INFO] Process Priority Manager
echo.

echo Running processes:
wmic process get Name,ProcessId,Priority /format:list | findstr "="
echo.

set /p process_name="Enter process name to change priority: "
set /p new_priority="Enter new priority (1-6, see custom priority menu): "

if "%new_priority%"=="1" set priority_class=REALTIME
if "%new_priority%"=="2" set priority_class=HIGH
if "%new_priority%"=="3" set priority_class=ABOVE_NORMAL
if "%new_priority%"=="4" set priority_class=NORMAL
if "%new_priority%"=="5" set priority_class=BELOW_NORMAL
if "%new_priority%"=="6" set priority_class=LOW

if "%priority_class%"=="" goto menu

wmic process where name="%process_name%" CALL setpriority "%priority_class%"
if %errorLevel% equ 0 (
    echo [SUCCESS] Process priority changed
) else (
    echo [ERROR] Failed to change process priority
)

pause
goto menu

:exit
echo.
echo [INFO] CPU Priority Optimizer closed
exit /b 0
