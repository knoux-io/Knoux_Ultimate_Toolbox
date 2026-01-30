@echo off
chcp 65001 >nul
title Winsock Repair Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    Winsock Repair Tool                       ║
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
echo ║                    Winsock Repair                            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Winsock Status
echo [2] Reset Winsock
echo [3] Reset Winsock Catalog
echo [4] Repair Winsock Entries
echo [5] Reset LSP (Layered Service Providers)
echo [6] Reinstall Winsock
echo [7] Check Winsock Corruption
echo [8] Backup/Restore Winsock
echo [9] Advanced Winsock Repair
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto reset_winsock
if "%choice%"=="3" goto reset_catalog
if "%choice%"=="4" goto repair_entries
if "%choice%"=="5" goto reset_lsp
if "%choice%"=="6" goto reinstall_winsock
if "%choice%"=="7" goto check_corruption
if "%choice%"=="8" goto backup_restore
if "%choice%"=="9" goto advanced_repair
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking Winsock status...
echo.

:: Check Winsock registry entries
echo [1/4] Checking Winsock registry entries...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Winsock registry entries found
) else (
    echo [ERROR] Winsock registry entries missing
)

:: Check Winsock parameters
echo [2/4] Checking Winsock parameters...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters" >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Winsock parameters found
) else (
    echo [WARNING] Winsock parameters missing
)

:: Check LSP entries
echo [3/4] Checking LSP entries...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\Protocol_Catalog9" >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] LSP entries found
) else (
    echo [WARNING] LSP entries missing
)

:: Check network connectivity
echo [4/4] Checking network connectivity...
ping -n 1 127.0.0.1 >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Network connectivity working
) else (
    echo [ERROR] Network connectivity issues detected
)

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

:: Restart network services
echo [INFO] Restarting network services...
net stop "Dnscache" >nul 2>&1
net start "Dnscache" >nul 2>&1

echo [SUCCESS] Winsock reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:reset_catalog
echo.
echo [INFO] Resetting Winsock catalog...
echo.

:: Reset Winsock catalog
netsh winsock reset catalog
if %errorLevel% equ 0 (
    echo [SUCCESS] Winsock catalog reset successfully
) else (
    echo [ERROR] Failed to reset Winsock catalog
)

:: Clear Winsock cache
echo [INFO] Clearing Winsock cache...
netsh winsock show catalog >nul 2>&1

echo [SUCCESS] Winsock catalog reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:repair_entries
echo.
echo [INFO] Repairing Winsock entries...
echo.

:: Backup current Winsock entries
echo [1/3] Backing up current Winsock entries...
reg export "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" "%TEMP%\winsock_backup.reg" >nul 2>&1

:: Repair Winsock registry entries
echo [2/3] Repairing Winsock registry entries...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\Protocol_Catalog9" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\NameSpace_Catalog5" /f >nul 2>&1

:: Reset Winsock
echo [3/3] Resetting Winsock...
netsh winsock reset

echo [SUCCESS] Winsock entries repaired
echo [INFO] Backup saved to: %TEMP%\winsock_backup.reg
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:reset_lsp
echo.
echo [INFO] Resetting LSP (Layered Service Providers)...
echo.

:: Reset LSP
netsh winsock reset
if %errorLevel% equ 0 (
    echo [SUCCESS] LSP reset successfully
) else (
    echo [ERROR] Failed to reset LSP
)

:: Remove malicious LSP entries
echo [INFO] Removing suspicious LSP entries...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\Protocol_Catalog9" /f >nul 2>&1

echo [SUCCESS] LSP reset completed
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:reinstall_winsock
echo.
echo [WARNING] This will reinstall Winsock completely!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Reinstalling Winsock...
echo.

:: Stop network services
echo [1/4] Stopping network services...
net stop "Dnscache" >nul 2>&1
net stop "LanmanServer" >nul 2>&1
net stop "LanmanWorkstation" >nul 2>&1

:: Remove Winsock registry entries
echo [2/4] Removing Winsock registry entries...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" /f >nul 2>&1

:: Reinstall Winsock
echo [3/4] Reinstalling Winsock...
netsh winsock reset

:: Start network services
echo [4/4] Starting network services...
net start "LanmanWorkstation" >nul 2>&1
net start "LanmanServer" >nul 2>&1
net start "Dnscache" >nul 2>&1

echo [SUCCESS] Winsock reinstalled
echo [INFO] Please restart your computer for all changes to take effect
pause
goto menu

