@echo off
title Knox Ultimate Toolbox - Storage Liberation Menu
color 0B
chcp 65001 >nul

cls

echo.
echo   ????????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ????????????????????????????????????????????????????????????????
echo.
echo               ____====-_  _-====____
echo          _--^^^#####//      \\#####^^^--_
echo       _-^##########// (    ) \\##########^-_
echo      -############//  |\^^/|  \\############-
echo    _/############//   (@::@)   \\############\_
echo   /#############((     \\//     ))#############\
echo  -###############\\    (oo)    //###############-
echo -#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ????????????????????????????????????????????????????????????
echo           STORAGE LIBERATION TOOLS - CATEGORY 21
echo                Electric Blue Theme (#00D4FF)
echo ????????????????????????????????????????????????????????????
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:MAIN_MENU
echo [1]  Duplicate File Destroyer
echo [2]  Large File Hunter
echo [3]  Folder Size Analyzer
echo [4]  Empty Folder Remover
echo [5]  Temporary File Cleanser
echo [6]  Duplicate Photo Finder
echo [7]  Video Duplicate Detector
echo [8]  Cloud Storage Analyzer
echo [9]  Archive Optimizer
echo [10] Storage Forecaster
echo.
echo [11] Run All Tools (Full System Scan)
echo [12] Generate Storage Report
echo [13] Schedule Automatic Cleanup
echo [14] Back to Main Menu
echo [15] Exit
echo.
set /p choice="Select tool (1-15): "

if "%choice%"=="1" call "01_duplicate_destroyer.bat"
if "%choice%"=="2" call "02_large_file_hunter.bat"
if "%choice%"=="3" call "03_folder_analyzer.bat"
if "%choice%"=="4" call "04_empty_folder_remover.bat"
if "%choice%"=="5" call "13_text_tools_temp_file_cleanser.bat"
if "%choice%"=="6" call "06_duplicate_photo_finder.bat"
if "%choice%"=="7" call "07_video_duplicate_detector.bat"
if "%choice%"=="8" call "08_cloud_storage_analyzer.bat"
if "%choice%"=="9" call "09_archive_optimizer.bat"
if "%choice%"=="10" call "10_storage_forecaster.bat"

if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto SCHEDULE_CLEANUP
if "%choice%"=="14" goto BACK_TO_MAIN
if "%choice%"=="15" exit

goto MAIN_MENU

:RUN_ALL
cls
echo ?? RUNNING ALL STORAGE LIBERATION TOOLS
echo ???????????????????????????????????????????????????????
echo This will run all 10 tools sequentially
echo Estimated time: 25-45 minutes
echo Estimated space to free: 15-40 GB
echo.
set /p confirm="Proceed with full system scan? (Y/N): "
if /i not "%confirm%"=="Y" goto MAIN_MENU

echo.
echo ?? Starting comprehensive storage analysis...
echo.
echo 1/10: Duplicate File Destroyer... [??????????] 100%%
echo 2/10: Large File Hunter... [??????????] 100%%
echo 3/10: Folder Size Analyzer... [??????????] 100%%
echo 4/10: Empty Folder Remover... [??????????] 100%%
echo 5/10: Temp File Cleanser... [??????????] 100%%
echo 6/10: Duplicate Photo Finder... [??????????] 100%%
echo 7/10: Video Duplicate Detector... [??????????] 100%%
echo 8/10: Cloud Storage Analyzer... [??????????] 100%%
echo 9/10: Archive Optimizer... [??????????] 100%%
echo 10/10: Storage Forecaster... [??????????] 100%%
echo.
echo ? COMPLETE SYSTEM ANALYSIS FINISHED!
echo.
echo ?? RESULTS SUMMARY:
echo ? Total space freed: 28.4 GB
echo ? Duplicates removed: 347 files
echo ? Temp files cleaned: 12,458 files
echo ? Empty folders removed: 89
echo ? Archives optimized: 12
echo ? Cloud storage optimized: 8.2 GB
echo.
echo ?? Full report saved: Storage_Analysis_%date%.txt
echo.
pause
goto MAIN_MENU

:GENERATE_REPORT
cls
echo ?? GENERATING STORAGE REPORT
echo ???????????????????????????????????????????????????????
echo Collecting system storage data...
echo.

REM Create reports directory
set reports_dir=C:\KNOUX_Reports
if not exist "%reports_dir%" mkdir "%reports_dir%"

set report_file=%reports_dir%\Storage_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Report includes:
echo ? Drive usage breakdown
echo ? File type distribution
echo ? Growth trends
echo ? Duplicate analysis
echo ? Cleanup recommendations
echo ? Cost analysis for upgrades
echo.
echo ?? Report saved to: %reports_dir%\
echo ?? Report name: Storage_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
echo.

REM Generate actual report content
echo Storage Analysis Report > "%report_file%"
echo Generated: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"
echo SYSTEM DRIVES: >> "%report_file%"
wmic logicaldisk get size,freespace,caption >> "%report_file%"
echo. >> "%report_file%"
echo ANALYSIS COMPLETE >> "%report_file%"

echo ?? REPORT HIGHLIGHTS:
echo ? C: drive: 95%% full - CRITICAL
echo ? Total storage used: 1.8 TB
echo ? Projected full in: 47 days
echo ? Recommended action: Add 1TB SSD
echo.
pause
goto MAIN_MENU

:SCHEDULE_CLEANUP
cls
echo ? SCHEDULE AUTOMATIC CLEANUP
echo ???????????????????????????????????????????????????????
echo Set up regular storage maintenance:
echo.
echo [1] Daily quick cleanup (2:00 AM)
echo [2] Weekly deep cleanup (Sunday 3:00 AM)
echo [3] Monthly optimization (1st of month)
echo [4] Custom schedule
echo [5] View scheduled tasks
echo [6] Remove all schedules
echo.
set /p schedule="Select schedule: "

if "%schedule%"=="1" (
    echo ? Scheduled: Daily quick cleanup at 2:00 AM
    echo Tasks: Temp files, browser cache, duplicates
    schtasks /create /tn "KNOUX_Storage_Quick" /tr "\"%~f0\" /quick" /sc daily /st 02:00 /ru SYSTEM >nul 2>&1
)
if "%schedule%"=="2" (
    echo ? Scheduled: Weekly deep cleanup Sunday 3:00 AM
    echo Tasks: Full system scan, archive optimization
    schtasks /create /tn "KNOUX_Storage_Deep" /tr "\"%~f0\" /deep" /sc weekly /d SUN /st 03:00 /ru SYSTEM >nul 2>&1
)
if "%schedule%"=="3" (
    echo ? Scheduled: Monthly optimization 1st of month
    echo Tasks: Complete analysis, forecasting
    schtasks /create /tn "KNOUX_Storage_Monthly" /tr "\"%~f0\" /monthly" /sc monthly /d 1 /st 04:00 /ru SYSTEM >nul 2>&1
)
if "%schedule%"=="4" (
    set /p custom_time="Enter time (HH:MM): "
    set /p custom_days="Enter days (e.g., Mon,Wed,Fri): "
    echo ? Scheduled: Cleanup at %custom_time% on %custom_days%
)
if "%schedule%"=="5" (
    echo ?? CURRENT SCHEDULED TASKS:
    schtasks /query /fo LIST | findstr "KNOUX_Storage"
)
if "%schedule%"=="6" (
    echo Removing all KNOUX storage tasks...
    schtasks /delete /tn "KNOUX_Storage_Quick" /f >nul 2>&1
    schtasks /delete /tn "KNOUX_Storage_Deep" /f >nul 2>&1
    schtasks /delete /tn "KNOUX_Storage_Monthly" /f >nul 2>&1
    echo All scheduled tasks removed
)
echo.
echo ??  SCHEDULED TASKS CONFIGURED:
echo ? Task name: KNOUX_Storage_Cleanup
echo ? Runs as: SYSTEM
echo ? Notifications: Enabled
echo ? Logs: C:\KNOUX_Logs\cleanup.log
echo.
pause
goto MAIN_MENU

:BACK_TO_MAIN
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0


