@echo off
chcp 65001 >nul
title Startup Manager Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    Startup Manager Tool                       ║
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
echo ║                    Startup Manager                           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] List Current Startup Programs
echo [2] Disable Startup Program
echo [3] Enable Startup Program
echo [4] Remove Startup Program
echo [5] Add Startup Program
echo [6] Optimize Startup
echo [7] Reset to Default
echo [0] Exit
echo.
set /p choice="Select an option [0-7]: "

if "%choice%"=="1" goto list_startup
if "%choice%"=="2" goto disable_startup
if "%choice%"=="3" goto enable_startup
if "%choice%"=="4" goto remove_startup
if "%choice%"=="5" goto add_startup
if "%choice%"=="6" goto optimize_startup
if "%choice%"=="7" goto reset_default
if "%choice%"=="0" goto exit
goto menu

:list_startup
echo.
echo [INFO] Current startup programs:
echo.
echo Registry startup entries:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" 2>nul
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.
echo Startup folder programs:
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /b 2>nul
dir "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup" /b 2>nul
echo.
echo Task Scheduler startup tasks:
schtasks /query /fo LIST | findstr /i "TaskName\|Status\|Logon" | findstr /v "Disabled"
pause
goto menu

:disable_startup
echo.
echo [INFO] Available startup programs:
echo.
wmic startup get Caption,Command,Location /format:list
echo.
set /p program="Enter program name to disable: "
wmic startup where "Caption='%program%'" call disable
if %errorLevel% equ 0 (
    echo [SUCCESS] Program disabled from startup
) else (
    echo [ERROR] Failed to disable program
)
pause
goto menu

:enable_startup
echo.
echo [INFO] Disabled startup programs:
echo.
wmic startup where "Enabled=False" get Caption,Command,Location /format:list
echo.
set /p program="Enter program name to enable: "
wmic startup where "Caption='%program%'" call enable
if %errorLevel% equ 0 (
    echo [SUCCESS] Program enabled for startup
) else (
    echo [ERROR] Failed to enable program
)
pause
goto menu

:remove_startup
echo.
echo [INFO] Current startup programs:
echo.
wmic startup get Caption,Command,Location /format:list
echo.
set /p program="Enter program name to remove: "
wmic startup where "Caption='%program%'" call delete
if %errorLevel% equ 0 (
    echo [SUCCESS] Program removed from startup
) else (
    echo [ERROR] Failed to remove program
)
pause
goto menu

:add_startup
echo.
set /p name="Enter program name: "
set /p path="Enter program path: "
set /p args="Enter program arguments (optional): "
if "%args%"=="" (
    wmic startup create Caption="%name%" Command="%path%"
) else (
    wmic startup create Caption="%name%" Command="%path% %args%"
)
if %errorLevel% equ 0 (
    echo [SUCCESS] Program added to startup
) else (
    echo [ERROR] Failed to add program to startup
)
pause
goto menu

:optimize_startup
echo.
echo [INFO] Optimizing startup configuration...
echo.

:: Disable unnecessary startup programs
echo Disabling common unnecessary startup programs...
wmic startup where "Caption='Adobe Updater'" call disable 2>nul
wmic startup where "Caption='Java Update Scheduler'" call disable 2>nul
wmic startup where "Caption='Skype'" call disable 2>nul
wmic startup where "Caption='Spotify'" call disable 2>nul

:: Optimize startup delay
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v MaxStartupDelay /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Startup optimization completed
pause
goto menu

:reset_default
echo.
echo [WARNING] This will reset all startup programs to Windows defaults!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Resetting startup to default...
:: Remove all non-essential startup programs
for /f "skip=1 tokens=1" %%a in ('wmic startup get Caption') do (
    wmic startup where "Caption='%%a'" call delete 2>nul
)

echo [SUCCESS] Startup reset to default
pause
goto menu

:exit
echo.
echo [INFO] Startup Manager closed
exit /b 0
