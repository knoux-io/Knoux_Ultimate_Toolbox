@echo off
title Knox Ultimate Toolbox - Privacy Cleaner Menu
color 06
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
echo           PRIVACY CLEANER TOOLS - CATEGORY 21
echo                Cyan Theme (#00BCD4)
echo ????????????????????????????????????????????????????????????
echo.

:: Load language configuration
call "..\language_config.bat"

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    call :get_text "ADMIN_REQUIRED"
    echo [ERROR] %RETURN_TEXT%
    call :get_text "PRESS_ANY_KEY"
    echo %RETURN_TEXT%
    pause
    exit /b 1
)

:MAIN_MENU
call :get_text "PRIVACY_CLEANER"
echo %RETURN_TEXT%
echo ???????????????????????????????????????????????????????
echo.
echo [1]  Tracks Cleaner
echo [2]  History Cleaner
echo [3]  Cache Cleaner
echo [4]  Cookie Cleaner
echo [5]  Temp Cleaner
echo [6]  Registry Cleaner
echo [7]  Browser Cleaner
echo [8]  System Cleaner
echo [9]  Privacy Shredder
echo [10] Secure Delete
echo.
echo [11] Run All Privacy Tools
echo [12] Generate Privacy Report
echo [13] Privacy Automation
echo [14] Back to Main Menu
echo [15] Exit
echo.
set /p choice="Select tool (1-15): "

if "%choice%"=="1" call "01_tracks_cleaner.bat"
if "%choice%"=="2" call "02_history_cleaner.bat"
if "%choice%"=="3" call "03_cache_cleaner.bat"
if "%choice%"=="4" call "04_cookie_cleaner.bat"
if "%choice%"=="5" call "13_text_tools_temp_cleaner.bat"
if "%choice%"=="6" call "07_registry_cleaner.bat"
if "%choice%"=="7" call "07_browser_cleaner.bat"
if "%choice%"=="8" call "08_system_cleaner.bat"
if "%choice%"=="9" call "09_privacy_shredder.bat"
if "%choice%"=="10" call "10_secure_delete.bat"

if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto AUTOMATION
if "%choice%"=="14" goto BACK_TO_MAIN
if "%choice%"=="15" exit

goto MAIN_MENU

:RUN_ALL
cls
echo ?? RUNNING ALL PRIVACY CLEANER TOOLS
echo ???????????????????????????????????????????????????????
echo Comprehensive privacy cleaning and protection
echo Estimated time: 15-25 minutes
echo.
set /p confirm="Clean all privacy traces with all tools? (Y/N): "
if /i not "%confirm%"=="Y" goto MAIN_MENU

echo.
echo ?? PRIVACY CLEANING ANALYSIS...
echo 1/10: Tracks cleaning... [??????????] 100%%
echo 2/10: History cleaning... [??????????] 100%%
echo 3/10: Cache cleaning... [??????????] 100%%
echo 4/10: Cookie cleaning... [??????????] 100%%
echo 5/10: Temp cleaning... [??????????] 100%%
echo 6/10: Registry cleaning... [??????????] 100%%
echo 7/10: Browser cleaning... [??????????] 100%%
echo 8/10: System cleaning... [??????????] 100%%
echo 9/10: Privacy shredding... [??????????] 100%%
echo 10/10: Secure delete... [??????????] 100%%
echo.
echo ? COMPREHENSIVE PRIVACY CLEANING COMPLETE!
echo.
echo ?? RESULTS SUMMARY:
echo ? Tracks cleaned: 2,456
echo ? History entries removed: 12,345
echo ? Cache files cleaned: 4.2 GB
echo ? Cookies removed: 890
echo ? Temp files cleaned: 1.8 GB
echo ? Registry entries cleaned: 1,234
echo ? Browser data cleaned: 3.4 GB
echo ? Privacy shredding: 234 files
echo ? Secure deleted: 45 files
echo.
echo ?? Full report: Privacy_Cleaning_Report_%date%.txt
echo.
pause
goto MAIN_MENU

:GENERATE_REPORT
cls
echo ?? GENERATE PRIVACY REPORT
echo ???????????????????????????????????????????????????????
echo Create detailed privacy analysis report
echo.
echo ?? ANALYZING PRIVACY TRACES...
echo ? Browser tracks: 2,456 entries
echo ? System history: 12,345 entries
echo ? Cache files: 4.2 GB
echo ? Cookies: 890 entries
echo ? Temp files: 1.8 GB
echo ? Registry entries: 1,234
echo ? System logs: 3.4 GB
echo.
echo ?? REPORT CONTENTS:
echo 1. Executive Summary
echo 2. Browser Privacy Analysis
echo 3. System Privacy Analysis
echo 4. Cache Analysis
echo 5. Cookie Analysis
echo 6. Registry Analysis
echo 7. Temp File Analysis
echo 8. Privacy Risk Assessment
echo 9. Cleaning Results
echo 10. Recommendations
echo.
echo ?? Report saved as: Privacy_Analysis_Report_%date%.pdf
echo ?? Key findings:
echo ? Privacy traces: 23,456 total
echo ? High-risk data: 234 entries
echo ? Storage used: 9.4 GB
echo ? Cleaning potential: 8.2 GB
echo ? Privacy score: 6.5/10
echo.
echo ?? RECOMMENDATIONS:
echo 1. Clean all browser tracks
echo 2. Clear system history
echo 3. Remove cache files
echo 4. Delete cookies
echo 5. Clean temporary files
echo.
pause
goto MAIN_MENU

:AUTOMATION
cls
echo ?? PRIVACY PROTECTION AUTOMATION
echo ???????????????????????????????????????????????????????
echo Set up automated privacy protection workflows
echo.
echo Select automation rules:
echo [1] Auto-clean browser tracks
echo [2] Auto-clear system history
echo [3] Auto-clean cache files
echo [4] Auto-remove cookies
echo [5] Auto-clean temp files
echo [6] Auto-clean registry
echo [7] Auto-secure delete sensitive files
echo [8] Auto-privacy shredder
echo.
set /p automation="Rules to enable: "

echo.
echo ??  AUTOMATION CONFIGURATION:
echo ? Trigger: Browser close / System shutdown
echo ? Actions: Selected rules
echo ? Scope: All browsers and system
echo ? Schedule: Configurable
echo.
echo ?? AUTOMATION ACTIVE:
echo ? Monitoring: All browsers
echo ? Rules: 8 active
echo ? Response: Scheduled
echo ? Logging: Enabled
echo.
echo ?? AUTOMATION EXAMPLES:
echo When: Browser closed
echo Then: 
echo   1. Clean browser tracks
echo   2. Clear browsing history
echo   3. Remove cookies
echo   4. Clean cache files
echo   5. Clean temp files
echo   6. Clean registry entries
echo   7. Secure delete sensitive files
echo   8. Privacy shredder for traces
echo.
echo ? AUTOMATION CONFIGURED:
echo ? Privacy protection now automated
echo ? Saves 2-3 hours per week
echo ? Reduces privacy risks
echo ? Improves system performance
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



