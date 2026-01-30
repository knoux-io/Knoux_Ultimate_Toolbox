@echo off
chcp 65001 >nul
title Password Policy Manager - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Password Policy Manager                     ║
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
echo ║                  Password Policy Manager                    ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Check Current Password Policy
echo [2] Set Strong Password Policy
echo [3] Set Moderate Password Policy
echo [4] Set Weak Password Policy
echo [5] Configure Password Complexity
echo [6] Configure Password Length
echo [7] Configure Password History
echo [8] Configure Account Lockout
echo [9] Reset to Default Policy
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto check_policy
if "%choice%"=="2" goto strong_policy
if "%choice%"=="3" goto moderate_policy
if "%choice%"=="4" goto weak_policy
if "%choice%"=="5" goto configure_complexity
if "%choice%"=="6" goto configure_length
if "%choice%"=="7" goto configure_history
if "%choice%"=="8" goto configure_lockout
if "%choice%"=="9" goto reset_default
if "%choice%"=="0" goto exit
goto menu

:check_policy
echo.
echo [INFO] Checking current password policy...
echo.

:: Check password policy settings
echo [1/6] Password complexity requirements:
net accounts | findstr /i "Password complexity"

echo [2/6] Minimum password length:
net accounts | findstr /i "Minimum password length"

echo [3/6] Maximum password age:
net accounts | findstr /i "Maximum password age"

echo [4/6] Minimum password age:
net accounts | findstr /i "Minimum password age"

echo [5/6] Password history:
net accounts | findstr /i "Password history"

echo [6/6] Account lockout threshold:
net accounts | findstr /i "Lockout threshold"

echo.
echo [INFO] Detailed policy information:
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet
findstr /i "PasswordComplexity\|MinimumPasswordLength\|MaximumPasswordAge\|MinimumPasswordAge\|PasswordHistorySize\|LockoutBadCount" "%TEMP%\secpolicy.cfg"
del "%TEMP%\secpolicy.cfg" 2>nul

pause
goto menu

:strong_policy
echo.
echo [INFO] Setting strong password policy...
echo.

:: Export current security policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet

:: Set strong password policy
echo [1/6] Enabling password complexity...
echo PasswordComplexity = 1 >> "%TEMP%\secpolicy.cfg"

echo [2/6] Setting minimum password length to 12...
echo MinimumPasswordLength = 12 >> "%TEMP%\secpolicy.cfg"

echo [3/6] Setting maximum password age to 90 days...
echo MaximumPasswordAge = 90 >> "%TEMP%\secpolicy.cfg"

echo [4/6] Setting minimum password age to 1 day...
echo MinimumPasswordAge = 1 >> "%TEMP%\secpolicy.cfg"

echo [5/6] Setting password history to 24...
echo PasswordHistorySize = 24 >> "%TEMP%\secpolicy.cfg"

echo [6/6] Setting account lockout to 5 attempts...
echo LockoutBadCount = 5 >> "%TEMP%\secpolicy.cfg"
echo LockoutDuration = 30 >> "%TEMP%\secpolicy.cfg"

:: Apply the policy
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Strong password policy applied
pause
goto menu

:moderate_policy
echo.
echo [INFO] Setting moderate password policy...
echo.

:: Export current security policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet

:: Set moderate password policy
echo [1/6] Enabling password complexity...
echo PasswordComplexity = 1 >> "%TEMP%\secpolicy.cfg"

echo [2/6] Setting minimum password length to 8...
echo MinimumPasswordLength = 8 >> "%TEMP%\secpolicy.cfg"

echo [3/6] Setting maximum password age to 180 days...
echo MaximumPasswordAge = 180 >> "%TEMP%\secpolicy.cfg"

echo [4/6] Setting minimum password age to 1 day...
echo MinimumPasswordAge = 1 >> "%TEMP%\secpolicy.cfg"

echo [5/6] Setting password history to 12...
echo PasswordHistorySize = 12 >> "%TEMP%\secpolicy.cfg"

echo [6/6] Setting account lockout to 10 attempts...
echo LockoutBadCount = 10 >> "%TEMP%\secpolicy.cfg"
echo LockoutDuration = 30 >> "%TEMP%\secpolicy.cfg"

:: Apply the policy
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Moderate password policy applied
pause
goto menu

:weak_policy
echo.
echo [WARNING] Setting weak password policy reduces security!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Setting weak password policy...
echo.

:: Export current security policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet

:: Set weak password policy
echo [1/6] Disabling password complexity...
echo PasswordComplexity = 0 >> "%TEMP%\secpolicy.cfg"

