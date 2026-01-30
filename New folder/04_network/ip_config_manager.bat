@echo off
chcp 65001 >nul
title IP Configuration Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                IP Configuration Manager                     ║
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
echo ║                IP Configuration Manager                     ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Show Current IP Configuration
echo [2] Set Static IP Address
echo [3] Set DHCP IP Address
echo [4] Configure DNS Servers
echo [5] Configure Default Gateway
echo [6] Configure Subnet Mask
echo [7] Advanced IP Settings
echo [8] Network Interface Selection
echo [9] IP Configuration Backup/Restore
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto show_config
if "%choice%"=="2" goto set_static
if "%choice%"=="3" goto set_dhcp
if "%choice%"=="4" goto configure_dns
if "%choice%"=="5" goto configure_gateway
if "%choice%"=="6" goto configure_subnet
if "%choice%"=="7" goto advanced_settings
if "%choice%"=="8" goto interface_selection
if "%choice%"=="9" goto backup_restore
if "%choice%"=="0" goto exit
goto menu

:show_config
echo.
echo [INFO] Current IP Configuration...
echo.

:: Show detailed IP configuration
echo [1/4] IP Configuration:
ipconfig /all

echo [2/4] Network Interfaces:
netsh interface show interface

echo [3/4] Route Table:
route print

echo [4/4] ARP Cache:
arp -a

pause
goto menu

:set_static
echo.
echo [INFO] Setting static IP address...
echo.

:: Select network interface
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto menu

:: Get IP configuration details
set /p ip_address="Enter IP address: "
set /p subnet_mask="Enter subnet mask: "
set /p default_gateway="Enter default gateway: "

if "%ip_address%"=="" goto menu
if "%subnet_mask%"=="" set subnet_mask=255.255.255.0

:: Set static IP
echo [1/3] Setting IP address...
netsh interface ip set address "%interface_name%" static %ip_address% %subnet_mask%
if %errorLevel% neq 0 (
    echo [ERROR] Failed to set IP address
    pause
    goto menu
)

:: Set default gateway if provided
if not "%default_gateway%"=="" (
    echo [2/3] Setting default gateway...
    netsh interface ip set address "%interface_name%" gateway=%default_gateway%
)

:: Set DNS servers
echo [3/3] Setting DNS servers...
set /p primary_dns="Enter primary DNS server: "
set /p secondary_dns="Enter secondary DNS server (optional): "

if not "%primary_dns%"=="" (
    netsh interface ip set dns "%interface_name%" static %primary_dns% primary
    if not "%secondary_dns%"=="" (
        netsh interface ip add dns "%interface_name%" %secondary_dns% index=2
    )
)

echo [SUCCESS] Static IP configuration completed
pause
goto menu

:set_dhcp
echo.
echo [INFO] Setting DHCP IP address...
echo.

:: Select network interface
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto menu

:: Set DHCP
echo [1/2] Setting IP address to DHCP...
netsh interface ip set address "%interface_name%" dhcp
if %errorLevel% neq 0 (
    echo [ERROR] Failed to set DHCP
    pause
    goto menu
)

:: Set DNS to DHCP
echo [2/2] Setting DNS to DHCP...
netsh interface ip set dns "%interface_name%" dhcp

echo [SUCCESS] DHCP configuration completed
pause
goto menu

:configure_dns
echo.
echo [INFO] Configuring DNS servers...
echo.

:: Select network interface
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto menu

echo [1] Set Google DNS (8.8.8.8, 8.8.4.4)
echo [2] Set Cloudflare DNS (1.1.1.1, 1.0.0.1)
echo [3] Set OpenDNS (208.67.222.222, 208.67.220.220)
echo [4] Set Custom DNS
echo [5] Set DHCP DNS
echo [0] Back to main menu
echo.
set /p dns_choice="Select an option [0-5]: "

