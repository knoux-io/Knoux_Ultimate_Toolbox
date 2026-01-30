@echo off
chcp 65001 >nul
title USB Autorun Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  USB Autorun Manager                         ║
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
echo ║                  USB Autorun Manager                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Current Autorun Settings
echo [2] Disable USB Autorun
echo [3] Enable USB Autorun
echo [4] Disable CD/DVD Autorun
echo [5] Enable CD/DVD Autorun
echo [6] Disable All Autorun
echo [7] Enable All Autorun
echo [8] Configure Removable Drive Access
echo [9] Scan for Suspicious USB Devices
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_settings
if "%choice%"=="2" goto disable_usb_autorun
if "%choice%"=="3" goto enable_usb_autorun
if "%choice%"=="4" goto disable_cd_autorun
if "%choice%"=="5" goto enable_cd_autorun
if "%choice%"=="6" goto disable_all_autorun
if "%choice%"=="7" goto enable_all_autorun
if "%choice%"=="8" goto configure_access
if "%choice%"=="9" goto scan_usb
if "%choice%"=="0" goto exit
goto menu

:check_settings
echo.
echo [INFO] Checking current autorun settings...
echo.

:: Check autorun settings
echo [1/4] Checking autorun for all drives...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun 2>nul
if %errorLevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun 2^>nul ^| find "NoDriveTypeAutoRun"') do set autorun_value=%%a
    echo Current autorun value: %autorun_value%
    if "%autorun_value%"=="255" echo Autorun is disabled for all drives
    if "%autorun_value%"=="181" echo Autorun is disabled for removable drives
    if "%autorun_value%"=="91" echo Autorun is enabled for all drives
) else (
    echo Autorun is enabled by default
)

echo [2/4] Checking USB specific settings...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutorun 2>nul
if %errorLevel% equ 0 (
    echo NoAutorun is set
) else (
    echo NoAutorun is not set
)

echo [3/4] Checking autoplay settings...
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay 2>nul
if %errorLevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay 2^>nul ^| find "DisableAutoplay"') do set autoplay_value=%%a
    if "%autoplay_value%"=="1" echo Autoplay is disabled
) else (
    echo Autoplay is enabled
)

echo [4/4] Checking current USB devices...
wmic logicaldisk where "DriveType=2" get DeviceID,VolumeName,Size,FreeSpace /format:list

pause
goto menu

:disable_usb_autorun
echo.
echo [INFO] Disabling USB autorun...
echo.

:: Disable autorun for removable drives
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 181 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutorun /t REG_DWORD /d 1 /f >nul

:: Disable autoplay for removable drives
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] USB autorun disabled
pause
goto menu

:enable_usb_autorun
echo.
echo [WARNING] Enabling USB autorun may pose security risks!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Enabling USB autorun...
echo.

:: Enable autorun for removable drives
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 91 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutorun /f >nul 2>&1

:: Enable autoplay
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /f >nul 2>&1

echo [SUCCESS] USB autorun enabled
pause
goto menu

:disable_cd_autorun
echo.
echo [INFO] Disabling CD/DVD autorun...
echo.

:: Disable autorun for CD/DVD drives
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 181 /f >nul

echo [SUCCESS] CD/DVD autorun disabled
pause
goto menu

:enable_cd_autorun
echo.
echo [WARNING] Enabling CD/DVD autorun may pose security risks!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Enabling CD/DVD autorun...
echo.

:: Enable autorun for CD/DVD drives
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 91 /f >nul

echo [SUCCESS] CD/DVD autorun enabled
pause
goto menu

:disable_all_autorun
echo.
echo [INFO] Disabling all autorun...
echo.

:: Disable autorun for all drives
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutorun /t REG_DWORD /d 1 /f >nul

:: Disable autoplay
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] All autorun disabled
pause
goto menu

:enable_all_autorun
echo.
echo [WARNING] Enabling all autorun may pose security risks!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Enabling all autorun...
echo.

:: Enable autorun for all drives
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutorun /f >nul 2>&1

:: Enable autoplay
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /f >nul 2>&1

