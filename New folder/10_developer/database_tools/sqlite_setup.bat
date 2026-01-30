@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  📁 SQLite - قاعدة البيانات الخفيفة بدون خادم%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

where sqlite3.exe >nul 2>&1 && (
    for /f "tokens=*" %%a in ('sqlite3 --version') do set "VER=%%a"
    echo %GREEN%✓ SQLite مثبت مسبقًا%WHITE%
    echo الإصدار: %CYAN%!VER!%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id SQLite.SQLite --silent >nul 2>&1

where sqlite3.exe >nul 2>&1 || (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "ZIP=%TEMP%\sqlite.zip"
    set "EXE=%USERPROFILE%\sqlite3.exe"
    
    powershell -Command "Invoke-WebRequest -Uri 'https://www.sqlite.org/2024/sqlite-tools-win32-x86-3450200.zip' -OutFile '!ZIP!'" >nul 2>&1
    powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath '%TEMP%\sqlite' -Force" >nul 2>&1
    
    copy "%TEMP%\sqlite\sqlite3.exe" "!EXE!" >nul 2>&1
    del "!ZIP!" >nul 2>&1
    rmdir /s /q "%TEMP%\sqlite" >nul 2>&1
    
    setx PATH "%PATH%;%USERPROFILE%" >nul
)

for /f "tokens=*" %%a in ('sqlite3 --version') do set "VER=%%a"
echo %GREEN%✓ تم التثبيت: SQLite !VER!%WHITE%

echo.
echo %CYAN%لماذا SQLite؟%WHITE%
echo   ✓ لا يتطلب خادم - ملف واحد يحتوي على قاعدة البيانات كاملة
echo   ✓ خفيف جدًا (المحرك ~500KB)
echo   ✓ مثالي للتطبيقات المحمولة والمشاريع الصغيرة
echo   ✓ يدعم معظم ميزات SQL القياسية
echo.
echo %CYAN%الأوامر الأساسية:%WHITE%
echo   sqlite3 database.db   ← فتح/إنشاء قاعدة بيانات
echo   .tables               ← عرض الجداول
echo   .schema tablename     ← عرض هيكل الجدول
echo   .mode column          ← وضع عرض عمودي
echo   .headers on           ← إظهار رؤوس الأعمدة
echo   .exit                 ← الخروج

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed SQLite !VER! (serverless database) >> "!LOG_FILE!"

timeout /t 6 >nul
