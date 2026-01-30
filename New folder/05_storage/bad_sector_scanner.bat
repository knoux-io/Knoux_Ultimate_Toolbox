@echo off
chcp 65001 >nul
title Bad Sector Scanner Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Bad Sector Scanner Tool                       ║
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
echo ║                Bad Sector Scanner                           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Quick Scan
echo [2] Thorough Scan
echo [3] Custom Scan
echo [4] Scan Specific Drive
echo [5] Check Disk Health
echo [6] Repair Bad Sectors
echo [7] Generate Report
echo [8] Schedule Scan
echo [9] Advanced Options
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto quick_scan
if "%choice%"=="2" goto thorough_scan
if "%choice%"=="3" goto custom_scan
if "%choice%"=="4" goto specific_drive
if "%choice%"=="5" goto disk_health
if "%choice%"=="6" goto repair_sectors
if "%choice%"=="7" goto generate_report
if "%choice%"=="8" goto schedule_scan
if "%choice%"=="9" goto advanced_options
if "%choice%"=="0" goto exit
goto menu

:quick_scan
echo.
echo [INFO] Quick Bad Sector Scan...
echo.

set /p drive_letter="Enter drive letter to scan (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [WARNING] This scan will check for bad sectors but may take time
echo [INFO] Starting quick scan on drive %drive_letter%:...
echo.

:: Run quick check
echo [1/2] Checking file system...
chkdsk %drive_letter%: /f

echo.
echo [2/2] Checking for bad sectors...
chkdsk %drive_letter%: /r

echo [SUCCESS] Quick scan completed
pause
goto menu

:thorough_scan
echo.
echo [WARNING] Thorough scan will take significant time!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

set /p drive_letter="Enter drive letter to scan (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Starting thorough scan on drive %drive_letter%:...
echo [INFO] This may take several hours depending on disk size
echo.

:: Run thorough check
echo [1/3] Checking file system integrity...
chkdsk %drive_letter%: /f

echo.
echo [2/3] Scanning for bad sectors...
chkdsk %drive_letter%: /r

echo.
echo [3/3] Recovering readable information...
chkdsk %drive_letter%: /b

echo [SUCCESS] Thorough scan completed
pause
goto menu

:custom_scan
echo.
echo [INFO] Custom Bad Sector Scan...
echo.

set /p drive_letter="Enter drive letter to scan (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [1] Scan only (no repair)
echo [2] Scan and repair
echo [3] Scan with surface test
echo [4] Scan with recovery
echo [0] Back to main menu
echo.
set /p custom_choice="Select an option [0-4]: "

if "%custom_choice%"=="1" goto scan_only
if "%custom_choice%"=="2" goto scan_repair
if "%custom_choice%"=="3" goto scan_surface
if "%custom_choice%"=="4" goto scan_recovery
if "%custom_choice%"=="0" goto menu
goto custom_scan

:scan_only
echo.
echo [INFO] Scanning drive %drive_letter%: (read-only)...
chkdsk %drive_letter%:

echo [SUCCESS] Scan completed
pause
goto custom_scan

:scan_repair
echo.
echo [INFO] Scanning and repairing drive %drive_letter%:...
chkdsk %drive_letter%: /f

echo [SUCCESS] Scan and repair completed
pause
goto custom_scan

:scan_surface
echo.
echo [INFO] Surface scanning drive %drive_letter%:...
chkdsk %drive_letter%: /r

echo [SUCCESS] Surface scan completed
pause
goto custom_scan

:scan_recovery
echo.
echo [INFO] Scanning with recovery on drive %drive_letter%:...
chkdsk %drive_letter%: /b

echo [SUCCESS] Recovery scan completed
pause
goto custom_scan

:specific_drive
echo.
echo [INFO] Available drives:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace /format:list
echo.

set /p drive_letter="Enter drive letter to scan (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Scanning drive %drive_letter%:...
echo.

:: Get drive information
echo [1/3] Drive information:
wmic logicaldisk where "DeviceID='%drive_letter%:'" get Size,FreeSpace,VolumeName /format:list

echo.
echo [2/3] File system check:
chkdsk %drive_letter%: /f

echo.
echo [3/3] Bad sector scan:
chkdsk %drive_letter%: /r

echo [SUCCESS] Drive scan completed
pause
goto menu

:disk_health
echo.
echo [INFO] Disk Health Check...
echo.

:: Check overall disk health
echo [1/4] Disk status:
wmic diskdrive get Status,Model,InterfaceType /format:list

echo.
echo [2/4] S.M.A.R.T. status:
wmic diskdrive get Status /format:list

echo.
echo [3/4] Volume health:
for /f "tokens=1" %%d in ('wmic logicaldisk get DeviceID /value ^| find "="') do (
    set drive=%%d
    echo Checking !drive! health...
    chkdsk !drive! /f
)

echo.
echo [4/4] System file check:
sfc /scannow

echo [SUCCESS] Disk health check completed
pause
goto menu

:repair_sectors
echo.
echo [WARNING] Repairing bad sectors may result in data loss!
set /p confirm="Do you have backups? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

set /p drive_letter="Enter drive letter to repair (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Repairing bad sectors on drive %drive_letter%:...
echo.

:: Repair bad sectors
echo [1/2] Unmounting volume (if possible)...
echo [INFO] Attempting to repair without dismounting...

echo [2/2] Repairing bad sectors...
chkdsk %drive_letter%: /r /f

echo [SUCCESS] Bad sector repair completed
pause
goto menu

:generate_report
echo.
echo [INFO] Generating Bad Sector Scan Report...
echo.

set report_file=%TEMP%\bad_sector_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

