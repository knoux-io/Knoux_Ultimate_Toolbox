@echo off
chcp 65001 >nul
title Privacy Disabler Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Privacy Disabler Tool                       ║
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
echo ║                  Privacy Disabler                             ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Disable Telemetry
echo [2] Disable Data Collection
echo [3] Disable Location Tracking
echo [4] Disable Advertising ID
echo [5] Disable Cortana
echo [6] Disable Feedback
echo [7] Disable App Permissions
echo [8] Disable All Privacy Features
echo [9] Restore Privacy Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto disable_telemetry
if "%choice%"=="2" goto disable_data_collection
if "%choice%"=="3" goto disable_location
if "%choice%"=="4" goto disable_advertising
if "%choice%"=="5" goto disable_cortana
if "%choice%"=="6" goto disable_feedback
if "%choice%"=="7" goto disable_permissions
if "%choice%"=="8" goto disable_all
if "%choice%"=="9" goto restore_privacy
if "%choice%"=="0" goto exit
goto menu

:disable_telemetry
echo.
echo [INFO] Disabling telemetry...
echo.

:: Disable telemetry services
sc config "DiagTrack" start= disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1

sc config "dmwappushservice" start= disabled >nul 2>&1
sc stop "dmwappushservice" >nul 2>&1

:: Disable telemetry via registry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

:: Disable Windows Customer Experience Improvement Program
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Telemetry disabled
pause
goto menu

:disable_data_collection
echo.
echo [INFO] Disabling data collection...
echo.

:: Disable data collection
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maintenance" /v DisableDiagnosticPolicyService /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul

:: Disable application telemetry
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f >nul

echo [SUCCESS] Data collection disabled
pause
goto menu

:disable_location
echo.
echo [INFO] Disabling location tracking...
echo.

:: Disable location services
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocationScripting /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableSensors /t REG_DWORD /d 1 /f >nul

:: Disable location for current user
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\LocationAndSensors" /v LocationEnabled /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Location tracking disabled
pause
goto menu

:disable_advertising
echo.
echo [INFO] Disabling advertising ID...
echo.

:: Disable advertising ID
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul

:: Disable tailored experiences
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Advertising ID disabled
pause
goto menu

:disable_cortana
echo.
echo [INFO] Disabling Cortana...
echo.

:: Disable Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CanCortanaBeEnabled /t REG_DWORD /d 0 /f >nul

:: Disable web search
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Cortana disabled
pause
goto menu

:disable_feedback
echo.
echo [INFO] Disabling feedback...
echo.

:: Disable feedback
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Feedback disabled
pause
goto menu

:disable_permissions
echo.
echo [INFO] Disabling app permissions...
echo.

:: Disable camera access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\camera" /v Value /t REG_SZ /d "Deny" /f >nul

:: Disable microphone access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Deny" /f >nul

:: Disable notifications
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v Value /t REG_SZ /d "Deny" /f >nul

:: Disable account info access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v Value /t REG_SZ /d "Deny" /f >nul

:: Disable contacts access
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v Value /t REG_SZ /d "Deny" /f >nul

echo [SUCCESS] App permissions disabled
pause
goto menu

:disable_all
echo.
echo [WARNING] This will disable ALL privacy features!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling all privacy features...
echo.

:: Disable telemetry
sc config "DiagTrack" start= disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

:: Disable location
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul

:: Disable advertising ID
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul

:: Disable Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul

:: Disable feedback
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul

:: Disable app permissions
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\camera" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Deny" /f >nul

echo [SUCCESS] All privacy features disabled
pause
goto menu

:restore_privacy
echo.
echo [INFO] Restoring privacy settings to default...
echo.

:: Enable telemetry (minimal)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f >nul

:: Enable location services
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /f >nul 2>&1

:: Enable advertising ID
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /f >nul 2>&1

:: Enable Cortana
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1

:: Enable feedback
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /f >nul 2>&1

:: Enable app permissions
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\camera" /v Value /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /f >nul 2>&1

echo [SUCCESS] Privacy settings restored to default
pause
goto menu

:exit
echo.
echo [INFO] Privacy Disabler closed
exit /b 0
