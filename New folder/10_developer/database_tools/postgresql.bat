@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🐘 PostgreSQL 15 - قاعدة البيانات العلائقية المتقدمة%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:CHECK_EXISTING
sc query postgresql-x64-15 >nul 2>&1 && (
    echo %GREEN%✓ PostgreSQL 15 قيد التشغيل%WHITE%
    psql --version
    goto :CREATE_USER
)

echo %YELLOW%[1/4] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 6

set "DATA_DIR=%PROGRAMFILES%\PostgreSQL\15\data"
set "PASS=postgres@Knoux%RANDOM%"

:: التثبيت الصامت مع إعدادات مخصصة
winget install -e --id PostgreSQL.PostgreSQL.15 --silent --override "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /TASKS=^'server^,stackbuilder^' /D=!PROGRAMFILES!\PostgreSQL\15" >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%البديل: استخدام المثبت الرسمي...%WHITE%
    set "INSTALLER=%TEMP%\postgresql.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://sbp.enterprisedb.com/getfile.jsp?fileid=12851' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        exit /b 1
    )
    
    start /wait "" "!INSTALLER!" --mode unattended --superpassword "!PASS!" --datadir "!DATA_DIR!" >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

:VERIFY
timeout /t 8 >nul
sc query postgresql-x64-15 >nul 2>&1 || (
    echo %RED%✗ فشل بدء الخدمة%WHITE%
    net start postgresql-x64-15 >nul 2>&1 || exit /b 1
)

:CREATE_USER
echo %YELLOW%[2/4] جارٍ إنشاء مستخدم مطور...%WHITE%
set "DEV_USER=developer"
set "DEV_PASS=dev@Knoux%RANDOM%"

psql -U postgres -c "CREATE USER !DEV_USER! WITH PASSWORD '!DEV_PASS!';" >nul 2>&1
psql -U postgres -c "ALTER USER !DEV_USER! CREATEDB;" >nul 2>&1
psql -U postgres -c "ALTER USER !DEV_USER! CREATEROLE;" >nul 2>&1

echo %GREEN%✓ تم إنشاء المستخدم: !DEV_USER!%WHITE%

:ENABLE_EXTENSIONS
echo %YELLOW%[3/4] جارٍ تفعيل الإضافات الشائعة...%WHITE%
psql -U postgres -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;" >nul 2>&1
psql -U postgres -c "CREATE EXTENSION IF NOT EXISTS hstore;" >nul 2>&1
psql -U postgres -c "CREATE EXTENSION IF NOT EXISTS uuid-ossp;" >nul 2>&1
psql -U postgres -c "CREATE EXTENSION IF NOT EXISTS pgcrypto;" >nul 2>&1
echo %GREEN%✓ تم تفعيل الإضافات: pg_stat_statements, hstore, uuid-ossp, pgcrypto%WHITE%

:TEST_CONNECTION
echo %YELLOW%[4/4] جارٍ اختبار الاتصال...%WHITE%
psql -U !DEV_USER! -d postgres -c "\conninfo" 2>nul && (
    echo %GREEN%===================================================%WHITE%
    echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
    echo %CYAN%معلومات الاتصال:%WHITE%
    echo   المضيف: %GRAY%localhost%WHITE%
    echo   المنفذ: %GRAY%5432%WHITE%
    echo   قاعدة البيانات: %GRAY%postgres%WHITE%
    echo   المستخدم المطور: %GRAY%!DEV_USER!%WHITE%
    echo   كلمة المرور: %GRAY%!DEV_PASS!%WHITE%
    echo %GREEN%===================================================%WHITE%
    echo.
    echo %CYAN%الأوامر السريعة:%WHITE%
    echo   psql -U !DEV_USER! -d postgres   ← الاتصال بقاعدة البيانات
    echo   \l                              ← عرض قواعد البيانات
    echo   \c dbname                       ← الاتصال بقاعدة بيانات
    echo   \dt                             ← عرض الجداول
    echo   \q                              ← الخروج
) || (
    echo %RED%✗ فشل اختبار الاتصال%WHITE%
)

:: حفظ بيانات الاعتماد في ملف آمن
set "CREDENTIALS=%~dp0..\..\..\backups\database\postgres_credentials.txt"
(
echo PostgreSQL 15 Credentials - Knoux Toolbox
echo Generated: !TIMESTAMP!
echo ========================================
echo Superuser: postgres
echo Developer User: !DEV_USER!
echo Password: !DEV_PASS!
echo Host: localhost
echo Port: 5432
echo ========================================
echo ⚠️  احفظ هذا الملف في مكان آمن واحذفه بعد الاستخدام
) > "!CREDENTIALS!"

echo %YELLOW%✓ تم حفظ بيانات الاعتماد في: !CREDENTIALS!%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed PostgreSQL 15 with dev user and extensions >> "!LOG_FILE!"

timeout /t 10 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣾⣽⣻⢿⡿⣟⣯⣷"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
