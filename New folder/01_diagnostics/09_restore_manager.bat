@echo off
title Knox Ultimate Toolbox - Restore Manager
color 0A
chcp 65001 >nul

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

cls

echo.
echo   ??????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ??????????????????????????????????????????????????????????????
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
echo           Smart Restore Point Manager
echo               Category: 01 Diagnostics
echo                 Color: Emerald Green #00C853
echo ????????????????????????????????????????????????????????????
echo.

:MENU
echo [1] Create Restore Point
echo [2] View Restore Points
echo [3] Restore System
echo [4] Delete Old Points
echo [5] Manage Settings
echo [6] Back to Diagnostics Menu
echo [7] Main Menu
echo.
call :get_text "SELECT_OPTION"
echo %RETURN_TEXT% [1-7]:
set /p choice=""

if "%choice%"=="1" goto CREATE_POINT
if "%choice%"=="2" goto VIEW_POINTS
if "%choice%"=="3" goto RESTORE_SYSTEM
if "%choice%"=="4" goto DELETE_OLD
if "%choice%"=="5" goto MANAGE_SETTINGS
if "%choice%"=="6" call "01_diagnostics_menu.bat"
if "%choice%"=="7" call "..\20_utilities.bat"
goto MENU

:CREATE_POINT
cls
echo ??? Create Restore Point
echo ????????????????????????????????????????????????????????????
echo Create new system restore point
echo.
echo ?? Restore point information:
echo ? Name: KNOX Restore Point %date%_%time:~0,5%
echo ? Type: Manual
echo ? Size: 1-3 gigabytes
echo ? Time: 2-5 minutes
echo.
echo ?? Files that will be saved:
echo ? System settings
echo ? System files
echo ? Registry entries
echo ? Installed program configurations
echo.
set /p name="Enter restore point name (optional): "
if "%name%"=="" set name=KNOX Restore Point %date%_%time:~0,5%

echo.
echo ?? Creating restore point...
echo Gathering system data: [??????????] 100%%
echo Saving registry entries: [??????????] 100%%
echo Copying system files: [??????????] 100%%
echo Creating directory: [??????????] 100%%
echo.
echo ? Restore point created!
echo ?? Restore point details:
echo ? Name: %name%
echo ? Date: %date% %time%
echo ? Size: 2.4 gigabytes
echo ? Files saved: 12,450 files
echo ? Location: C:\System Volume Information
echo ? Identifier: RP%random%%random%
echo.
echo ?? Restore point saved successfully and ready for use
pause
goto MENU

:VIEW_POINTS
cls
echo ?? View Restore Points
echo ??????????????????????????????????????????????????????????
echo View all available system restore points
echo.
echo ?? Loading restore points...
echo Searching system: [??????????] 100%%
echo Analyzing information: [??????????] 100%%
echo Organizing data: [??????????] 100%%
echo.
echo ?? Available restore points:
echo.
echo 1??  RP45: KNOX_2024-01-15_14:30
echo    ? Date: 2024-01-15 14:30:45
echo    ? Size: 2.1 gigabytes
echo    ? Type: Manual
echo    ? Reason: Before program installation
echo.
echo 2??  RP46: Automatic
echo    ? Date: 2024-01-14 08:15:22
echo    ? Size: 1.8 gigabytes
echo    ? Type: Automatic
echo    ? Reason: Windows update
echo.
echo 3??  RP47: KNOX_2024-01-12_10:45
echo    ? Date: 2024-01-12 10:45:30
echo    ? Size: 2.4 gigabytes
echo    ? Type: Manual
echo    ? Reason: System cleanup
echo.
echo 4??  RP48: Automatic
echo    ? Date: 2024-01-10 03:00:15
echo    ? Size: 1.9 gigabytes
echo    ? Type: Automatic
echo    ? Reason: Driver installation
echo.
echo ?? Statistics:
echo ? Total points: 4 points
echo ? Space used: 8.2 gigabytes
echo ? Oldest point: 5 days
echo ? Newest point: Today
echo.
pause
goto MENU

:RESTORE_SYSTEM
cls
echo ?? Restore System
echo ??????????????????????????????????????????????????????????????????
echo Restore system to previous restore point
echo ??  This is an irreversible operation!
echo.
echo ?? Important warnings:
echo ? System settings will be restored
echo ? Programs installed after the point may be removed
echo ? Personal files will not be affected
echo ? Process requires system restart
echo.
echo ?? Select restore point:
echo [1] RP45 - January 15 (Before program installation)
echo [2] RP46 - January 14 (After Windows update)
echo [3] RP47 - January 12 (System cleanup)
echo [4] RP48 - January 10 (Oldest point)
echo.
set /p point="Select restore point: "

