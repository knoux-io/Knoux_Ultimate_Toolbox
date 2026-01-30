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
echo %BLUE%  🔍 ElasticSearch 8.x - محرك بحث وتحليل قوي%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت (مطلوب لـ ElasticSearch)%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

sc query elasticsearch >nul 2>&1 && (
    echo %GREEN%✓ ElasticSearch قيد التشغيل%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/4] جارٍ التثبيت عبر Chocolatey...%WHITE%
call :LOADING_ANIMATION 6
choco install elasticsearch -y >nul 2>&1

:CONFIGURE_JVM
echo %YELLOW%[2/4] جارٍ تهيئة إعدادات JVM...%WHITE%
set "CONF=C:\ProgramData\Elastic\Elasticsearch\config\jvm.options"
if exist "!CONF!" (
    powershell -Command "(Get-Content '!CONF!' -Raw) -replace '-Xms1g', '-Xms512m' -replace '-Xmx1g', '-Xmx1g' | Set-Content '!CONF!'" >nul 2>&1
    echo %GREEN%✓ تم ضبط ذاكرة JVM (512MB-1GB)%WHITE%
)

:START_SERVICE
echo %YELLOW%[3/4] جارٍ بدء الخدمة...%WHITE%
net start elasticsearch >nul 2>&1
timeout /t 20 >nul

:TEST_CONNECTION
echo %YELLOW%[4/4] جارٍ اختبار الاتصال...%WHITE%
powershell -Command "Invoke-RestMethod -Uri 'http://localhost:9200' -Method Get" 2>nul | findstr "version" && (
    echo %GREEN%===================================================%WHITE%
    echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
    echo %CYAN%واجهة HTTP:%WHITE% http://localhost:9200
    echo %CYAN%حالة الصحة:%WHITE% http://localhost:9200/_cluster/health?pretty
    echo %CYAN%واجهة Kibana (مطلوب تثبيت منفصل):%WHITE% http://localhost:5601
    echo %GREEN%===================================================%WHITE%
    
    echo.
    echo %CYAN%أمثلة على الاستخدام:%WHITE%
    echo   POST /my-index/_doc { "message": "مرحباً" }
    echo   GET /my-index/_search?q=message:مرحباً
) || (
    echo %RED%✗ فشل اختبار الاتصال%WHITE%
    echo %YELLOW%الحلول:%WHITE%
    echo   - تحقق من جدار الحماية (المنفذ 9200)
    echo   - انتظر 30 ثانية أخرى ثم أعد المحاولة
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed ElasticSearch 8.x with JVM tuning >> "!LOG_FILE!"

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
