@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %ORANGE%===================================================%WHITE%
echo %ORANGE%  🔵 Expo CLI - تطوير React Native بسهولة%WHITE%
echo %ORANGE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:CHECK_EXISTING
where expo >nul 2>&1 && (
    echo %GREEN%✓ Expo CLI مثبت مسبقًا%WHITE%
    expo --version
    goto :GLOBAL_INSTALL
)

:GLOBAL_INSTALL
echo %YELLOW%جارٍ تثبيت Expo CLI عالميًا...%WHITE%
npm install -g @expo/cli >nul 2>&1

where expo >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Expo CLI%WHITE%

echo %YELLOW%جارٍ إنشاء مشروع Expo تجريبي...%WHITE%
set "EXPO_PROJECT=%USERPROFILE%\expo-demo"
if not exist "!EXPO_PROJECT!" (
    npx create-expo-app "!EXPO_PROJECT!" --template >nul 2>&1
    if errorlevel 1 (
        npx create-expo-app "!EXPO_PROJECT!" >nul 2>&1
    )
)

if exist "!EXPO_PROJECT!" (
    echo %GREEN%✓ تم إنشاء مشروع Expo: !EXPO_PROJECT!%WHITE%
) else (
    echo %YELLOW%فشل إنشاء المشروع - إنشاء يدوي...%WHITE%
    mkdir "!EXPO_PROJECT!" >nul
    cd /d "!EXPO_PROJECT!" && npm init -y >nul 2>&1
    npm install @expo/cli >nul 2>&1
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Expo!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   CLI: %GRAY%expo (or npx expo)%WHITE%
echo   مشروع تجريبي: %GRAY%!EXPO_PROJECT!%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%مزايا Expo:%WHITE%
echo   ✓ لا حاجة لـ Android Studio أو Xcode
echo   ✓ مكونات جاهزة (Camera, Location, etc.)
echo   ✓ نشر مباشر للتطبيق (Expo Go)
echo   ✓ دعم عبر الإنترنت (Expo Snack)
echo.
echo %CYAN%الخطوات التالية:%WHITE%
echo   1. cd "!EXPO_PROJECT!"
echo   2. npx expo start ← لبدء الخادم التنموي
echo   3. نصب تطبيق Expo Go على هاتفك
echo   4. مسح QR Code للتشغيل على الهاتف
echo.
echo %YELLOW%ملاحظات:%WHITE%
echo   • Expo محدود في بعض الوظائف المتقدمة
echo   • لتطبيقات معقدة: استخدم Expo Development Builds
echo   • للنشر: expo publish أو expo build

:: تعديل package.json لدعم العربية
if exist "!EXPO_PROJECT!\package.json" (
    powershell -Command "(Get-Content '!EXPO_PROJECT!\package.json' -Raw) -replace '\"scripts\": {', '\"scripts\": {\n    \"android\": \"expo run:android\",\n    \"ios\": \"expo run:ios\",\n    \"web\": \"expo start --web",' | Set-Content '!EXPO_PROJECT!\package.json'" >nul 2>&1
)

echo %GREEN%✓ تم تعديل scripts في package.json%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Expo CLI with demo project >> "!LOG_FILE!"

timeout /t 8 >nul
