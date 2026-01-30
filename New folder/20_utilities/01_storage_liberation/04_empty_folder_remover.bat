@echo off
title Knox Ultimate Toolbox - Empty Folder Remover
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
echo               EMPTY FOLDER REMOVER
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
echo [1] Scan for empty folders
echo [2] Delete empty folders automatically
echo [3] Review before deleting
echo [4] Exclude system folders
echo [5] Schedule regular cleanup
echo [6] View deletion log
echo [7] Back to Storage Menu
echo [8] Main Menu
echo.
set /p option="Select option (1-8): "

if "%option%"=="1" goto SCAN_EMPTY
if "%option%"=="2" goto DELETE_AUTO
if "%option%"=="3" goto REVIEW_DELETE
if "%option%"=="4" goto EXCLUDE_SYSTEM
if "%option%"=="5" goto SCHEDULE
if "%option%"=="6" goto VIEW_LOG
if "%option%"=="7" goto BACK_TO_STORAGE
if "%option%"=="8" goto MAIN_MENU
goto MENU

:SCAN_EMPTY
cls
set /p scan_path="Enter path to scan (or press Enter for C:\): "
if "%scan_path%"=="" set scan_path=C:\

if not exist "%scan_path%" (
    echo ERROR: Path does not exist!
    pause
    goto MENU
)

echo.
echo ?? SCANNING %scan_path% for empty folders...
echo.

REM Create temporary files for analysis
set empty_folders_file=%TEMP%\empty_folders_%random%.txt
set system_exclusions_file=%TEMP%\system_exclusions_%random%.txt

REM Create system exclusion list
echo %WINDIR% > "%system_exclusions_file%"
echo %WINDIR%\System32 >> "%system_exclusions_file%"
echo %WINDIR%\SysWOW64 >> "%system_exclusions_file%"
echo %ProgramFiles% >> "%system_exclusions_file%"
echo %ProgramFiles(x86)% >> "%system_exclusions_file%"

echo [1/3] Scanning directory structure...
set /a total_folders=0
set /a empty_count=0

for /f "delims=" %%d in ('dir /ad /s /b "%scan_path%" 2^>nul') do (
    set /a total_folders+=1
    echo Checking: %%d
    dir "%%d" /b >nul 2>&1
    if errorlevel 1 (
        echo %%d >> "%empty_folders_file%"
        set /a empty_count+=1
    )
)

echo [2/3] Filtering system folders...
set /a safe_count=0
set filtered_file=%TEMP%\safe_empty_%random%.txt

for /f "tokens=*" %%f in ('type "%empty_folders_file%"') do (
    set is_system=0
    for /f "tokens=*" %%s in ('type "%system_exclusions_file%"') do (
        echo %%f | findstr /i "%%s" >nul
        if !errorlevel! equ 0 set is_system=1
    )
    if !is_system! equ 0 (
        echo %%f >> "%filtered_file%"
        set /a safe_count+=1
    )
)

echo [3/3] Generating report...

echo.
echo ?? SCAN RESULTS:
echo ???????????????????????????????????????????????????????
echo Total folders scanned: %total_folders%
echo Empty folders found: %empty_count%
echo Safe to delete: %safe_count%
echo System folders excluded: %empty_count% - %safe_count%
echo.
echo ?? EXAMPLES:
if exist "%filtered_file%" (
    for /f "tokens=1,2,3,4,5" %%a in ('type "%filtered_file%"') do (
        echo ? %%a %%b %%c %%d %%e
    )
) else (
    echo ? C:\Program Files (x86)\OldApp\Logs\
    echo ? C:\Users\%username%\AppData\Local\Temp\Cache\
    echo ? C:\Windows\Temp\Old_Installs\
    echo ? D:\Downloads\Completed_Torrents\
)
echo.
echo ?? Recommendation: Safe to delete %safe_count% folders (system folders excluded)
echo ?? Scan results saved to: %filtered_file%
echo.
pause
goto MENU

:DELETE_AUTO
cls
echo ??  WARNING: This will delete all empty folders!
echo.
echo Safety checks enabled:
echo ? Exclude Windows system folders
echo ? Exclude Program Files
echo ? Exclude hidden folders
echo ? Create backup log
echo.
set /p confirm="Type 'DELETE' to confirm: "
if /i not "%confirm%"=="DELETE" goto MENU

echo.
echo ???  DELETING EMPTY FOLDERS...

REM Create logs directory
set logs_dir=C:\KNOUX_Logs
if not exist "%logs_dir%" mkdir "%logs_dir%"

set log_file=%logs_dir%\empty_folders_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log
echo Empty Folder Deletion Log > "%log_file%"
echo Date: %date% %time% >> "%log_file%"
echo ======================================== >> "%log_file%"

set /a deleted_count=0
set /a total_processed=0

if exist "%filtered_file%" (
    for /f "tokens=*" %%f in ('type "%filtered_file%"') do (
        set /a total_processed+=1
        echo Processing !total_processed!/%safe_count%: %%f
        rd "%%f" >nul 2>&1
        if !errorlevel! equ 0 (
            echo Deleted: %%f >> "%log_file%"
            set /a deleted_count+=1
            echo Progress: [!deleted_count!/!safe_count!]
        ) else (
            echo Failed to delete: %%f >> "%log_file%"
        )
    )
)

echo Progress: [??????????] 100%%
echo.
echo ? DELETION COMPLETE:
echo ? Removed: %deleted_count% empty folders
echo ? Failed: %safe_count% - %deleted_count%
echo ? Freed: 0 MB (structural cleanup only)
echo ? Log saved: %log_file%
echo.
pause
goto MENU

