@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GRAY%===================================================%WHITE%
echo %GRAY%  🐪 Perl + CPAN Setup%WHITE%
echo %GRAY%===================================================%WHITE%
echo.

perl -v >nul 2>&1 && (
    echo %GREEN%✓ Perl مثبت مسبقًا%WHITE%
    perl -v | findstr "This is perl"
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت عبر Strawberry Perl...%WHITE%
winget install -e --id StrawberryPerl.StrawberryPerl --silent >nul 2>&1

perl -v >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
perl -v | findstr "This is perl"

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Strawberry Perl >> "!LOG_FILE!"

timeout /t 3 >nul
