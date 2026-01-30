@echo off
chcp 65001 >nul
title Disk Space Monitor - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Disk Space Monitor                           ║
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
echo ║                Disk Space Monitor                           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Current Disk Space Status
echo [2] Real-time Monitoring
echo [3] Space Usage Analysis
echo [4] Set Space Alerts
echo [5] Disk Space History
echo [6] Generate Space Report
echo [7] Clean Up Recommendations
echo [8] Schedule Monitoring
echo [9] Advanced Monitoring
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto current_status
if "%choice%"=="2" goto realtime_monitoring
if "%choice%"=="3" goto usage_analysis
if "%choice%"=="4" goto space_alerts
if "%choice%"=="5" goto space_history
if "%choice%"=="6" goto generate_report
if "%choice%"=="7" goto cleanup_recommendations
if "%choice%"=="8" goto schedule_monitoring
if "%choice%"=="9" goto advanced_monitoring
if "%choice%"=="0" goto exit
goto menu

:current_status
echo.
echo [INFO] Current Disk Space Status...
echo.

:: Display current disk space information
echo [1/4] Overall disk status:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,DriveType /format:list

echo.
echo [2/4] Disk usage percentage:
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        set /a free_percent=100-!usage!
        echo Drive %%b: !usage!%% used (!free_percent!%% free)
        if !free_percent! lss 10 (
            echo [WARNING] Low disk space on drive %%b!
        )
    )
)

echo.
echo [3/4] Critical space analysis:
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a free_gb=!free!/1073741824
        if !free_gb! lss 5 (
            echo [CRITICAL] Drive %%b has only !free_gb! GB free!
        )
    )
)

echo.
echo [4/4] System folders space usage:
echo Windows folder:
for /f "tokens=3" %%a in ('dir "%WINDIR%" /s /-c ^| find "bytes"') do (
    set /a windows_gb=%%a/1073741824
    echo !windows_gb! GB
)

echo Program Files:
for /f "tokens=3" %%a in ('dir "%ProgramFiles%" /s /-c ^| find "bytes"') do (
    set /a program_gb=%%a/1073741824
    echo !program_gb! GB
)

pause
goto menu

:realtime_monitoring
echo.
echo [INFO] Real-time Disk Space Monitoring
echo Press Ctrl+C to stop monitoring
echo.

:monitor_loop
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║              Real-time Disk Space Monitor                    ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo Time: %time%
echo.

:: Display current disk usage
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        set /a free_gb=!free!/1073741824
        echo Drive %%b: !usage!%% used (!free_gb! GB free)
        
        if !free_gb! lss 5 (
            echo [CRITICAL] Low space!
        ) else if !free_gb! lss 10 (
            echo [WARNING] Low space!
        )
    )
)

echo.
echo [INFO] Monitoring... (updating every 30 seconds)
timeout /t 30 >nul
goto monitor_loop

:usage_analysis
echo.
echo [INFO] Disk Space Usage Analysis...
echo.

set /p target_path="Enter path to analyze (e.g., C:\Users): "
if "%target_path%"=="" set target_path=C:\Users

echo [1/3] Analyzing folder sizes...
echo Top 10 largest folders in %target_path%:

:: Get folder sizes
for /d %%d in ("%target_path%\*") do (
    echo Analyzing %%d...
    for /f "tokens=3" %%a in ('dir "%%d" /s /-c ^| find "bytes"') do (
        set /a size_gb=%%a/1073741824
        echo %%d: !size_gb! GB
    )
)

echo.
echo [2/3] File type analysis:
for %%e in (exe dll txt docx pdf jpg mp3 mp4 zip iso) do (
    set count=0
    set total_size=0
    for /r "%target_path%" %%f in (*%%e) do (
        set /a count+=1
        set /a total_size+=%%~zf
    )
    set /a total_mb=!total_size!/1048576
    echo .%%e files: !count! files, !total_mb! MB
)

echo.
echo [3/3] Temporary files analysis:
echo Temp folder:
for /f "tokens=3" %%a in ('dir "%TEMP%" /s /-c ^| find "bytes"') do (
    set /a temp_mb=%%a/1048576
    echo !temp_mb! MB
)

pause
goto menu

:space_alerts
echo.
echo [INFO] Disk Space Alerts Configuration...
echo.

echo [1] Set Low Space Alert Threshold
echo [2] Set Critical Space Alert Threshold
echo [3] Enable Email Alerts
echo [4] Test Alerts
echo [5] View Alert History
echo [0] Back to main menu
echo.
set /p alert_choice="Select an option [0-5]: "

if "%alert_choice%"=="1" goto low_threshold
if "%alert_choice%"=="2" goto critical_threshold
if "%alert_choice%"=="3" goto email_alerts
if "%alert_choice%"=="4" goto test_alerts
if "%alert_choice%"=="5" goto alert_history
if "%alert_choice%"=="0" goto menu
goto space_alerts

:low_threshold
echo.
set /p low_percent="Enter low space alert percentage (default 15): "
if "%low_percent%"=="" set low_percent=15