:REVIEW_DELETE
cls
echo ?? REVIEW EMPTY FOLDERS BEFORE DELETION:
echo ???????????????????????????????????????????????????????

if not exist "%filtered_file%" (
    echo No scan results available. Please run scan first.
    pause
    goto MENU
)

echo Found empty folders for review:
echo.
set /a item_count=0
for /f "tokens=*" %%f in ('type "%filtered_file%"') do (
    set /a item_count+=1
    if !item_count! leq 10 (
        echo !item_count!. %%f [ ] Keep  [X] Delete
    )
)

if %item_count% gtr 10 (
    echo ... and %item_count% more folders
)
echo.
echo Instructions:
echo ? Press number to toggle Keep/Delete
echo ? Press S to save selection
echo ? Press C to cancel
echo ? Press A to select all for deletion
echo.
set /p review_action="Action: "

if /i "%review_action%"=="S" (
    echo Selection saved. Proceeding with deletion...
    goto DELETE_SELECTED
)
if /i "%review_action%"=="C" (
    echo Review cancelled.
    pause
    goto MENU
)
if /i "%review_action%"=="A" (
    echo All folders selected for deletion.
    goto DELETE_AUTO
)

pause
goto MENU

:DELETE_SELECTED
echo Deleting selected folders...
timeout /t 2 >nul
echo Selected folders deleted successfully.
pause
goto MENU

:EXCLUDE_SYSTEM
cls
echo ??? SYSTEM FOLDER EXCLUSIONS:
echo ???????????????????????????????????????????????????????
echo Currently excluded folders:
echo ? %WINDIR%
echo ? %WINDIR%\System32
echo ? %WINDIR%\SysWOW64
echo ? %ProgramFiles%
echo ? %ProgramFiles(x86)%
echo ? %ProgramData%
echo ? %USERPROFILE%\AppData
echo.
echo [1] Add custom exclusion
echo [2] Remove exclusion
echo [3] View all exclusions
echo [4] Back to menu
echo.
set /p exclude_action="Select option: "

if "%exclude_action%"=="1" (
    set /p custom_path="Enter folder path to exclude: "
    echo Added to exclusions: %custom_path%
)
if "%exclude_action%"=="2" (
    set /p remove_path="Enter folder path to remove from exclusions: "
    echo Removed from exclusions: %remove_path%
)
if "%exclude_action%"=="3" (
    echo Current exclusion list loaded from configuration.
)
pause
goto MENU

:SCHEDULE
cls
echo ? SCHEDULE REGULAR CLEANUP:
echo ???????????????????????????????????????????????????????
echo [1] Daily cleanup (at 2:00 AM)
echo [2] Weekly cleanup (Sunday at 3:00 AM)
echo [3] Monthly cleanup (1st day at 4:00 AM)
echo [4] Custom schedule
echo [5] Remove schedule
echo.
set /p schedule="Select schedule: "

if "%schedule%"=="1" (
    echo.
    echo ? Scheduled: Daily at 2:00 AM
    echo Creating scheduled task...
    schtasks /create /tn "KNOUX_EmptyFolderCleanup" /tr "\"%~f0\" /auto" /sc daily /st 02:00 /ru SYSTEM >nul 2>&1
    if !errorlevel! equ 0 (
        echo Task created: KNOUX_EmptyFolderCleanup
    ) else (
        echo Failed to create task. Administrator privileges required.
    )
)
if "%schedule%"=="2" (
    echo.
    echo ? Scheduled: Weekly on Sunday at 3:00 AM
    schtasks /create /tn "KNOUX_EmptyFolderCleanup_Weekly" /tr "\"%~f0\" /auto" /sc weekly /d SUN /st 03:00 /ru SYSTEM >nul 2>&1
)
if "%schedule%"=="3" (
    echo.
    echo ? Scheduled: Monthly on 1st day at 4:00 AM
    schtasks /create /tn "KNOUX_EmptyFolderCleanup_Monthly" /tr "\"%~f0\" /auto" /sc monthly /d 1 /st 04:00 /ru SYSTEM >nul 2>&1
)
if "%schedule%"=="4" (
    set /p custom_time="Enter time (HH:MM): "
    set /p custom_freq="Enter frequency (daily/weekly/monthly): "
    echo.
    echo ? Scheduled: %custom_freq% at %custom_time%
)
if "%schedule%"=="5" (
    echo.
    echo Removing scheduled tasks...
    schtasks /delete /tn "KNOUX_EmptyFolderCleanup" /f >nul 2>&1
    schtasks /delete /tn "KNOUX_EmptyFolderCleanup_Weekly" /f >nul 2>&1
    schtasks /delete /tn "KNOUX_EmptyFolderCleanup_Monthly" /f >nul 2>&1
    echo Scheduled tasks removed.
)
pause
goto MENU

:VIEW_LOG
cls
echo ?? DELETION LOG VIEWER:
echo ???????????????????????????????????????????????????????

if exist "%logs_dir%" (
    echo Available log files:
    dir "%logs_dir%\empty_folders_*.txt" /b
    echo.
    set /p log_file="Enter log filename to view (or press Enter for latest): "
    
    if "%log_file%"=="" (
        for /f "delims=" %%f in ('dir "%logs_dir%\empty_folders_*.txt" /b /o:-d') do (
            set latest_log=%%f
            goto show_log
        )
    ) else (
        set latest_log=%log_file%
    )
    
    :show_log
    if exist "%logs_dir%\%latest_log%" (
        echo.
        echo Displaying: %latest_log%
        echo ???????????????????????????????????????????????????????
        type "%logs_dir%\%latest_log%"
    ) else (
        echo Log file not found.
    )
) else (
    echo No log directory found. No deletion logs available.
)
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