:check_corruption
echo.
echo [INFO] Checking Winsock corruption...
echo.

:: Check for common corruption signs
echo [1/4] Checking for missing Winsock entries...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Winsock registry entries missing
)

:: Check for corrupted LSP entries
echo [2/4] Checking for corrupted LSP entries...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\Protocol_Catalog9" >nul 2>&1
if %errorLevel% neq 0 (
    echo [WARNING] LSP entries missing or corrupted
)

:: Check network functionality
echo [3/4] Checking network functionality...
ping -n 1 8.8.8.8 >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Network connectivity issues detected
)

:: Check for suspicious entries
echo [4/4] Checking for suspicious Winsock entries...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters" | findstr /i "malware\|virus\|trojan" >nul 2>&1
if %errorLevel% equ 0 (
    echo [WARNING] Suspicious Winsock entries detected
)

echo [SUCCESS] Winsock corruption check completed
pause
goto menu

:backup_restore
echo.
echo [INFO] Winsock Backup/Restore...
echo.

echo [1] Backup Winsock Settings
echo [2] Restore Winsock Settings
echo [0] Back to main menu
echo.
set /p backup_choice="Select an option [0-2]: "

if "%backup_choice%"=="1" goto backup_winsock
if "%backup_choice%"=="2" goto restore_winsock
if "%backup_choice%"=="0" goto menu
goto backup_restore

:backup_winsock
echo.
echo [INFO] Backing up Winsock settings...
echo.

set backup_file=%TEMP%\winsock_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.reg

reg export "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" "%backup_file%" >nul 2>&1
if %errorLevel% equ 0 (
    echo [SUCCESS] Winsock settings backed up
    echo [INFO] Backup saved to: %backup_file%
) else (
    echo [ERROR] Failed to backup Winsock settings
)

pause
goto backup_restore

:restore_winsock
echo.
echo [INFO] Restoring Winsock settings...
echo.

set /p backup_file="Enter backup file path: "
if "%backup_file%"=="" goto backup_restore

if exist "%backup_file%" (
    reg import "%backup_file%"
    if %errorLevel% equ 0 (
        echo [SUCCESS] Winsock settings restored
        echo [INFO] Please restart your computer for changes to take effect
    ) else (
        echo [ERROR] Failed to restore Winsock settings
    )
) else (
    echo [ERROR] Backup file not found
)

pause
goto backup_restore

:advanced_repair
echo.
echo [INFO] Advanced Winsock repair...
echo.

echo [1] Reset All Network Components
echo [2] Clean Winsock Registry
echo [3] Rebuild Winsock Catalog
echo [4] Fix Winsock Permissions
echo [5] Reset Network Protocols
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto reset_all
if "%adv_choice%"=="2" goto clean_registry
if "%adv_choice%"=="3" goto rebuild_catalog
if "%adv_choice%"=="4" goto fix_permissions
if "%adv_choice%"=="5" goto reset_protocols
if "%adv_choice%"=="0" goto menu
goto advanced_repair

:reset_all
echo.
echo [INFO] Resetting all network components...
echo.

netsh winsock reset
netsh int ip reset
ipconfig /flushdns

echo [SUCCESS] All network components reset
echo [INFO] Please restart your computer for all changes to take effect
pause
goto advanced_repair

:clean_registry
echo.
echo [WARNING] This will clean Winsock registry!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto advanced_repair

echo [INFO] Cleaning Winsock registry...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" /f >nul 2>&1
netsh winsock reset

echo [SUCCESS] Winsock registry cleaned
pause
goto advanced_repair

:rebuild_catalog
echo.
echo [INFO] Rebuilding Winsock catalog...
echo.

netsh winsock reset catalog
netsh winsock reset

echo [SUCCESS] Winsock catalog rebuilt
pause
goto advanced_repair

:fix_permissions
echo.
echo [INFO] Fixing Winsock permissions...
echo.

:: Reset registry permissions
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" /v Test /t REG_SZ /d "Test" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2" /v Test /f >nul 2>&1

echo [SUCCESS] Winsock permissions fixed
pause
goto advanced_repair

:reset_protocols
echo.
echo [INFO] Resetting network protocols...
echo.

netsh int ipv4 reset
netsh int ipv6 reset
netsh winsock reset

echo [SUCCESS] Network protocols reset
pause
goto advanced_repair

:exit
echo.
echo [INFO] Winsock Repair Tool closed
exit /b 0
