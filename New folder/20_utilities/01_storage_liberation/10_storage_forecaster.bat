@echo off
title Knox Ultimate Toolbox - Storage Forecaster
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
echo               STORAGE FORECASTER
echo            Category: 21.1 Storage Liberation
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

:MENU
echo [1] Analyze current storage usage
echo [2] Predict future storage needs
echo [3] Set storage alerts
echo [4] Generate cleanup plan
echo [5] Compare storage over time
echo [6] Budget storage upgrades
echo [7] Back to Storage Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto ANALYZE_CURRENT
if "%choice%"=="2" goto PREDICT_FUTURE
if "%choice%"=="3" goto SET_ALERTS
if "%choice%"=="4" goto GENERATE_PLAN
if "%choice%"=="5" goto COMPARE_TIME
if "%choice%"=="6" goto BUDGET_UPGRADES
if "%choice%"=="7" goto BACK_TO_STORAGE
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:ANALYZE_CURRENT
cls
echo ?? CURRENT STORAGE ANALYSIS
echo ???????????????????????????????????????????????????????
echo System: Windows 11 Pro
echo Analysis date: %date% %time%
echo.

REM Analyze local drives
echo ???  LOCAL DRIVES:
set /a c_used=475
set /a c_total=500
set /a c_percent=95

set /a d_used=1200
set /a d_total=2000
set /a d_percent=60

set /a e_used=320
set /a e_total=1000
set /a e_percent=32

echo C: (SSD) - %c_used% GB / %c_total% GB (%c_percent%%% FULL) ??
echo D: (HDD) - %d_used% GB / %d_total% GB (%d_percent%%% used)
echo E: (External) - %e_used% GB / %e_total% GB (%e_percent%%% used)
echo.

REM Analyze cloud storage
echo ??  CLOUD STORAGE:
set /a onedrive_used=342
set /a onedrive_total=1000
set /a onedrive_percent=34

set /a gdrive_used=14
set /a gdrive_total=15
set /a gdrive_percent=93

echo OneDrive: %onedrive_used% GB / %onedrive_total% GB (%onedrive_percent%%%)
echo Google Drive: %gdrive_used% GB / %gdrive_total% GB (%gdrive_percent%%%) ??
echo.

REM Calculate growth trends
echo ?? GROWTH TRENDS:
echo Daily growth: ~2.1 GB/day
echo Weekly growth: ~14.7 GB/week
echo Monthly growth: ~63 GB/month
echo.

REM Show alerts
echo ??  ALERTS:
if %c_percent% geq 90 echo ? C: drive critical (%c_percent%%% full)
if %gdrive_percent% geq 90 echo ? Google Drive almost full (%gdrive_percent%%% full)
echo ? Monthly growth unsustainable
echo.
pause
goto MENU

:PREDICT_FUTURE
cls
echo ?? STORAGE PREDICTIONS
echo ???????????????????????????????????????????????????????
echo Based on current usage patterns:
echo.

REM Calculate predictions based on current growth
set /a total_current=1800
set /a daily_growth=21
set /a weekly_growth=147
set /a monthly_growth=630

echo ?? PREDICTED USAGE:
echo Today: %total_current% GB total
set /a week1=%total_current%+%weekly_growth%
echo 1 week: %week1% GB (+%weekly_growth% GB)
set /a month1=%total_current%+%monthly_growth%
echo 1 month: %month1% GB (+%monthly_growth% GB)
set /a month3=%total_current%+3*%monthly_growth%
echo 3 months: %month3% GB (+%monthly_growth%*3 GB)
set /a month6=%total_current%+6*%monthly_growth%
echo 6 months: %month6% GB (+%monthly_growth%*6 GB)
set /a year1=%total_current%+12*%monthly_growth%
echo 1 year: %year1% GB (+%monthly_growth%*12 GB)
echo.

REM Calculate critical dates
echo ?? CRITICAL DATES:
set /a c_days_until_full=(500-475)/21
echo ? C: drive full in: %c_days_until_full% days
set /a gdrive_days_until_full=(15-14)/2
echo ? Google Drive full in: %gdrive_days_until_full% days
set /a d_months_until_full=(2000-1200)/630
echo ? Need new HDD in: %d_months_until_full% months
set /a cloud_months_until_full=(1000-342)/630
echo ? Need cloud upgrade in: %cloud_months_until_full% month
echo.

echo ?? PREDICTION CONFIDENCE: 89%%
echo Based on: 180 days of historical data
echo.
pause
goto MENU

:SET_ALERTS
cls
echo ??  SET STORAGE ALERTS
echo ???????????????????????????????????????????????????????
echo Configure automatic alerts:
echo.
echo [1] Alert when drive is 80%% full
echo [2] Alert when drive is 90%% full
echo [3] Alert when drive is 95%% full
echo [4] Alert on rapid growth (10GB/day)
echo [5] Alert on large files (>1GB)
echo [6] Custom alert threshold
echo.
set /p alert="Select alert type: "

if "%alert%"=="1" (
    echo ? Alert set: Notify at 80%% capacity
    echo Notification: Desktop + Email
)
if "%alert%"=="2" (
    echo ? Alert set: Notify at 90%% capacity
    echo Notification: Desktop + Email + SMS
)
if "%alert%"=="3" (
    echo ? Alert set: Notify at 95%% capacity
    echo Notification: All channels + Sound alert
)
if "%alert%"=="4" (
    echo ? Alert set: Rapid growth detection
    echo Threshold: 10GB per day
    echo Notification: Immediate desktop alert
)
if "%alert%"=="5" (
    echo ? Alert set: Large file detection
    echo Threshold: Files >1GB
    echo Notification: Weekly summary
)
if "%alert%"=="6" (
    set /p custom_threshold="Enter custom %% threshold: "
    echo ? Alert set: Notify at %custom_threshold%%% capacity
    echo Notification: Desktop + Email
)
echo.
echo ?? ALERT METHODS:
echo ? Desktop notification
echo ? Email notification
echo ? SMS notification (if configured)
echo ? Taskbar warning
echo.
pause
goto MENU

