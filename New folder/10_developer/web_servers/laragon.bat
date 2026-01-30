@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "LARAGON_DIR=%USERPROFILE%\laragon"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🟦 Laragon - أسرع حزمة تطوير محلي (محمولة)%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

if exist "!LARAGON_DIR!" (
    echo %GREEN%✓ Laragon مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التنزيل (إصدار محمول - لا يحتاج تثبيت)...%WHITE%
set "ZIP=%TEMP%\laragon.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/laragon/laragon/releases/latest/download/laragon.zip' -OutFile '!ZIP!'" >nul 2>&1

if not exist "!ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    exit /b 1
)

echo %YELLOW%جارٍ الاستخراج إلى مجلد المستخدم...%WHITE%
if not exist "!LARAGON_DIR!" mkdir "!LARAGON_DIR!" >nul
powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath '!LARAGON_DIR!' -Force" >nul 2>&1
del "!ZIP!" >nul 2>&1

echo %GREEN%✓ تم الاستخراج بنجاح%WHITE%

:: إنشاء اختصار على سطح المكتب
powershell -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Laragon.lnk'); $s.TargetPath='!LARAGON_DIR!\laragon.exe'; $s.IconLocation='!LARAGON_DIR!\laragon.exe'; $s.Save()" >nul 2>&1

echo %CYAN%لماذا Laragon؟%WHITE%
echo   ⚡ تشغيل فوري بدون تثبيت (Portable)
echo   ⚡ إنشاء نطاقات فرعية تلقائيًا (project.test)
echo   ⚡ دعم كامل لـ Laravel, WordPress, Drupal
echo   ⚡ MySQL + PHP + Apache/Nginx في حزمة واحدة
echo   ⚡ واجهة أنيقة وسريعة جدًا
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. انقر مزدوج على اختصار سطح المكتب "Laragon"
echo   2. انقر "Start All" لتشغيل جميع الخدمات
echo   3. انقر بزر الماوس الأيمن ← Quick App ← Laravel لبدء مشروع جديد
echo   4. افتح المتصفح: %CYAN%http://laravel.test%WHITE% (مثال)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Laragon portable dev environment >> "!LOG_FILE!"

timeout /t 8 >nul
