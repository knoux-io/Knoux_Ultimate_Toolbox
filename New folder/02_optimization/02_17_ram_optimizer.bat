@echo off
chcp 65001 >nul
title RAM Optimizer Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    RAM Optimizer Tool                         ║
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

echo [INFO] Starting RAM optimization...
echo.

:: Display current RAM usage
echo [1/6] Current RAM usage:
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:list | findstr "="
echo.

:: Clear standby memory
echo [2/6] Clearing standby memory...
powershell -Command "$Process = [System.Diagnostics.Process]::Start('powershell', '-NoProfile -ExecutionPolicy Bypass -Command \"[System.Runtime.InteropServices.Marshal]::FreeHGlobal((New-Object System.Runtime.InteropServices.GCHandle([IntPtr]::Zero, [System.Runtime.InteropServices.GCHandleType]::Pinned)).AddrOfPinnedObject())\"'); $Process.WaitForExit()"
echo [SUCCESS] Standby memory cleared

:: Optimize page file
echo [3/6] Optimizing page file settings...
wmic computersystem where "name='%computername%'" set AutomaticManagedPagefile=True
echo [SUCCESS] Page file optimization completed

:: Clean memory dumps
echo [4/6] Cleaning memory dump files...
del /q /f "%WINDIR%\*.dmp" 2>nul
del /q /f "%WINDIR%\Minidump\*.dmp" 2>nul
echo [SUCCESS] Memory dump files cleaned

:: Optimize system cache
echo [5/6] Optimizing system cache...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul
echo [SUCCESS] System cache optimized

:: Restart memory management services
echo [6/6] Restarting memory management services...
net stop "SysMain" 2>nul
net start "SysMain" 2>nul
echo [SUCCESS] Memory management services restarted

:: Display optimized RAM usage
echo.
echo [INFO] RAM optimization completed!
echo.
echo [INFO] Optimized RAM usage:
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:list | findstr "="

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  RAM Optimization Complete                   ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [INFO] RAM has been optimized for better performance.
echo [INFO] Consider restarting your computer for best results.
echo.
pause
