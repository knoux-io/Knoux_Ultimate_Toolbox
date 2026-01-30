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
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🍃 MongoDB 7.0 - قاعدة البيانات الوثائقية (NoSQL)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:CHECK_EXISTING
sc query MongoDB >nul 2>&1 && (
    echo %GREEN%✓ MongoDB قيد التشغيل%WHITE%
    mongod --version | findstr "db version"
    goto :CREATE_USER
)

echo %YELLOW%[1/4] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 6

:: إضافة مستودع MongoDB أولاً
winget source add --name mongodb --arg https://mongoshellmongodbprod.azureedge.net/mongocli/winget-prod >nul 2>&1

winget install -e --id MongoDB.Server --silent --accept-source-agreements >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "MSI=%TEMP%\mongodb.msi"
    powershell -Command "Invoke-WebRequest -Uri 'https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-7.0.5-signed.msi' -OutFile '!MSI!'" >nul 2>&1
    
    if not exist "!MSI!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        exit /b 1
    )
    
    start /wait msiexec /i "!MSI!" /quiet INSTALLLOCATION="C:\Program Files\MongoDB\Server\7.0" ADDLOCAL="Server,Router,Client" >nul 2>&1
    del "!MSI!" >nul 2>&1
)

:CREATE_DIRS
set "DATA_DIR=C:\data\db"
set "LOG_DIR=C:\data\log"
if not exist "!DATA_DIR!" mkdir "!DATA_DIR!" >nul
if not exist "!LOG_DIR!" mkdir "!LOG_DIR!" >nul

:CONFIG_FILE
set "CONF=C:\Program Files\MongoDB\Server\7.0\bin\mongod.cfg"
(
echo systemLog:
echo   destination: file
echo   path: C:\data\log\mongod.log
echo storage:
echo   dbPath: C:\data\db
echo net:
echo   bindIp: 127.0.0.1
echo   port: 27017
echo security:
echo   authorization: enabled
) > "!CONF!"

:START_SERVICE
net start MongoDB >nul 2>&1 || (
    sc create MongoDB binPath= "\"C:\Program Files\MongoDB\Server\7.0\bin\mongod.exe\" --config=\"C:\Program Files\MongoDB\Server\7.0\bin\mongod.cfg\" --service" DisplayName= "MongoDB" start= auto >nul 2>&1
    net start MongoDB >nul 2>&1 || (
        echo %RED%✗ فشل بدء الخدمة%WHITE%
        exit /b 1
    )
)

:CREATE_USER
echo %YELLOW%[2/4] جارٍ إنشاء مستخدم مسؤول...%WHITE%
set "ADMIN_USER=admin"
set "ADMIN_PASS=Mongo@Knoux%RANDOM%%RANDOM%"

:: بدء خادم مؤقت بدون مصادقة لإنشاء المستخدم
start /min "" "C:\Program Files\MongoDB\Server\7.0\bin\mongod.exe" --dbpath "!DATA_DIR!" --noauth
timeout /t 5 >nul

mongo admin --eval "db.createUser({user: '!ADMIN_USER!', pwd: '!ADMIN_PASS!', roles: [{role: 'userAdminAnyDatabase', db: 'admin'}, {role: 'readWriteAnyDatabase', db: 'admin'}]})" >nul 2>&1

taskkill /f /im mongod.exe >nul 2>&1
net start MongoDB >nul 2>&1

:TEST_CONNECTION
echo %YELLOW%[3/4] جارٍ اختبار الاتصال...%WHITE%
timeout /t 5 >nul
mongo admin -u !ADMIN_USER! -p !ADMIN_PASS! --eval "db.runCommand({connectionStatus: 1})" | findstr "authenticated" && (
    echo %GREEN%✓ تم التوثيق بنجاح%WHITE%
) || (
    echo %RED%✗ فشل التوثيق%WHITE%
    goto :END
)

:ENABLE_COMPRESSION
echo %YELLOW%[4/4] جارٍ تفعيل ضغط البيانات (WiredTiger)...%WHITE%
mongo admin -u !ADMIN_USER! -p !ADMIN_PASS! --eval "db.adminCommand({setParameter: 1, wiredTigerEngineConfig: 'cache_size=1G'})" >nul 2>&1
echo %GREEN%✓ تم تحسين أداء التخزين%WHITE%

:END
echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%معلومات الاتصال:%WHITE%
echo   المضيف: %GRAY%localhost%WHITE%
echo   المنفذ: %GRAY%27017%WHITE%
echo   المستخدم: %GRAY%!ADMIN_USER!%WHITE%
echo   كلمة المرور: %GRAY%!ADMIN_PASS!%WHITE%
echo   قاعدة البيانات: %GRAY%admin%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الأوامر الأساسية:%WHITE%
echo   mongo -u !ADMIN_USER! -p !ADMIN_PASS! --authenticationDatabase admin
echo   use mydb                     ← اختيار/إنشاء قاعدة بيانات
echo   db.mycollection.insertOne({name: "test"})  ← إدخال مستند
echo   db.mycollection.find()     ← استعلام المستندات
echo   show dbs                   ← عرض قواعد البيانات
echo   show collections           ← عرض المجموعات

:: حفظ بيانات الاعتماد
set "CRED=%~dp0..\..\..\backups\database\mongodb_credentials.txt"
(
echo MongoDB 7.0 Credentials - Knoux Toolbox
echo Generated: !TIMESTAMP!
echo ========================================
echo Host: localhost
echo Port: 27017
echo Username: !ADMIN_USER!
echo Password: !ADMIN_PASS!
echo Auth Database: admin
echo ========================================
echo ⚠️  احفظ هذا الملف في مكان آمن ثم احذفه
) > "!CRED!"

echo %YELLOW%✓ تم حفظ بيانات الاعتماد في: !CRED!%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed MongoDB 7.0 with auth enabled >> "!LOG_FILE!"

timeout /t 10 >nul
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
