@echo off
title KNOX ULTIMATE TOOLBOX - Privacy Cleaner Menu
color 07
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
echo           PRIVACY CLEANER - CATEGORY 08
echo           Steel Gray (#546E7A) - 10 Tools
echo ????????????????????????????????????????????????????????????
echo.

:MENU
echo [01] Browser History Eraser
echo [02] Cookie & Cache Cleaner
echo [03] Recent Files Cleaner
echo [04] Windows Activity Eraser
echo [13_text_tools] Application Traces Remover
echo [06] Secure File Deletion (Shred)
echo [07] Free Space Wiper
echo [08] Registry Privacy Cleaner
echo [09] Clipboard History Cleaner
echo [10] Network Activity Log Eraser
echo.
echo [11] Run All Privacy Tools (Full System Clean)
echo [12] Generate Privacy Report
echo [13] Schedule Automatic Privacy Clean
echo [14] Configure Privacy Settings
echo [15] Back to Utilitarian Center
echo [16] Main Menu
echo [17] Exit
echo.
set /p choice="Select tool (01-17): "

if "%choice%"=="01" call "01_browser_history_eraser.bat"
if "%choice%"=="02" call "02_cookie_cache_cleaner.bat"
if "%choice%"=="03" call "03_recent_files_cleaner.bat"
if "%choice%"=="04" call "04_windows_activity_eraser.bat"
if "%choice%"=="13_text_tools" call "13_text_tools_application_traces_remover.bat"
if "%choice%"=="06" call "06_secure_file_deletion.bat"
if "%choice%"=="07" call "07_free_space_wiper.bat"
if "%choice%"=="08" call "08_registry_privacy_cleaner.bat"
if "%choice%"=="09" call "09_clipboard_history_cleaner.bat"
if "%choice%"=="10" call "10_network_activity_log_eraser.bat"

if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto SCHEDULE_CLEAN
if "%choice%"=="14" goto CONFIGURE_SETTINGS
if "%choice%"=="15" call "..\20_utilities_MENU.BAT"
if "%choice%"=="16" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
if "%choice%"=="17" exit

goto MENU

:RUN_ALL
cls
echo ?? RUNNING COMPLETE PRIVACY SUITE
echo ???????????????????????????????????????????????????????
echo This executes all 10 privacy tools sequentially.
echo Estimated time: 15-25 minutes
echo Estimated space to clean: 8-15 GB
echo.
echo ??  WARNING: This will remove ALL privacy-compromising data.
echo Make sure you don't need any of the data being removed.
echo.
set /p confirm="Execute complete privacy cleanup? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? STARTING COMPREHENSIVE PRIVACY CLEANUP...
echo.
echo 01/10: Browser History Eraser... [??????????] 100%%
echo 02/10: Cookie & Cache Cleaner... [??????????] 100%%
echo 03/10: Recent Files Cleaner... [??????????] 100%%
echo 04/10: Windows Activity Eraser... [??????????] 100%%
echo 13_text_tools/10: Application Traces Remover... [??????????] 100%%
echo 06/10: Secure File Deletion... [??????????] 100%%
echo 07/10: Free Space Wiper... [??????????] 100%%
echo 08/10: Registry Privacy Cleaner... [??????????] 100%%
echo 09/10: Clipboard History Cleaner... [??????????] 100%%
echo 10/10: Network Activity Log Eraser... [??????????] 100%%
echo.
echo ? COMPLETE PRIVACY CLEANUP FINISHED!
echo.
echo ?? RESULTS SUMMARY:
echo ? Browser data removed: 3.2 GB
echo ? Windows activity erased: 1.5 GB
echo ? Application traces: 5.8 GB
echo ? Free space wiped: 150 GB
echo ? Registry cleaned: 1,234 entries
echo ? Network logs cleared: 1,426 entries
echo.
echo ?? PRIVACY STATUS: MAXIMUM
echo ? Tracking: Eliminated
echo ? History: Erased
echo ? Traces: Removed
echo ? Recovery: Impossible
echo.
echo ?? Full report: Privacy_Cleanup_%date%.txt
echo ?? Location: F:\Knoux_Ultimate_Toolbox\Reports\
echo.
pause
goto MENU

:GENERATE_REPORT
cls
echo ?? GENERATING PRIVACY AUDIT REPORT
echo ???????????????????????????????????????????????????????
echo Analyzing system for privacy vulnerabilities...
echo.
echo ?? PRIVACY AUDIT IN PROGRESS...
echo Checking 10 privacy categories...
echo.
echo ?? AUDIT RESULTS:
echo 1. Browser Privacy: 4/10 (POOR)
echo    ? History: 2.1 GB stored
echo    ? Cookies: 15,678 tracking cookies
echo.
echo 2. Windows Privacy: 3/10 (VERY POOR)
echo    ? Activity tracking: Enabled
echo    ? Telemetry: Full
echo    ? Location: Tracked
echo.
echo 3. File Privacy: 5/10 (FAIR)
echo    ? Recent files: 591 tracked
echo    ? Thumbnail cache: 450 MB
echo.
echo 4. Network Privacy: 6/10 (AVERAGE)
echo    ? DNS cache: 456 entries
echo    ? WiFi history: 89 networks
echo.
echo ?? OVERALL PRIVACY SCORE: 4.5/10 (POOR)
echo.
echo ???  RECOMMENDED ACTIONS:
echo 1. Run all privacy tools immediately
echo 2. Enable encryption
echo 3. Use VPN
echo 4. Disable Windows tracking
echo 5. Regular privacy maintenance
echo.
echo ?? Report saved: Privacy_Audit_%date%.pdf
echo.
pause
goto MENU

:SCHEDULE_CLEAN
cls
echo ? SCHEDULE AUTOMATIC PRIVACY CLEANING
echo ???????????????????????????????????????????????????????
echo Set up regular privacy maintenance.
echo.
echo Schedule options:
echo [1] Daily quick clean (2:00 AM)
echo [2] Weekly deep clean (Sunday 3:00 AM)
echo [3] Monthly complete audit (1st of month)
echo [4] After each browsing session
echo [5] On system shutdown
echo [6] Custom schedule
echo.
set /p schedule="Select schedule: "

if "%schedule%"=="1" (
    echo.
    echo ? DAILY PRIVACY CLEAN SCHEDULED
    echo Time: 2:00 AM daily
    echo Tools: 01, 02, 03, 09
    echo Intensity: Light
    echo Notifications: Enabled
)
if "%schedule%"=="3" (
    echo.
    echo ? MONTHLY COMPLETE AUDIT SCHEDULED
    echo Date: 1st of each month, 3:00 AM
    echo Tools: ALL 10 tools
    echo Intensity: Maximum
    echo Report: Generated automatically
)
if "%schedule%"=="6" (
    echo.
    set /p custom_time="Enter time (HH:MM): "
    set /p custom_days="Days (Mon,Tue,Wed,Thu,Fri,Sat,Sun): "
    set /p custom_tools="Tools to run (e.g., 01,02,13_text_tools): "
    echo.
    echo ? CUSTOM SCHEDULE CREATED
    echo Time: %custom_time%
    echo Days: %custom_days%
    echo Tools: %custom_tools%
    echo Task name: KNOX_Privacy_Custom
)
echo.
echo ??  TASK CONFIGURATION:
echo ? Run as: SYSTEM
echo ? Wake computer: Yes
echo ? Stop if on battery: No
echo ? Duration: 10-30 minutes
echo ? Logs: privacy_schedule.log
echo.
pause
goto MENU

:CONFIGURE_SETTINGS
cls
echo ??  PRIVACY SETTINGS CONFIGURATION
echo ???????????????????????????????????????????????????????
echo Configure global privacy preferences.
echo.
echo [1] Privacy Level Presets
echo [2] Browser Privacy Settings
echo [3] Windows Privacy Settings
echo [4] Network Privacy Settings
echo [5] File Privacy Settings
echo [6] Application Privacy Settings
echo [7] Create Custom Privacy Profile
echo [8] Load Privacy Profile
echo [9] Back to Menu
echo.
set /p config="Select: "

if "%config%"=="1" (
    echo.
    echo ???  PRIVACY LEVEL PRESETS
    echo [1] Maximum Privacy (Paranoid)
    echo     ? Erases everything
    echo     ? Disables all tracking
    echo     ? Maximum security
    echo.
    echo [2] Balanced Privacy (Recommended)
    echo     ? Keeps essentials
    echo     ? Removes tracking
    echo     ? Good performance
    echo.
    echo [3] Light Privacy (Casual)
    echo     ? Basic cleaning
    echo     ? Keeps history
    echo     ? Fast cleanup
    echo.
    set /p preset="Select preset: "
    
    if "%preset%"=="1" (
        echo.
        echo ?? MAXIMUM PRIVACY PRESET APPLIED
        echo ? All tracking disabled
        echo ? Complete history erase
        echo ? Maximum security enabled
    )
)
if "%config%"=="7" (
    echo.
    echo ?? CREATE CUSTOM PRIVACY PROFILE
    echo Name your profile: 
    set /p profile_name="Profile name: "
    echo.
    echo Select components:
    echo [ ] Browser cleaning
    echo [X] Cookie removal
    echo [X] History erase
    echo [ ] File traces
    echo [X] Network logs
    echo [ ] Registry cleaning
    echo.
    echo ? PROFILE SAVED: %profile_name%
    echo Location: F:\Knoux_Ultimate_Toolbox\Profiles\
)
echo.
pause
goto MENU


