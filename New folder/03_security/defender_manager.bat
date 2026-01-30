@echo off
chcp 65001 >nul
title Windows Defender Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Windows Defender Manager                       ║
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
echo ║                Windows Defender Manager                      ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Defender Status
echo [2] Enable Real-time Protection
echo [3] Disable Real-time Protection
echo [4] Update Virus Definitions
echo [5] Run Full Scan
echo [6] Run Quick Scan
echo [7] Configure Exclusions
echo [8] Reset Defender Settings
echo [9] Tamper Protection Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto enable_realtime
if "%choice%"=="3" goto disable_realtime
if "%choice%"=="4" goto update_definitions
if "%choice%"=="5" goto full_scan
if "%choice%"=="6" goto quick_scan
if "%choice%"=="7" goto configure_exclusions
if "%choice%"=="8" goto reset_settings
if "%choice%"=="9" goto tamper_protection
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking Windows Defender status...
echo.

:: Check Defender service status
echo [1/4] Checking Defender service status...
sc query "WinDefend" | findstr "STATE"

:: Check real-time protection status
echo [2/4] Checking real-time protection status...
powershell -Command "Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled"

:: Check virus definitions
echo [3/4] Checking virus definitions...
powershell -Command "Get-MpComputerStatus | Select-Object AntispywareSignatureVersion, AntivirusSignatureVersion"

:: Check last scan time
echo [4/4] Checking last scan time...
powershell -Command "Get-MpComputerStatus | Select-Object QuickScanAge, FullScanAge"

pause
goto menu

:enable_realtime
echo.
echo [INFO] Enabling real-time protection...
echo.

:: Enable real-time protection
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"
if %errorLevel% equ 0 (
    echo [SUCCESS] Real-time protection enabled
) else (
    echo [ERROR] Failed to enable real-time protection
)

:: Start Defender service
net start "WinDefend" >nul 2>&1

pause
goto menu

:disable_realtime
echo.
echo [WARNING] Disabling real-time protection reduces security!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling real-time protection...
echo.

:: Disable real-time protection
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
if %errorLevel% equ 0 (
    echo [SUCCESS] Real-time protection disabled
) else (
    echo [ERROR] Failed to disable real-time protection
)

pause
goto menu

:update_definitions
echo.
echo [INFO] Updating virus definitions...
echo.

:: Update definitions
powershell -Command "Update-MpSignature"
if %errorLevel% equ 0 (
    echo [SUCCESS] Virus definitions updated
) else (
    echo [ERROR] Failed to update virus definitions
)

pause
goto menu

:full_scan
echo.
echo [INFO] Starting full system scan...
echo.

:: Start full scan
powershell -Command "Start-MpScan -ScanType FullScan"
if %errorLevel% equ 0 (
    echo [SUCCESS] Full scan started
) else (
    echo [ERROR] Failed to start full scan
)

echo [INFO] This may take some time to complete
pause
goto menu

:quick_scan
echo.
echo [INFO] Starting quick scan...
echo.

:: Start quick scan
powershell -Command "Start-MpScan -ScanType QuickScan"
if %errorLevel% equ 0 (
    echo [SUCCESS] Quick scan started
) else (
    echo [ERROR] Failed to start quick scan
)

pause
goto menu

:configure_exclusions
echo.
echo [INFO] Configuring exclusions...
echo.

echo [1] Add folder exclusion
echo [2] Add file exclusion
echo [3] Add process exclusion
echo [4] Add extension exclusion
echo [5] Remove exclusions
echo [6] List current exclusions
echo [0] Back to main menu
echo.
set /p excl_choice="Select an option [0-6]: "

if "%excl_choice%"=="1" goto add_folder_exclusion
if "%excl_choice%"=="2" goto add_file_exclusion
if "%excl_choice%"=="3" goto add_process_exclusion
if "%excl_choice%"=="4" goto add_extension_exclusion
if "%excl_choice%"=="5" goto remove_exclusions
if "%excl_choice%"=="6" goto list_exclusions
if "%excl_choice%"=="0" goto menu
goto configure_exclusions

:add_folder_exclusion
echo.
set /p folder_path="Enter folder path to exclude: "
powershell -Command "Add-MpPreference -ExclusionPath '%folder_path%'"
if %errorLevel% equ 0 (
    echo [SUCCESS] Folder exclusion added
) else (
    echo [ERROR] Failed to add folder exclusion
)
pause
goto configure_exclusions

:add_file_exclusion
echo.
set /p file_path="Enter file path to exclude: "
powershell -Command "Add-MpPreference -ExclusionPath '%file_path%'"
if %errorLevel% equ 0 (
    echo [SUCCESS] File exclusion added
) else (
    echo [ERROR] Failed to add file exclusion
)
pause
goto configure_exclusions

:add_process_exclusion
echo.
set /p process_name="Enter process name to exclude: "
powershell -Command "Add-MpPreference -ExclusionProcess '%process_name%'"
if %errorLevel% equ 0 (
    echo [SUCCESS] Process exclusion added
) else (
    echo [ERROR] Failed to add process exclusion
)
pause
goto configure_exclusions

:add_extension_exclusion
echo.
set /p file_extension="Enter file extension to exclude (e.g., .exe): "
powershell -Command "Add-MpPreference -ExclusionExtension '%file_extension%'"
if %errorLevel% equ 0 (
    echo [SUCCESS] Extension exclusion added
) else (
    echo [ERROR] Failed to add extension exclusion
)
pause
goto configure_exclusions

:remove_exclusions
echo.
echo [WARNING] This will remove all exclusions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto configure_exclusions

powershell -Command "Set-MpPreference -ExclusionPath @() -ExclusionProcess @() -ExclusionExtension @()"
if %errorLevel% equ 0 (
    echo [SUCCESS] All exclusions removed
) else (
    echo [ERROR] Failed to remove exclusions
)
pause
goto configure_exclusions

:list_exclusions
echo.
echo [INFO] Current exclusions:
echo.
powershell -Command "Get-MpPreference | Select-Object ExclusionPath, ExclusionProcess, ExclusionExtension"
pause
goto configure_exclusions

:reset_settings
echo.
echo [WARNING] This will reset all Defender settings to default!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Resetting Defender settings...
echo.

:: Reset Defender settings
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableBlockAtFirstSeen $false -DisableIOAVProtection $false -DisableScriptScanning $false -DisableArchiveScanning $false -DisableEmailScanning $false -DisableRemovableDriveScanning $false -DisableScanningMappedNetworkDrivesForFullScan $false"

echo [SUCCESS] Defender settings reset to default
pause
goto menu

:tamper_protection
echo.
echo [INFO] Tamper Protection Settings
echo.

echo Current tamper protection status:
powershell -Command "Get-MpComputerStatus | Select-Object TamperProtectionEnabled"
echo.

set /p tamper_choice="Enable tamper protection? [Y/N]: "
if /i "%tamper_choice%"=="Y" (
    echo [INFO] Tamper protection can only be enabled through Windows Security app
    echo Please open Windows Security > Virus & threat protection > Manage settings
) else (
    echo [WARNING] Disabling tamper protection requires manual intervention
    echo Please open Windows Security > Virus & threat protection > Manage settings
)

pause
goto menu

:exit
echo.
echo [INFO] Windows Defender Manager closed
exit /b 0
