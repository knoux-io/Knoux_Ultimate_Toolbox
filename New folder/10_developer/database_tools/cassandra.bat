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
echo %GRAY%===================================================%WHITE%
echo %GRAY%  📊 Apache Cassandra - قاعدة بيانات موزعة عالية التوفر%WHITE%
echo %GRAY%===================================================%WHITE%
echo.

java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت (مطلوب لـ Cassandra)%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

sc query Cassandra >nul 2>&1 && (
    echo %GREEN%✓ Cassandra قيد التشغيل%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/3] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 8

choco install cassandra -y >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الشرط المسبق: تثبيت Chocolatey أولاً (package_managers\chocolatey_setup.bat)%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CONFIGURE
echo %YELLOW%[2/3] جارٍ التهيئة...%WHITE%
set "CASSANDRA_HOME=C:\Program Files\Apache Cassandra"
set "CONF_DIR=!CASSANDRA_HOME!\conf"

if exist "!CONF_DIR!" (
    powershell -Command "(Get-Content '!CONF_DIR!\cassandra.yaml' -Raw) -replace 'cluster_name: .*', 'cluster_name: KnouxCluster' | Set-Content '!CONF_DIR!\cassandra.yaml'" >nul 2>&1
    powershell -Command "(Get-Content '!CONF_DIR!\cassandra.yaml' -Raw) -replace '# listen_address: .*', 'listen_address: 127.0.0.1' | Set-Content '!CONF_DIR!\cassandra.yaml'" >nul 2>&1
)

:START_SERVICE
echo %YELLOW%[3/3] جارٍ بدء الخدمة...%WHITE%
net start Cassandra >nul 2>&1 || (
    echo %RED%✗ فشل بدء الخدمة%WHITE%
    echo %YELLOW%الحل: أعد التشغيل ثم جرب مجددًا%WHITE%
    exit /b 1
)

timeout /t 15 >nul

echo %GREEN%✓ تم التثبيت والتهيئة بنجاح!%WHITE%
echo %CYAN%الاتصال:%WHITE% cqlsh localhost 9042
echo %CYAN%واجهة الإدارة:%WHITE% http://localhost:9160 (مع تثبيت إضافي)

echo.
echo %YELLOW%ملاحظة:%WHITE% Cassandra يستهلك موارد كبيرة (2GB+ RAM مطلوب)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Apache Cassandra distributed database >> "!LOG_FILE!"

timeout /t 6 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣷⣯⣟⡿⢿⣻⣽⣾"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
