@echo off
chcp 65001 >nul
title Disk Defragmentation Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Disk Defragmentation Tool                      ║
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
echo ║                Disk Defragmentation                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Analyze Disk Fragmentation
echo [2] Defragment All Disks
echo [3] Defragment Specific Disk
echo [4] Quick Defragmentation
echo [5] Optimize Drive
echo [6] Schedule Defragmentation
echo [7] Defragmentation Report
echo [8] SSD Optimization
echo [9] Advanced Defragmentation
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto analyze_disk
if "%choice%"=="2" goto defrag_all
if "%choice%"=="3" goto defrag_specific
if "%choice%"=="4" goto quick_defrag
if "%choice%"=="5" goto optimize_drive
if "%choice%"=="6" goto schedule_defrag
if "%choice%"=="7" goto defrag_report
if "%choice%"=="8" goto ssd_optimization
if "%choice%"=="9" goto advanced_defrag
if "%choice%"=="0" goto exit
goto menu

:analyze_disk
echo.
echo [INFO] Analyzing disk fragmentation...
echo.

:: List available drives
echo Available drives:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace /format:list
echo.

set /p drive_letter="Enter drive letter to analyze (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Analyzing drive %drive_letter%:...
defrag %drive_letter%: /A

echo [SUCCESS] Analysis completed
pause
goto menu

:defrag_all
echo.
echo [WARNING] This will defragment all disks!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Defragmenting all disks...
echo.

:: Defragment all drives
for /f "tokens=1" %%d in ('wmic logicaldisk get DeviceID /value ^| find "="') do (
    set drive=%%d
    echo Defragmenting !drive!...
    defrag !drive! /V
)

echo [SUCCESS] All disks defragmented
pause
goto menu

:defrag_specific
echo.
echo Available drives:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace /format:list
echo.

set /p drive_letter="Enter drive letter to defragment (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Defragmenting drive %drive_letter%:...
defrag %drive_letter%: /V

echo [SUCCESS] Drive %drive_letter%: defragmented
pause
goto menu

:quick_defrag
echo.
echo [INFO] Quick defragmentation...
echo.

set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Quick defragmenting drive %drive_letter%:...
defrag %drive_letter%: /U

echo [SUCCESS] Quick defragmentation completed
pause
goto menu

:optimize_drive
echo.
echo [INFO] Optimizing drive...
echo.

set /p drive_letter="Enter drive letter to optimize (e.g., C): "
if "%drive_letter%"=="" goto menu

echo [INFO] Optimizing drive %drive_letter%:...
defrag %drive_letter%: /O

echo [SUCCESS] Drive optimization completed
pause
goto menu

:schedule_defrag
echo.
echo [INFO] Schedule defragmentation...
echo.

echo [1] Schedule Weekly Defragmentation
echo [2] Schedule Monthly Defragmentation
echo [3] Schedule Daily Defragmentation
echo [4] Remove Scheduled Defragmentation
echo [0] Back to main menu
echo.
set /p schedule_choice="Select an option [0-4]: "

if "%schedule_choice%"=="1" goto weekly_schedule
if "%schedule_choice%"=="2" goto monthly_schedule
if "%schedule_choice%"=="3" goto daily_schedule
if "%schedule_choice%"=="4" goto remove_schedule
if "%schedule_choice%"=="0" goto menu
goto schedule_defrag

:weekly_schedule
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_defrag

echo [INFO] Scheduling weekly defragmentation for drive %drive_letter%:...
schtasks /create /tn "Weekly Defrag %drive_letter%" /tr "defrag %drive_letter%: /V" /sc weekly /d SUN /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Weekly defragmentation scheduled
) else (
    echo [ERROR] Failed to schedule defragmentation
)

pause
goto schedule_defrag

:monthly_schedule
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_defrag

echo [INFO] Scheduling monthly defragmentation for drive %drive_letter%:...
schtasks /create /tn "Monthly Defrag %drive_letter%" /tr "defrag %drive_letter%: /V" /sc monthly /d 1 /st 02:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Monthly defragmentation scheduled
) else (
    echo [ERROR] Failed to schedule defragmentation
)

pause
goto schedule_defrag

:daily_schedule
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto schedule_defrag

echo [INFO] Scheduling daily defragmentation for drive %drive_letter%:...
schtasks /create /tn "Daily Defrag %drive_letter%" /tr "defrag %drive_letter%: /V" /sc daily /st 03:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Daily defragmentation scheduled
) else (
    echo [ERROR] Failed to schedule defragmentation
)

pause
goto schedule_defrag

:remove_schedule
echo.
echo [INFO] Removing scheduled defragmentation tasks...
schtasks /delete /tn "Weekly Defrag *" /f >nul 2>&1
schtasks /delete /tn "Monthly Defrag *" /f >nul 2>&1
schtasks /delete /tn "Daily Defrag *" /f >nul 2>&1

echo [SUCCESS] Scheduled defragmentation tasks removed
pause
goto schedule_defrag

:defrag_report
echo.
echo [INFO] Generating defragmentation report...
echo.

set report_file=%TEMP%\defrag_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