echo [INFO] Low space alert set to %low_percent%%
pause
goto space_alerts

:critical_threshold
echo.
set /p critical_percent="Enter critical space alert percentage (default 5): "
if "%critical_percent%"=="" set critical_percent=5

echo [INFO] Critical space alert set to %critical_percent%%
pause
goto space_alerts

:email_alerts
echo.
echo [INFO] Email alerts require SMTP configuration
echo [INFO] This feature requires manual setup
pause
goto space_alerts

:test_alerts
echo.
echo [INFO] Testing disk space alerts...
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        set /a free_percent=100-!usage!
        if !free_percent! lss 15 (
            echo [ALERT] Low space on drive %%b: !free_percent!%% free
        )
    )
)

pause
goto space_alerts

:alert_history
echo.
echo [INFO] Alert history would be stored in log files
echo [INFO] Current alerts:
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        set /a free_percent=100-!usage!
        if !free_percent! lss 10 (
            echo [%date% %time%] [ALERT] Drive %%b: !free_percent!%% free
        )
    )
)

pause
goto space_alerts

:space_history
echo.
echo [INFO] Disk Space History...
echo.

set history_file=%TEMP%\disk_space_history.txt

if not exist "%history_file%" (
    echo Creating disk space history file...
    echo Date,Time,Drive,Total,Free,Used,Usage%% > "%history_file%"
)

:: Add current data
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        echo %date%,%time%,%%b,!size!,!free!,!used!,!usage!%% >> "%history_file%"
    )
)

echo Disk space history:
echo ====================
type "%history_file%"

pause
goto menu

:generate_report
echo.
echo [INFO] Generating Disk Space Report...
echo.

set report_file=%TEMP%\disk_space_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

echo Disk Space Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/6] Disk Information: >> "%report_file%"
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,DriveType /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [2/6] Usage Summary: >> "%report_file%"
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        set /a free_gb=!free!/1073741824
        echo Drive %%b: !usage!%% used (!free_gb! GB free) >> "%report_file%"
    )
)
echo. >> "%report_file%"

echo [3/6] Critical Alerts: >> "%report_file%"
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a free_gb=!free!/1073741824
        if !free_gb! lss 5 (
            echo [CRITICAL] Drive %%b has only !free_gb! GB free! >> "%report_file%"
        )
    )
)
echo. >> "%report_file%"

echo [4/6] System Folder Usage: >> "%report_file%"
echo Windows: >> "%report_file%"
for /f "tokens=3" %%a in ('dir "%WINDIR%" /s /-c ^| find "bytes"') do (
    set /a windows_gb=%%a/1073741824
    echo !windows_gb! GB >> "%report_file%"
)
echo. >> "%report_file%"

echo [5/6] Recommendations: >> "%report_file%"
echo 1. Run disk cleanup to free up space >> "%report_file%"
echo 2. Remove unnecessary programs >> "%report_file%"
echo 3. Move large files to external storage >> "%report_file%"
echo 4. Enable disk compression if needed >> "%report_file%"
echo 5. Monitor disk space regularly >> "%report_file%"
echo. >> "%report_file%"

echo [6/6] System Information: >> "%report_file%"
echo OS: %OS% >> "%report_file%"
echo Computer: %COMPUTERNAME% >> "%report_file%"
echo User: %USERNAME% >> "%report_file%"

echo [SUCCESS] Disk space report generated
echo [INFO] Report saved to: %report_file%
pause
goto menu

:cleanup_recommendations
echo.
echo [INFO] Cleanup Recommendations...
echo.

:: Analyze disk space and provide recommendations
echo [1/5] Analyzing disk space...
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a free_gb=!free!/1073741824
        set /a free_percent=!free!*100/!size!
        
        echo Drive %%b analysis:
        if !free_gb! lss 5 (
            echo [CRITICAL] Only !free_gb! GB free (!free_percent!%%)
            echo - Immediate cleanup required
            echo - Consider moving large files to external storage
            echo - Run disk cleanup with system files
        ) else if !free_gb! lss 10 (
            echo [WARNING] Only !free_gb! GB free (!free_percent!%%)
            echo - Cleanup recommended soon
            echo - Remove temporary files
            echo - Clear recycle bin
        ) else (
            echo [OK] !free_gb! GB free (!free_percent!%%)
            echo - Disk space is adequate
        )
        echo.
    )
)

echo [2/5] Temporary files analysis:
echo Temp folder size:
for /f "tokens=3" %%a in ('dir "%TEMP%" /s /-c ^| find "bytes"') do (
    set /a temp_mb=%%a/1048576
    echo !temp_mb! MB
    if !temp_mb! gtr 100 (
        echo [RECOMMENDATION] Clean temp folder
    )
)

echo [3/5] Recycle bin analysis:
echo [INFO] Check recycle bin size manually
echo [RECOMMENDATION] Empty recycle bin if large

echo [4/5] Large files analysis:
echo [INFO] Run Large Files Detector to identify space hogs

