@echo off
chcp 65001 >nul
title DNS Flusher Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    DNS Flusher Tool                          ║
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
echo ║                    DNS Flusher                               ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Flush DNS Cache
echo [2] Clear DNS Cache Completely
echo [3] Reset DNS Settings
echo [4] Configure DNS Servers
echo [5] Test DNS Resolution
echo [6] Clear Browser DNS Cache
echo [7] Flush DNS for Specific Domain
echo [8] DNS Cache Statistics
echo [9] Advanced DNS Operations
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto flush_dns
if "%choice%"=="2" goto clear_dns
if "%choice%"=="3" goto reset_dns
if "%choice%"=="4" goto configure_dns
if "%choice%"=="5" goto test_dns
if "%choice%"=="6" goto clear_browser_dns
if "%choice%"=="7" goto flush_domain
if "%choice%"=="8" goto dns_stats
if "%choice%"=="9" goto advanced_dns
if "%choice%"=="0" goto exit
goto menu

:flush_dns
echo.
echo [INFO] Flushing DNS cache...
echo.

:: Flush DNS cache
ipconfig /flushdns
if %errorLevel% equ 0 (
    echo [SUCCESS] DNS cache flushed successfully
) else (
    echo [ERROR] Failed to flush DNS cache
)

:: Clear NetBIOS cache
echo [INFO] Clearing NetBIOS cache...
nbtstat -R

:: Clear ARP cache
echo [INFO] Clearing ARP cache...
arp -d

echo [SUCCESS] DNS and network caches cleared
pause
goto menu

:clear_dns
echo.
echo [WARNING] This will completely clear DNS cache and settings!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Completely clearing DNS cache...
echo.

:: Stop DNS client service
echo [1/4] Stopping DNS Client service...
net stop "Dnscache" >nul 2>&1

:: Clear DNS cache files
echo [2/4] Clearing DNS cache files...
del /q /f "%WINDIR%\System32\dns\*.dns" 2>nul
del /q /f "%WINDIR%\System32\dns\cache\*.*" 2>nul

:: Reset DNS client service
echo [3/4] Resetting DNS Client service...
sc config "Dnscache" start= auto >nul 2>&1

:: Start DNS client service
echo [4/4] Starting DNS Client service...
net start "Dnscache" >nul 2>&1

echo [SUCCESS] DNS cache completely cleared
pause
goto menu

:reset_dns
echo.
echo [INFO] Resetting DNS settings...
echo.

:: Reset DNS settings to default
echo [1/3] Resetting DNS settings to DHCP...
netsh interface ip set dns "Local Area Connection" dhcp >nul 2>&1
netsh interface ip set dns "Wireless Network Connection" dhcp >nul 2>&1

:: Reset all interfaces
echo [2/3] Resetting all interfaces to DHCP...
for /f "tokens=1,2" %%a in ('netsh interface show interface ^| findstr "Connected"') do (
    netsh interface ip set dns "%%b" dhcp >nul 2>&1
)

:: Flush DNS
echo [3/3] Flushing DNS cache...
ipconfig /flushdns

echo [SUCCESS] DNS settings reset to default
pause
goto menu

:configure_dns
echo.
echo [INFO] Configuring DNS servers...
echo.

echo [1] Set Google DNS (8.8.8.8, 8.8.4.4)
echo [2] Set Cloudflare DNS (1.1.1.1, 1.0.0.1)
echo [3] Set OpenDNS (208.67.222.222, 208.67.220.220)
echo [4] Set Custom DNS
echo [5] Reset to DHCP
echo [0] Back to main menu
echo.
set /p dns_choice="Select an option [0-5]: "

if "%dns_choice%"=="1" goto set_google_dns
if "%dns_choice%"=="2" goto set_cloudflare_dns
if "%dns_choice%"=="3" goto set_opendns
if "%dns_choice%"=="4" goto set_custom_dns
if "%dns_choice%"=="5" goto reset_to_dhcp
if "%dns_choice%"=="0" goto menu
goto configure_dns

:set_google_dns
echo.
echo [INFO] Setting Google DNS servers...
netsh interface ip set dns "Local Area Connection" static 8.8.8.8 primary >nul 2>&1
netsh interface ip add dns "Local Area Connection" 8.8.4.4 index=2 >nul 2>&1
netsh interface ip set dns "Wireless Network Connection" static 8.8.8.8 primary >nul 2>&1
netsh interface ip add dns "Wireless Network Connection" 8.8.4.4 index=2 >nul 2>&1
echo [SUCCESS] Google DNS configured
pause
goto configure_dns

:set_cloudflare_dns
echo.
echo [INFO] Setting Cloudflare DNS servers...
netsh interface ip set dns "Local Area Connection" static 1.1.1.1 primary >nul 2>&1
netsh interface ip add dns "Local Area Connection" 1.0.0.1 index=2 >nul 2>&1
netsh interface ip set dns "Wireless Network Connection" static 1.1.1.1 primary >nul 2>&1
netsh interface ip add dns "Wireless Network Connection" 1.0.0.1 index=2 >nul 2>&1
echo [SUCCESS] Cloudflare DNS configured
pause
goto configure_dns

:set_opendns
echo.
echo [INFO] Setting OpenDNS servers...
netsh interface ip set dns "Local Area Connection" static 208.67.222.222 primary >nul 2>&1
netsh interface ip add dns "Local Area Connection" 208.67.220.220 index=2 >nul 2>&1
netsh interface ip set dns "Wireless Network Connection" static 208.67.222.222 primary >nul 2>&1
netsh interface ip add dns "Wireless Network Connection" 208.67.220.220 index=2 >nul 2>&1
echo [SUCCESS] OpenDNS configured
pause
goto configure_dns

