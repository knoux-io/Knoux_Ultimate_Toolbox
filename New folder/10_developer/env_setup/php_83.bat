@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🐘 PHP 8.3 + Composer Setup%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

php -v >nul 2>&1 && (
    echo %GREEN%✓ PHP مثبت مسبقًا%WHITE%
    php -v | findstr "PHP"
    goto :INSTALL_COMPOSER
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id php.php.8.3 --silent >nul 2>&1

php -v >nul 2>&1 || (
    echo %RED%✗ فشل تثبيت PHP%WHITE%
    exit /b 1
)

:INSTALL_COMPOSER
echo %YELLOW%جارٍ تثبيت Composer...%WHITE%
powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://getcomposer.org/installer -OutFile %TEMP%\composer-setup.php; php %TEMP%\composer-setup.php --install-dir=C:\ProgramData\ComposerSetup\bin --filename=composer" >nul 2>&1

if not exist "C:\ProgramData\ComposerSetup\bin\composer.bat" (
    echo %YELLOW%المحاولة عبر Winget...%WHITE%
    winget install -e --id Composer.Composer --silent >nul 2>&1
)

composer -V >nul 2>&1 || (
    echo %RED%✗ فشل تثبيت Composer%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت الكامل!%WHITE%
php -v | findstr "PHP"
composer -V

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed PHP 8.3 with Composer >> "!LOG_FILE!"

timeout /t 4 >nul
