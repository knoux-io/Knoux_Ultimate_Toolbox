@echo off
chcp 65001 >nul
title Hibernation Manager Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Hibernation Manager Tool                    ║
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
echo ║                  Hibernation Manager                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Hibernation Status
echo [2] Enable Hibernation
echo [3] Disable Hibernation
echo [4] Configure Hibernation Settings
echo [5] Delete Hibernation File
echo [6] Optimize Power Settings
echo [7] Hybrid Sleep Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-7]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto enable_hibernation
if "%choice%"=="3" goto disable_hibernation
if "%choice%"=="4" goto configure_settings
if "%choice%"=="5" goto delete_hiberfile
if "%choice%"=="6" goto optimize_power
if "%choice%"=="7" goto hybrid_sleep
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking hibernation status...
echo.

:: Check if hibernation is enabled
powercfg /availablesleepstates | findstr /i "hibernate"
if %errorLevel% equ 0 (
    echo [INFO] Hibernation is available
) else (
    echo [WARNING] Hibernation is not available
)

:: Check hibernation file size
echo.
echo [INFO] Hibernation file information:
if exist "%WINDIR%\hiberfil.sys" (
    dir "%WINDIR%\hiberfil.sys" | find "hiberfil.sys"
    echo [INFO] Hibernation file exists
) else (
    echo [INFO] Hibernation file does not exist
)

:: Check current power settings
echo.
echo [INFO] Current power settings:
powercfg /query SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE
powercfg /query SCHEME_CURRENT SUB_SLEEP HIBERNATETIMEOUT

pause
goto menu

:enable_hibernation
echo.
echo [INFO] Enabling hibernation...
echo.

:: Enable hibernation
powercfg /hibernate on
if %errorLevel% equ 0 (
    echo [SUCCESS] Hibernation enabled
) else (
    echo [ERROR] Failed to enable hibernation
)

:: Check if hiberfil.sys was created
if exist "%WINDIR%\hiberfil.sys" (
    echo [SUCCESS] Hibernation file created
) else (
    echo [WARNING] Hibernation file not found
)

pause
goto menu

:disable_hibernation
echo.
echo [WARNING] Disabling hibernation will remove the hibernation file!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling hibernation...
echo.

:: Disable hibernation
powercfg /hibernate off
if %errorLevel% equ 0 (
    echo [SUCCESS] Hibernation disabled
) else (
    echo [ERROR] Failed to disable hibernation
)

:: Check if hiberfil.sys was removed
if exist "%WINDIR%\hiberfil.sys" (
    echo [WARNING] Hibernation file still exists
) else (
    echo [SUCCESS] Hibernation file removed
)

pause
goto menu

:configure_settings
echo.
echo [INFO] Configuring hibernation settings...
echo.

:: Set hibernation timeout
echo [1/3] Setting hibernation timeout to 240 minutes...
powercfg /change standby-timeout-ac 240
powercfg /change standby-timeout-dc 120

:: Configure hibernation behavior
echo [2/3] Configuring hibernation behavior...
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 1

:: Apply settings
echo [3/3] Applying settings...
powercfg /setactive SCHEME_CURRENT

echo [SUCCESS] Hibernation settings configured
pause
goto menu

:delete_hiberfile
echo.
echo [WARNING] This will permanently delete the hibernation file!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Deleting hibernation file...
echo.

:: Delete hibernation file
powercfg /hibernate off
if %errorLevel% equ 0 (
    echo [SUCCESS] Hibernation file deleted
) else (
    echo [ERROR] Failed to delete hibernation file
)

pause
goto menu

:optimize_power
echo.
echo [INFO] Optimizing power settings for hibernation...
echo.

:: Set power plan to balanced
echo [1/4] Setting power plan to Balanced...
powercfg /setactive SCHEME_BALANCED

:: Optimize sleep settings
echo [2/4] Optimizing sleep settings...
powercfg /change standby-timeout-ac 30
powercfg /change standby-timeout-dc 15

:: Optimize hibernation settings
echo [3/4] Optimizing hibernation settings...
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATETIMEOUT 240
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATETIMEOUT 120

:: Apply settings
echo [4/4] Applying settings...
powercfg /setactive SCHEME_CURRENT

echo [SUCCESS] Power settings optimized
pause
goto menu

:hybrid_sleep
echo.
echo [INFO] Configuring hybrid sleep settings...
echo.

:: Enable hybrid sleep on AC power
echo [1/2] Enabling hybrid sleep on AC power...
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 1

:: Enable hybrid sleep on battery power
echo [2/2] Enabling hybrid sleep on battery power...
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 1

:: Apply settings
powercfg /setactive SCHEME_CURRENT

echo [SUCCESS] Hybrid sleep enabled
pause
goto menu

:exit
echo.
echo [INFO] Hibernation Manager closed
exit /b 0
