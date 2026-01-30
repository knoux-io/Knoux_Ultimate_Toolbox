@echo off
chcp 65001 >nul
title UAC Settings Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  UAC Settings Manager                         ║
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
echo ║                  UAC Settings Manager                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Current UAC Status
echo [2] Set UAC to Never Notify
echo [3] Set UAC to Notify on App Changes
echo [4] Set UAC to Notify on App Changes (No Desktop Dimming)
echo [5] Set UAC to Always Notify
echo [6] Enable UAC
echo [7] Disable UAC
echo [8] Configure UAC Prompts
echo [9] UAC Virtualization Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto never_notify
if "%choice%"=="3" goto notify_app_changes
if "%choice%"=="4" goto notify_no_dimming
if "%choice%"=="5" goto always_notify
if "%choice%"=="6" goto enable_uac
if "%choice%"=="7" goto disable_uac
if "%choice%"=="8" goto configure_prompts
if "%choice%"=="9" goto virtualization_settings
if "%choice%"=="0" goto exit
goto menu

:check_status
echo.
echo [INFO] Checking current UAC status...
echo.

:: Check UAC registry value
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA 2>nul
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin 2>nul
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop 2>nul

echo.
echo [INFO] UAC Status:
echo.
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | findstr "EnableLUA"
if %errorLevel% equ 0 (
    echo UAC is Enabled
) else (
    echo UAC is Disabled
)

echo.
echo [INFO] Current UAC Level:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin 2>nul
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin 2^>nul ^| find "ConsentPromptBehaviorAdmin"') do set uac_level=%%a

if "%uac_level%"=="0" echo Level 0: Never notify
if "%uac_level%"=="1" echo Level 1: Notify on app changes (no desktop dimming)
if "%uac_level%"=="2" echo Level 2: Notify on app changes
if "%uac_level%"=="3" echo Level 3: Always notify

pause
goto menu

:never_notify
echo.
echo [WARNING] Setting UAC to Never Notify reduces security!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Setting UAC to Never Notify...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] UAC set to Never Notify
echo [INFO] You may need to restart your computer for changes to take effect
pause
goto menu

:notify_app_changes
echo.
echo [INFO] Setting UAC to Notify on App Changes...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] UAC set to Notify on App Changes
echo [INFO] You may need to restart your computer for changes to take effect
pause
goto menu

:notify_no_dimming
echo.
echo [INFO] Setting UAC to Notify on App Changes (No Desktop Dimming)...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] UAC set to Notify on App Changes (No Desktop Dimming)
echo [INFO] You may need to restart your computer for changes to take effect
pause
goto menu

:always_notify
echo.
echo [INFO] Setting UAC to Always Notify...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] UAC set to Always Notify
echo [INFO] You may need to restart your computer for changes to take effect
pause
goto menu

:enable_uac
echo.
echo [INFO] Enabling UAC...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] UAC enabled
echo [INFO] You may need to restart your computer for changes to take effect
pause
goto menu

:disable_uac
echo.
echo [WARNING] Disabling UAC significantly reduces security!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling UAC...
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] UAC disabled
echo [INFO] You may need to restart your computer for changes to take effect
pause
goto menu

:configure_prompts
echo.
echo [INFO] Configuring UAC prompts...
echo.

echo [1] Configure admin consent prompt behavior
echo [2] Configure standard user consent prompt behavior
echo [3] Configure secure desktop prompt
echo [0] Back to main menu
echo.
set /p prompt_choice="Select an option [0-3]: "

if "%prompt_choice%"=="1" goto admin_prompt
if "%prompt_choice%"=="2" goto standard_prompt
if "%prompt_choice%"=="3" goto secure_desktop
if "%prompt_choice%"=="0" goto menu
goto configure_prompts

:admin_prompt
echo.
echo Admin consent prompt behavior:
echo [0] No prompt
echo [1] Prompt on secure desktop
echo [2] Prompt on secure desktop (no credentials)
echo [3] Prompt on secure desktop (with credentials)
echo.
set /p admin_choice="Select an option [0-3]: "

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d %admin_choice% /f >nul
echo [SUCCESS] Admin consent prompt behavior configured
pause
goto configure_prompts

:standard_prompt
echo.
echo Standard user consent prompt behavior:
echo [0] Automatically deny elevation requests
echo [1] Prompt for credentials on secure desktop
echo [2] Prompt for credentials on interactive desktop
echo [3] Prompt for credentials on secure desktop (with smartcard)
echo.
set /p standard_choice="Select an option [0-3]: "

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d %standard_choice% /f >nul
echo [SUCCESS] Standard user consent prompt behavior configured
pause
goto configure_prompts

:secure_desktop
echo.
set /p secure_choice="Enable secure desktop prompts? [Y/N]: "
if /i "%secure_choice%"=="Y" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Secure desktop prompts enabled
) else (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Secure desktop prompts disabled
)
pause
goto configure_prompts

:virtualization_settings
echo.
echo [INFO] Configuring UAC virtualization settings...
echo.

echo Current virtualization status:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableVirtualization 2>nul

echo.
set /p virt_choice="Enable UAC virtualization? [Y/N]: "
if /i "%virt_choice%"=="Y" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableVirtualization /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] UAC virtualization enabled
) else (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableVirtualization /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] UAC virtualization disabled
)

pause
goto menu

:exit
echo.
echo [INFO] UAC Settings Manager closed
exit /b 0