echo [SUCCESS] All autorun enabled
pause
goto menu

:configure_access
echo.
echo [INFO] Configuring removable drive access...
echo.

echo [1] Deny write access to removable drives
echo [2] Allow write access to removable drives
echo [3] Deny read access to removable drives
echo [4] Allow read access to removable drives
echo [5] Configure USB device installation
echo [0] Back to main menu
echo.
set /p access_choice="Select an option [0-5]: "

if "%access_choice%"=="1" goto deny_write
if "%access_choice%"=="2" goto allow_write
if "%access_choice%"=="3" goto deny_read
if "%access_choice%"=="4" goto allow_read
if "%access_choice%"=="5" goto configure_usb_install
if "%access_choice%"=="0" goto menu
goto configure_access

:deny_write
echo.
echo [INFO] Denying write access to removable drives...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" /v DenyWrite /t REG_DWORD /d 1 /f >nul
echo [SUCCESS] Write access denied to removable drives
pause
goto configure_access

:allow_write
echo.
echo [INFO] Allowing write access to removable drives...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" /v DenyWrite /f >nul 2>&1
echo [SUCCESS] Write access allowed to removable drives
pause
goto configure_access

:deny_read
echo.
echo [WARNING] Denying read access will prevent USB drives from working!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto configure_access

echo [INFO] Denying read access to removable drives...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" /v DenyRead /t REG_DWORD /d 1 /f >nul
echo [SUCCESS] Read access denied to removable drives
pause
goto configure_access

:allow_read
echo.
echo [INFO] Allowing read access to removable drives...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" /v DenyRead /f >nul 2>&1
echo [SUCCESS] Read access allowed to removable drives
pause
goto configure_access

:configure_usb_install
echo.
echo [INFO] Configuring USB device installation...
echo.

echo [1] Prevent installation of USB devices
echo [2] Allow installation of USB devices
echo [3] Allow only approved USB devices
echo [0] Back to main menu
echo.
set /p install_choice="Select an option [0-3]: "

if "%install_choice%"=="1" goto prevent_usb_install
if "%install_choice%"=="2" goto allow_usb_install
if "%install_choice%"=="3" goto approved_usb
if "%install_choice%"=="0" goto configure_access
goto configure_usb_install

:prevent_usb_install
echo.
echo [WARNING] This will prevent all USB device installation!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto configure_usb_install

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /v DenyDeviceIDs /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceIDs" /v 1 /t REG_SZ /d "USB\*" /f >nul
echo [SUCCESS] USB device installation prevented
pause
goto configure_usb_install

:allow_usb_install
echo.
echo [INFO] Allowing USB device installation...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /v DenyDeviceIDs /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceIDs" /f >nul 2>&1
echo [SUCCESS] USB device installation allowed
pause
goto configure_usb_install

:approved_usb
echo.
echo [INFO] Configuring approved USB devices...
echo [WARNING] This feature requires manual configuration of approved device IDs
echo [INFO] Please consult Windows documentation for approved device ID format
pause
goto configure_usb_install

:scan_usb
echo.
echo [INFO] Scanning for suspicious USB devices...
echo.

:: Get current USB devices
echo [1/3] Scanning current USB devices...
wmic logicaldisk where "DriveType=2" get DeviceID,VolumeName,Size,FreeSpace /format:list

echo [2/3] Checking for autorun files on USB drives...
for /f "tokens=1" %%d in ('wmic logicaldisk where "DriveType=2" get DeviceID /value ^| find "="') do (
    set drive=%%d
    if exist "!drive!\autorun.inf" (
        echo [WARNING] Found autorun.inf on !drive!
        type "!drive!\autorun.inf"
    )
    if exist "!drive!\*.exe" (
        echo [WARNING] Found executable files on !drive!
        dir "!drive!\*.exe" /b
    )
)

echo [3/3] Checking USB device properties...
wmic path win32_usbcontrollerdevice get Antecedent,Dependent /format:list

echo [SUCCESS] USB scan completed
pause
goto menu

:exit
echo.
echo [INFO] USB Autorun Manager closed
exit /b 0
