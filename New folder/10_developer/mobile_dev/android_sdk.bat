@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  ⚙️  Android SDK Tools - أدوات تطوير الأندرويد%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:CHECK_EXISTING
if exist "%ANDROID_HOME%\platform-tools\adb.exe" (
    echo %GREEN%✓ Android SDK Tools مثبت مسبقًا%WHITE%
    adb version
    goto :SETUP_ENVIRONMENT
)

echo %YELLOW%[1/4] جارٍ إنشاء مجلد SDK...%WHITE%
if not exist "%ANDROID_HOME%" mkdir "%ANDROID_HOME%" >nul

echo %YELLOW%[2/4] جارٍ تنزيل أدوات سطر الأوامر...%WHITE%
call :LOADING_ANIMATION 6

set "CMDLINE_ZIP=%TEMP%\cmdline-tools.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-9477386_latest.zip' -OutFile '!CMDLINE_ZIP!'" >nul 2>&1

if not exist "!CMDLINE_ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://developer.android.com/studio#command-tools%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

echo %YELLOW%[3/4] جارٍ الاستخراج...%WHITE%
powershell -Command "Expand-Archive -Path '!CMDLINE_ZIP!' -DestinationPath '%TEMP%\cmdline-tools' -Force" >nul 2>&1
if not exist "%ANDROID_HOME%\cmdline-tools" mkdir "%ANDROID_HOME%\cmdline-tools" >nul
xcopy "%TEMP%\cmdline-tools\cmdline-tools" "%ANDROID_HOME%\cmdline-tools\latest\" /E /I /Y >nul 2>&1
del "!CMDLINE_ZIP!" >nul 2>&1
rmdir /s /q "%TEMP%\cmdline-tools" >nul 2>&1

:SETUP_ENVIRONMENT
echo %YELLOW%[4/4] جارٍ إعداد المتغيرات والPackages...%WHITE%

setx ANDROID_HOME "%ANDROID_HOME%" >nul 2>&1
setx ANDROID_SDK_ROOT "%ANDROID_HOME%" >nul 2>&1
setx PATH "%PATH%;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin" >nul 2>&1

:: تثبيت الحزم الأساسية
if exist "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo y | "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools" "platforms;android-34" "build-tools;34.0.0" "emulator" >nul 2>&1
    echo %GREEN%✓ تم تثبيت الحزم الأساسية%WHITE%
) else (
    echo %RED%✗ فشل تثبيت الحزم%WHITE%
    exit /b 1
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل لـ Android SDK!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   SDK Location: %GRAY%%ANDROID_HOME%%WHITE%
echo   أدوات: %GRAY%%ANDROID_HOME%\platform-tools%WHITE%
echo   أدوات CLI: %GRAY%%ANDROID_HOME%\cmdline-tools\latest\bin%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الأوامر الشائعة:%WHITE%
echo   adb devices           ← عرض الأجهزة المتصلة
echo   adb install app.apk   ← تثبيت تطبيق
echo   sdkmanager --list     ← عرض الحزم المتوفرة
echo   avdmanager list avd   ← عرض الأجهزة الافتراضية
echo.
echo %YELLOW%ملاحظات:%WHITE%
echo   • هذا التثبيت مناسب للمطورين الذين لا يريدون Android Studio الكامل
echo   • يتطلب Java 8+ (JDK) لتثبيت الحزم
echo   • للجهاز الافتراضي: استخدم Android Studio أو AVD Manager

:: إنشاء ملف تعليمات
(
echo # Android SDK Command Line Tools
echo 
echo ## Environment Variables:
echo - ANDROID_HOME: %ANDROID_HOME%
echo - PATH: Added platform-tools and cmdline-tools
echo 
echo ## Common Commands:
echo - List available packages: sdkmanager --list
echo - Install platform: sdkmanager "platforms;android-34"
echo - Connect device: adb devices
echo - Install APK: adb install your-app.apk
echo 
echo ## Troubleshooting:
echo - If adb is not recognized, restart command prompt after PATH change
echo - For permission issues, run as Administrator
) > "%ANDROID_HOME%\README.txt"

echo %GREEN%✓ تم إنشاء ملف تعليمات%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Android SDK Command Line Tools with basic packages >> "!LOG_FILE!"

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