echo Disk Defragmentation Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/4] Drive Information: >> "%report_file%"
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,DriveType /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [2/4] Defragmentation Analysis: >> "%report_file%"
for /f "tokens=1" %%d in ('wmic logicaldisk get DeviceID /value ^| find "="') do (
    set drive=%%d
    echo Analyzing !drive!... >> "%report_file%"
    defrag !drive! /A >> "%report_file%" 2>&1
    echo. >> "%report_file%"
)

echo [3/4] Scheduled Tasks: >> "%report_file%"
schtasks /query | findstr "Defrag" >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo [4/4] System Information: >> "%report_file%"
echo OS: %OS% >> "%report_file%"
echo Computer: %COMPUTERNAME% >> "%report_file%"

echo [SUCCESS] Defragmentation report generated
echo [INFO] Report saved to: %report_file%
pause
goto menu

:ssd_optimization
echo.
echo [INFO] SSD Optimization...
echo.

echo [WARNING] SSDs should not be defragmented!
echo [INFO] SSDs use TRIM command for optimization
echo.

echo [1] Enable TRIM
echo [2] Check TRIM Status
echo [3] Optimize SSD (TRIM)
echo [4] Disable Defragmentation for SSD
echo [0] Back to main menu
echo.
set /p ssd_choice="Select an option [0-4]: "

if "%ssd_choice%"=="1" goto enable_trim
if "%ssd_choice%"=="2" goto check_trim
if "%ssd_choice%"=="3" goto optimize_ssd
if "%ssd_choice%"=="4" goto disable_defrag_ssd
if "%ssd_choice%"=="0" goto menu
goto ssd_optimization

:enable_trim
echo.
echo [INFO] Enabling TRIM...
fsutil behavior query DisableDeleteNotify
fsutil behavior set DisableDeleteNotify 0

echo [SUCCESS] TRIM enabled
pause
goto ssd_optimization

:check_trim
echo.
echo [INFO] Checking TRIM status...
fsutil behavior query DisableDeleteNotify

if %errorLevel% equ 0 (
    echo [INFO] TRIM status check completed
) else (
    echo [ERROR] Failed to check TRIM status
)

pause
goto ssd_optimization

:optimize_ssd
echo.
set /p drive_letter="Enter SSD drive letter (e.g., C): "
if "%drive_letter%"=="" goto ssd_optimization

echo [INFO] Optimizing SSD drive %drive_letter%:...
defrag %drive_letter%: /O

echo [SUCCESS] SSD optimization completed
pause
goto ssd_optimization

:disable_defrag_ssd
echo.
echo [INFO] Disabling automatic defragmentation for SSDs...
echo [WARNING] This requires manual configuration of defragmentation settings
echo [INFO] Use Windows Defragmenter to exclude SSD drives
pause
goto ssd_optimization

:advanced_defrag
echo.
echo [INFO] Advanced Defragmentation...
echo.

echo [1] Force Defragmentation
echo [2] Consolidate Free Space
echo [3] Defragment with Priority
echo [4] Boot Time Defragmentation
echo [5] Custom Defragmentation
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto force_defrag
if "%adv_choice%"=="2" goto consolidate_space
if "%adv_choice%"=="3" goto priority_defrag
if "%adv_choice%"=="4" goto boot_defrag
if "%adv_choice%"=="5" goto custom_defrag
if "%adv_choice%"=="0" goto menu
goto advanced_defrag

:force_defrag
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_defrag

echo [WARNING] Force defragmentation may take a long time!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto advanced_defrag

echo [INFO] Force defragmenting drive %drive_letter%:...
defrag %drive_letter%: /F /V

echo [SUCCESS] Force defragmentation completed
pause
goto advanced_defrag

:consolidate_space
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_defrag

echo [INFO] Consolidating free space on drive %drive_letter%:...
defrag %drive_letter%: /X

echo [SUCCESS] Free space consolidation completed
pause
goto advanced_defrag

:priority_defrag
echo.
set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_defrag

echo [INFO] High priority defragmentation of drive %drive_letter%:...
defrag %drive_letter%: /H /V

echo [SUCCESS] High priority defragmentation completed
pause
goto advanced_defrag

:boot_defrag
echo.
echo [WARNING] Boot time defragmentation requires restart!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto advanced_defrag

echo [INFO] Scheduling boot time defragmentation...
defrag C: /B

echo [SUCCESS] Boot time defragmentation scheduled
echo [INFO] Restart your computer to start boot defragmentation
pause
goto advanced_defrag

:custom_defrag
echo.
echo [INFO] Custom defragmentation options...
echo.

set /p drive_letter="Enter drive letter (e.g., C): "
if "%drive_letter%"=="" goto advanced_defrag

echo [1] Analyze only
echo [2] Normal defragmentation
echo [3] Quick defragmentation
echo [4] Full defragmentation
echo [5] Consolidate only
echo.
set /p custom_choice="Select defragmentation type [1-5]: "

if "%custom_choice%"=="1" (
    defrag %drive_letter%: /A
) else if "%custom_choice%"=="2" (
    defrag %drive_letter%: /V
) else if "%custom_choice%"=="3" (
    defrag %drive_letter%: /U
) else if "%custom_choice%"=="4" (
    defrag %drive_letter%: /F /V
) else if "%custom_choice%"=="5" (
    defrag %drive_letter%: /X
)

echo [SUCCESS] Custom defragmentation completed
pause
goto advanced_defrag

:exit
echo.
echo [INFO] Disk Defragmentation Tool closed
exit /b 0
