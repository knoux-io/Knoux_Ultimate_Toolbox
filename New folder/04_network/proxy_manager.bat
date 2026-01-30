@echo off
chcp 65001 >nul
title Proxy Manager Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    Proxy Manager Tool                         ║
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
echo ║                    Proxy Manager                              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Show Current Proxy Settings
echo [2] Configure System Proxy
echo [3] Configure Browser Proxy
echo [4] Disable Proxy
echo [5] Test Proxy Connection
echo [6] Proxy Server List
echo [7] Proxy Authentication
echo [8] Proxy Backup/Restore
echo [9] Advanced Proxy Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto show_proxy
if "%choice%"=="2" goto configure_system
if "%choice%"=="3" goto configure_browser
if "%choice%"=="4" goto disable_proxy
if "%choice%"=="5" goto test_proxy
if "%choice%"=="6" goto proxy_list
if "%choice%"=="7" goto proxy_auth
if "%choice%"=="8" goto backup_restore
if "%choice%"=="9" goto advanced_settings
if "%choice%"=="0" goto exit
goto menu

:show_proxy
echo.
echo [INFO] Current proxy settings...
echo.

:: Show system proxy settings
echo [1/4] System proxy settings:
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2>nul
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2>nul
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride 2>nul

echo.
echo [2/4] LAN settings:
netsh winhttp show proxy

echo.
echo [3/4] Environment variables:
echo HTTP_PROXY: %HTTP_PROXY%
echo HTTPS_PROXY: %HTTPS_PROXY%
echo FTP_PROXY: %FTP_PROXY%
echo NO_PROXY: %NO_PROXY%

echo.
echo [4/4] Browser proxy detection:
powershell -Command "Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyEnable,ProxyServer"

pause
goto menu

:configure_system
echo.
echo [INFO] Configuring system proxy...
echo.

echo [1] HTTP Proxy
echo [2] HTTPS Proxy
echo [3] FTP Proxy
echo [4] SOCKS Proxy
echo [5] PAC File
echo [6] Automatic Detection
echo [0] Back to main menu
echo.
set /p proxy_choice="Select an option [0-6]: "

if "%proxy_choice%"=="1" goto http_proxy
if "%proxy_choice%"=="2" goto https_proxy
if "%proxy_choice%"=="3" goto ftp_proxy
if "%proxy_choice%"=="4" goto socks_proxy
if "%proxy_choice%"=="5" goto pac_file
if "%proxy_choice%"=="6" goto auto_detect
if "%proxy_choice%"=="0" goto menu
goto configure_system

:http_proxy
echo.
set /p proxy_server="Enter HTTP proxy server (e.g., proxy.example.com:8080): "
if "%proxy_server%"=="" goto configure_system

echo [INFO] Setting HTTP proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%proxy_server%" /f >nul

echo [SUCCESS] HTTP proxy configured
pause
goto configure_system

:https_proxy
echo.
set /p proxy_server="Enter HTTPS proxy server (e.g., proxy.example.com:8080): "
if "%proxy_server%"=="" goto configure_system

echo [INFO] Setting HTTPS proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "https=%proxy_server%" /f >nul

echo [SUCCESS] HTTPS proxy configured
pause
goto configure_system

:ftp_proxy
echo.
set /p proxy_server="Enter FTP proxy server (e.g., proxy.example.com:8080): "
if "%proxy_server%"=="" goto configure_system

echo [INFO] Setting FTP proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "ftp=%proxy_server%" /f >nul

echo [SUCCESS] FTP proxy configured
pause
goto configure_system

:socks_proxy
echo.
set /p proxy_server="Enter SOCKS proxy server (e.g., proxy.example.com:1080): "
if "%proxy_server%"=="" goto configure_system

echo [INFO] Setting SOCKS proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "socks=%proxy_server%" /f >nul

echo [SUCCESS] SOCKS proxy configured
pause
goto configure_system

:pac_file
echo.
set /p pac_url="Enter PAC file URL: "
if "%pac_url%"=="" goto configure_system

echo [INFO] Setting PAC file...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /t REG_SZ /d "%pac_url%" /f >nul

echo [SUCCESS] PAC file configured
pause
goto configure_system

:auto_detect
echo.
echo [INFO] Enabling automatic proxy detection...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Automatic proxy detection enabled
pause
goto configure_system