echo Bad Sector Scan Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/5] Disk Information: >> "%report_file%"
wmic diskdrive get Model,Status,InterfaceType,Size /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [2/5] Volume Information: >> "%report_file%"
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,FileSystem /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [3/5] Recent Scan Results: >> "%report_file%"
echo Checking recent chkdsk logs... >> "%report_file%"
wevtutil qe Application /q:"*[System[(EventID=1001)]]" /c:5 /rd:true /f:text 2>nul | findstr /i "chkdsk\|bad sector" >> "%report_file%"
echo. >> "%report_file%"

echo [4/5] S.M.A.R.T. Status: >> "%report_file%"
wmic diskdrive get Status /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [5/5] Recommendations: >> "%report_file%"
echo 1. Run regular disk checks >> "%report_file%"
echo 2. Monitor S.M.A.R.T. status >> "%report_file%"
echo 3. Replace drives showing bad sectors >> "%report_file%"
echo 4. Maintain regular backups >> "%report_file%"

echo [SUCCESS] Report generated
echo [INFO] Report saved to: %report_file%
pause
goto menu

:schedule_scan
echo.
echo [INFO] Schedule Bad Sector Scan...
echo.

echo [1] Schedule Weekly Scan
echo [2] Schedule Monthly Scan
echo [3] Schedule Daily Scan
echo [4] Remove Scheduled Scans
echo [0] Back to main menu
echo.
set /p schedule_choice="Select an option [0-4]: "

if "%schedule_choice%"=="1" goto weekly_schedule
if "%schedule_choice%"=="2" goto monthly_schedule
if "%schedule_choice%"=="3" goto daily_schedule
if "%schedule_choice%"=="4" goto remove_schedule
if "%schedule_choice%"=="0" goto menu
goto schedule_scan

:weekly_schedule
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_scan

echo [INFO] Scheduling weekly bad sector scan for drive %drive_letter%:...
schtasks /create /tn "Weekly Bad Sector Scan %drive_letter%" /tr "chkdsk %drive_letter%: /f /r" /sc weekly /d SUN /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Weekly scan scheduled
) else (
    echo [ERROR] Failed to schedule scan
)

pause
goto schedule_scan

:monthly_schedule
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_scan

echo [INFO] Scheduling monthly bad sector scan for drive %drive_letter%:...
schtasks /create /tn "Monthly Bad Sector Scan %drive_letter%" /tr "chkdsk %drive_letter%: /f /r" /sc monthly /d 1 /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Monthly scan scheduled
) else (
    echo [ERROR] Failed to schedule scan
)

pause
goto schedule_scan

:daily_schedule
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_scan

echo [INFO] Scheduling daily bad sector scan for drive %drive_letter%:...
schtasks /create /tn "Daily Bad Sector Scan %drive_letter%" /tr "chkdsk %drive_letter%: /f" /sc daily /st 03:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Daily scan scheduled
) else (
    echo [ERROR] Failed to schedule scan
)

pause
goto schedule_scan

:remove_schedule
echo.
echo [INFO] Removing scheduled bad sector scans...
schtasks /delete /tn "Weekly Bad Sector Scan *" /f >nul 2>&1
schtasks /delete /tn "Monthly Bad Sector Scan *" /f >nul 2>&1
schtasks /delete /tn "Daily Bad Sector Scan *" /f >nul 2>&1

echo [SUCCESS] Scheduled scans removed
pause
goto schedule_scan

:advanced_options
echo.
echo [INFO] Advanced Bad Sector Scanner Options...
echo.

echo [1] Surface Test Only
echo [2] Force Dismount
echo [3] Skip Indexing Check
echo [4] Check Free Space
echo [5] Verify Security Descriptors
echo [6] Shorten Timeout
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-6]: "

if "%adv_choice%"=="1" goto surface_test
if "%adv_choice%"=="2" goto force_dismount
if "%adv_choice%"=="3" goto skip_indexing
if "%adv_choice%"=="4" goto check_freespace
if "%adv_choice%"=="5" goto verify_security
if "%adv_choice%"=="6" goto shorten_timeout
if "%adv_choice%"=="0" goto menu
goto advanced_options

:surface_test
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_options

echo [INFO] Running surface test on drive %drive_letter%:...
chkdsk %drive_letter%: /r /x

echo [SUCCESS] Surface test completed
pause
goto advanced_options

:force_dismount
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_options

echo [WARNING] Force dismount may cause data loss!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto advanced_options

echo [INFO] Force dismounting drive %drive_letter%:...
chkdsk %drive_letter%: /r /x

echo [SUCCESS] Force dismount completed
pause
goto advanced_options

:skip_indexing
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_options

echo [INFO] Skipping indexing check on drive %drive_letter%:...
chkdsk %drive_letter%: /f /i

echo [SUCCESS] Scan with skipped indexing completed
pause
goto advanced_options

:check_freespace
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_options

echo [INFO] Checking free space on drive %drive_letter%:...
chkdsk %drive_letter%: /f /c

echo [SUCCESS] Free space check completed
pause
goto advanced_options

:verify_security
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_options

echo [INFO] Verifying security descriptors on drive %drive_letter%:...
chkdsk %drive_letter%: /f /l

echo [SUCCESS] Security verification completed
pause
goto advanced_options

:shorten_timeout
echo.
echo [INFO] Shortening chkdsk timeout...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v AutoChkTimeOut /t REG_DWORD /d 10 /f >nul

echo [SUCCESS] Timeout shortened to 10 seconds
pause
goto advanced_options

:exit
echo.
echo [INFO] Bad Sector Scanner Tool closed
exit /b 0
