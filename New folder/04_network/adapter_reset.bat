@echo off
chcp 65001 >nul
title Network Adapter Reset Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Network Adapter Reset Tool                     ║
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
echo ║                Network Adapter Reset                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] List Network Adapters
echo [2] Reset All Network Adapters
echo [3] Reset Specific Adapter
echo [4] Disable/Enable Adapter
echo [5] Reset Adapter Settings
echo [6] Renew IP Address
echo [7] Flush DNS Cache
echo [8] Reset Winsock
echo [9] Advanced Adapter Reset
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto list_adapters
if "%choice%"=="2" goto reset_all
if "%choice%"=="3" goto reset_specific
if "%choice%"=="4" goto disable_enable
if "%choice%"=="5" goto reset_settings
if "%choice%"=="6" goto renew_ip
if "%choice%"=="7" goto flush_dns
if "%choice%"=="8" goto reset_winsock
if "%choice%"=="9" goto advanced_reset
if "%choice%"=="0" goto exit
goto menu

:list_adapters
echo.
echo [INFO] Listing network adapters...
echo.

echo [1/3] Physical network adapters:
wmic nic get Name,AdapterType,MACAddress,NetConnectionStatus /format:list | findstr "="

echo [2/3] Network adapter configurations:
wmic nicconfig get Description,IPAddress,IPSubnet,DefaultIPGateway,DNSServerSearchOrder /format:list | findstr "="

echo [3/3] Active network connections:
netsh interface show interface

pause
goto menu

:reset_all
echo.
echo [WARNING] This will reset ALL network adapters!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Resetting all network adapters...
echo.

:: Disable all network adapters
echo [1/4] Disabling all network adapters...
netsh interface set interface "*" admin=disable

:: Wait for adapters to disable
timeout /t 3 >nul

:: Enable all network adapters
echo [2/4] Enabling all network adapters...
netsh interface set interface "*" admin=enable

:: Reset IP configuration
echo [3/4] Resetting IP configuration...
ipconfig /release
ipconfig /renew

:: Flush DNS
echo [4/4] Flushing DNS cache...
ipconfig /flushdns

echo [SUCCESS] All network adapters reset
pause
goto menu

:reset_specific
echo.
echo [INFO] Available network adapters:
echo.
netsh interface show interface | findstr "Enabled"
echo.

set /p adapter_name="Enter adapter name to reset: "
if "%adapter_name%"=="" goto menu

echo [INFO] Resetting adapter: %adapter_name%
echo.

:: Disable specific adapter
echo [1/3] Disabling adapter...
netsh interface set interface "%adapter_name%" admin=disable

:: Wait for adapter to disable
timeout /t 2 >nul

:: Enable specific adapter
echo [2/3] Enabling adapter...
netsh interface set interface "%adapter_name%" admin=enable

:: Reset IP configuration for adapter
echo [3/3] Resetting IP configuration...
netsh interface ip set address "%adapter_name%" dhcp
netsh interface ip set dns "%adapter_name%" dhcp

echo [SUCCESS] Adapter %adapter_name% reset
pause
goto menu

:disable_enable
echo.
echo [INFO] Available network adapters:
echo.
netsh interface show interface | findstr "Enabled"
echo.

echo [1] Disable adapter
echo [2] Enable adapter
echo [0] Back to main menu
echo.
set /p action_choice="Select an option [0-2]: "

if "%action_choice%"=="1" goto disable_adapter
if "%action_choice%"=="2" goto enable_adapter
if "%action_choice%"=="0" goto menu
goto disable_enable

:disable_adapter
echo.
set /p adapter_name="Enter adapter name to disable: "
if "%adapter_name%"=="" goto disable_enable

netsh interface set interface "%adapter_name%" admin=disable
if %errorLevel% equ 0 (
    echo [SUCCESS] Adapter %adapter_name% disabled
) else (
    echo [ERROR] Failed to disable adapter
)
pause
goto disable_enable

:enable_adapter
echo.
set /p adapter_name="Enter adapter name to enable: "
if "%adapter_name%"=="" goto disable_enable

netsh interface set interface "%adapter_name%" admin=enable
if %errorLevel% equ 0 (
    echo [SUCCESS] Adapter %adapter_name% enabled
) else (
    echo [ERROR] Failed to enable adapter
)
pause
goto disable_enable

:reset_settings
echo.
echo [INFO] Resetting adapter settings...
echo.

:: Reset TCP/IP stack
echo [1/4] Resetting TCP/IP stack...
netsh int ip reset

:: Reset Winsock
echo [2/4] Resetting Winsock...
netsh winsock reset

:: Reset firewall settings
echo [3/4] Resetting firewall settings...
netsh advfirewall reset

:: Reset network profile
echo [4/4] Resetting network profile...
netsh advfirewall set allprofiles state on

echo [SUCCESS] Adapter settings reset
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:renew_ip
echo.
echo [INFO] Renewing IP address...
echo.

:: Release current IP
echo [1/2] Releasing current IP address...
ipconfig /release

:: Renew IP
echo [2/2] Renewing IP address...
ipconfig /renew

echo [SUCCESS] IP address renewed
pause
goto menu

:flush_dns
echo.
echo [INFO] Flushing DNS cache...
echo.

:: Flush DNS cache
ipconfig /flushdns
if %errorLevel% equ 0 (
    echo [SUCCESS] DNS cache flushed
) else (
    echo [ERROR] Failed to flush DNS cache
)

:: Clear NetBIOS cache
nbtstat -R

:: Clear ARP cache
arp -d

echo [SUCCESS] Network caches cleared
pause
goto menu

:reset_winsock
echo.
echo [INFO] Resetting Winsock...
echo.

:: Reset Winsock catalog
netsh winsock reset
if %errorLevel% equ 0 (
    echo [SUCCESS] Winsock reset completed
) else (
    echo [ERROR] Failed to reset Winsock
)

:: Reset Winsock catalog for IPv6
netsh winsock reset catalog

echo [SUCCESS] Winsock reset completed
echo [INFO] Please restart your computer for changes to take effect
pause
goto menu

:advanced_reset
echo.
echo [INFO] Advanced network reset...
echo.

echo [WARNING] This will perform a complete network reset!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Performing advanced network reset...
echo.

:: Complete network reset
echo [1/6] Resetting network adapters...
netsh interface set interface "*" admin=disable
timeout /t 3 >nul
netsh interface set interface "*" admin=enable

echo [2/6] Resetting TCP/IP stack...
netsh int ip reset

echo [3/6] Resetting Winsock...
netsh winsock reset

echo [4/6] Flushing DNS...
ipconfig /flushdns

echo [5/6] Resetting firewall...
netsh advfirewall reset

echo [6/6] Clearing ARP cache...
arp -d

echo [SUCCESS] Advanced network reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:exit
echo.
echo [INFO] Network Adapter Reset Tool closed
exit /b 0