:configure_browser
echo.
echo [INFO] Configuring browser proxy...
echo.

echo [1] Chrome Proxy Settings
echo [2] Firefox Proxy Settings
echo [3] Edge Proxy Settings
echo [4] Internet Explorer Settings
echo [0] Back to main menu
echo.
set /p browser_choice="Select an option [0-4]: "

if "%browser_choice%"=="1" goto chrome_proxy
if "%browser_choice%"=="2" goto firefox_proxy
if "%browser_choice%"=="3" goto edge_proxy
if "%browser_choice%"=="4" goto ie_proxy
if "%browser_choice%"=="0" goto menu
goto configure_browser

:chrome_proxy
echo.
echo [INFO] Chrome uses system proxy settings
echo [INFO] Configure system proxy first, then restart Chrome
echo [INFO] Or use Chrome command line: chrome.exe --proxy-server=proxy.example.com:8080
pause
goto configure_browser

:firefox_proxy
echo.
echo [INFO] Firefox proxy settings are stored in profile
echo [INFO] Manual configuration required in Firefox settings
echo [INFO] Or use about:config to modify network.proxy.type settings
pause
goto configure_browser

:edge_proxy
echo.
echo [INFO] Edge uses system proxy settings
echo [INFO] Configure system proxy first, then restart Edge
pause
goto configure_browser

:ie_proxy
echo.
echo [INFO] Internet Explorer uses system proxy settings
echo [INFO] Configure system proxy first, then restart IE
pause
goto configure_browser

:disable_proxy
echo.
echo [INFO] Disabling proxy...
echo.

:: Disable system proxy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 0 /f >nul

:: Clear environment variables
set HTTP_PROXY=
set HTTPS_PROXY=
set FTP_PROXY=
set NO_PROXY=

:: Reset WinHTTP proxy
netsh winhttp reset proxy

echo [SUCCESS] Proxy disabled
pause
goto menu

:test_proxy
echo.
echo [INFO] Testing proxy connection...
echo.

:: Get current proxy settings
for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2^>nul ^| find "ProxyServer"') do set proxy_server=%%a

if defined proxy_server (
    echo [1/3] Testing proxy: %proxy_server%
    
    :: Test HTTP connection through proxy
    echo [2/3] Testing HTTP connection...
    powershell -Command "try { Invoke-WebRequest -Uri 'http://www.google.com' -Proxy 'http://%proxy_server%' -UseBasicParsing; Write-Host 'HTTP: SUCCESS' } catch { Write-Host 'HTTP: FAILED' }"
    
    :: Test HTTPS connection through proxy
    echo [3/3] Testing HTTPS connection...
    powershell -Command "try { Invoke-WebRequest -Uri 'https://www.google.com' -Proxy 'http://%proxy_server%' -UseBasicParsing; Write-Host 'HTTPS: SUCCESS' } catch { Write-Host 'HTTPS: FAILED' }"
) else (
    echo [ERROR] No proxy configured
)

echo [SUCCESS] Proxy test completed
pause
goto menu

:proxy_list
echo.
echo [INFO] Common proxy servers...
echo.

echo [1] Free Proxy Servers:
echo - HTTP: proxy.example.com:8080
echo - HTTPS: secure.example.com:8443
echo - SOCKS: socks.example.com:1080

echo.
echo [2] Common Proxy Ports:
echo - HTTP: 8080, 3128, 8888
echo - HTTPS: 8443, 3129
echo - SOCKS: 1080, 1081

echo.
echo [3] Public Proxy Services:
echo - HideMyAss: proxy.hidemyass.com
echo - KProxy: kproxy.com
echo - Proxify: proxify.com

echo [INFO] Use these services at your own risk
pause
goto menu

:proxy_auth
echo.
echo [INFO] Proxy Authentication...
echo.

echo [1] Set Proxy Username/Password
echo [2] Clear Proxy Credentials
echo [3] Test Proxy Authentication
echo [0] Back to main menu
echo.
set /p auth_choice="Select an option [0-3]: "

if "%auth_choice%"=="1" goto set_auth
if "%auth_choice%"=="2" goto clear_auth
if "%auth_choice%"=="3" goto test_auth
if "%auth_choice%"=="0" goto menu
goto proxy_auth

