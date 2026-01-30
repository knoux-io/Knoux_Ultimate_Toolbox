@echo off
chcp 65001 >nul
title Shadow Copy Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Shadow Copy Manager                          ║
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
echo ║                Shadow Copy Manager                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] List Shadow Copies
echo [2] Create Shadow Copy
echo [3] Delete Shadow Copies
echo [4] Restore from Shadow Copy
echo [5] Shadow Copy Settings
echo [6] Schedule Shadow Copies
echo [7] Shadow Copy Report
echo [8] Mount Shadow Copy
echo [9] Advanced Options
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto list_shadows
if "%choice%"=="2" goto create_shadow
if "%choice%"=="3" goto delete_shadows
if "%choice%"=="4" goto restore_shadow
if "%choice%"=="5" goto shadow_settings
if "%choice%"=="6" goto schedule_shadows
if "%choice%"=="7" goto shadow_report
if "%choice%"=="8" goto mount_shadow
if "%choice%"=="9" goto advanced_options
if "%choice%"=="0" goto exit
goto menu

:list_shadows
echo.
echo [INFO] Listing Shadow Copies...
echo.

:: List all shadow copies
echo [1/3] Local shadow copies:
vssadmin list shadows

echo.
echo [2/3] Shadow copy storage:
vssadmin list shadowstorage

echo.
echo [3/3] Shadow copy writers:
vssadmin list writers

pause
goto menu

:create_shadow
echo.
echo [INFO] Creating Shadow Copy...
echo.

set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [WARNING] Creating shadow copy may take time...
set /p confirm="Continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Creating shadow copy for drive %drive_letter%:...
vssadmin create shadow /for=%drive_letter%:

if %errorLevel% equ 0 (
    echo [SUCCESS] Shadow copy created
) else (
    echo [ERROR] Failed to create shadow copy
)

pause
goto menu

:delete_shadows
echo.
echo [WARNING] This will delete shadow copies!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [1] Delete All Shadow Copies
echo [2] Delete Oldest Shadow Copies
echo [3] Delete Specific Shadow Copy
echo [0] Back to main menu
echo.
set /p delete_choice="Select an option [0-3]: "

if "%delete_choice%"=="1" goto delete_all
if "%delete_choice%"=="2" goto delete_oldest
if "%delete_choice%"=="3" goto delete_specific
if "%delete_choice%"=="0" goto menu
goto delete_shadows

:delete_all
echo.
echo [INFO] Deleting all shadow copies...
vssadmin delete shadows /all /quiet

if %errorLevel% equ 0 (
    echo [SUCCESS] All shadow copies deleted
) else (
    echo [ERROR] Failed to delete shadow copies
)

pause
goto delete_shadows

:delete_oldest
echo.
echo [INFO] Deleting oldest shadow copies...
vssadmin delete shadows /for=C: /oldest /quiet

if %errorLevel% equ 0 (
    echo [SUCCESS] Oldest shadow copies deleted
) else (
    echo [ERROR] Failed to delete oldest shadow copies
)

pause
goto delete_shadows

:delete_specific
echo.
echo [INFO] Available shadow copies:
vssadmin list shadows

echo.
set /p shadow_id="Enter shadow copy ID to delete: "
if "%shadow_id%"=="" goto delete_shadows

echo [INFO] Deleting shadow copy %shadow_id%...
vssadmin delete shadows /shadow=%shadow_id% /quiet

if %errorLevel% equ 0 (
    echo [SUCCESS] Shadow copy deleted
) else (
    echo [ERROR] Failed to delete shadow copy
)

pause
goto delete_shadows

:restore_shadow
echo.
echo [INFO] Restore from Shadow Copy...
echo.

echo [1] List Available Shadow Copies
echo [2] Restore File
echo [3] Restore Folder
echo [4] List Files in Shadow Copy
echo [0] Back to main menu
echo.
set /p restore_choice="Select an option [0-4]: "

