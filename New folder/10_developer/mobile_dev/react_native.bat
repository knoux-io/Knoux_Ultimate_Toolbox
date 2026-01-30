@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  ⚛️  React Native - تطوير تطبيقات متعددة المنصات بـ JavaScript%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:: التحقق من Node.js
node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:: التحقق من Java (مطلوب لـ Android)
java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:: التحقق من Android SDK
adb version >nul 2>&1 || (
    echo %YELLOW%⚠️  Android SDK غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً mobile_dev\android_studio.bat%WHITE%
    echo %GRAY%سيتم المتابعة مع التحذير%WHITE%
    timeout /t 4 >nul
)

:CHECK_EXISTING
where react-native >nul 2>&1 && (
    echo %GREEN%✓ React Native CLI مثبت مسبقًا%WHITE%
    react-native --version
    goto :GLOBAL_INSTALL
)

:GLOBAL_INSTALL
echo %YELLOW%جارٍ تثبيت React Native CLI عالميًا...%WHITE%

:: تثبيت CLI أدوات
npm install -g @react-native-community/cli >nul 2>&1
npm install -g react-native-cli >nul 2>&1

:: التحقق من التثبيت
where react-native >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%المحاولة البديلة: npx react-native-cli%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت React Native CLI%WHITE%

echo %YELLOW%جارٍ إعداد متغيرات البيئة...%WHITE%

:: تعيين متغيرات البيئة
setx ANDROID_HOME "%LOCALAPPDATA%\Android\Sdk" >nul 2>&1
setx JAVA_HOME "%PROGRAMFILES%\Java\jdk-17" >nul 2>&1
setx PATH "%PATH%;%LOCALAPPDATA%\Android\Sdk\platform-tools;%LOCALAPPDATA%\Android\Sdk\tools" >nul 2>&1

echo %GREEN%✓ تم تعيين المتغيرات:%WHITE%
echo   ANDROID_HOME = %GRAY%%LOCALAPPDATA%\Android\Sdk%WHITE%
echo   JAVA_HOME    = %GRAY%%PROGRAMFILES%\Java\jdk-17%WHITE%

echo %YELLOW%جارٍ إنشاء مشروع تجريبي...%WHITE%
set "RN_PROJECT=%USERPROFILE%\react-native-demo"
if not exist "!RN_PROJECT!" (
    npx react-native init ReactNativeDemo --directory "!RN_PROJECT!" >nul 2>&1
    if errorlevel 1 (
        echo %YELLOW%المحاولة مع npm install...%WHITE%
        mkdir "!RN_PROJECT!" >nul
        cd /d "!RN_PROJECT!" && npm install react-native >nul 2>&1
    )
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ React Native!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   CLI: %GRAY%npx react-native%WHITE%
echo   مشروع تجريبي: %GRAY%!RN_PROJECT!%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الخطوات التالية:%WHITE%
echo   1. cd "!RN_PROJECT!"
echo   2. react-native run-android ← لتشغيل على Android
echo   3. react-native run-ios ← لتشغيل على iOS (Mac فقط)
echo.
echo %YELLOW%ملاحظات:%WHITE%
echo   • يتطلب Android Studio مع SDK
echo   • للجهاز الحقيقي: USB Debugging مفعل
echo   • للجهاز الافتراضي: AVD مع Android 7.0+

:: إنشاء ملف تعليمات
(
echo # React Native Development Setup
echo 
echo ## Requirements:
echo - Node.js (v16+)
echo - Java JDK (v11+)
echo - Android SDK (from Android Studio)
echo 
echo ## Commands:
echo - Create project: npx react-native init ProjectName
echo - Run on Android: react-native run-android
echo - Run on iOS: react-native run-ios
echo 
echo ## Environment Variables:
echo - ANDROID_HOME: %LOCALAPPDATA%\Android\Sdk
echo - JAVA_HOME: %PROGRAMFILES%\Java\jdk-17
) > "!RN_PROJECT!\README.md"

echo %GREEN%✓ تم إنشاء README.md مع التعليمات%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed React Native CLI with environment setup >> "!LOG_FILE!"

timeout /t 8 >nul
