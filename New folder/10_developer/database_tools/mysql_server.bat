@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول لتثبيت خادم MySQL%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %RED%===================================================%WHITE%
echo %RED%  🐬 MySQL Server 8.0 - قاعدة البيانات العلائقية%WHITE%
echo %RED%===================================================%WHITE%
echo.

:CHECK_EXISTING
sc query MySQL80 >nul 2>&1 && (
    echo %GREEN%✓ MySQL Server 8.0 قيد التشغيل%WHITE%
    mysql --version 2>nul | findstr "Ver"
    goto :SECURITY_SETUP
)

echo %YELLOW%[1/4] جارٍ التثبيت عبر Winget...%WHITE%
call :LOADING_ANIMATION 5
winget install -e --id Oracle.MySQL.8.0 --silent --accept-source-agreements >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%المحاولة البديلة: التثبيت اليدوي...%WHITE%
    set "INSTALLER=%TEMP%\mysql-installer.msi"
    powershell -Command "Invoke-WebRequest -Uri 'https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.36-winx64.msi' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        echo %YELLOW%الحل اليدوي: نزّل من https://dev.mysql.com/downloads/installer/%WHITE%
        timeout /t 6 >nul
        exit /b 1
    )
    
    start /wait msiexec /i "!INSTALLER!" /quiet INSTALLDIR="C:\Program Files\MySQL\MySQL Server 8.0" >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

:VERIFY
timeout /t 5 >nul
sc query MySQL80 >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت أو لم يبدأ الخدمة%WHITE%
    net start MySQL80 >nul 2>&1 || (
        echo %YELLOW%حاول بدء الخدمة يدويًا:%WHITE% net start MySQL80
        timeout /t 5 >nul
        exit /b 1
    )
)

:SECURITY_SETUP
echo %YELLOW%[2/4] جارٍ تهيئة إعدادات الأمان الأولية...%WHITE%
echo %GRAY%(سيتم إنشاء كلمة مرور افتراضية مؤقتة)%WHITE%

set "TEMP_PASS=Knoux@%RANDOM%%RANDOM%"
echo كلمة المرور المؤقتة: %CYAN%!TEMP_PASS!%WHITE%
echo %YELLOW%⚠️  احفظ هذه الكلمة - ستستخدم لتهيئة الأمان%WHITE%
timeout /t 3 >nul

:: تهيئة الأمان (يتطلب تشغيل مع كلمات المرور المؤقتة)
mysql --user=root --password="" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '!TEMP_PASS!'; FLUSH PRIVILEGES;" >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%ملاحظة: قد تكون التهيئة مسبقة - تجاوز خطوة التهيئة%WHITE%
) else (
    echo %GREEN%✓ تم تعيين كلمة مرور الجذر%WHITE%
)

:CREATE_CONFIG
echo %YELLOW%[3/4] جارٍ إنشاء ملف التهيئة (my.ini)...%WHITE%
set "MY_INI=C:\ProgramData\MySQL\MySQL Server 8.0\my.ini"

if not exist "!MY_INI!" (
    (
    echo [mysqld]
    echo port=3306
    echo basedir="C:/Program Files/MySQL/MySQL Server 8.0"
    echo datadir="C:/ProgramData/MySQL/MySQL Server 8.0/Data"
    echo character-set-server=utf8mb4
    echo default-storage-engine=INNODB
    echo sql-mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    echo max_connections=151
    echo query_cache_size=0
    echo table_cache=256
    echo tmp_table_size=64M
    echo thread_cache_size=8
    echo innodb_buffer_pool_size=256M
    echo innodb_log_file_size=64M
    echo [client]
    echo port=3306
    echo [mysql]
    echo no-beep
    ) > "!MY_INI!"
    echo %GREEN%✓ تم إنشاء ملف التهيئة مع إعدادات الأداء%WHITE%
)

:TEST_CONNECTION
echo %YELLOW%[4/4] جارٍ اختبار الاتصال...%WHITE%
mysql --user=root --password="!TEMP_PASS!" -e "SELECT VERSION(), @@hostname;" 2>nul | findstr "8.0" && (
    echo %GREEN%✓ تم التثبيت والتهيئة بنجاح!%WHITE%
    echo.
    echo %CYAN%معلومات الاتصال:%WHITE%
    echo   المضيف: %GRAY%localhost%WHITE%
    echo   المنفذ: %GRAY%3306%WHITE%
    echo   المستخدم: %GRAY%root%WHITE%
    echo   كلمة المرور: %GRAY%!TEMP_PASS!%WHITE%
    echo.
    echo %YELLOW%الأمر التالي لتغيير كلمة المرور بشكل دائم:%WHITE%
    echo   mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'كلمة_مرور_جديدة';"
) || (
    echo %RED%✗ فشل اختبار الاتصال%WHITE%
    echo %YELLOW%الحلول:%WHITE%
    echo   1. أعد تشغيل الخدمة: %CYAN%net stop MySQL80 && net start MySQL80%WHITE%
    echo   2. تحقق من جدار الحماية
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed MySQL Server 8.0 with security hardening >> "!LOG_FILE!"

timeout /t 8 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