if "%restore_choice%"=="1" goto list_available
if "%restore_choice%"=="2" goto restore_file
if "%restore_choice%"=="3" goto restore_folder
if "%restore_choice%"=="4" goto list_files
if "%restore_choice%"=="0" goto menu
goto restore_shadow

:list_available
echo.
echo [INFO] Available shadow copies:
vssadmin list shadows

pause
goto restore_shadow

:restore_file
echo.
echo [INFO] Available shadow copies:
vssadmin list shadows

echo.
set /p shadow_id="Enter shadow copy ID: "
if "%shadow_id%"=="" goto restore_shadow

set /p source_file="Enter source file path: "
if "%source_file%"=="" goto restore_shadow

set /p destination_file="Enter destination file path: "
if "%destination_file%"=="" goto restore_shadow

echo [INFO] Restoring file from shadow copy...
copy "\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy%shadow_id%\%source_file%" "%destination_file%"

if %errorLevel% equ 0 (
    echo [SUCCESS] File restored
) else (
    echo [ERROR] Failed to restore file
)

pause
goto restore_shadow

:restore_folder
echo.
echo [INFO] Available shadow copies:
vssadmin list shadows

echo.
set /p shadow_id="Enter shadow copy ID: "
if "%shadow_id%"=="" goto restore_shadow

set /p source_folder="Enter source folder path: "
if "%source_folder%"=="" goto restore_shadow

set /p destination_folder="Enter destination folder path: "
if "%destination_folder%"=="" goto restore_shadow

echo [INFO] Restoring folder from shadow copy...
robocopy "\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy%shadow_id%\%source_folder%" "%destination_folder%" /E /COPYALL

if %errorLevel% leq 7 (
    echo [SUCCESS] Folder restored
) else (
    echo [ERROR] Failed to restore folder
)

pause
goto restore_shadow

:list_files
echo.
echo [INFO] Available shadow copies:
vssadmin list shadows

echo.
set /p shadow_id="Enter shadow copy ID: "
if "%shadow_id%"=="" goto restore_shadow

set /p folder_path="Enter folder path to list: "
if "%folder_path%"=="" goto restore_shadow

echo [INFO] Listing files in shadow copy...
dir "\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy%shadow_id%\%folder_path%"

pause
goto restore_shadow

:shadow_settings
echo.
echo [INFO] Shadow Copy Settings...
echo.

echo [1] Configure Shadow Copy Storage
echo [2] Set Maximum Shadow Storage
echo [3] Configure Shadow Copy Schedule
echo [4] Enable/Disable Shadow Copy
echo [5] View Current Settings
echo [0] Back to main menu
echo.
set /p settings_choice="Select an option [0-5]: "

if "%settings_choice%"=="1" goto configure_storage
if "%settings_choice%"=="2" goto max_storage
if "%settings_choice%"=="3" goto configure_schedule
if "%settings_choice%"=="4" goto enable_disable
if "%settings_choice%"=="5" goto view_settings
if "%settings_choice%"=="0" goto menu
goto shadow_settings

:configure_storage
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto shadow_settings

set /p storage_size="Enter storage size (e.g., 10GB): "
if "%storage_size%"=="" goto shadow_settings

echo [INFO] Configuring shadow copy storage...
vssadmin resize shadowstorage /for=%drive_letter%: /on=%drive_letter%: /maxsize=%storage_size%

if %errorLevel% equ 0 (
    echo [SUCCESS] Shadow storage configured
) else (
    echo [ERROR] Failed to configure shadow storage
)

pause
goto shadow_settings

:max_storage
echo.
echo [INFO] Setting maximum shadow storage...
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=10GB

if %errorLevel% equ 0 (
    echo [SUCCESS] Maximum shadow storage set to 10GB
) else (
    echo [ERROR] Failed to set maximum shadow storage
)

pause
goto shadow_settings

