@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🚀 سيرفر تطوير على المنفذ 8080%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

:: نفس المبدأ كـ server_3000.bat ولكن على المنفذ 8080
:: مفيد عندما يكون 3000 مشغولًا (مثل تطبيقات React الافتراضية)

netstat -ano | findstr ":8080 " >nul && (
    echo %YELLOW%⚠️  المنفذ 8080 مشغول%WHITE%
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 " ^| findstr "LISTENING"') do (
        tasklist /fi "PID eq %%a" /fo table | findstr "%%a"
    )
    set /p "KILL=إيقاف العملية؟ (y/n): "
    if /i "!KILL!"=="y" (
        for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 " ^| findstr "LISTENING"') do taskkill /f /pid %%a >nul 2>&1
    )
)

set /p "SERVE_DIR=مسار المجلد للعرض: "
if not exist "!SERVE_DIR!" (
    echo %RED%✗ المجلد غير موجود%WHITE%
    exit /b 1
)

echo %CYAN%نوع السيرفر:%WHITE%
echo   [1] Python (موصى به للبساطة)
echo   [2] Node.js + http-server
echo   [3] PHP Built-in
set /p "TYPE=اختر: "

if "!TYPE!"=="1" (
    cd /d "!SERVE_DIR!" && echo %GREEN%✓ السيرفر يعمل: http://localhost:8080%WHITE% && start http://localhost:8080 && python -m http.server 8080
)
if "!TYPE!"=="2" (
    where npx >nul 2>&1 && (
        cd /d "!SERVE_DIR!" && echo %GREEN%✓ السيرفر يعمل: http://localhost:8080%WHITE% && start http://localhost:8080 && npx http-server -p 8080
    ) || (
        echo %RED%✗ Node.js غير مثبت%WHITE%
    )
)
if "!TYPE!"=="3" (
    where php >nul 2>&1 && (
        cd /d "!SERVE_DIR!" && echo %GREEN%✓ السيرفر يعمل: http://localhost:8080%WHITE% && start http://localhost:8080 && php -S localhost:8080
    ) || (
        echo %RED%✗ PHP غير مثبت%WHITE%
    )
)
