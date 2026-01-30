@echo off
chcp 65001 >nul
title Event Logs Cleaner Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Event Logs Cleaner Tool                     ║
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
echo ║                  Event Logs Cleaner                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Event Log Status
echo [2] Clear Application Logs
echo [3] Clear System Logs
echo [4] Clear Security Logs
echo [5] Clear All Event Logs
echo [6] Clear Specific Log
echo [7] Configure Log Settings
echo [8] Export Event Logs
echo [9] Backup Event Logs
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto clear_application
if "%choice%"=="3" goto clear_system
if "%choice%"=="4" goto clear_security
if "%choice%"=="5" goto clear_all
if "%choice%"=="6" goto clear_specific
if "%choice%"=="7" goto configure_settings
if "%choice%"=="8" goto export_logs
if "%choice%"=="9" goto backup_logs
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking event log status...
echo.

:: Get event log information
echo [1/4] Checking Application log...
wevtutil qe Application /c:1 /rd:true /f:text >nul 2>&1
if %errorLevel% equ 0 (
    echo Application log is accessible
    wevtutil gli Application | findstr "logSize\|oldestRecordNumber\|recordCount"
) else (
    echo Application log is not accessible
)

echo [2/4] Checking System log...
wevtutil qe System /c:1 /rd:true /f:text >nul 2>&1
if %errorLevel% equ 0 (
    echo System log is accessible
    wevtutil gli System | findstr "logSize\|oldestRecordNumber\|recordCount"
) else (
    echo System log is not accessible
)

echo [3/4] Checking Security log...
wevtutil qe Security /c:1 /rd:true /f:text >nul 2>&1
if %errorLevel% equ 0 (
    echo Security log is accessible
    wevtutil gli Security | findstr "logSize\|oldestRecordNumber\|recordCount"
) else (
    echo Security log is not accessible
)

echo [4/4] Checking all available logs...
echo Available event logs:
wevtutil el | more

pause
goto menu

:clear_application
echo.
echo [WARNING] This will clear all Application event logs!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Clearing Application logs...
echo.

:: Clear Application log
wevtutil cl Application
if %errorLevel% equ 0 (
    echo [SUCCESS] Application log cleared
) else (
    echo [ERROR] Failed to clear Application log
)

pause
goto menu

:clear_system
echo.
echo [WARNING] This will clear all System event logs!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Clearing System logs...
echo.

:: Clear System log
wevtutil cl System
if %errorLevel% equ 0 (
    echo [SUCCESS] System log cleared
) else (
    echo [ERROR] Failed to clear System log
)

pause
goto menu

:clear_security
echo.
echo [WARNING] This will clear all Security event logs!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Clearing Security logs...
echo.

:: Clear Security log
wevtutil cl Security
if %errorLevel% equ 0 (
    echo [SUCCESS] Security log cleared
) else (
    echo [ERROR] Failed to clear Security log
)

pause
goto menu

:clear_all
echo.
echo [WARNING] This will clear ALL event logs!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Clearing all event logs...
echo.

:: Clear all logs
for /f %%i in ('wevtutil el') do (
    echo Clearing %%i...
    wevtutil cl %%i >nul 2>&1
)

echo [SUCCESS] All event logs cleared
pause
goto menu

:clear_specific
echo.
echo [INFO] Available event logs:
echo.
wevtutil el
echo.

set /p log_name="Enter log name to clear: "
if "%log_name%"=="" goto menu

echo [WARNING] This will clear the %log_name% log!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Clearing %log_name% log...
wevtutil cl "%log_name%"
if %errorLevel% equ 0 (
    echo [SUCCESS] %log_name% log cleared
) else (
    echo [ERROR] Failed to clear %log_name% log
)

pause
goto menu

:configure_settings
echo.
echo [INFO] Configuring event log settings...
echo.

echo [1] Configure log retention
echo [2] Configure log size limits
echo [3] Configure log backup settings
echo [4] Configure log access permissions
echo [0] Back to main menu
echo.
set /p config_choice="Select an option [0-4]: "

if "%config_choice%"=="1" goto configure_retention
if "%config_choice%"=="2" goto configure_size
if "%config_choice%"=="3" goto configure_backup
if "%config_choice%"=="4" goto configure_permissions
if "%config_choice%"=="0" goto menu
goto configure_settings