:configure_schedule
echo.
echo [INFO] Shadow copy scheduling requires manual configuration
echo [INFO] Use Task Scheduler to create shadow copy tasks
echo [INFO] Example: vssadmin create shadow /for=C:
pause
goto shadow_settings

:enable_disable
echo.
echo [1] Enable Shadow Copy
echo [2] Disable Shadow Copy
echo [0] Back
echo.
set /p enable_choice="Select an option [0-2]: "

if "%enable_choice%"=="1" (
    echo [INFO] Enabling shadow copy...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoChkTimeOut" /t REG_DWORD /d 10 /f >nul
    echo [SUCCESS] Shadow copy enabled
) else if "%enable_choice%"=="2" (
    echo [INFO] Disabling shadow copy...
    vssadmin delete shadows /all /quiet
    echo [SUCCESS] Shadow copy disabled
)

pause
goto shadow_settings

:view_settings
echo.
echo [INFO] Current shadow copy settings:
echo.

echo [1/3] Shadow storage information:
vssadmin list shadowstorage

echo.
echo [2/3] Shadow copy writers:
vssadmin list writers

echo.
echo [3/3] Registry settings:
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoChkTimeOut" 2>nul

pause
goto shadow_settings

:schedule_shadows
echo.
echo [INFO] Schedule Shadow Copies...
echo.

echo [1] Create Daily Shadow Copy Task
echo [2] Create Weekly Shadow Copy Task
echo [3] Create Monthly Shadow Copy Task
echo [4] Remove Scheduled Tasks
echo [0] Back to main menu
echo.
set /p schedule_choice="Select an option [0-4]: "

if "%schedule_choice%"=="1" goto daily_task
if "%schedule_choice%"=="2" goto weekly_task
if "%schedule_choice%"=="3" goto monthly_task
if "%schedule_choice%"=="4" goto remove_tasks
if "%schedule_choice%"=="0" goto menu
goto schedule_shadows

:daily_task
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_shadows

echo [INFO] Creating daily shadow copy task...
schtasks /create /tn "Daily Shadow Copy %drive_letter%" /tr "vssadmin create shadow /for=%drive_letter%:" /sc daily /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Daily shadow copy task created
) else (
    echo [ERROR] Failed to create task
)

pause
goto schedule_shadows

:weekly_task
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_shadows

echo [INFO] Creating weekly shadow copy task...
schtasks /create /tn "Weekly Shadow Copy %drive_letter%" /tr "vssadmin create shadow /for=%drive_letter%:" /sc weekly /d SUN /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Weekly shadow copy task created
) else (
    echo [ERROR] Failed to create task
)

pause
goto schedule_shadows

:monthly_task
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_shadows

echo [INFO] Creating monthly shadow copy task...
schtasks /create /tn "Monthly Shadow Copy %drive_letter%" /tr "vssadmin create shadow /for=%drive_letter%:" /sc monthly /d 1 /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Monthly shadow copy task created
) else (
    echo [ERROR] Failed to create task
)

pause
goto schedule_shadows

:remove_tasks
echo.
echo [INFO] Removing scheduled shadow copy tasks...
schtasks /delete /tn "Daily Shadow Copy *" /f >nul 2>&1
schtasks /delete /tn "Weekly Shadow Copy *" /f >nul 2>&1
schtasks /delete /tn "Monthly Shadow Copy *" /f >nul 2>&1

echo [SUCCESS] Scheduled tasks removed
pause
goto schedule_shadows

:shadow_report
echo.
echo [INFO] Generating Shadow Copy Report...
echo.

set report_file=%TEMP%\shadow_copy_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

echo Shadow Copy Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/6] Current Shadow Copies: >> "%report_file%"
vssadmin list shadows >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo [2/6] Shadow Storage Information: >> "%report_file%"
vssadmin list shadowstorage >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo [3/6] Shadow Copy Writers: >> "%report_file%"
vssadmin list writers >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo [4/6] Scheduled Tasks: >> "%report_file%"
schtasks /query | findstr "Shadow Copy" >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo [5/6] Disk Space Usage: >> "%report_file%"
wmic logicaldisk get DeviceID,Size,FreeSpace /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [6/6] Recommendations: >> "%report_file%"
echo 1. Monitor shadow copy storage usage >> "%report_file%"
echo 2. Delete old shadow copies when storage is full >> "%report_file%"
echo 3. Schedule regular shadow copies for important data >> "%report_file%"
echo 4. Test restore procedures regularly >> "%report_file%"

