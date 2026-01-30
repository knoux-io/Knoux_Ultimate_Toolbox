@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BROWN%===================================================%WHITE%
echo %BROWN%  🛋️  Apache CouchDB - قاعدة بيانات مستندات مع مزامنة%WHITE%
echo %BROWN%===================================================%WHITE%
echo.

sc query couchdb >nul 2>&1 && (
    echo %GREEN%✓ CouchDB قيد التشغيل%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id Apache.CouchDB --silent >nul 2>&1

sc query couchdb >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

net start couchdb >nul 2>&1

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
timeout /t 5 >nul

echo %CYAN%تهيئة أولية:%WHITE%
echo   1. افتح المتصفح: http://127.0.0.1:5984/_utils/
echo   2. اضغط على "Fix This" لتهيئة الخادم
echo   3. أنشئئ كلمة مرور المسؤول
echo.
echo %CYAN%المزايا الفريدة:%WHITE%
echo   ✓ مزامنة تلقائية بين الأجهزة (Offline-First)
echo   ✓ واجهة RESTful كاملة
echo   ✓ MapReduce للتحليل المتقدم
echo   ✓ دعم كامل لـ JSON كتنسيق تخزين

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Apache CouchDB >> "!LOG_FILE!"

timeout /t 6 >nul
