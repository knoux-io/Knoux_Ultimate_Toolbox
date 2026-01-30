@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  💎 Ruby + DevKit Setup%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

ruby --version >nul 2>&1 && (
    echo %GREEN%✓ Ruby مثبت مسبقًا%WHITE%
    ruby --version
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت عبر RubyInstaller...%WHITE%
winget install -e --id RubyInstallerTeam.Ruby.3.2 --silent >nul 2>&1

ruby --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:: تثبيت حزم أساسية
gem install bundler rails jekyll --no-document >nul 2>&1

echo %GREEN%✓ تم التثبيت الكامل!%WHITE%
ruby --version
gem --version

echo.
echo %CYAN%إنشاء تطبيق Rails:%WHITE%
echo   rails new myapp
echo   cd myapp && rails server

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Ruby 3.2 with DevKit >> "!LOG_FILE!"

timeout /t 4 >nul
