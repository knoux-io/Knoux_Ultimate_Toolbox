@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  📦 NVM for Windows - إدارة إصدارات Node.js%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:: فحص وجود nvm
nvm version >nul 2>&1 && (
    echo %GREEN%✓ NVM مثبت مسبقًا%WHITE%
    nvm version
    echo.
    echo %CYAN%الأوامر السريعة:%WHITE%
    echo   nvm install 20.15.0   ← تثبيت إصدار
    echo   nvm use 20.15.0       ← التبديل للإصدار
    echo   nvm list             ← عرض الإصدارات
    timeout /t 5 >nul
    exit /b 0
)

echo %YELLOW%تنزيل NVM for Windows...%WHITE%
set "INSTALLER=%TEMP%\nvm-setup.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/coreybutler/nvm-windows/releases/latest/download/nvm-setup.zip' -OutFile '!INSTALLER!'" >nul 2>&1

if not exist "!INSTALLER!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    exit /b 1
)

:: استخراج وتثبيت
powershell -Command "Expand-Archive -Path '!INSTALLER!' -DestinationPath '%TEMP%\nvm-setup' -Force" >nul 2>&1
start /wait "" "%TEMP%\nvm-setup\nvm-setup.exe" >nul 2>&1

del "!INSTALLER!" >nul 2>&1
rmdir /s /q "%TEMP%\nvm-setup" >nul 2>&1

:: التحقق
nvm version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت - جرب التثبيت اليدوي من:%WHITE%
    echo https://github.com/coreybutler/nvm-windows
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح!%WHITE%
nvm version

echo.
echo %YELLOW%الخطوة التالية:%WHITE% أعد فتح موجه الأوامر ثم:
echo   nvm install 20.15.0
echo   nvm use 20.15.0

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed NVM for Windows >> "!LOG_FILE!"

timeout /t 6 >nul
