@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🥄 Scoop - مدير الحزم الخفيف (بدون أذونات)%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:: فحص التثبيت الحالي
scoop --version >nul 2>&1 && (
    echo %GREEN%✓ Scoop مثبت مسبقًا%WHITE%
    scoop --version
    goto :ADD_BUCKETS
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
echo %GRAY%(التثبيت في %USERPROFILE%\scoop - لا يحتاج صلاحيات مسؤول)%WHITE%

:: تثبيت عبر PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; irm https://get.scoop.sh  | iex" >nul 2>&1

scoop --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:ADD_BUCKETS
echo %YELLOW%جارٍ إضافة المستودعات الإضافية...%WHITE%
scoop bucket add extras >nul 2>&1
scoop bucket add versions >nul 2>&1
scoop bucket add java >nul 2>&1
scoop bucket add php >nul 2>&1

echo %GREEN%✓ تم التثبيت الكامل مع المستودعات الإضافية!%WHITE%
scoop --version

echo.
echo %CYAN%أوامر سريعة:%WHITE%
echo   scoop install app        ← تثبيت تطبيق
echo   scoop update *          ← تحديث كل التطبيقات
echo   scoop list              ← عرض المثبتة
echo   scoop uninstall app     ← إزالة تطبيق
echo.
echo %GRAY%المزايا: لا يحتاج صلاحيات • تثبيت محلي • تحديثات سهلة%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Scoop with extras/java/php buckets >> "!LOG_FILE!"

timeout /t 5 >nul
