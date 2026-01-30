@echo off
chcp 65001 >nul
title RDP Security Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  RDP Security Manager                        ║
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
echo ║                  RDP Security Manager                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check RDP Status
echo [2] Enable RDP
echo [3] Disable RDP
echo [4] Configure RDP Security
echo [5] Set RDP Port
echo [6] Configure Network Level Authentication
echo [7] Configure RDP Firewall Rules
echo [8] Monitor RDP Connections
echo [9] RDP Security Hardening
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto enable_rdp
if "%choice%"=="3" goto disable_rdp
if "%choice%"=="4" goto configure_security
if "%choice%"=="5" goto set_port
if "%choice%"=="6" goto configure_nla
if "%choice%"=="7" goto configure_firewall
if "%choice%"=="8" goto monitor_connections
if "%choice%"=="9" goto security_hardening
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking RDP status...
echo.

:: Check RDP service status
echo [1/4] Checking Remote Desktop Services status...
sc query "TermService" | findstr "STATE"

:: Check RDP enabled status
echo [2/4] Checking Remote Desktop enabled status...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections 2>nul
if %errorLevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections 2^>nul ^| find "fDenyTSConnections"') do set rdp_status=%%a
    if "%rdp_status%"=="0" (
        echo Remote Desktop is enabled
    ) else (
        echo Remote Desktop is disabled
    )
) else (
    echo Remote Desktop status could not be determined
)

:: Check RDP port
echo [3/4] Checking RDP port...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber 2>nul
if %errorLevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber 2^>nul ^| find "PortNumber"') do set rdp_port=%%a
    echo RDP Port: %rdp_port%
) else (
    echo RDP port could not be determined
)

:: Check NLA status
echo [4/4] Checking Network Level Authentication status...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication 2>nul
if %errorLevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication 2^>nul ^| find "UserAuthentication"') do set nla_status=%%a
    if "%nla_status%"=="1" (
        echo Network Level Authentication is enabled
    ) else (
        echo Network Level Authentication is disabled
    )
) else (
    echo Network Level Authentication status could not be determined
)

pause
goto menu

:enable_rdp
echo.
echo [WARNING] Enabling RDP may pose security risks!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Enabling Remote Desktop...
echo.

:: Enable RDP
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f >nul
if %errorLevel% equ 0 (
    echo [SUCCESS] Remote Desktop enabled
) else (
    echo [ERROR] Failed to enable Remote Desktop
)

:: Start RDP service
net start "TermService" >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Remote Desktop Services started
) else (
    echo [WARNING] Remote Desktop Services may already be running
)

:: Configure firewall
echo [INFO] Configuring firewall for RDP...
netsh advfirewall firewall add rule name="Remote Desktop" dir=in action=allow protocol=TCP localport=3389 >nul 2>&1

echo [SUCCESS] RDP enabled and firewall configured
pause
goto menu

:disable_rdp
echo.
echo [INFO] Disabling Remote Desktop...
echo.

:: Disable RDP
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul
if %errorLevel% equ 0 (
    echo [SUCCESS] Remote Desktop disabled
) else (
    echo [ERROR] Failed to disable Remote Desktop
)

:: Stop RDP service
net stop "TermService" >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Remote Desktop Services stopped
) else (
    echo [WARNING] Remote Desktop Services may already be stopped
)

:: Remove firewall rule
netsh advfirewall firewall delete rule name="Remote Desktop" >nul 2>&1

echo [SUCCESS] RDP disabled
pause
goto menu

:configure_security
echo.
echo [INFO] Configuring RDP security settings...
echo.

echo [1] Set security layer
echo [2] Set encryption level
echo [3] Configure client settings
echo [4] Configure session settings
echo [0] Back to main menu
echo.
set /p security_choice="Select an option [0-4]: "

if "%security_choice%"=="1" goto security_layer
if "%security_choice%"=="2" goto encryption_level
if "%security_choice%"=="3" goto client_settings
if "%security_choice%"=="4" goto session_settings
if "%security_choice%"=="0" goto menu
goto configure_security

:security_layer
echo.
echo Security Layer options:
echo [1] RDP Security Layer
echo [2] SSL Security Layer
echo [3] Negotiate
echo.
set /p layer_choice="Select security layer [1-3]: "

if "%layer_choice%"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Security layer set to RDP
) else if "%layer_choice%"=="2" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD /d 2 /f >nul
    echo [SUCCESS] Security layer set to SSL
) else if "%layer_choice%"=="3" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Security layer set to Negotiate
)

pause
goto configure_security

:encryption_level
echo.
echo Encryption Level options:
echo [1] Low (56-bit)
echo [2] Client Compatible
echo [3] High (128-bit)
echo [4] FIPS Compliant
echo.
set /p encrypt_choice="Select encryption level [1-4]: "

if "%encrypt_choice%"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Encryption level set to Low
) else if "%encrypt_choice%"=="2" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 2 /f >nul
    echo [SUCCESS] Encryption level set to Client Compatible
) else if "%encrypt_choice%"=="3" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 3 /f >nul
    echo [SUCCESS] Encryption level set to High
) else if "%encrypt_choice%"=="4" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 4 /f >nul
    echo [SUCCESS] Encryption level set to FIPS Compliant
)