:set_auth
echo.
set /p proxy_user="Enter proxy username: "
set /p proxy_pass="Enter proxy password: "

if not "%proxy_user%"=="" (
    echo [INFO] Setting proxy credentials...
    netsh winhttp set proxy proxy-server="proxy.example.com:8080" bypass-list="<local>" >nul 2>&1
    echo [WARNING] Proxy credentials require manual configuration in applications
    echo [INFO] Username: %proxy_user%
    echo [INFO] Password: [HIDDEN]
)

pause
goto proxy_auth

:clear_auth
echo.
echo [INFO] Clearing proxy credentials...
cmdkey /list | findstr "proxy" >nul 2>&1
if %errorLevel% equ 0 (
    cmdkey /delete:proxy:* >nul 2>&1
    echo [SUCCESS] Proxy credentials cleared
) else (
    echo [INFO] No proxy credentials found
)

pause
goto proxy_auth

:test_auth
echo.
echo [INFO] Testing proxy authentication...
echo [WARNING] Requires manual testing with proxy server
pause
goto proxy_auth

:backup_restore
echo.
echo [INFO] Proxy Backup/Restore...
echo.

echo [1] Backup Proxy Settings
echo [2] Restore Proxy Settings
echo [0] Back to main menu
echo.
set /p backup_choice="Select an option [0-2]: "

if "%backup_choice%"=="1" goto backup_proxy
if "%backup_choice%"=="2" goto restore_proxy
if "%backup_choice%"=="0" goto menu
goto backup_restore

:backup_proxy
echo.
echo [INFO] Backing up proxy settings...
set backup_file=%TEMP%\proxy_settings_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.reg

reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" "%backup_file%" /y >nul 2>&1

echo [SUCCESS] Proxy settings backed up
echo [INFO] Backup file: %backup_file%
pause
goto backup_restore

:restore_proxy
echo.
set /p backup_file="Enter backup file path: "
if "%backup_file%"=="" goto backup_restore

if exist "%backup_file%" (
    echo [INFO] Restoring proxy settings...
    reg import "%backup_file%"
    echo [SUCCESS] Proxy settings restored
) else (
    echo [ERROR] Backup file not found
)

pause
goto backup_restore

:advanced_settings
echo.
echo [INFO] Advanced Proxy Settings...
echo.

echo [1] Configure Proxy Bypass List
echo [2] Set Proxy Timeout
echo [3] Configure Proxy Auto-Discovery
echo [4] Set Proxy for Specific Applications
echo [5] Proxy Chain Configuration
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto bypass_list
if "%adv_choice%"=="2" goto proxy_timeout
if "%adv_choice%"=="3" goto auto_discovery
if "%adv_choice%"=="4" goto app_proxy
if "%adv_choice%"=="5" goto proxy_chain
if "%adv_choice%"=="0" goto menu
goto advanced_settings

:bypass_list
echo.
set /p bypass_list="Enter proxy bypass list (comma-separated): "
if not "%bypass_list%"=="" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "%bypass_list%" /f >nul
    echo [SUCCESS] Proxy bypass list configured
)
pause
goto advanced_settings

:proxy_timeout
echo.
set /p timeout="Enter proxy timeout (seconds): "
if not "%timeout%"=="" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyTimeout /t REG_DWORD /d %timeout% /f >nul
    echo [SUCCESS] Proxy timeout configured
)
pause
goto advanced_settings

:auto_discovery
echo.
set /p wpad_url="Enter WPAD URL: "
if not "%wpad_url%"=="" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /t REG_SZ /d "%wpad_url%" /f >nul
    echo [SUCCESS] Auto-discovery configured
)
pause
goto advanced_settings

:app_proxy
echo.
echo [INFO] Application-specific proxy configuration requires manual setup
echo [INFO] Examples:
echo - Git: git config --global http.proxy http://proxy.example.com:8080
echo - npm: npm config set proxy http://proxy.example.com:8080
echo - curl: curl -x proxy.example.com:8080 http://example.com
pause
goto advanced_settings

:proxy_chain
echo.
echo [INFO] Proxy chain configuration requires specialized software
echo [INFO] Consider using tools like Proxychains, Proxifier, or custom scripts
pause
goto advanced_settings

:exit
echo.
echo [INFO] Proxy Manager Tool closed
exit /b 0
