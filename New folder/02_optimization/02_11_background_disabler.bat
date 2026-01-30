@echo off
chcp 65001 >nul
title Background Disabler Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Background Disabler Tool                    ║
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
echo ║                  Background Disabler                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Disable Windows Background Services
echo [2] Disable Telemetry Services
echo [3] Disable Update Services
echo [4] Disable Indexing Service
echo [5] Disable Superfetch/Prefetch
echo [6] Disable All Background Services
echo [7] Enable Background Services
echo [8] Current Background Services Status
echo [0] Exit
echo.
set /p choice="Select an option [0-8]: "

if "%choice%"=="1" goto disable_background
if "%choice%"=="2" goto disable_telemetry
if "%choice%"=="3" goto disable_update
if "%choice%"=="4" goto disable_indexing
if "%choice%"=="5" goto disable_superfetch
if "%choice%"=="6" goto disable_all
if "%choice%"=="7" goto enable_services
if "%choice%"=="8" goto status_check
if "%choice%"=="0" goto exit
goto menu

:disable_background
echo.
echo [INFO] Disabling Windows background services...
echo.

:: Disable background services
sc config "Background Intelligent Transfer Service" start= disabled >nul 2>&1
sc stop "Background Intelligent Transfer Service" >nul 2>&1

sc config "Windows Search" start= disabled >nul 2>&1
sc stop "Windows Search" >nul 2>&1

sc config "Windows Update" start= disabled >nul 2>&1
sc stop "Windows Update" >nul 2>&1

sc config "SysMain" start= disabled >nul 2>&1
sc stop "SysMain" >nul 2>&1

echo [SUCCESS] Background services disabled
pause
goto menu

:disable_telemetry
echo.
echo [INFO] Disabling telemetry services...
echo.

:: Disable telemetry services
sc config "DiagTrack" start= disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1

sc config "dmwappushservice" start= disabled >nul 2>&1
sc stop "dmwappushservice" >nul 2>&1

:: Disable telemetry via registry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Telemetry services disabled
pause
goto menu

:disable_update
echo.
echo [INFO] Disabling update services...
echo.

:: Disable update services
sc config "wuauserv" start= disabled >nul 2>&1
sc stop "wuauserv" >nul 2>&1

sc config "UsoSvc" start= disabled >nul 2>&1
sc stop "UsoSvc" >nul 2>&1

echo [SUCCESS] Update services disabled
pause
goto menu

:disable_indexing
echo.
echo [INFO] Disabling indexing service...
echo.

:: Disable indexing service
sc config "WSearch" start= disabled >nul 2>&1
sc stop "WSearch" >nul 2>&1

:: Disable indexing via registry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowIndexingEncryptedStoresOrItems /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Indexing service disabled
pause
goto menu

:disable_superfetch
echo.
echo [INFO] Disabling Superfetch/Prefetch...
echo.

:: Disable Superfetch
sc config "SysMain" start= disabled >nul 2>&1
sc stop "SysMain" >nul 2>&1

:: Disable prefetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Superfetch/Prefetch disabled
pause
goto menu

:disable_all
echo.
echo [WARNING] This will disable ALL background services!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling all background services...

:: Disable all background services
sc config "Background Intelligent Transfer Service" start= disabled >nul 2>&1
sc config "Windows Search" start= disabled >nul 2>&1
sc config "Windows Update" start= disabled >nul 2>&1
sc config "SysMain" start= disabled >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1
sc config "dmwappushservice" start= disabled >nul 2>&1
sc config "wuauserv" start= disabled >nul 2>&1
sc config "UsoSvc" start= disabled >nul 2>&1
sc config "WSearch" start= disabled >nul 2>&1

:: Stop all services
sc stop "Background Intelligent Transfer Service" >nul 2>&1
sc stop "Windows Search" >nul 2>&1
sc stop "Windows Update" >nul 2>&1
sc stop "SysMain" >nul 2>&1
sc stop "DiagTrack" >nul 2>&1
sc stop "dmwappushservice" >nul 2>&1
sc stop "wuauserv" >nul 2>&1
sc stop "UsoSvc" >nul 2>&1
sc stop "WSearch" >nul 2>&1

echo [SUCCESS] All background services disabled
pause
goto menu

:enable_services
echo.
echo [INFO] Enabling background services...
echo.

:: Enable background services
sc config "Background Intelligent Transfer Service" start= demand >nul 2>&1
sc config "Windows Search" start= auto >nul 2>&1
sc config "Windows Update" start= auto >nul 2>&1
sc config "SysMain" start= auto >nul 2>&1

:: Enable telemetry (optional)
sc config "DiagTrack" start= auto >nul 2>&1
sc config "dmwappushservice" start= demand >nul 2>&1

:: Enable prefetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul

echo [SUCCESS] Background services enabled
pause
goto menu

:status_check
echo.
echo [INFO] Current background services status:
echo.
echo Background Services:
sc query "Background Intelligent Transfer Service" | findstr "STATE"
sc query "Windows Search" | findstr "STATE"
sc query "Windows Update" | findstr "STATE"
sc query "SysMain" | findstr "STATE"
echo.
echo Telemetry Services:
sc query "DiagTrack" | findstr "STATE"
sc query "dmwappushservice" | findstr "STATE"
echo.
echo Update Services:
sc query "wuauserv" | findstr "STATE"
sc query "UsoSvc" | findstr "STATE"
echo.
pause
goto menu

:exit
echo.
echo [INFO] Background Disabler closed
exit /b 0
