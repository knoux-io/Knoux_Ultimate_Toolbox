@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🌐 .NET 6 SDK (LTS) - للتوافق مع المشاريع القديمة%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

dotnet --list-sdks | findstr "6.0" >nul && (
    echo %GREEN%✓ .NET 6 مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id Microsoft.DotNet.SDK.6 --silent >nul 2>&1

dotnet --list-sdks | findstr "6.0" >nul || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed .NET 6 SDK (LTS) >> "!LOG_FILE!"

timeout /t 3 >nul
