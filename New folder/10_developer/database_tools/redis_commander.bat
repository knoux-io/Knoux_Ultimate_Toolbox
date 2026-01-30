@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🎮 Redis Commander - واجهة ويب لإدارة Redis%WHITE%
echo %RED%===================================================%WHITE%
echo.

:: التحقق من وجود Node.js
node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:: التحقق من التثبيت
where redis-commander >nul 2>&1 && (
    echo %GREEN%✓ Redis Commander مثبت مسبقًا%WHITE%
    goto :RUN_SERVER
)

echo %YELLOW%جارٍ التثبيت العالمي عبر NPM...%WHITE%
npm install -g redis-commander >nul 2>&1

where redis-commander >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:RUN_SERVER
echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
echo %YELLOW%جارٍ تشغيل الخادم...%WHITE%
echo %CYAN%افتح المتصفح على: http://localhost:8081%WHITE%
echo %GRAY%(اضغط Ctrl+C لإيقاف الخادم)%WHITE%
echo.

start http://localhost:8081
redis-commander --port 8081

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Redis Commander web UI >> "!LOG_FILE!"

timeout /t 3 >nul
