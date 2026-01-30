@echo off
chcp 65001 >nul
title WiFi Password Viewer - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  WiFi Password Viewer                        ║
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
echo ║                  WiFi Password Viewer                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Show All WiFi Passwords
echo [2] Show Specific WiFi Password
echo [3] Show WiFi Profiles
echo [4] Export WiFi Passwords
echo [5] WiFi Security Analysis
echo [6] Delete WiFi Profile
echo [7] Backup WiFi Profiles
echo [8] Restore WiFi Profiles
echo [9] WiFi Network Information
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto show_all
if "%choice%"=="2" goto show_specific
if "%choice%"=="3" goto show_profiles
if "%choice%"=="4" goto export_passwords
if "%choice%"=="5" goto security_analysis
if "%choice%"=="6" goto delete_profile
if "%choice%"=="7" goto backup_profiles
if "%choice%"=="8" goto restore_profiles
if "%choice%"=="9" goto network_info
if "%choice%"=="0" goto exit
goto menu

:show_all
echo.
echo [INFO] Showing all WiFi passwords...
echo.

:: Get all WiFi profiles
echo [1/2] Getting WiFi profiles...
netsh wlan show profiles | findstr "All User Profile"

echo.
echo [2/2] Extracting passwords...
echo.

:: Extract passwords for all profiles
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    echo.
    echo [PROFILE] %%a
    echo ----------------------------------------
    netsh wlan show profile name="%%a" key=clear | findstr "Key Content\|Authentication\|Cipher"
    echo ----------------------------------------
)

echo [SUCCESS] All WiFi passwords displayed
pause
goto menu

:show_specific
echo.
echo [INFO] Showing specific WiFi password...
echo.

:: List available profiles
echo Available WiFi profiles:
netsh wlan show profiles | findstr "All User Profile"
echo.

set /p profile_name="Enter WiFi profile name: "
if "%profile_name%"=="" goto menu

echo.
echo [INFO] Password for profile: %profile_name%
echo ----------------------------------------
netsh wlan show profile name="%profile_name%" key=clear
echo ----------------------------------------

echo [SUCCESS] WiFi password displayed
pause
goto menu

:show_profiles
echo.
echo [INFO] Showing WiFi profiles...
echo.

:: Show all WiFi profiles with details
echo [1/3] Basic profile information:
netsh wlan show profiles

echo.
echo [2/3] Profile details:
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    echo.
    echo [PROFILE] %%a
    netsh wlan show profile name="%%a"
)

echo.
echo [3/3] Profile security information:
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    echo.
    echo [PROFILE] %%a - Security
    netsh wlan show profile name="%%a" key=clear | findstr "Authentication\|Cipher\|Key Content"
)

echo [SUCCESS] WiFi profiles displayed
pause
goto menu

:export_passwords
echo.
echo [INFO] Exporting WiFi passwords...
echo.

set export_file=%TEMP%\wifi_passwords_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

echo WiFi Password Export > "%export_file%"
echo Generated on: %date% %time% >> "%export_file%"
echo ======================================== >> "%export_file%"
echo. >> "%export_file%"

:: Export all WiFi passwords
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    echo Profile: %%a >> "%export_file%"
    echo ---------------------------------------- >> "%export_file%"
    netsh wlan show profile name="%%a" key=clear >> "%export_file%"
    echo. >> "%export_file%"
    echo ======================================== >> "%export_file%"
    echo. >> "%export_file%"
)

echo [SUCCESS] WiFi passwords exported
echo [INFO] Export file: %export_file%
pause
goto menu

:security_analysis
echo.
echo [INFO] WiFi Security Analysis...
echo.

:: Analyze WiFi security
echo [1/4] Checking WiFi adapter security:
netsh wlan show interfaces | findstr "State\|Authentication\|Cipher"

echo.
echo [2/4] Analyzing profile security:
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    echo [PROFILE] %%a
    netsh wlan show profile name="%%a" key=clear | findstr "Authentication\|Cipher"
)

echo.
echo [3/4] Checking for weak passwords:
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    for /f "tokens=3" %%b in ('netsh wlan show profile name="%%a" key=clear ^| findstr "Key Content"') do (
        set password=%%b
        if "!password:~8!"=="" (
            echo [WARNING] Weak password detected for profile %%a
        )
    )
)

echo.
echo [4/4] Checking WiFi adapter settings:
netsh wlan show drivers | findstr "Radio types\|Auto config"

echo [SUCCESS] Security analysis completed
pause
goto menu

:delete_profile
echo.
echo [WARNING] This will delete a WiFi profile!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Available WiFi profiles:
netsh wlan show profiles | findstr "All User Profile"
echo.

set /p profile_name="Enter WiFi profile name to delete: "
if "%profile_name%"=="" goto menu

echo [INFO] Deleting WiFi profile: %profile_name%...
netsh wlan delete profile name="%profile_name%"

if %errorLevel% equ 0 (
    echo [SUCCESS] WiFi profile deleted
) else (
    echo [ERROR] Failed to delete WiFi profile
)

pause
goto menu

:backup_profiles
echo.
echo [INFO] Backing up WiFi profiles...
echo.

set backup_dir=%TEMP%\wifi_profiles_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
mkdir "%backup_dir%" 2>nul

:: Backup all WiFi profiles
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    echo Backing up profile: %%a
    netsh wlan export profile name="%%a" folder="%backup_dir%" key=clear
)

echo [SUCCESS] WiFi profiles backed up
echo [INFO] Backup location: %backup_dir%
pause
goto menu

:restore_profiles
echo.
echo [INFO] Restoring WiFi profiles...
echo.

set /p backup_dir="Enter backup directory path: "
if "%backup_dir%"=="" goto menu

if exist "%backup_dir%" (
    echo Restoring profiles from: %backup_dir%
    for %%f in ("%backup_dir%\*.xml") do (
        echo Restoring: %%f
        netsh wlan add profile filename="%%f"
    )
    echo [SUCCESS] WiFi profiles restored
) else (
    echo [ERROR] Backup directory not found
)

pause
goto menu

:network_info
echo.
echo [INFO] WiFi Network Information...
echo.

:: Show WiFi network information
echo [1/4] WiFi adapter information:
netsh wlan show interfaces

echo.
echo [2/4] Available networks:
netsh wlan show networks

echo.
echo [3/4] Current connection details:
netsh wlan show connections

echo.
echo [4/4] Radio state:
netsh wlan show radio

echo [SUCCESS] Network information displayed
pause
goto menu

:exit
echo.
echo [INFO] WiFi Password Viewer closed
exit /b 0