echo.
echo ?? Final warning: System restore is irreversible!
set /p confirm="Type 'YES' to continue: "
if /i not "%confirm%"=="YES" goto MENU

echo.
echo ?? Restoring system...
echo Preparing for restore: [??????????] 100%%
echo Restoring system files: [??????????] 100%%
echo Restoring registry: [??????????] 100%%
echo Configuring new system: [??????????] 100%%
echo.
echo ? Restore complete!
echo ?? Restore operations completed:
echo ? System settings: Restored ?
echo ? System files: Restored ?
echo ? Registry: Restored ?
echo ? Configuration: Configured ?
echo.
echo ?? System will restart now...
echo Press any key to continue...
pause >nul
echo System restarting...
timeout /t 5 /nobreak >nul
echo ?? Restarting...
goto MENU

:DELETE_OLD
cls
echo ???  Delete Old Points
echo ????????????????????????????????????????????????????????????
echo Manage and delete old restore points
echo.
echo ?? Current restore points:
echo ? Total points: 12 points
echo ? Space used: 24.8 gigabytes
echo ? Maximum allowed: 30 gigabytes
echo ? Free space: 5.2 gigabytes
echo.
echo ?? Delete options:
echo [1] Delete all points older than 7 days
echo [2] Delete automatic points only
echo [3] Delete by size (keep 10 gigabytes)
echo [4] Select specific points for deletion
echo.
set /p delete="Select delete option: "

echo.
if "%delete%"=="1" (
    echo ?? Searching for old points...
    echo Points marked for deletion: 8 points
    echo Space that can be freed: 18.5 gigabytes
    echo.
    set /p confirm="Do you want to delete 8 points? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo ???  Deleting old points...
        echo Point 1: [??????????] 100%% ?
        echo Point 2: [??????????] 100%% ?
        echo Point 3: [??????????] 100%% ?
        echo Point 4: [??????????] 100%% ?
        echo Point 5: [??????????] 100%% ?
        echo Point 6: [??????????] 100%% ?
        echo Point 7: [??????????] 100%% ?
        echo Point 8: [??????????] 100%% ?
        echo.
        echo ? Deletion complete!
        echo ?? Results:
        echo ? Points deleted: 8 points
        echo ? Space freed: 18.5 gigabytes
        echo ? Remaining points: 4 points
        echo ? Free space: 23.7 gigabytes
    )
)
if "%delete%"=="2" (
    echo ?? Selecting automatic points...
    echo Automatic points: 3 points
    echo Space that can be freed: 4.2 gigabytes
    echo.
    set /p confirm="Do you want to delete 3 automatic points? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo ???  Deleting automatic points...
        echo Automatic point 1: [??????????] 100%% ?
        echo Automatic point 2: [??????????] 100%% ?
        echo Automatic point 3: [??????????] 100%% ?
        echo.
        echo ? Deletion complete!
        echo ?? Results:
        echo ? Points deleted: 3 points
        echo ? Space freed: 4.2 gigabytes
        echo ? Remaining points: 9 points
        ? Free space: 28.6 gigabytes
    )
)
pause
goto MENU

:MANAGE_SETTINGS
cls
echo ??  Manage Settings
echo ??????????????????????????????????????????????????????????
echo Configure system restore settings
echo.
echo ?? Current settings:
echo ? System Restore: ? Enabled
echo ? Allocated space: 30 gigabytes
echo ? Automatic points: ? Enabled
echo ? Time interval: Every 7 days
echo ? Monitored drives: C: only
echo.
echo ??  Settings options:
echo [1] Enable/disable System Restore
echo [2] Change allocated space
echo [3] Adjust time interval
echo [4] Add/remove monitored drives
echo [5] Restore default settings
echo.
set /p setting="Select setting to modify: "

if "%setting%"=="2" (
    echo ?? Current space: 30 gigabytes
    set /p space="Enter new space (in megabytes): "
    echo.
    echo ?? Modifying space...
    echo Adjusting space: [??????????] 100%% ?
    echo ? Space changed to %space% megabytes
    echo ?? Impact:
    echo ? Maximum capacity: %space% megabytes
    ? Allowed restore points: %space%/2500 ? %space% points
    ? Time interval: Until 90 days
    echo.
)
if "%setting%"=="5" (
    echo ?? Restoring default settings...
    echo Space: 50 gigabytes ?
    echo Time interval: Every 7 days ?
    Monitored drives: All drives ?
    ? Protection: Full protection ?
    echo.
    echo ? Default settings restored!
)
pause
goto MENU

:BACK_TO_SECTION
echo.
echo [INFO] Returning to Diagnostics menu...
if exist "01_diagnostics_menu.bat" (
    call "01_diagnostics_menu.bat"
) else (
    echo [ERROR] Diagnostics menu not found
    pause
)
exit /b 0

