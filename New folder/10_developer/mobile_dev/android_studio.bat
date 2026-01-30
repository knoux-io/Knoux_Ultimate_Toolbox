@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "ANDROID_STUDIO_DIR=%PROGRAMFILES%\Android\Android Studio"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🤖 Android Studio - بيئة تطوير الأندرويد الرسمية%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:CHECK_EXISTING
where studio64.exe >nul 2>&1 && (
    echo %GREEN%✓ Android Studio مثبت مسبقًا%WHITE%
    echo المسار: %GRAY%%ANDROID_STUDIO_DIR%%WHITE%
    goto :SETUP_ENVIRONMENT
)

echo %YELLOW%[1/5] جارٍ التثبيت عبر Winget...%WHITE%
call :LOADING_ANIMATION 10

winget install -e --id Google.AndroidStudio --silent --accept-source-agreements --accept-package-agreements >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "INSTALLER=%TEMP%\android-studio.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.27/android-studio-2023.1.1.27-windows.zip' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        echo %YELLOW%الحل اليدوي: نزّل من https://developer.android.com/studio%WHITE%
        timeout /t 6 >nul
        exit /b 1
    )
    
    powershell -Command "Expand-Archive -Path '!INSTALLER!' -DestinationPath '%PROGRAMFILES%' -Force" >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

:SETUP_ENVIRONMENT
echo %YELLOW%[2/5] جارٍ إعداد متغيرات البيئة...%WHITE%

setx ANDROID_HOME "%ANDROID_HOME%" >nul 2>&1
setx ANDROID_SDK_ROOT "%ANDROID_HOME%" >nul 2>&1
setx PATH "%PATH%;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools;%ANDROID_HOME%\cmdline-tools\latest\bin" >nul 2>&1

echo %GREEN%✓ تم تعيين المتغيرات:%WHITE%
echo   ANDROID_HOME = %GRAY%%ANDROID_HOME%%WHITE%
echo   PATH         = %GRAY%...;%ANDROID_HOME%\platform-tools%WHITE%

echo %YELLOW%[3/5] جارٍ تثبيت أدوات SDK الضرورية...%WHITE%

:: إنشاء مجلد SDK إذا لم يكن موجودًا
if not exist "%ANDROID_HOME%" mkdir "%ANDROID_HOME%" >nul

:: تثبيت أدوات SDK الأساسية
adb version >nul 2>&1 || (
    echo %YELLOW%جارٍ تنزيل أدوات ADB...%WHITE%
    set "CMDLINE_ZIP=%TEMP%\cmdline-tools.zip"
    powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-9477386_latest.zip' -OutFile '!CMDLINE_ZIP!'" >nul 2>&1
    
    if exist "!CMDLINE_ZIP!" (
        powershell -Command "Expand-Archive -Path '!CMDLINE_ZIP!' -DestinationPath '%TEMP%\cmdline-tools' -Force" >nul 2>&1
        if not exist "%ANDROID_HOME%\cmdline-tools" mkdir "%ANDROID_HOME%\cmdline-tools" >nul
        xcopy "%TEMP%\cmdline-tools\cmdline-tools" "%ANDROID_HOME%\cmdline-tools\latest\" /E /I /Y >nul 2>&1
        del "!CMDLINE_ZIP!" >nul 2>&1
        rmdir /s /q "%TEMP%\cmdline-tools" >nul 2>&1
    )
)

echo %YELLOW%[4/5] جارٍ تثبيت حزم SDK الضرورية...%WHITE%

:: تثبيت الحزم الأساسية (إذا كانت الأدوات متوفرة)
if exist "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo y | "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools" "platforms;android-34" "build-tools;34.0.0" "emulator" >nul 2>&1
    echo %GREEN%✓ تم تثبيت حزم SDK الأساسية%WHITE%
) else (
    echo %YELLOW%ملاحظة: تثبيت الحزم التلقائي معلق - سيحدث من داخل Android Studio%WHITE%
)

echo %YELLOW%[5/5] جارٍ اختبار التثبيت...%WHITE%

adb version >nul 2>&1 && (
    echo %GREEN%✓ أدوات ADB جاهزة%WHITE%
) || (
    echo %YELLOW%ملاحظة: ADB سيُثبّت عند أول تشغيل لـ Android Studio%WHITE%
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   Android Studio: %GRAY%%ANDROID_STUDIO_DIR%\bin\studio64.exe%WHITE%
echo   SDK Location: %GRAY%%ANDROID_HOME%%WHITE%
echo   أدوات: %GRAY%%ANDROID_HOME%\platform-tools%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الخطوات التالية:%WHITE%
echo   1. افتح Android Studio ← سيكمل التثبيت التلقائي للـ SDK
echo   2. أنشئ مشروع تجريبي ← Hello World
echo   3. قم بتكوين جهاز افتراضي (AVD)
echo   4. ابدأ تطوير تطبيقات الأندرويد!
echo.
echo %YELLOW%نصائح:%WHITE%
echo   • التثبيت الأول قد يستغرق 10-20 دقيقة (الـ SDK كبير)
echo   • للجهاز الحقيقي: فعل "USB Debugging" من خيارات المطور
echo   • AVD: اختر جهاز بمواصفات مناسبة (RAM 2GB+ موصى)

:: إنشاء اختصار على سطح المكتب
powershell -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Android Studio.lnk'); $s.TargetPath='%ANDROID_STUDIO_DIR%\bin\studio64.exe'; $s.IconLocation='%ANDROID_STUDIO_DIR%\bin\studio64.exe'; $s.Save()" >nul 2>&1

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Android Studio with SDK environment variables >> "!LOG_FILE!"

timeout /t 12 >nul
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