if "%dns_choice%"=="1" goto set_google_dns
if "%dns_choice%"=="2" goto set_cloudflare_dns
if "%dns_choice%"=="3" goto set_opendns
if "%dns_choice%"=="4" goto set_custom_dns
if "%dns_choice%"=="5" goto set_dhcp_dns
if "%dns_choice%"=="0" goto menu
goto configure_dns

:set_google_dns
echo.
netsh interface ip set dns "%interface_name%" static 8.8.8.8 primary
netsh interface ip add dns "%interface_name%" 8.8.4.4 index=2
echo [SUCCESS] Google DNS configured
pause
goto configure_dns

:set_cloudflare_dns
echo.
netsh interface ip set dns "%interface_name%" static 1.1.1.1 primary
netsh interface ip add dns "%interface_name%" 1.0.0.1 index=2
echo [SUCCESS] Cloudflare DNS configured
pause
goto configure_dns

:set_opendns
echo.
netsh interface ip set dns "%interface_name%" static 208.67.222.222 primary
netsh interface ip add dns "%interface_name%" 208.67.220.220 index=2
echo [SUCCESS] OpenDNS configured
pause
goto configure_dns

:set_custom_dns
echo.
set /p primary_dns="Enter primary DNS server: "
set /p secondary_dns="Enter secondary DNS server (optional): "

if not "%primary_dns%"=="" (
    netsh interface ip set dns "%interface_name%" static %primary_dns% primary
    if not "%secondary_dns%"=="" (
        netsh interface ip add dns "%interface_name%" %secondary_dns% index=2
    )
    echo [SUCCESS] Custom DNS configured
) else (
    echo [ERROR] Primary DNS server is required
)
pause
goto configure_dns

:set_dhcp_dns
echo.
netsh interface ip set dns "%interface_name%" dhcp
echo [SUCCESS] DNS set to DHCP
pause
goto configure_dns

:configure_gateway
echo.
echo [INFO] Configuring default gateway...
echo.

:: Select network interface
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto menu

set /p gateway_address="Enter gateway address: "
if "%gateway_address%"=="" goto menu

netsh interface ip set address "%interface_name%" gateway=%gateway_address%
if %errorLevel% equ 0 (
    echo [SUCCESS] Default gateway configured
) else (
    echo [ERROR] Failed to configure gateway
)

pause
goto menu

:configure_subnet
echo.
echo [INFO] Configuring subnet mask...
echo.

:: Select network interface
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto menu

set /p subnet_mask="Enter subnet mask: "
if "%subnet_mask%"=="" goto menu

:: Get current IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "%interface_name%" -A 4 ^| findstr "IPv4"') do set current_ip=%%a
set current_ip=%current_ip: =%

if not "%current_ip%"=="" (
    netsh interface ip set address "%interface_name%" static %current_ip% %subnet_mask%
    if %errorLevel% equ 0 (
        echo [SUCCESS] Subnet mask configured
    ) else (
        echo [ERROR] Failed to configure subnet mask
    )
) else (
    echo [ERROR] Could not determine current IP address
)

pause
goto menu

:advanced_settings
echo.
echo [INFO] Advanced IP settings...
echo.

echo [1] Configure WINS Servers
echo [2] Configure DNS Suffix
echo [3] Configure Metric
echo [4] Configure MTU
echo [5] Enable/Disable NetBIOS
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto configure_wins
if "%adv_choice%"=="2" goto configure_suffix
if "%adv_choice%"=="3" goto configure_metric
if "%adv_choice%"=="4" goto configure_mtu
if "%adv_choice%"=="5" goto configure_netbios
if "%adv_choice%"=="0" goto menu
goto advanced_settings

:configure_wins
echo.
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto advanced_settings

set /p primary_wins="Enter primary WINS server: "
set /p secondary_wins="Enter secondary WINS server (optional): "

if not "%primary_wins%"=="" (
    netsh interface ip set wins "%interface_name%" static %primary_wins%
    if not "%secondary_wins%"=="" (
        netsh interface ip add wins "%interface_name%" %secondary_wins%
    )
    echo [SUCCESS] WINS servers configured
)
pause
goto advanced_settings

