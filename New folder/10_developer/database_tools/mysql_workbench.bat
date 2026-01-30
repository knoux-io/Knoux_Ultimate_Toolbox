@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  📊 MySQL Workbench - واجهة إدارة قواعد البيانات%WHITE%
echo %RED%===================================================%WHITE%
echo.

where mysqlworkbench.exe >nul 2>&1 && (
    echo %GREEN%✓ MySQL Workbench مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id Oracle.MySQL.Workbench --silent >nul 2>&1

where mysqlworkbench.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://dev.mysql.com/downloads/workbench/%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:: إنشاء اتصال افتراضي محلي
set "CONNECTIONS=%APPDATA%\MySQL\Workbench\connections.xml"
if not exist "%APPDATA%\MySQL\Workbench" mkdir "%APPDATA%\MySQL\Workbench" >nul

(
echo ^<?xml version="1.0" encoding="UTF-8"?^>
echo ^<workbench^>
echo   ^<connection name="Local MySQL" host="localhost" port="3306" username="root" password="^<^<encrypted^>^>" /^>
echo ^</workbench^>
) > "!CONNECTIONS!" 2>nul

echo %CYAN%المزايا الرئيسية:%WHITE%
echo   ✓ تصميم قواعد البيانات (ER Diagrams)
echo   ✓ مراقبة الأداء في الوقت الفعلي
echo   ✓ تصدير/استيراد البيانات (SQL, CSV, JSON)
echo   ✓ مهاجرة قواعد البيانات من أنظمة أخرى
echo   ✓ إدارة المستخدمين والصلاحيات

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed MySQL Workbench GUI >> "!LOG_FILE!"

timeout /t 5 >nul
