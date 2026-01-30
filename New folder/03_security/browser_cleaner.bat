@echo off
chcp 65001 >nul
title Browser Cleaner Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Browser Cleaner Tool                        ║
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
echo ║                  Browser Cleaner                             ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Clean Google Chrome
echo [2] Clean Mozilla Firefox
echo [3] Clean Microsoft Edge
echo [4] Clean Internet Explorer
echo [5] Clean All Browsers
echo [6] Clean Browser Extensions
echo [7] Reset Browser Settings
echo [8] Browser Security Check
echo [0] Exit
echo.
set /p choice="Select an option [0-8]: "

if "%choice%"=="1" goto clean_chrome
if "%choice%"=="2" goto clean_firefox
if "%choice%"=="3" goto clean_edge
if "%choice%"=="4" goto clean_ie
if "%choice%"=="5" goto clean_all
if "%choice%"=="6" goto clean_extensions
if "%choice%"=="7" goto reset_settings
if "%choice%"=="8" goto security_check
if "%choice%"=="0" goto exit
goto menu

:clean_chrome
echo.
echo [INFO] Cleaning Google Chrome...
echo.

:: Close Chrome processes
taskkill /f /im chrome.exe >nul 2>&1

:: Clean Chrome cache
echo [1/6] Cleaning Chrome cache...
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" 2>nul
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache" 2>nul

:: Clean Chrome history
echo [2/6] Cleaning Chrome history...
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\History" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\History Provider Cache" 2>nul

:: Clean Chrome cookies
echo [3/6] Cleaning Chrome cookies...
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cookies" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cookies-Journal" 2>nul

:: Clean Chrome temporary files
echo [4/6] Cleaning Chrome temporary files...
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache" 2>nul
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\ShaderCache" 2>nul

:: Clean Chrome login data
echo [5/6] Cleaning Chrome login data...
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data-Journal" 2>nul

:: Clean Chrome preferences
echo [6/6] Cleaning Chrome preferences...
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Secure Preferences" 2>nul

echo [SUCCESS] Google Chrome cleaned
pause
goto menu

:clean_firefox
echo.
echo [INFO] Cleaning Mozilla Firefox...
echo.

:: Close Firefox processes
taskkill /f /im firefox.exe >nul 2>&1

:: Find Firefox profiles
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    set firefox_profile=%%i
    goto firefox_found
)

:firefox_found
if defined firefox_profile (
    :: Clean Firefox cache
    echo [1/5] Cleaning Firefox cache...
    rmdir /s /q "%firefox_profile%\cache2" 2>nul
    rmdir /s /q "%firefox_profile%\startupCache" 2>nul

    :: Clean Firefox history
    echo [2/5] Cleaning Firefox history...
    del /q /f "%firefox_profile%\places.sqlite" 2>nul
    del /q /f "%firefox_profile%\places.sqlite-wal" 2>nul

    :: Clean Firefox cookies
    echo [3/5] Cleaning Firefox cookies...
    del /q /f "%firefox_profile%\cookies.sqlite" 2>nul
    del /q /f "%firefox_profile%\cookies.sqlite-wal" 2>nul

    :: Clean Firefox temporary files
    echo [4/5] Cleaning Firefox temporary files...
    rmdir /s /q "%firefox_profile%\thumbnails" 2>nul
    rmdir /s /q "%firefox_profile%\jumpListCache" 2>nul

    :: Clean Firefox preferences
    echo [5/5] Cleaning Firefox preferences...
    del /q /f "%firefox_profile%\prefs.js" 2>nul

    echo [SUCCESS] Mozilla Firefox cleaned
) else (
    echo [WARNING] Firefox profile not found
)

pause
goto menu

:clean_edge
echo.
echo [INFO] Cleaning Microsoft Edge...
echo.

:: Close Edge processes
taskkill /f /im msedge.exe >nul 2>&1

:: Clean Edge cache
echo [1/6] Cleaning Edge cache...
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" 2>nul
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache" 2>nul

:: Clean Edge history
echo [2/6] Cleaning Edge history...
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History" 2>nul
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History Provider Cache" 2>nul

:: Clean Edge cookies
echo [3/6] Cleaning Edge cookies...
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cookies" 2>nul
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cookies-Journal" 2>nul

:: Clean Edge temporary files
echo [4/6] Cleaning Edge temporary files...
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache" 2>nul
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\ShaderCache" 2>nul

:: Clean Edge login data
echo [5/6] Cleaning Edge login data...
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Login Data" 2>nul
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Login Data-Journal" 2>nul

:: Clean Edge preferences
echo [6/6] Cleaning Edge preferences...
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Preferences" 2>nul

echo [SUCCESS] Microsoft Edge cleaned
pause
goto menu

:clean_ie
echo.
echo [INFO] Cleaning Internet Explorer...
echo.

:: Clean IE cache
echo [1/4] Cleaning IE cache...
rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Windows\Temporary Internet Files" 2>nul

:: Clean IE history
echo [2/4] Cleaning IE history...
rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
del /q /f "%LOCALAPPDATA%\Microsoft\Windows\History\History.IE5\*.*" 2>nul

:: Clean IE cookies
echo [3/4] Cleaning IE cookies...
rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
del /q /f "%APPDATA%\Microsoft\Windows\Cookies\*.*" 2>nul

:: Clean IE form data
echo [4/4] Cleaning IE form data...
rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 16

echo [SUCCESS] Internet Explorer cleaned
pause
goto menu

