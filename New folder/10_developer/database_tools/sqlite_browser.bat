@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🔍 DB Browser for SQLite - واجهة رسومية لـ SQLite%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

where sqlitebrowser.exe >nul 2>&1 && (
    echo %GREEN%✓ DB Browser for SQLite مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id DBBrowserForSQLite.DBBrowserForSQLite --silent >nul 2>&1

where sqlitebrowser.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%المزايا:%WHITE%
echo   ✓ واجهة سحب وإفلات لاستيراد/تصدير البيانات
echo   ✓ محرر استعلامات مع إكمال تلقائي
echo   ✓ عارض هيكل قاعدة البيانات (الجداول، الفهارس، المشغلات)
echo   ✓ دعم لغات متعددة بما فيها العربية
echo   ✓ تصدير إلى CSV, JSON, SQL

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed DB Browser for SQLite GUI >> "!LOG_FILE!"

timeout /t 4 >nul
