@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "FLUTTER_DIR=%USERPROFILE%\flutter"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🦋 Flutter SDK - تطوير تطبيقات متعددة المنصات%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:CHECK_EXISTING
where flutter >nul 2>&1 && (
    echo %GREEN%✓ Flutter SDK مثبت مسبقًا%WHITE%
    flutter --version | findstr "Flutter"
    goto :SETUP_ENVIRONMENT
)

echo %YELLOW%[1/4] جارٍ التنزيل من الموقع الرسمي...%WHITE%
call :LOADING_ANIMATION 8

set "ZIP=%TEMP%\flutter.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.5-stable.zip' -OutFile '!ZIP!'" >nul 2>&1

if not exist "!ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://flutter.dev/docs/get-started/install/windows%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

echo %YELLOW%[2/4] جارٍ الاستخراج إلى مجلد المستخدم...%WHITE%
powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath '%USERPROFILE%' -Force" >nul 2>&1
del "!ZIP!" >nul 2>&1

if not exist "!FLUTTER_DIR!" (
    echo %RED%✗ فشل الاستخراج%WHITE%
    exit /b 1
)

:SETUP_ENVIRONMENT
echo %YELLOW%[3/4] جارٍ إعداد متغيرات البيئة...%WHITE%

setx FLUTTER_HOME "%FLUTTER_DIR%" >nul 2>&1
setx PATH "%PATH%;%FLUTTER_DIR%\bin" >nul 2>&1

echo %GREEN%✓ تم تعيين المتغيرات:%WHITE%
echo   FLUTTER_HOME = %GRAY%!FLUTTER_DIR!%WHITE%
echo   PATH         = %GRAY%...;!FLUTTER_DIR!\bin%WHITE%

echo %YELLOW%[4/4] جارٍ التحقق من التثبيت...%WHITE%

timeout /t 3 >nul
flutter --version >nul 2>&1 && (
    echo %GREEN%✓ Flutter SDK جاهز للعمل%WHITE%
    flutter doctor -v
) || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   Flutter SDK: %GRAY%!FLUTTER_DIR!%WHITE%
echo   الإصدار: %GRAY%3.16.5-stable%WHITE%
echo   أمر التحقق: %GRAY%flutter doctor -v%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الخطوات التالية:%WHITE%
echo   1. تشغيل flutter doctor ← لفحص المتطلبات
echo   2. إنشاء مشروع جديد: flutter create my_app
echo   3. تشغيل التطبيق: flutter run
echo   4. بناء APK: flutter build apk
echo.
echo %YELLOW%ملاحظات:%WHITE%
echo   • Flutter يتطلب Android SDK (Android Studio)
echo   • لتطوير iOS: يتطلب جهاز Mac
echo   • Dart مدمج مع Flutter (لا حاجة لتثبيت منفصل)

:: إنشاء مشروع تجريبي
echo %YELLOW%جارٍ إنشاء مشروع تجريبي...%WHITE%
set "TEST_PROJECT=%USERPROFILE%\flutter_hello"
if not exist "!TEST_PROJECT!" (
    flutter create --org com.knoux "!TEST_PROJECT!" >nul 2>&1
    echo %GREEN%✓ تم إنشاء مشروع تجريبي في: !TEST_PROJECT!%WHITE%
)

echo.
echo %CYAN%لتجربة سريعة:%WHITE%
echo   cd "!TEST_PROJECT!" && flutter run

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Flutter SDK 3.16.5 with environment setup >> "!LOG_FILE!"

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