echo [5/5] System cleanup options:
echo [1] Run Windows Disk Cleanup
echo [2] Remove Windows Update cache
echo [3] Clean system restore points
echo [4] Compress old files

pause
goto menu

:schedule_monitoring
echo.
echo [INFO] Schedule Disk Space Monitoring...
echo.

echo [1] Schedule Daily Monitoring
echo [2] Schedule Weekly Monitoring
echo [3] Schedule Monthly Monitoring
echo [4] Remove Scheduled Monitoring
echo [0] Back to main menu
echo.
set /p schedule_choice="Select an option [0-4]: "

if "%schedule_choice%"=="1" goto daily_schedule
if "%schedule_choice%"=="2" goto weekly_schedule
if "%schedule_choice%"=="3" goto monthly_schedule
if "%schedule_choice%"=="4" goto remove_schedule
if "%schedule_choice%"=="0" goto menu
goto schedule_monitoring

:daily_schedule
echo.
echo [INFO] Scheduling daily disk space monitoring...
schtasks /create /tn "Daily Disk Space Monitor" /tr "\"%~f0\" /monitoring" /sc daily /st 09:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Daily monitoring scheduled
) else (
    echo [ERROR] Failed to schedule monitoring
)

pause
goto schedule_monitoring

:weekly_schedule
echo.
echo [INFO] Scheduling weekly disk space monitoring...
schtasks /create /tn "Weekly Disk Space Monitor" /tr "\"%~f0\" /monitoring" /sc weekly /d MON /st 09:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Weekly monitoring scheduled
) else (
    echo [ERROR] Failed to schedule monitoring
)

pause
goto schedule_monitoring

:monthly_schedule
echo.
echo [INFO] Scheduling monthly disk space monitoring...
schtasks /create /tn "Monthly Disk Space Monitor" /tr "\"%~f0\" /monitoring" /sc monthly /d 1 /st 09:00 /ru SYSTEM

if %errorLevel% equ 0 (
    echo [SUCCESS] Monthly monitoring scheduled
) else (
    echo [ERROR] Failed to schedule monitoring
)

pause
goto schedule_monitoring

:remove_schedule
echo.
echo [INFO] Removing scheduled monitoring...
schtasks /delete /tn "Daily Disk Space Monitor" /f >nul 2>&1
schtasks /delete /tn "Weekly Disk Space Monitor" /f >nul 2>&1
schtasks /delete /tn "Monthly Disk Space Monitor" /f >nul 2>&1

echo [SUCCESS] Scheduled monitoring removed
pause
goto schedule_monitoring

:advanced_monitoring
echo.
echo [INFO] Advanced Disk Space Monitoring...
echo.

echo [1] Monitor Specific Drive
echo [2] Set Custom Thresholds
echo [3] Generate Trend Analysis
echo [4] Export Monitoring Data
echo [5] Performance Impact Analysis
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto monitor_drive
if "%adv_choice%"=="2" goto custom_thresholds
if "%adv_choice%"=="3" goto trend_analysis
if "%adv_choice%"=="4" goto export_data
if "%adv_choice%"=="5" goto performance_analysis
if "%adv_choice%"=="0" goto menu
goto advanced_monitoring

:monitor_drive
echo.
set /p drive_letter="Enter drive letter to monitor (e.g., C): "
if "%drive_letter%"=="" goto advanced_monitoring

echo [INFO] Monitoring drive %drive_letter%:...
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk where "DeviceID='%drive_letter%:'" get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        set /a free_gb=!free!/1073741824
        echo Drive %drive_letter%: !usage!%% used (!free_gb! GB free)
    )
)

pause
goto advanced_monitoring

:custom_thresholds
echo.
set /p warning_threshold="Enter warning threshold (percent): "
set /p critical_threshold="Enter critical threshold (percent): "

echo [INFO] Custom thresholds set:
echo Warning: %warning_threshold%%
echo Critical: %critical_threshold%%
pause
goto advanced_monitoring

:trend_analysis
echo.
echo [INFO] Trend analysis requires historical data
echo [INFO] Current snapshot:
wmic logicaldisk get DeviceID,Size,FreeSpace /format:list

pause
goto advanced_monitoring

:export_data
echo.
set /p export_file="Enter export file path: "
if "%export_file%"=="" set export_file=%TEMP%\disk_space_data.csv

echo "Date","Time","Drive","Total","Free","Used","Usage%%" > "%export_file%"

for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        echo "%date%","%time%","%%b","!size!","!free!","!used!","!usage!%%" >> "%export_file%"
    )
)

echo [SUCCESS] Data exported to %export_file%
pause
goto advanced_monitoring

:performance_analysis
echo.
echo [INFO] Disk space monitoring performance impact...
echo [INFO] Monitoring uses minimal system resources
echo [INFO] Scheduled tasks run in background
echo [INFO] Real-time monitoring uses CPU during updates
pause
goto advanced_monitoring

:exit
echo.
echo [INFO] Disk Space Monitor closed
exit /b 0