pause
goto configure_security

:client_settings
echo.
echo [INFO] Configuring client settings...
echo.

set /p client_choice="Disable client printer redirection? [Y/N]: "
if /i "%client_choice%"=="Y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v DisableCpm /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Client printer redirection disabled
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v DisableCpm /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Client printer redirection enabled
)

set /p clipboard_choice="Disable clipboard redirection? [Y/N]: "
if /i "%clipboard_choice%"=="Y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v DisableClipboardRedirection /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Clipboard redirection disabled
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v DisableClipboardRedirection /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Clipboard redirection enabled
)

pause
goto configure_security

:session_settings
echo.
echo [INFO] Configuring session settings...
echo.

set /p timeout_choice="Set session timeout (minutes): "
if "%timeout_choice%"=="" set timeout_choice=240

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxDisconnectionTime /t REG_DWORD /d %timeout_choice%000 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxIdleTime /t REG_DWORD /d %timeout_choice%000 /f >nul

echo [SUCCESS] Session timeout set to %timeout_choice% minutes
pause
goto configure_security

:set_port
echo.
echo [INFO] Setting RDP port...
echo.

set /p new_port="Enter new RDP port (1-65535): "
if "%new_port%"=="" goto menu

:: Validate port range
if %new_port% lss 1 (
    echo [ERROR] Port must be between 1 and 65535
    pause
    goto set_port
)
if %new_port% gtr 65535 (
    echo [ERROR] Port must be between 1 and 65535
    pause
    goto set_port
)

:: Set new port
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD /d %new_port% /f >nul
if %errorLevel% equ 0 (
    echo [SUCCESS] RDP port set to %new_port%
    
    :: Update firewall rule
    netsh advfirewall firewall delete rule name="Remote Desktop" >nul 2>&1
    netsh advfirewall firewall add rule name="Remote Desktop" dir=in action=allow protocol=TCP localport=%new_port% >nul 2>&1
    echo [SUCCESS] Firewall rule updated for port %new_port%
) else (
    echo [ERROR] Failed to set RDP port
)

pause
goto menu

:configure_nla
echo.
echo [INFO] Configuring Network Level Authentication...
echo.

set /p nla_choice="Enable Network Level Authentication? [Y/N]: "
if /i "%nla_choice%"=="Y" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Network Level Authentication enabled
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Network Level Authentication disabled
)

pause
goto menu

:configure_firewall
echo.
echo [INFO] Configuring RDP firewall rules...
echo.

:: Get current RDP port
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber 2^>nul ^| find "PortNumber"') do set current_port=%%a

echo [1/3] Adding inbound rule for port %current_port%...
netsh advfirewall firewall delete rule name="Remote Desktop" >nul 2>&1
netsh advfirewall firewall add rule name="Remote Desktop" dir=in action=allow protocol=TCP localport=%current_port% >nul 2>&1

echo [2/3] Adding rule for specific IP addresses (optional)...
set /p ip_restriction="Restrict to specific IP addresses? [Y/N]: "
if /i "%ip_restriction%"=="Y" (
    set /p allowed_ips="Enter allowed IP addresses (comma-separated): "
    netsh advfirewall firewall set rule name="Remote Desktop" new remoteip=%allowed_ips% >nul 2>&1
    echo [SUCCESS] RDP restricted to IP addresses: %allowed_ips%
)

echo [3/3] Configuring advanced firewall settings...
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound >nul 2>&1

echo [SUCCESS] RDP firewall rules configured
pause
goto menu

:monitor_connections
echo.
echo [INFO] Monitoring RDP connections...
echo.

:: Show current connections
echo [1/3] Current RDP sessions...
query session

echo [2/3] Recent RDP connection events...
wevtutil qe "Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational" /c:10 /rd:true /f:text 2>nul | findstr /i "User\|IP\|Event"

echo [3/3] Network connections on RDP port...
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber 2^>nul ^| find "PortNumber"') do set rdp_port=%%a
netstat -an | findstr ":%rdp_port%"

pause
goto menu

:security_hardening
echo.
echo [INFO] RDP Security Hardening...
echo.

echo [1/6] Enforcing strong encryption...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 3 /f >nul

echo [2/6] Enabling Network Level Authentication...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f >nul

echo [3/6] Setting session timeout to 15 minutes...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxIdleTime /t REG_DWORD /d 900000 /f >nul

echo [4/6] Disabling client drive mapping...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fDisableCdm /t REG_DWORD /d 1 /f >nul

echo [5/6] Disabling clipboard redirection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v DisableClipboardRedirection /t REG_DWORD /d 1 /f >nul

echo [6/6] Enforcing SSL/TLS...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD /d 2 /f >nul

echo [SUCCESS] RDP security hardening completed
pause
goto menu

:exit
echo.
echo [INFO] RDP Security Manager closed
exit /b 0