:set_custom_dns
echo.
set /p primary_dns="Enter primary DNS server: "
set /p secondary_dns="Enter secondary DNS server (optional): "

if not "%primary_dns%"=="" (
    netsh interface ip set dns "Local Area Connection" static %primary_dns% primary >nul 2>&1
    netsh interface ip set dns "Wireless Network Connection" static %primary_dns% primary >nul 2>&1
    
    if not "%secondary_dns%"=="" (
        netsh interface ip add dns "Local Area Connection" %secondary_dns% index=2 >nul 2>&1
        netsh interface ip add dns "Wireless Network Connection" %secondary_dns% index=2 >nul 2>&1
    )
    
    echo [SUCCESS] Custom DNS configured
) else (
    echo [ERROR] Primary DNS server is required
)
pause
goto configure_dns

:reset_to_dhcp
echo.
echo [INFO] Resetting DNS to DHCP...
netsh interface ip set dns "Local Area Connection" dhcp >nul 2>&1
netsh interface ip set dns "Wireless Network Connection" dhcp >nul 2>&1
echo [SUCCESS] DNS reset to DHCP
pause
goto configure_dns

:test_dns
echo.
echo [INFO] Testing DNS resolution...
echo.

:: Test DNS resolution
echo [1/3] Testing DNS resolution for google.com...
nslookup google.com

echo [2/3] Testing DNS resolution for microsoft.com...
nslookup microsoft.com

echo [3/3] Testing DNS resolution for github.com...
nslookup github.com

echo [SUCCESS] DNS resolution test completed
pause
goto menu

:clear_browser_dns
echo.
echo [INFO] Clearing browser DNS cache...
echo.

:: Close browsers
echo [1/4] Closing browsers...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im firefox.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1

:: Clear Chrome DNS cache
echo [2/4] Clearing Chrome DNS cache...
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" 2>nul

:: Clear Firefox DNS cache
echo [3/4] Clearing Firefox DNS cache...
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    rmdir /s /q "%%i\cache2" 2>nul
)

:: Clear Edge DNS cache
echo [4/4] Clearing Edge DNS cache...
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" 2>nul

echo [SUCCESS] Browser DNS cache cleared
pause
goto menu

:flush_domain
echo.
set /p domain_name="Enter domain name to flush from DNS cache: "
if "%domain_name%"=="" goto menu

echo [INFO] Flushing DNS cache for %domain_name%...

:: Flush specific domain from DNS cache
ipconfig /displaydns | findstr /i "%domain_name%" >nul
if %errorLevel% equ 0 (
    ipconfig /flushdns
    echo [SUCCESS] DNS cache flushed for %domain_name%
) else (
    echo [INFO] No DNS cache entries found for %domain_name%
)

pause
goto menu

:dns_stats
echo.
echo [INFO] DNS cache statistics...
echo.

:: Display DNS cache statistics
echo [1/3] DNS cache entries count:
ipconfig /displaydns | find /c "Record Name"

echo [2/3] DNS cache size:
for /f "tokens=3" %%a in ('ipconfig /displaydns ^| findstr /c:"Cache Size"') do echo Cache Size: %%a bytes

echo [3/3] DNS cache entries:
ipconfig /displaydns | findstr "Record Name"

pause
goto menu

:advanced_dns
echo.
echo [INFO] Advanced DNS operations...
echo.

echo [1] Clear DNS Client Cache
echo [2] Reset DNS Client Service
echo [3] Configure DNS Suffix
echo [4] Set DNS Search Order
echo [5] Enable/Disable DNS Caching
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto clear_client_cache
if "%adv_choice%"=="2" goto reset_dns_service
if "%adv_choice%"=="3" goto configure_suffix
if "%adv_choice%"=="4" goto set_search_order
if "%adv_choice%"=="5" goto toggle_caching
if "%adv_choice%"=="0" goto menu
goto advanced_dns

:clear_client_cache
echo.
echo [INFO] Clearing DNS client cache...
netsh dnsclient flushcache
echo [SUCCESS] DNS client cache cleared
pause
goto advanced_dns

:reset_dns_service
echo.
echo [INFO] Resetting DNS Client service...
net stop "Dnscache" >nul 2>&1
net start "Dnscache" >nul 2>&1
echo [SUCCESS] DNS Client service reset
pause
goto advanced_dns

:configure_suffix
echo.
set /p dns_suffix="Enter DNS suffix: "
if not "%dns_suffix%"=="" (
    netsh interface ip set dns "Local Area Connection" suffix=%dns_suffix% >nul 2>&1
    netsh interface ip set dns "Wireless Network Connection" suffix=%dns_suffix% >nul 2>&1
    echo [SUCCESS] DNS suffix configured
)
pause
goto advanced_dns

:set_search_order
echo.
echo [INFO] Current DNS search order:
ipconfig /all | findstr "DNS Suffix Search List"

set /p search_order="Enter new DNS search order (comma-separated): "
if not "%search_order%"=="" (
    netsh interface ip set dns "Local Area Connection" suffix=%search_order% >nul 2>&1
    netsh interface ip set dns "Wireless Network Connection" suffix=%search_order% >nul 2>&1
    echo [SUCCESS] DNS search order configured
)
pause
goto advanced_dns

:toggle_caching
echo.
set /p cache_choice="Enable DNS caching? [Y/N]: "
if /i "%cache_choice%"=="Y" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableBucketSize /t REG_DWORD /d 1 /f >nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheEntryTtlLimit /t REG_DWORD /d 86400 /f >nul
    echo [SUCCESS] DNS caching enabled
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheEntryTtlLimit /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] DNS caching disabled
)
pause
goto advanced_dns

:exit
echo.
echo [INFO] DNS Flusher Tool closed
exit /b 0
