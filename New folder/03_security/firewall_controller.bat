@echo off
chcp 65001 >nul
title Firewall Controller Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Firewall Controller Tool                     ║
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
echo ║                  Firewall Controller                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Firewall Status
echo [2] Enable Firewall
echo [3] Disable Firewall
echo [4] Configure Firewall Profiles
echo [5] Add Firewall Rule
echo [6] Remove Firewall Rule
echo [7] List Firewall Rules
echo [8] Reset Firewall Settings
echo [9] Advanced Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto enable_firewall
if "%choice%"=="3" goto disable_firewall
if "%choice%"=="4" goto configure_profiles
if "%choice%"=="5" goto add_rule
if "%choice%"=="6" goto remove_rule
if "%choice%"=="7" goto list_rules
if "%choice%"=="8" goto reset_settings
if "%choice%"=="9" goto advanced_settings
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking firewall status...
echo.

:: Check firewall status for all profiles
echo [1/3] Domain Profile:
netsh advfirewall show domainprofile state

echo [2/3] Private Profile:
netsh advfirewall show privateprofile state

echo [3/3] Public Profile:
netsh advfirewall show publicprofile state

pause
goto menu

:enable_firewall
echo.
echo [INFO] Enabling firewall...
echo.

:: Enable firewall for all profiles
netsh advfirewall set allprofiles state on
if %errorLevel% equ 0 (
    echo [SUCCESS] Firewall enabled for all profiles
) else (
    echo [ERROR] Failed to enable firewall
)

pause
goto menu

:disable_firewall
echo.
echo [WARNING] Disabling firewall reduces security!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling firewall...
echo.

:: Disable firewall for all profiles
netsh advfirewall set allprofiles state off
if %errorLevel% equ 0 (
    echo [SUCCESS] Firewall disabled for all profiles
) else (
    echo [ERROR] Failed to disable firewall
)

pause
goto menu

:configure_profiles
echo.
echo [INFO] Configuring firewall profiles...
echo.

echo [1] Configure Domain Profile
echo [2] Configure Private Profile
echo [3] Configure Public Profile
echo [0] Back to main menu
echo.
set /p profile_choice="Select an option [0-3]: "

if "%profile_choice%"=="1" goto configure_domain
if "%profile_choice%"=="2" goto configure_private
if "%profile_choice%"=="3" goto configure_public
if "%profile_choice%"=="0" goto menu
goto configure_profiles

:configure_domain
echo.
echo [INFO] Configuring Domain Profile...
echo.

set /p domain_action="Enable/Disable [E/D]: "
if /i "%domain_action%"=="E" (
    netsh advfirewall set domainprofile state on
    echo [SUCCESS] Domain profile enabled
) else (
    netsh advfirewall set domainprofile state off
    echo [SUCCESS] Domain profile disabled
)

pause
goto configure_profiles

:configure_private
echo.
echo [INFO] Configuring Private Profile...
echo.

set /p private_action="Enable/Disable [E/D]: "
if /i "%private_action%"=="E" (
    netsh advfirewall set privateprofile state on
    echo [SUCCESS] Private profile enabled
) else (
    netsh advfirewall set privateprofile state off
    echo [SUCCESS] Private profile disabled
)

pause
goto configure_profiles

:configure_public
echo.
echo [INFO] Configuring Public Profile...
echo.

set /p public_action="Enable/Disable [E/D]: "
if /i "%public_action%"=="E" (
    netsh advfirewall set publicprofile state on
    echo [SUCCESS] Public profile enabled
) else (
    netsh advfirewall set publicprofile state off
    echo [SUCCESS] Public profile disabled
)

pause
goto configure_profiles

:add_rule
echo.
echo [INFO] Adding firewall rule...
echo.

echo [1] Allow inbound port
echo [2] Block inbound port
echo [3] Allow outbound port
echo [4] Block outbound port
echo [5] Allow application
echo [6] Block application
echo [0] Back to main menu
echo.
set /p rule_choice="Select an option [0-6]: "

if "%rule_choice%"=="1" goto allow_inbound_port
if "%rule_choice%"=="2" goto block_inbound_port
if "%rule_choice%"=="3" goto allow_outbound_port
if "%rule_choice%"=="4" goto block_outbound_port
if "%rule_choice%"=="5" goto allow_application
if "%rule_choice%"=="6" goto block_application
if "%rule_choice%"=="0" goto menu
goto add_rule

:allow_inbound_port
echo.
set /p port="Enter port number: "
set /p protocol="Enter protocol (TCP/UDP): "
set /p rule_name="Enter rule name: "

netsh advfirewall firewall add rule name="%rule_name%" dir=in action=allow protocol=%protocol% localport=%port%
if %errorLevel% equ 0 (
    echo [SUCCESS] Inbound rule added
) else (
    echo [ERROR] Failed to add inbound rule
)
pause
goto add_rule

:block_inbound_port
echo.
set /p port="Enter port number: "
set /p protocol="Enter protocol (TCP/UDP): "
set /p rule_name="Enter rule name: "

