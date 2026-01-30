@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🟥 Redis Server - ذاكرة تخزين مؤقت عالية الأداء%WHITE%
echo %RED%===================================================%WHITE%
echo.

:: ملاحظة: Redis الرسمي لا يدعم Windows مباشرة، نستخدم الإصدار المدعوم من Microsoft Archive
where redis-server.exe >nul 2>&1 && (
    echo %GREEN%✓ Redis Server مثبت مسبقًا%WHITE%
    redis-server --version 2>nul || redis-cli INFO server | findstr "redis_version"
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%تنبيه هام:%WHITE%
echo Redis الرسمي لم يعد يدعم Windows رسميًا منذ 2019.
echo سيتم تثبيت الإصدار المدعوم من مجتمع Windows (tporadowski).
echo.
echo %CYAN%البدائل الموصى بها للإنتاج:%WHITE%
echo   1. تشغيل Redis داخل WSL2 (موصى به)
echo   2. استخدام Docker: docker run -p 6379:6379 redis
echo   3. خدمة سحابية مثل Azure Cache for Redis
echo.
set /p "CONFIRM=هل تريد المتابعة بالتثبيت المحلي؟ (y/n): "
if /i "!CONFIRM!" neq "y" exit /b 0

echo %YELLOW%جارٍ التثبيت عبر Chocolatey...%WHITE%
choco install redis-64 -y >nul 2>&1

where redis-server.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل البديل: استخدام WSL2%WHITE%
    echo   1. شغّل containers\wsl2_setup.bat
    echo   2. ثم: sudo apt update && sudo apt install redis-server
    timeout /t 6 >nul
    exit /b 1
)

:: بدء الخدمة
net start redis >nul 2>&1 || sc start redis >nul 2>&1

echo %GREEN%✓ تم التثبيت بنجاح (للتطوير فقط)%WHITE%
redis-cli INFO server | findstr "redis_version"

echo.
echo %CYAN%اختبار سريع:%WHITE%
redis-cli PING
redis-cli SET test "مرحباً بك في Redis"
redis-cli GET test

echo.
echo %YELLOW%ملاحظة أمان:%WHITE% هذا التثبيت للتطوير فقط.
echo للإنتاج، استخدم WSL2 أو خدمة سحابية.

:: تسجيل العملية
echo [!TIMESTAMP!] WARNING: Installed Redis for Windows (dev only - not for production) >> "!LOG_FILE!"

timeout /t 6 >nul