:clean_all
echo.
echo [INFO] Cleaning all browsers...
echo.

:: Close all browser processes
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im firefox.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im iexplore.exe >nul 2>&1

:: Clean all browsers
call :clean_chrome_internal
call :clean_firefox_internal
call :clean_edge_internal
call :clean_ie_internal

echo [SUCCESS] All browsers cleaned
pause
goto menu

:clean_chrome_internal
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\History" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cookies" 2>nul
goto :eof

:clean_firefox_internal
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    rmdir /s /q "%%i\cache2" 2>nul
    del /q /f "%%i\places.sqlite" 2>nul
    del /q /f "%%i\cookies.sqlite" 2>nul
)
goto :eof

:clean_edge_internal
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" 2>nul
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History" 2>nul
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cookies" 2>nul
goto :eof

:clean_ie_internal
rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
goto :eof

:clean_extensions
echo.
echo [INFO] Cleaning browser extensions...
echo.

echo [1] Clean Chrome extensions
echo [2] Clean Firefox extensions
echo [3] Clean Edge extensions
echo [4] Clean all extensions
echo [0] Back to main menu
echo.
set /p ext_choice="Select an option [0-4]: "

if "%ext_choice%"=="1" goto clean_chrome_ext
if "%ext_choice%"=="2" goto clean_firefox_ext
if "%ext_choice%"=="3" goto clean_edge_ext
if "%ext_choice%"=="4" goto clean_all_ext
if "%ext_choice%"=="0" goto menu
goto clean_extensions

:clean_chrome_ext
echo.
echo [WARNING] This will remove all Chrome extensions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto clean_extensions

rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions" 2>nul
echo [SUCCESS] Chrome extensions removed
pause
goto clean_extensions

:clean_firefox_ext
echo.
echo [WARNING] This will remove all Firefox extensions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto clean_extensions

for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    rmdir /s /q "%%i\extensions" 2>nul
)
echo [SUCCESS] Firefox extensions removed
pause
goto clean_extensions

:clean_edge_ext
echo.
echo [WARNING] This will remove all Edge extensions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto clean_extensions

rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Extensions" 2>nul
echo [SUCCESS] Edge extensions removed
pause
goto clean_extensions

:clean_all_ext
echo.
echo [WARNING] This will remove all browser extensions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto clean_extensions

rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions" 2>nul
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Extensions" 2>nul
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    rmdir /s /q "%%i\extensions" 2>nul
)
echo [SUCCESS] All browser extensions removed
pause
goto clean_extensions

:reset_settings
echo.
echo [INFO] Resetting browser settings...
echo.

echo [1] Reset Chrome settings
echo [2] Reset Firefox settings
echo [3] Reset Edge settings
echo [4] Reset all settings
echo [0] Back to main menu
echo.
set /p reset_choice="Select an option [0-4]: "

if "%reset_choice%"=="1" goto reset_chrome
if "%reset_choice%"=="2" goto reset_firefox
if "%reset_choice%"=="3" goto reset_edge
if "%reset_choice%"=="4" goto reset_all
if "%reset_choice%"=="0" goto menu
goto reset_settings

:reset_chrome
echo.
echo [WARNING] This will reset Chrome to default settings!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto reset_settings

del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" 2>nul
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Secure Preferences" 2>nul
echo [SUCCESS] Chrome settings reset
pause
goto reset_settings

:reset_firefox
echo.
echo [WARNING] This will reset Firefox to default settings!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto reset_settings

for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    del /q /f "%%i\prefs.js" 2>nul
    del /q /f "%%i\user.js" 2>nul
)
echo [SUCCESS] Firefox settings reset
pause
goto reset_settings

:reset_edge
echo.
echo [WARNING] This will reset Edge to default settings!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto reset_settings

del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Preferences" 2>nul
echo [SUCCESS] Edge settings reset
pause
goto reset_settings

:reset_all
echo.
echo [WARNING] This will reset all browsers to default settings!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto reset_settings

del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" 2>nul
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Preferences" 2>nul
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    del /q /f "%%i\prefs.js" 2>nul
)
echo [SUCCESS] All browser settings reset
pause
goto reset_settings

:security_check
echo.
echo [INFO] Browser security check...
echo.

echo [1/4] Checking Chrome security...
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" (
    findstr /i "safe_browsing" "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" >nul 2>&1
    if %errorLevel% equ 0 (
        echo Chrome safe browsing is enabled
    ) else (
        echo Chrome safe browsing may be disabled
    )
) else (
    echo Chrome not installed or no preferences found
)

echo [2/4] Checking Firefox security...
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    if exist "%%i\prefs.js" (
        findstr /i "safebrowsing" "%%i\prefs.js" >nul 2>&1
        if %errorLevel% equ 0 (
            echo Firefox safe browsing is enabled
        ) else (
            echo Firefox safe browsing may be disabled
        )
    )
)

echo [3/4] Checking Edge security...
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Preferences" (
    findstr /i "safe_browsing" "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Preferences" >nul 2>&1
    if %errorLevel% equ 0 (
        echo Edge safe browsing is enabled
    ) else (
        echo Edge safe browsing may be disabled
    )
) else (
    echo Edge not installed or no preferences found
)

echo [4/4] Checking for suspicious browser processes...
tasklist | findstr /i "chrome\|firefox\|msedge\|iexplore" | findstr /v "svchost"

echo [SUCCESS] Browser security check completed
pause
goto menu

:exit
echo.
echo [INFO] Browser Cleaner closed
exit /b 0
