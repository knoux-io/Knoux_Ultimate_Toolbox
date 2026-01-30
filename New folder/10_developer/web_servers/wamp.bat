@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "WAMP_DIR=C:\wamp64"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🟩 WAMP Server - بيئة تطوير بسيطة (Windows + Apache + MySQL + PHP)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

if exist "!WAMP_DIR!" (
    echo %GREEN%✓ WAMP Server مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت عبر Winget...%WHITE%
winget install -e --id WampServer.WampServer --silent >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من http://www.wampserver.com/en/#download-wrapper%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
echo %YELLOW%ملاحظة:%WHITE% قد تحتاج إلى تثبيت Visual C++ Redistributable يدويًا

:: إنشاء صفحة اختبار
set "WWW=!WAMP_DIR!\www"
if exist "!WWW!" (
    (
    echo ^<!DOCTYPE html^>
    echo ^<html dir="rtl" lang="ar"^>
    echo ^<head^>
    echo     ^<meta charset="UTF-8"^>
    echo     ^<title^>WAMP Server^</title^>
    echo     ^<style^>
    echo         body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #27ae60; color: white; }
    echo         .container { background: rgba(0,0,0,0.2); padding: 40px; border-radius: 15px; max-width: 600px; margin: 0 auto; }
    echo         h1 { font-size: 2.5em; }
    echo         .wamp { font-size: 64px; margin: 20px 0; }
    echo     ^</style^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<div class="container"^>
    echo         ^<div class="wamp"^>🟢^</div^>
    echo         ^<h1^>WAMP Server يعمل!^</h1^>
    echo         ^<p^>بيئة تطوير بسيطة وخفيفة^</p^>
    echo     ^</div^>
    echo ^</body^>
    echo ^</html^>
    ) > "!WWW!\index.php"
)

echo %CYAN%البدء:%WHITE%
echo   1. افتح قائمة ابدأ ← ابحث عن "WampServer"
echo   2. انقر على الأيقونة في شريط المهام ← Start All Services
echo   3. افتح المتصفح: %CYAN%http://localhost%WHITE%
echo.
echo %YELLOW%الاختلافات عن XAMPP:%WHITE%
echo   ✓ واجهة أكثر بساطة للمبتدئين
echo   ✓ تكامل أفضل مع بيئة ويندوز
echo   ✓ تحديثات أكثر انتظامًا
echo   ✗ أقل مرونة في التهيئة المتقدمة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed WAMP Server >> "!LOG_FILE!"

timeout /t 6 >nul