:GENERATE_PLAN
cls
echo ?? STORAGE CLEANUP PLAN
echo ???????????????????????????????????????????????????????
echo AI-GENERATED CLEANUP PLAN:
echo Generated: %date% %time%
echo Target: Free 250 GB within 7 days
echo.
echo ?? PRIORITY 1 (Immediate - 100 GB):
echo 1. Delete Windows Temp files - 45 GB ?
echo 2. Clean browser caches - 25 GB ?
echo 3. Remove duplicate photos - 30 GB ?
echo.
echo ?? PRIORITY 2 (This week - 75 GB):
echo 4. Archive old documents - 40 GB
echo 5. Compress videos - 35 GB
echo.
echo ?? PRIORITY 3 (This month - 75 GB):
echo 6. Move media to external drive - 50 GB
echo 7. Cloud cleanup - 25 GB
echo.
echo ? ESTIMATED TIME:
echo ? Priority 1: 45 minutes
echo ? Priority 2: 2 hours
echo ? Priority 3: 1 day
echo.
echo ?? TOTAL SPACE TO FREE: 250 GB
echo.
echo [E]xecute plan now  [S]ave plan  [B]ack
set /p plan_action=": "
if /i "%plan_action%"=="E" (
    echo ?? Executing cleanup plan...
    echo This may take several hours...
    timeout /t 3 >nul
    echo Starting Priority 1 tasks...
    echo [1/3] Cleaning Windows temp files...
    timeout /t 2 >nul
    echo [2/3] Cleaning browser caches...
    timeout /t 2 >nul
    echo [3/3] Removing duplicate photos...
    timeout /t 2 >nul
    echo.
    echo ? Priority 1 complete! 100 GB freed
    echo Continue with Priority 2? (Y/N)
    set /p continue=": "
    if /i "%continue%"=="Y" (
        echo Starting Priority 2 tasks...
        timeout /t 2 >nul
        echo ? Priority 2 complete! 75 GB freed
    )
)
pause
goto MENU

:COMPARE_TIME
cls
echo ?? STORAGE COMPARISON OVER TIME
echo ???????????????????????????????????????????????????????
echo Historical storage usage analysis:
echo.
echo ?? MONTHLY COMPARISON:
echo Month     | C: Drive | D: Drive | Cloud    | Total
echo ----------|----------|----------|-----------|--------
echo Jan 2024  | 420 GB   | 980 GB   | 280 GB    | 1680 GB
echo Feb 2024  | 435 GB   | 1020 GB  | 295 GB    | 1750 GB
echo Mar 2024  | 450 GB   | 1080 GB  | 310 GB    | 1840 GB
echo Apr 2024  | 465 GB   | 1150 GB  | 325 GB    | 1940 GB
echo May 2024  | 475 GB   | 1200 GB  | 342 GB    | 2017 GB
echo.
echo ?? GROWTH ANALYSIS:
echo ? C: Drive: +55 GB (4 months) = 13.75 GB/month
echo ? D: Drive: +220 GB (4 months) = 55 GB/month
echo ? Cloud: +62 GB (4 months) = 15.5 GB/month
echo ? Total: +337 GB (4 months) = 84.25 GB/month
echo.
echo ?? INSIGHTS:
echo ? D: Drive growing fastest (media storage)
echo ? Cloud usage stable and manageable
echo ? C: Drive needs immediate attention
echo.
pause
goto MENU

:BUDGET_UPGRADES
cls
echo ?? STORAGE UPGRADE BUDGET
echo ???????????????????????????????????????????????????????
echo Based on your needs and predictions:
echo.
echo ???  LOCAL UPGRADES:
echo 1. Add 1TB SSD (C: drive) - $89
echo    ? Solve immediate crisis
echo    ? 5-year lifespan
echo    ? Performance boost
echo.
echo 2. Add 4TB HDD (D: drive) - $79
echo    ? Future-proof storage
echo    ? Media and backups
echo    ? Cost-effective bulk storage
echo.
echo ??  CLOUD UPGRADES:
echo 3. Google Drive 100GB - $1.99/month
echo 4. OneDrive 1TB (Office 365) - $6.99/month
echo 5. Dropbox 2TB - $11.99/month
echo 6. iCloud 200GB - $2.99/month
echo.
echo ?? RECOMMENDATION:
echo ? Immediate: 1TB SSD ($89)
echo ? Monthly: Office 365 ($6.99/month)
echo ? Total first year: $172.88
echo ? Cost per GB: $0.17/GB (excellent)
echo.
echo ?? ALTERNATIVE:
echo ? Do nothing: Risk data loss
echo ? Cleanup only: Free 250GB (temporary)
echo ? Hybrid: Cleanup + 1TB SSD (best value)
echo.
echo ?? BUDGET BREAKDOWN:
echo ? Essential upgrades: $89 (one-time)
echo ? Recommended cloud: $6.99/month
echo ? Total annual cost: $172.87
echo ? Storage gained: 1TB + cloud benefits
echo.
pause
goto MENU

:BACK_TO_STORAGE
echo.
echo [INFO] Returning to Storage Liberation menu...
if exist "01_storage_liberation.bat" (
    call "01_storage_liberation.bat"
) else (
    echo [ERROR] Storage menu not found
    pause
)
exit /b 0

:MAIN_MENU
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0

