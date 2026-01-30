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
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🚀 Postman - أدوات اختبار واجهات API الاحترافية%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

:CHECK_EXISTING
where Postman.exe >nul 2>&1 && (
    echo %GREEN%✓ Postman مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/4] جارٍ التثبيت عبر Winget...%WHITE%
call :LOADING_ANIMATION 6

winget install -e --id Postman.Postman --silent --accept-source-agreements --accept-package-agreements >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "INSTALLER=%TEMP%\Postman.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://dl.pstmn.io/download/latest/win64' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        echo %YELLOW%الحل اليدوي: نزّل من https://www.postman.com/downloads/%WHITE%
        timeout /t 6 >nul
        exit /b 1
    )
    
    start /wait "" "!INSTALLER!" /S >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

:VERIFY
timeout /t 8 >nul
where Postman.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %YELLOW%[2/4] جارٍ إنشاء بيئة تطوير جاهزة...%WHITE%

set "POSTMAN_DIR=%APPDATA%\Postman"
if not exist "!POSTMAN_DIR!" mkdir "!POSTMAN_DIR!" >nul

:: إنشاء ملف إعدادات بيئة Postman
(
echo {
echo   "version": "2.1.0",
echo   "info": {
echo     "name": "Knoux API Development Environment",
echo     "description": "بيئة تطوير API جاهزة للعمل باللغة العربية",
echo     "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collections.json"
echo   },
echo   "item": [
echo     {
echo       "name": "Test Endpoints",
echo       "request": {
echo         "method": "GET",
echo         "header": [],
echo         "url": {
echo           "raw": "https://jsonplaceholder.typicode.com/posts",
echo           "protocol": "https",
echo           "host": [
echo             "jsonplaceholder",
echo             "typicode",
echo             "com"
echo           ],
echo           "path": [
echo             "posts"
echo           ]
echo         }
echo       },
echo       "response": []
echo     }
echo   ],
echo   "variable": [
echo     {
echo       "key": "baseUrl",
echo       "value": "https://api.example.com",
echo       "description": "النطاق الأساسي للـ API"
echo     },
echo     {
echo       "key": "authToken",
echo       "value": "",
echo       "description": "رمز المصادقة"
echo     }
echo   ]
echo }
) > "%USERPROFILE%\knoux-api-collection.json"

echo %GREEN%✓ تم إنشاء بيئة تطوير جاهزة%WHITE%

echo %YELLOW%[3/4] جارٍ تثبيت Newman (Postman CLI)...%WHITE%
npm install -g newman >nul 2>&1

where newman >nul 2>&1 && (
    echo %GREEN%✓ Newman CLI مثبت%WHITE%
) || (
    echo %YELLOW%Newman متوفر عبر npm install -g newman%WHITE%
)

echo %YELLOW%[4/4] جارٍ إنشاء مشروع تجريبي...%WHITE%

set "POSTMAN_PROJECT=%USERPROFILE%\postman-workspace"
if not exist "!POSTMAN_PROJECT!" mkdir "!POSTMAN_PROJECT!" >nul

(
echo # Postman API Development Guide
echo 
echo ## Getting Started
echo 1. Open Postman
echo 2. Import collection: knoux-api-collection.json
echo 3. Create new request or use existing ones
echo 
echo ## Environment Variables
echo - baseUrl: https://api.example.com
echo - authToken: your_token_here
echo 
echo ## Useful Shortcuts
echo - Ctrl+N: New request
echo - Ctrl+S: Save
echo - Ctrl+Enter: Send request
echo 
echo ## Arabic Support
echo Postman supports Arabic text in requests and responses
) > "!POSTMAN_PROJECT!\README.md"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   Postman: %GRAY%ابحث في قائمة ابدأ عن "Postman"%WHITE%
echo   Newman CLI: %GRAY%newman run collection.json%WHITE%
echo   مشروع تجريبي: %GRAY%!POSTMAN_PROJECT!%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ واجهة رسومية سهلة الاستخدام
echo   ✓ دعم لجميع أنواع طلبات HTTP
echo   ✓ إدارة المتغيرات والبيئات
echo   ✓ اختبارات Postman Tests (JavaScript)
echo   ✓ مزامنة عبر السحابة
echo   ✓ دعم العمل الجماعي
echo.
echo %YELLOW%نصائح:%WHITE%
echo   • استخدم المتغيرات لتجنب تكرار القيم
echo   • أنشئ بيئات مختلفة (Development, Production)
echo   • استخدم Newman للتشغيل الآلي في CI/CD

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Postman with Newman CLI and development environment >> "!LOG_FILE!"

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
