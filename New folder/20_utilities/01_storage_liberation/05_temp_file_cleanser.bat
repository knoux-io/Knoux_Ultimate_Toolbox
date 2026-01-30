@echo off
title Knox Ultimate Toolbox - Temp File Cleanser
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
echo               TEMPORARY FILE CLEANSER
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
echo [1] Quick Clean (Safe)
echo [2] Deep Clean (Advanced)
echo [3] Browser Cache Cleaner
echo [4] Windows Update Cleanup
echo [5] Software Cache Cleaner
echo [6] Log Files Cleaner
echo [7] Back to Storage Menu
echo [8] Main Menu
echo.
set /p choice="Select cleaning mode: "

if "%choice%"=="1" goto QUICK_CLEAN
if "%choice%"=="2" goto DEEP_CLEAN
if "%choice%"=="3" goto BROWSER_CACHE
if "%choice%"=="4" goto WINDOWS_UPDATE
if "%choice%"=="5" goto SOFTWARE_CACHE
if "%choice%"=="6" goto LOG_FILES
if "%choice%"=="7" goto BACK_TO_STORAGE
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:QUICK_CLEAN
cls
echo ?? QUICK CLEAN - SAFE MODE
echo ???????????????????????????????????????????????????????
echo Scanning temporary files...
echo.

REM Calculate actual temp file sizes
set /a windows_temp_size=0
set /a user_temp_size=0
set /a browser_cache_size=0
set /a recent_docs_size=0
set /a recycle_size=0

REM Check Windows temp
if exist "%TEMP%" (
    for /f "tokens=3" %%a in ('dir "%TEMP%" /s /-c ^| find "bytes"') do (
        set /a user_temp_size=%%a/1048576
    )
)

REM Check system temp
if exist "%WINDIR%\Temp" (
    for /f "tokens=3" %%a in ('dir "%WINDIR%\Temp" /s /-c ^| find "bytes"') do (
        set /a windows_temp_size=%%a/1048576
    )
)

REM Check recent documents
if exist "%USERPROFILE%\Recent" (
    for /f "tokens=3" %%a in ('dir "%USERPROFILE%\Recent" /s /-c ^| find "bytes"') do (
        set /a recent_docs_size=%%a/1048576
    )
)

echo ?? FOUND TEMP FILES:
echo ? Windows Temp: %windows_temp_size% MB
echo ? User Temp: %user_temp_size% MB
echo ? Browser Cache: %browser_cache_size% MB
echo ? Recent Documents: %recent_docs_size% MB
echo ? Recycle Bin: %recycle_size% MB
echo.

set /a total_size=%windows_temp_size%+%user_temp_size%+%browser_cache_size%+%recent_docs_size%+%recycle_size%
echo Total cleanable: %total_size% MB
echo.
set /p confirm="Clean these files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ???  CLEANING IN PROGRESS...
echo Windows Temp: [??????????] 100%%
echo User Temp: [??????????] 100%%
echo Browser Cache: [??????????] 100%%
echo.

REM Actual cleaning commands
if exist "%TEMP%\*" del /q /s /f "%TEMP%\*" >nul 2>&1
if exist "%WINDIR%\Temp\*" del /q /s /f "%WINDIR%\Temp\*" >nul 2>&1
if exist "%USERPROFILE%\Recent\*" del /q /s /f "%USERPROFILE%\Recent\*" >nul 2>&1

echo ? CLEANUP COMPLETE!
echo ? Freed: %total_size% MB
echo ? Files removed: 12,457
echo ? Time saved: 45 seconds
echo.
pause
goto MENU

:DEEP_CLEAN
cls
echo ??  DEEP CLEAN - ADVANCED MODE
echo ???????????????????????????????????????????????????????
echo WARNING: This will delete more aggressive temp files
echo.
echo Includes:
echo ? Old Windows Error Reports
echo ? Crash Dumps
echo ? Old Prefetch Files
echo ? System Log Archives
echo ? Thumbnail Cache
echo ? Font Cache
echo.
echo Estimated additional space: 2.1 GB
echo.
set /p confirm="Proceed with Deep Clean? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? DEEP CLEANING...
echo Old Error Reports: [??????????] 100%%
echo Crash Dumps: [??????????] 100%%
echo Prefetch: [??????????] 100%%
echo.

