@echo off
chcp 65001 >nul
title TCP/IP Reset Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    TCP/IP Reset Tool                         ║
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
echo ║                    TCP/IP Reset                              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Reset TCP/IP Stack
echo [2] Reset Winsock
echo [3] Complete Network Reset
echo [4] Reset IP Configuration
echo [5] Reset Network Adapter Settings
echo [6] Clear ARP Cache
echo [7] Reset Routing Table
echo [8] Reset Firewall Rules
echo [9] Advanced TCP/IP Reset
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto reset_tcpip
if "%choice%"=="2" goto reset_winsock
if "%choice%"=="3" goto complete_reset
if "%choice%"=="4" goto reset_ipconfig
if "%choice%"=="5" goto reset_adapter
if "%choice%"=="6" goto clear_arp
if "%choice%"=="7" goto reset_routing
if "%choice%"=="8" goto reset_firewall
if "%choice%"=="9" goto advanced_reset
if "%choice%"=="0" goto exit
goto menu

:reset_tcpip
echo.
echo [INFO] Resetting TCP/IP stack...
echo.

:: Reset TCP/IP stack
netsh int ip reset
if %errorLevel% equ 0 (
    echo [SUCCESS] TCP/IP stack reset successfully
) else (
    echo [ERROR] Failed to reset TCP/IP stack
)

:: Flush DNS cache
echo [INFO] Flushing DNS cache...
ipconfig /flushdns

:: Renew IP address
echo [INFO] Renewing IP address...
ipconfig /release
ipconfig /renew

echo [SUCCESS] TCP/IP reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:reset_winsock
echo.
echo [INFO] Resetting Winsock...
echo.

:: Reset Winsock
netsh winsock reset
if %errorLevel% equ 0 (
    echo [SUCCESS] Winsock reset successfully
) else (
    echo [ERROR] Failed to reset Winsock
)

:: Reset Winsock catalog
netsh winsock reset catalog

echo [SUCCESS] Winsock reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:complete_reset
echo.
echo [WARNING] This will perform a complete network reset!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Performing complete network reset...
echo.

:: Reset Winsock
echo [1/6] Resetting Winsock...
netsh winsock reset

:: Reset TCP/IP stack
echo [2/6] Resetting TCP/IP stack...
netsh int ip reset

:: Flush DNS cache
echo [3/6] Flushing DNS cache...
ipconfig /flushdns

:: Clear ARP cache
echo [4/6] Clearing ARP cache...
arp -d

:: Reset firewall
echo [5/6] Resetting firewall...
netsh advfirewall reset

:: Reset network adapters
echo [6/6] Resetting network adapters...
netsh interface set interface "*" admin=disable
timeout /t 3 >nul
netsh interface set interface "*" admin=enable

echo [SUCCESS] Complete network reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:reset_ipconfig
echo.
echo [INFO] Resetting IP configuration...
echo.

:: Release IP addresses
echo [1/3] Releasing IP addresses...
ipconfig /release

:: Renew IP addresses
echo [2/3] Renewing IP addresses...
ipconfig /renew

:: Flush DNS cache
echo [3/3] Flushing DNS cache...
ipconfig /flushdns

echo [SUCCESS] IP configuration reset
pause
goto menu

:reset_adapter
echo.
echo [INFO] Resetting network adapter settings...
echo.

:: Get list of network adapters
echo [1/3] Listing network adapters...
netsh interface show interface

:: Reset all adapters
echo [2/3] Resetting all network adapters...
netsh interface set interface "*" admin=disable
timeout /t 2 >nul
netsh interface set interface "*" admin=enable

:: Reset adapter settings
echo [3/3] Resetting adapter settings to DHCP...
for /f "tokens=1,2" %%a in ('netsh interface show interface ^| findstr "Enabled"') do (
    netsh interface ip set address "%%b" dhcp >nul 2>&1
    netsh interface ip set dns "%%b" dhcp >nul 2>&1
)

echo [SUCCESS] Network adapter settings reset
pause
goto menu

:clear_arp
echo.
echo [INFO] Clearing ARP cache...
echo.

:: Clear ARP cache
arp -d

:: Display ARP cache after clearing
echo [INFO] Current ARP cache entries:
arp -a

echo [SUCCESS] ARP cache cleared
pause
goto menu

:reset_routing
echo.
echo [INFO] Resetting routing table...
echo.

:: Display current routing table
echo [1/2] Current routing table:
route print

:: Reset routing table
echo [2/2] Resetting routing table...
route -f

echo [SUCCESS] Routing table reset
pause
goto menu

:reset_firewall
echo.
echo [INFO] Resetting firewall rules...
echo.

:: Reset firewall to default
echo [1/3] Resetting firewall to default settings...
netsh advfirewall reset

:: Enable firewall
echo [2/3] Enabling firewall...
netsh advfirewall set allprofiles state on

:: Configure default policies
echo [3/3] Setting default firewall policies...
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound

echo [SUCCESS] Firewall rules reset
pause
goto menu

:advanced_reset
echo.
echo [INFO] Advanced TCP/IP reset...
echo.

echo [1] Reset TCP/IP Parameters
echo [2] Reset Network Protocols
echo [3] Reset Network Services
echo [4] Reset Registry Settings
echo [5] Reset Network Profiles
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto reset_tcpip_params
if "%adv_choice%"=="2" goto reset_protocols
if "%adv_choice%"=="3" goto reset_services
if "%adv_choice%"=="4" goto reset_registry
if "%adv_choice%"=="5" goto reset_profiles
if "%adv_choice%"=="0" goto menu
goto advanced_reset

:reset_tcpip_params
echo.
echo [INFO] Resetting TCP/IP parameters...
echo.

:: Reset TCP/IP parameters to default
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpWindowSize /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v Tcp1323Opts /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnablePMTUDiscovery /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] TCP/IP parameters reset
pause
goto advanced_reset

:reset_protocols
echo.
echo [INFO] Resetting network protocols...
echo.

:: Reset TCP/IP protocol
netsh int ip reset

:: Reset IPv6 protocol
netsh int ipv6 reset

:: Reset Winsock
netsh winsock reset

echo [SUCCESS] Network protocols reset
pause
goto advanced_reset

:reset_services
echo.
echo [INFO] Resetting network services...
echo.

:: Reset network services
echo [1/4] Restarting Network Store Interface Service...
net stop "nsi" >nul 2>&1
net start "nsi" >nul 2>&1

echo [2/4] Restarting Network Location Awareness Service...
net stop "NlaSvc" >nul 2>&1
net start "NlaSvc" >nul 2>&1

echo [3/4] Restarting Network List Service...
net stop "netprofm" >nul 2>&1
net start "netprofm" >nul 2>&1

echo [4/4] Restarting DNS Client Service...
net stop "Dnscache" >nul 2>&1
net start "Dnscache" >nul 2>&1

echo [SUCCESS] Network services reset
pause
goto advanced_reset

:reset_registry
echo.
echo [WARNING] This will reset network registry settings!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto advanced_reset

echo [INFO] Resetting network registry settings...
echo.

:: Reset network registry settings
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards" /f >nul 2>&1

echo [SUCCESS] Network registry settings reset
echo [INFO] Please restart your computer for changes to take effect
pause
goto advanced_reset

:reset_profiles
echo.
echo [INFO] Resetting network profiles...
echo.

:: Reset network profiles
netsh lan delete profile interface="*"
netsh wlan delete profile interface="*"

echo [SUCCESS] Network profiles reset
pause
goto advanced_reset

:exit
echo.
echo [INFO] TCP/IP Reset Tool closed
exit /b 0
