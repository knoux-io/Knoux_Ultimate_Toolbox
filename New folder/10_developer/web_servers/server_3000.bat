@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🚀 سيرفر تطوير على المنفذ 3000%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:: التحقق من المنفذ
netstat -ano | findstr ":3000 " >nul && (
    echo %YELLOW%⚠️  المنفذ 3000 مشغول حاليًا%WHITE%
    set /p "KILL=هل تريد إيقاف العملية؟ (y/n): "
    if /i "!KILL!"=="y" (
        for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3000 " ^| findstr "LISTENING"') do taskkill /f /pid %%a >nul 2>&1
        echo %GREEN%✓ تم إيقاف العملية%WHITE%
    )
)

:MENU
echo %CYAN%اختر نوع السيرفر:%WHITE%
echo   [1] Node.js (مع Express - للمشاريع الحديثة)
echo   [2] Python HTTP Server (سريع وخفيف)
echo   [3] PHP Built-in Server
echo   [4] Live Server (للمشاريع الثابتة HTML/CSS/JS)
echo   [0] الخروج
echo.
set /p "TYPE=اختر: "

if "!TYPE!"=="0" exit /b 0
if "!TYPE!"=="1" goto :NODE_SERVER
if "!TYPE!"=="2" goto :PYTHON_SERVER
if "!TYPE!"=="3" goto :PHP_SERVER
if "!TYPE!"=="4" goto :LIVE_SERVER
goto :MENU

:NODE_SERVER
where node.exe >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

set /p "PROJECT_DIR=مسار مشروع Node.js: "
if not exist "!PROJECT_DIR!\package.json" (
    echo %YELLOW%لم يتم العثور على package.json - إنشاء مشروع سريع...%WHITE%
    cd /d "!PROJECT_DIR!" && npm init -y >nul 2>&1
    npm install express >nul 2>&1
)

(
echo const express = require('express');
echo const path = require('path');
echo const app = express();
echo const PORT = 3000;
echo 
echo app.use(express.static('public'));
echo 
echo app.get('/', (req, res) =^> {
echo   res.send('^<h1 style="text-align:center; font-family:Arial"^>سيرفر التطوير يعمل على المنفذ 3000 🚀^</h1^>');
echo });
echo 
echo app.listen(PORT, () =^> {
echo   console.log(`^✓ السيرفر يعمل: http://localhost:${PORT}`);
echo });
) > "!PROJECT_DIR!\server.js"

cd /d "!PROJECT_DIR!" && start http://localhost:3000 && node server.js
exit /b

:PYTHON_SERVER
where python.exe >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

set /p "SERVE_DIR=مسار المجلد للعرض: "
cd /d "!SERVE_DIR!" && start http://localhost:3000 && python -m http.server 3000
exit /b

:PHP_SERVER
where php.exe >nul 2>&1 || (
    echo %RED%✗ PHP غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

set /p "SERVE_DIR=مسار المشروع: "
cd /d "!SERVE_DIR!" && start http://localhost:3000 && php -S localhost:3000
exit /b

:LIVE_SERVER
where npx >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

set /p "PROJECT_DIR=مسار المشروع: "
cd /d "!PROJECT_DIR!" && start http://127.0.0.1:3000 && npx live-server --port=3000
exit /b