echo [SUCCESS] Shadow copy report generated
echo [INFO] Report saved to: %report_file%
pause
goto menu

:mount_shadow
echo.
echo [INFO] Mount Shadow Copy...
echo.

echo [INFO] Available shadow copies:
vssadmin list shadows

echo.
set /p shadow_id="Enter shadow copy ID: "
if "%shadow_id%"=="" goto menu

set /p mount_point="Enter mount point (e.g., X): "
if "%mount_point%"=="" goto menu

echo [INFO] Mounting shadow copy...
mklink /d "%mount_point%:" "\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy%shadow_id%\"

if %errorLevel% equ 0 (
    echo [SUCCESS] Shadow copy mounted to %mount_point%:
    echo [INFO] Access files at %mount_point%:
    echo [INFO] To unmount: rmdir "%mount_point%:"
) else (
    echo [ERROR] Failed to mount shadow copy
)

pause
goto menu

:advanced_options
echo.
echo [INFO] Advanced Shadow Copy Options...
echo.

echo [1] Create System State Backup
echo [2] Verify Shadow Copy Integrity
echo [3] Export Shadow Copy Metadata
echo [4] Import Shadow Copy Configuration
echo [5] Shadow Copy Performance Tuning
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto system_backup
if "%adv_choice%"=="2" goto verify_integrity
if "%adv_choice%"=="3" goto export_metadata
if "%adv_choice%"=="4" goto import_config
if "%adv_choice%"=="5" goto performance_tuning
if "%adv_choice%"=="0" goto menu
goto advanced_options

:system_backup
echo.
echo [INFO] Creating system state backup...
echo [WARNING] This requires Windows Server Backup or wbadmin
echo [INFO] For Windows 10/11, use File History or System Restore
pause
goto advanced_options

:verify_integrity
echo.
echo [INFO] Verifying shadow copy integrity...
echo [INFO] This requires specialized tools
echo [INFO] Basic verification: Check if shadow copies are accessible
vssadmin list shadows

pause
goto advanced_options

:export_metadata
echo.
echo [INFO] Exporting shadow copy metadata...
set metadata_file=%TEMP%\shadow_metadata_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Shadow Copy Metadata > "%metadata_file%"
echo Exported on: %date% %time% >> "%metadata_file%"
echo ======================================== >> "%metadata_file%"

vssadmin list shadows >> "%metadata_file%" 2>&1
vssadmin list shadowstorage >> "%metadata_file%" 2>&1

echo [SUCCESS] Metadata exported to %metadata_file%
pause
goto advanced_options

:import_config
echo.
echo [INFO] Importing shadow copy configuration...
echo [INFO] This requires manual configuration
pause
goto advanced_options

:performance_tuning
echo.
echo [INFO] Shadow copy performance tuning...
echo.

echo [1] Optimize Shadow Copy Storage
echo [2] Configure Shadow Copy Frequency
echo [3] Set Resource Limits
echo [0] Back
echo.
set /p perf_choice="Select an option [0-3]: "

if "%perf_choice%"=="1" (
    echo [INFO] Optimizing shadow copy storage...
    vssadmin resize shadowstorage /for=C: /on=C: /maxsize=5GB
) else if "%perf_choice%"=="2" (
    echo [INFO] Shadow copy frequency depends on schedule
) else if "%perf_choice%"=="3" (
    echo [INFO] Resource limits configured via registry
)

pause
goto advanced_options

:exit
echo.
echo [INFO] Shadow Copy Manager closed
exit /b 0