:configure_suffix
echo.
set /p dns_suffix="Enter DNS suffix: "
if not "%dns_suffix%"=="" (
    netsh interface ip set dns "%interface_name%" suffix=%dns_suffix%
    echo [SUCCESS] DNS suffix configured
)
pause
goto advanced_settings

:configure_metric
echo.
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto advanced_settings

set /p metric_value="Enter metric value: "
if "%metric_value%"=="" goto advanced_settings

netsh interface ip set interface "%interface_name%" metric=%metric_value%
echo [SUCCESS] Metric configured
pause
goto advanced_settings

:configure_mtu
echo.
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto advanced_settings

set /p mtu_value="Enter MTU value (576-1500): "
if "%mtu_value%"=="" goto advanced_settings

netsh interface ipv4 set subinterface "%interface_name%" mtu=%mtu_value% store=persistent
echo [SUCCESS] MTU configured
pause
goto advanced_settings

:configure_netbios
echo.
echo Available network interfaces:
netsh interface show interface | findstr "Enabled"
echo.

set /p interface_name="Enter interface name: "
if "%interface_name%"=="" goto advanced_settings

echo [1] Enable NetBIOS over TCP/IP
echo [2] Disable NetBIOS over TCP/IP
echo [3] Use DHCP setting for NetBIOS
echo.
set /p netbios_choice="Select an option [1-3]: "

if "%netbios_choice%"=="1" (
    netsh interface ip set interface "%interface_name%" netbios=enabled
    echo [SUCCESS] NetBIOS enabled
) else if "%netbios_choice%"=="2" (
    netsh interface ip set interface "%interface_name%" netbios=disabled
    echo [SUCCESS] NetBIOS disabled
) else if "%netbios_choice%"=="3" (
    netsh interface ip set interface "%interface_name%" netbios=dhcpenabled
    echo [SUCCESS] NetBIOS set to DHCP
)

pause
goto advanced_settings

:interface_selection
echo.
echo [INFO] Network Interface Selection...
echo.

echo Available network interfaces:
netsh interface show interface

echo.
set /p selected_interface="Enter interface name for operations: "
if "%selected_interface%"=="" goto menu

echo [INFO] Selected interface: %selected_interface%
echo Current configuration for %selected_interface%:
netsh interface ip show address "%selected_interface%"

pause
goto menu

:backup_restore
echo.
echo [INFO] IP Configuration Backup/Restore...
echo.

echo [1] Backup Current Configuration
echo [2] Restore Configuration
echo [3] List Backup Files
echo [0] Back to main menu
echo.
set /p backup_choice="Select an option [0-3]: "

if "%backup_choice%"=="1" goto backup_config
if "%backup_choice%"=="2" goto restore_config
if "%backup_choice%"=="3" goto list_backups
if "%backup_choice%"=="0" goto menu
goto backup_restore

:backup_config
echo.
echo [INFO] Backing up current IP configuration...
echo.

set backup_file=%TEMP%\ip_config_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

ipconfig /all > "%backup_file%"
route print >> "%backup_file%"
arp -a >> "%backup_file%"

echo [SUCCESS] Configuration backed up
echo [INFO] Backup saved to: %backup_file%
pause
goto backup_restore

:restore_config
echo.
echo [INFO] Restoring IP configuration...
echo.

set /p backup_file="Enter backup file path: "
if "%backup_file%"=="" goto backup_restore

if exist "%backup_file%" (
    echo [INFO] Configuration from backup:
    type "%backup_file%"
    echo.
    echo [WARNING] Manual restoration required based on backup content
) else (
    echo [ERROR] Backup file not found
)

pause
goto backup_restore

:list_backups
echo.
echo [INFO] Available backup files:
echo.
dir %TEMP%\ip_config_backup_*.txt /b 2>nul
if %errorLevel% neq 0 (
    echo No backup files found
)
pause
goto backup_restore

:exit
echo.
echo [INFO] IP Configuration Manager closed
exit /b 0