echo [2/6] Setting minimum password length to 6...
echo MinimumPasswordLength = 6 >> "%TEMP%\secpolicy.cfg"

echo [3/6] Setting maximum password age to unlimited...
echo MaximumPasswordAge = -1 >> "%TEMP%\secpolicy.cfg"

echo [4/6] Setting minimum password age to 0 days...
echo MinimumPasswordAge = 0 >> "%TEMP%\secpolicy.cfg"

echo [5/6] Setting password history to 0...
echo PasswordHistorySize = 0 >> "%TEMP%\secpolicy.cfg"

echo [6/6] Setting account lockout to 20 attempts...
echo LockoutBadCount = 20 >> "%TEMP%\secpolicy.cfg"
echo LockoutDuration = 30 >> "%TEMP%\secpolicy.cfg"

:: Apply the policy
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Weak password policy applied
pause
goto menu

:configure_complexity
echo.
echo [INFO] Configuring password complexity...
echo.

set /p complexity="Enable password complexity? [Y/N]: "
if /i "%complexity%"=="Y" (
    set complexity_value=1
    echo [INFO] Password complexity will be enabled
) else (
    set complexity_value=0
    echo [INFO] Password complexity will be disabled
)

:: Export and modify policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet
echo PasswordComplexity = %complexity_value% >> "%TEMP%\secpolicy.cfg"
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Password complexity configured
pause
goto menu

:configure_length
echo.
echo [INFO] Configuring password length...
echo.

set /p min_length="Enter minimum password length (0-14): "
if "%min_length%"=="" set min_length=8
if %min_length% gtr 14 set min_length=14
if %min_length% lss 0 set min_length=0

:: Export and modify policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet
echo MinimumPasswordLength = %min_length% >> "%TEMP%\secpolicy.cfg"
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Minimum password length set to %min_length%
pause
goto menu

:configure_history
echo.
echo [INFO] Configuring password history...
echo.

set /p history_size="Enter password history size (0-24): "
if "%history_size%"=="" set history_size=12
if %history_size% gtr 24 set history_size=24
if %history_size% lss 0 set history_size=0

:: Export and modify policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet
echo PasswordHistorySize = %history_size% >> "%TEMP%\secpolicy.cfg"
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Password history size set to %history_size%
pause
goto menu

:configure_lockout
echo.
echo [INFO] Configuring account lockout settings...
echo.

set /p lockout_threshold="Enter lockout threshold (0-999): "
if "%lockout_threshold%"=="" set lockout_threshold=5
if %lockout_threshold% gtr 999 set lockout_threshold=999
if %lockout_threshold% lss 0 set lockout_threshold=0

set /p lockout_duration="Enter lockout duration in minutes (0-99999): "
if "%lockout_duration%"=="" set lockout_duration=30
if %lockout_duration% gtr 99999 set lockout_duration=99999
if %lockout_duration% lss 0 set lockout_duration=0

:: Export and modify policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet
echo LockoutBadCount = %lockout_threshold% >> "%TEMP%\secpolicy.cfg"
echo LockoutDuration = %lockout_duration% >> "%TEMP%\secpolicy.cfg"
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Account lockout configured
echo [INFO] Lockout threshold: %lockout_threshold% attempts
echo [INFO] Lockout duration: %lockout_duration% minutes
pause
goto menu

:reset_default
echo.
echo [WARNING] This will reset password policy to Windows defaults!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Resetting password policy to default...
echo.

:: Export current security policy
secedit /export /cfg "%TEMP%\secpolicy.cfg" /quiet

:: Set default password policy
echo PasswordComplexity = 1 >> "%TEMP%\secpolicy.cfg"
echo MinimumPasswordLength = 6 >> "%TEMP%\secpolicy.cfg"
echo MaximumPasswordAge = 42 >> "%TEMP%\secpolicy.cfg"
echo MinimumPasswordAge = 1 >> "%TEMP%\secpolicy.cfg"
echo PasswordHistorySize = 0 >> "%TEMP%\secpolicy.cfg"
echo LockoutBadCount = 0 >> "%TEMP%\secpolicy.cfg"
echo LockoutDuration = 30 >> "%TEMP%\secpolicy.cfg"

:: Apply the policy
secedit /configure /db "%WINDIR%\security\database\secedit.sdb" /cfg "%TEMP%\secpolicy.cfg" /quiet
del "%TEMP%\secpolicy.cfg" 2>nul

echo [SUCCESS] Password policy reset to default
pause
goto menu

:exit
echo.
echo [INFO] Password Policy Manager closed
exit /b 0