:configure_retention
echo.
echo [INFO] Configuring log retention settings...
echo.

set /p log_name="Enter log name (Application/System/Security): "
if "%log_name%"=="" goto configure_settings

echo Retention options:
echo [1] Overwrite events as needed
echo [2] Archive log when full
echo [3] Do not overwrite events
echo.
set /p retention_choice="Select retention option [1-3]: "

if "%retention_choice%"=="1" (
    wevtutil sl "%log_name%" /rt:false
    echo [SUCCESS] Log retention set to overwrite as needed
) else if "%retention_choice%"=="2" (
    wevtutil sl "%log_name%" /rt:true
    echo [SUCCESS] Log retention set to archive when full
) else if "%retention_choice%"=="3" (
    wevtutil sl "%log_name%" /rt:true /ab:false
    echo [SUCCESS] Log retention set to do not overwrite
)

pause
goto configure_settings

:configure_size
echo.
echo [INFO] Configuring log size limits...
echo.

set /p log_name="Enter log name (Application/System/Security): "
if "%log_name%"=="" goto configure_settings

set /p max_size="Enter maximum log size (KB): "
if "%max_size%"=="" set max_size=20480

wevtutil sl "%log_name%" /ms:%max_size%
if %errorLevel% equ 0 (
    echo [SUCCESS] Maximum log size set to %max_size% KB
) else (
    echo [ERROR] Failed to set log size
)

pause
goto configure_settings

:configure_backup
echo.
echo [INFO] Configuring log backup settings...
echo.

set /p log_name="Enter log name (Application/System/Security): "
if "%log_name%"=="" goto configure_settings

set /p backup_path="Enter backup path: "
if "%backup_path%"=="" goto configure_settings

wevtutil sl "%log_name%" /ab:true
if %errorLevel% equ 0 (
    echo [SUCCESS] Log backup enabled
    echo [INFO] Logs will be backed up to: %backup_path%
) else (
    echo [ERROR] Failed to enable log backup
)

pause
goto configure_settings

:configure_permissions
echo.
echo [INFO] Configuring log access permissions...
echo.

echo Current log permissions:
wevtutil gl Application | findstr "channelAccess"
wevtutil gl System | findstr "channelAccess"
wevtutil gl Security | findstr "channelAccess"

echo.
set /p log_name="Enter log name to modify permissions: "
if "%log_name%"=="" goto configure_settings

echo Example permissions: O:BAG:SYD:(A;;0x1;;;SY)(A;;0x5;;;BA)(A;;0x1;;;LA)(A;;0x3;;;IU)
set /p permissions="Enter new permissions (leave blank to keep current): "

if not "%permissions%"=="" (
    wevtutil sl "%log_name%" /ca:"%permissions%"
    if %errorLevel% equ 0 (
        echo [SUCCESS] Log permissions updated
    ) else (
        echo [ERROR] Failed to update log permissions
    )
)

pause
goto configure_settings

:export_logs
echo.
echo [INFO] Exporting event logs...
echo.

set /p log_name="Enter log name to export: "
if "%log_name%"=="" goto menu

set /p export_path="Enter export file path: "
if "%export_path%"=="" set export_path=%TEMP%\%log_name%_export.evtx

echo [INFO] Exporting %log_name% log to %export_path%...
wevtutil epl "%log_name%" "%export_path%"
if %errorLevel% equ 0 (
    echo [SUCCESS] Log exported successfully
    echo [INFO] Exported to: %export_path%
) else (
    echo [ERROR] Failed to export log
)

pause
goto menu

:backup_logs
echo.
echo [INFO] Creating backup of all event logs...
echo.

set backup_dir=%TEMP%\EventLogs_Backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
mkdir "%backup_dir%" 2>nul

echo [INFO] Backing up event logs to: %backup_dir%

:: Backup all logs
for /f %%i in ('wevtutil el') do (
    echo Backing up %%i...
    wevtutil epl "%%i" "%backup_dir%\%%i.evtx" >nul 2>&1
)

echo [SUCCESS] Event logs backed up
echo [INFO] Backup location: %backup_dir%

pause
goto menu

:exit
echo.
echo [INFO] Event Logs Cleaner closed
exit /b 0
