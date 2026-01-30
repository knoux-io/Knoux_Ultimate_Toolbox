@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

net session >nul 2>&1 || (
    echo %RED%⚠️  صلاحيات مسؤول مطلوبة%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🌐 .NET 8 SDK - أحدث إصدار من مايكروسوفت%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

dotnet --list-sdks 2>nul | findstr "8.0" >nul && (
    echo %GREEN%✓ .NET 8 مثبت مسبقًا%WHITE%
    dotnet --list-sdks | findstr "8.0"
    goto :TEMPLATES
)

echo %YELLOW%جارٍ التثبيت عبر Winget...%WHITE%
winget install -e --id Microsoft.DotNet.SDK.8 --silent --accept-source-agreements >nul 2>&1

dotnet --list-sdks 2>nul | findstr "8.0" >nul || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:TEMPLATES
echo %YELLOW%جارٍ تثبيت القوالب الشائعة...%WHITE%
dotnet new install Microsoft.DotNet.Web.ProjectTemplates.8.0 >nul 2>&1
dotnet new install Microsoft.DotNet.Web.Spa.ProjectTemplates.8.0 >nul 2>&1

echo %GREEN%✓ تم التثبيت الكامل!%WHITE%
dotnet --info | findstr "SDK"

echo.
echo %CYAN%إنشاء مشروع جديد:%WHITE%
echo   dotnet new web -n MyWebApp
echo   dotnet new mvc -n MyMvcApp
echo   dotnet new blazor -n MyBlazorApp

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed .NET 8 SDK with templates >> "!LOG_FILE!"

timeout /t 5 >nul