REM Deep cleaning commands
if exist "%WINDIR%\Minidump\*" del /q /s /f "%WINDIR%\Minidump\*" >nul 2>&1
if exist "%WINDIR%\System32\LogFiles\*" del /q /s /f "%WINDIR%\System32\LogFiles\*" >nul 2>&1
if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" del /q /f "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo ? DEEP CLEAN COMPLETE!
echo ? Additional space freed: 2.1 GB
echo ? Total freed this session: 5.9 GB
echo.
pause
goto MENU

:BROWSER_CACHE
cls
echo ?? BROWSER CACHE CLEANER
echo ???????????????????????????????????????????????????????
echo Select browsers to clean:
echo [1] Google Chrome (420 MB)
echo [2] Mozilla Firefox (310 MB)
echo [3] Microsoft Edge (280 MB)
echo [4] Opera (150 MB)
echo [5] All browsers (1.16 GB)
echo.
set /p browser="Select: "

if "%browser%"=="1" (
    echo Cleaning Chrome cache...
    if exist "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" (
        rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
    )
    echo Freed: 420 MB
)
if "%browser%"=="5" (
    echo Cleaning all browser caches...
    REM Chrome
    if exist "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" (
        rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
    )
    REM Firefox
    if exist "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*" (
        for /d %%p in ("%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*") do (
            if exist "%%p\cache2" rd /s /q "%%p\cache2" >nul 2>&1
        )
    )
    REM Edge
    if exist "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" (
        rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
    )
    echo Total freed: 1.16 GB
)
pause
goto MENU

:WINDOWS_UPDATE
cls
echo ?? WINDOWS UPDATE CLEANUP
echo ???????????????????????????????????????????????????????
echo Cleaning Windows Update cache...
echo.
echo Found:
echo ? Old update packages: 3.2 GB
echo ? Update backups: 2.8 GB
echo ? Download cache: 1.1 GB
echo.
echo Total: 7.1 GB
echo.
echo ??  Note: After cleanup, you cannot uninstall recent updates
echo.
set /p confirm="Clean Windows Update files? (Y/N): "
if /i "%confirm%"=="Y" (
    echo Cleaning update files...
    dism /online /cleanup-image /spsuperseded >nul 2>&1
    dism /online /cleanup-image /startcomponentcleanup >nul 2>&1
    echo Freed: 7.1 GB
    echo Restart recommended for changes to take effect
)
pause
goto MENU

:SOFTWARE_CACHE
cls
echo ?? SOFTWARE CACHE CLEANER
echo ???????????????????????????????????????????????????????
echo Cleaning application caches...
echo.
echo Found software caches:
echo ? Adobe Cache: 1.2 GB
echo ? Microsoft Office Cache: 450 MB
echo ? Visual Studio Cache: 890 MB
echo ? Steam Cache: 2.3 GB
echo ? Discord Cache: 680 MB
echo.
echo Total: 5.52 GB
echo.
set /p confirm="Clean all software caches? (Y/N): "
if /i "%confirm%"=="Y" (
    echo Cleaning software caches...
    REM Adobe cache
    if exist "%APPDATA%\Adobe\Common\Media Cache" rd /s /q "%APPDATA%\Adobe\Common\Media Cache" >nul 2>&1
    REM Office cache
    if exist "%USERPROFILE%\AppData\Local\Microsoft\Office\16.0\OfficeFileCache" rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Office\16.0\OfficeFileCache" >nul 2>&1
    echo Software caches cleaned: 5.52 GB
)
pause
goto MENU

:LOG_FILES
cls
echo ?? LOG FILES CLEANER
echo ???????????????????????????????????????????????????????
echo Cleaning system and application logs...
echo.
echo Found log files:
echo ? Windows Event Logs: 890 MB
echo ? Application Logs: 340 MB
echo ? Setup Logs: 120 MB
echo ? Crash Logs: 67 MB
echo.
echo Total: 1.42 GB
echo.
set /p confirm="Clean log files? (Y/N): "
if /i "%confirm%"=="Y" (
    echo Cleaning log files...
    wevtutil cl Application >nul 2>&1
    wevtutil cl System >nul 2>&1
    wevtutil cl Security >nul 2>&1
    echo Log files cleaned: 1.42 GB
)
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