netsh advfirewall firewall add rule name="%rule_name%" dir=in action=block protocol=%protocol% localport=%port%
if %errorLevel% equ 0 (
    echo [SUCCESS] Inbound block rule added
) else (
    echo [ERROR] Failed to add inbound block rule
)
pause
goto add_rule

:allow_outbound_port
echo.
set /p port="Enter port number: "
set /p protocol="Enter protocol (TCP/UDP): "
set /p rule_name="Enter rule name: "

netsh advfirewall firewall add rule name="%rule_name%" dir=out action=allow protocol=%protocol% localport=%port%
if %errorLevel% equ 0 (
    echo [SUCCESS] Outbound rule added
) else (
    echo [ERROR] Failed to add outbound rule
)
pause
goto add_rule

:block_outbound_port
echo.
set /p port="Enter port number: "
set /p protocol="Enter protocol (TCP/UDP): "
set /p rule_name="Enter rule name: "

netsh advfirewall firewall add rule name="%rule_name%" dir=out action=block protocol=%protocol% localport=%port%
if %errorLevel% equ 0 (
    echo [SUCCESS] Outbound block rule added
) else (
    echo [ERROR] Failed to add outbound block rule
)
pause
goto add_rule

:allow_application
echo.
set /p app_path="Enter application path: "
set /p rule_name="Enter rule name: "

netsh advfirewall firewall add rule name="%rule_name%" dir=in action=allow program="%app_path%"
if %errorLevel% equ 0 (
    echo [SUCCESS] Application allow rule added
) else (
    echo [ERROR] Failed to add application allow rule
)
pause
goto add_rule

:block_application
echo.
set /p app_path="Enter application path: "
set /p rule_name="Enter rule name: "

netsh advfirewall firewall add rule name="%rule_name%" dir=in action=block program="%app_path%"
if %errorLevel% equ 0 (
    echo [SUCCESS] Application block rule added
) else (
    echo [ERROR] Failed to add application block rule
)
pause
goto add_rule

:remove_rule
echo.
echo [INFO] Removing firewall rule...
echo.

set /p rule_name="Enter rule name to remove: "
netsh advfirewall firewall delete rule name="%rule_name%"
if %errorLevel% equ 0 (
    echo [SUCCESS] Rule removed
) else (
    echo [ERROR] Failed to remove rule
)

pause
goto menu

:list_rules
echo.
echo [INFO] Listing firewall rules...
echo.

echo [1] List inbound rules
echo [2] List outbound rules
echo [3] List all rules
echo [0] Back to main menu
echo.
set /p list_choice="Select an option [0-3]: "

if "%list_choice%"=="1" (
    netsh advfirewall firewall show rule name=all dir=in | more
) else if "%list_choice%"=="2" (
    netsh advfirewall firewall show rule name=all dir=out | more
) else if "%list_choice%"=="3" (
    netsh advfirewall firewall show rule name=all | more
)

pause
goto menu

:reset_settings
echo.
echo [WARNING] This will reset all firewall settings to default!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Resetting firewall settings...
echo.

netsh advfirewall reset
if %errorLevel% equ 0 (
    echo [SUCCESS] Firewall settings reset to default
) else (
    echo [ERROR] Failed to reset firewall settings
)

pause
goto menu

:advanced_settings
echo.
echo [INFO] Advanced firewall settings...
echo.

echo [1] Set default inbound action
echo [2] Set default outbound action
echo [3] Configure logging
echo [4] Configure notifications
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-4]: "

if "%adv_choice%"=="1" goto default_inbound
if "%adv_choice%"=="2" goto default_outbound
if "%adv_choice%"=="3" goto configure_logging
if "%adv_choice%"=="4" goto configure_notifications
if "%adv_choice%"=="0" goto menu
goto advanced_settings

:default_inbound
echo.
echo [1] Allow inbound by default
echo [2] Block inbound by default
echo.
set /p inbound_choice="Select an option [1-2]: "

if "%inbound_choice%"=="1" (
    netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
    echo [SUCCESS] Inbound traffic allowed by default
) else (
    netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound
    echo [SUCCESS] Inbound traffic blocked by default
)
pause
goto advanced_settings

:default_outbound
echo.
echo [1] Allow outbound by default
echo [2] Block outbound by default
echo.
set /p outbound_choice="Select an option [1-2]: "

if "%outbound_choice%"=="1" (
    netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
    echo [SUCCESS] Outbound traffic allowed by default
) else (
    netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound
    echo [SUCCESS] Outbound traffic blocked by default
)
pause
goto advanced_settings

:configure_logging
echo.
echo [INFO] Configuring firewall logging...
echo.

netsh advfirewall set allprofiles logging allowedconnections enable
netsh advfirewall set allprofiles logging droppedconnections enable
netsh advfirewall set allprofiles logging filename "%%SYSTEMROOT%%\System32\LogFiles\Firewall\pfirewall.log"

echo [SUCCESS] Firewall logging configured
pause
goto advanced_settings

:configure_notifications
echo.
echo [INFO] Configuring firewall notifications...
echo.

netsh advfirewall set allprofiles notifications enable
echo [SUCCESS] Firewall notifications enabled
pause
goto advanced_settings

:exit
echo.
echo [INFO] Firewall Controller closed
exit /b 0
