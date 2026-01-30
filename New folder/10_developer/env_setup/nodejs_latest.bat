@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:: فحص الصلاحيات
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  🌈 Node.js Latest - أحدث إصدار (غير مستقر)%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.
echo %YELLOW%⚠️  تحذير:%WHITE% هذا الإصدار قد يحتوي على أخطاء - غير مناسب للإنتاج
echo.

:: فحص التثبيت الحالي
node -v >nul 2>&1 && (
    for /f "tokens=*" %%a in ('node -v') do set "CURRENT=%%a"
    echo %CYAN%مثبت حاليًا:%WHITE% !CURRENT!
    echo.
)

set /p "CONFIRM=هل أنت متأكد من المتابعة؟ (y/n): "
if /i "!CONFIRM!" neq "y" exit /b 0

:: التثبيت عبر winget
echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id OpenJS.NodeJS --silent --accept-source-agreements >nul 2>&1

:: التحقق
node -v >nul 2>&1 && npm -v >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

for /f "tokens=*" %%a in ('node -v') do set "VER=%%a"
echo %GREEN%✓ تم التثبيت بنجاح: !VER!%WHITE%
echo %GRAY%(ملاحظة: يمكنك استخدام nvm للتبديل بين الإصدارات)%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Node.js Latest !VER! >> "!LOG_FILE!"

timeout /t 4 >nul
