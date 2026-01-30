@echo off
:: =================================================================
:: KNOUX FLUTTER INSTALLER
:: تثبيت Flutter SDK مع مدير المشاريع
:: =================================================================
title Knoux - Flutter Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX FLUTTER SDK + PROJECT MANAGER
echo   تثبيت Flutter SDK مع مدير المشاريع
echo ═══════════════════════════════════════════════════════════
echo.

:: Check if Git is installed
echo [Knoux] جاري فحص Git...
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [✗] Git غير مثبت!
    echo [→] يرجى تثبيت Git أولاً
    pause
    exit /b 1
)

echo [→] جاري تثبيت Flutter SDK...
set "FLUTTER_DIR=C:\flutter"

if not exist "%FLUTTER_DIR%" (
    echo [→] جاري تنزيل Flutter...
    powershell -Command "Invoke-WebRequest -Uri 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.0-stable.zip' -OutFile '$env:TEMP\flutter.zip'"
    
    echo [→] جاري استخراج Flutter...
    powershell -Command "Expand-Archive -Path '$env:TEMP\flutter.zip' -DestinationPath 'C:\' -Force"
    
    echo [→] جاري تنظيف الملفات المؤقتة...
    del "$env:TEMP\flutter.zip"
) else (
    echo [!] Flutter مثبت مسبقاً!
)

echo [✓] تم تثبيت Flutter SDK!

:: Add Flutter to PATH
echo [→] جاري إضافة Flutter إلى PATH...
setx PATH "%PATH%;C:\flutter\bin" /M
set "PATH=%PATH%;C:\flutter\bin"

:: Verify installation
echo [→] جاري التحقق من التثبيت...
flutter --version

:: Run Flutter doctor
echo [→] جاري تشغيل Flutter Doctor...
flutter doctor

echo [✓] Flutter جاهز للاستخدام!

:: Create project manager
echo [→] جاري إنشاء مدير مشاريع Flutter...
(
    echo @echo off
    echo title Knoux Flutter Project Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX FLUTTER PROJECT MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] إنشاء مشروع جديد
    echo echo [2] تشغيل مشروع
    echo echo [3] بناء مشروع
    echo echo [4] تشغيل على الويب
    echo echo [5] تشغيل على Windows
    echo echo [6] إضافة حزم
    echo echo [7] تحديث الحزم
    echo echo [8] عرض الأجهزة المتاحة
    echo echo [9] فحص المشروع
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" goto :CREATE_PROJECT
    echo if "%%choice%%"=="2" goto :RUN_PROJECT
    echo if "%%choice%%"=="3" goto :BUILD_PROJECT
    echo if "%%choice%%"=="4" goto :RUN_WEB
    echo if "%%choice%%"=="5" goto :RUN_WINDOWS
    echo if "%%choice%%"=="6" goto :ADD_PACKAGES
    echo if "%%choice%%"=="7" goto :UPGRADE_PACKAGES
    echo if "%%choice%%"=="8" flutter devices
    echo if "%%choice%%"=="9" flutter analyze
    echo if "%%choice%%"=="0" exit /b
    echo pause
    echo goto MENU
    echo.
    echo :CREATE_PROJECT
    echo set /p project_name=اسم المشروع: 
    echo set /p org_name=اسم المؤسسة (com.example): 
    echo if "%%org_name%%"=="" set "org_name=com.example"
    echo flutter create --org %%org_name%% %%project_name%%
    echo echo [✓] تم إنشاء المشروع: %%project_name%%
    echo pause
    echo goto MENU
    echo.
    echo :RUN_PROJECT
    echo set /p project_name=اسم المشروع: 
    echo cd %%project_name%%
    echo flutter run
    echo cd ..
    echo pause
    echo goto MENU
    echo.
    echo :RUN_WEB
    echo set /p project_name=اسم المشروع: 
    echo cd %%project_name%%
    echo flutter run -d chrome
    echo cd ..
    echo pause
    echo goto MENU
    echo.
    echo :ADD_PACKAGES
    echo set /p project_name=اسم المشروع: 
    echo set /p package_name=اسم الحزمة: 
    echo cd %%project_name%%
    echo flutter pub add %%package_name%%
    echo cd ..
    echo echo [✓] تم إضافة الحزمة: %%package_name%%
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_flutter_manager.bat"

echo [✓] تم إنشاء مدير مشاريع Flutter!
echo [→] المسار: %USERPROFILE%\knoux_flutter_manager.bat

:: Create desktop shortcut
echo [→] جاري إنشاء اختصار سطح المكتب...
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Flutter Manager.lnk'); $Shortcut.TargetPath = '%USERPROFILE%\knoux_flutter_manager.bat'; $Shortcut.Save()"

echo [✓] تم إنشاء اختصار سطح المكتب!

:: Create sample project template
echo [→] جاري إنشاء قالب مشروع...
set "TEMPLATES_DIR=%USERPROFILE%\Knoux_Flutter_Templates"
if not exist "%TEMPLATES_DIR%" mkdir "%TEMPLATES_DIR%"

(
    echo name: knoux_app_template
    echo description: A Flutter app template by Knoux
    echo version: 1.0.0+1
    echo.
    echo environment:
    echo   sdk: '>=3.0.0 <4.0.0'
    echo.
    echo dependencies:
    echo   flutter:
    echo     sdk: flutter
    echo   cupertino_icons: ^1.0.2
    echo   http: ^1.1.0
    echo   provider: ^6.0.5
    echo.
    echo dev_dependencies:
    echo   flutter_test:
    echo     sdk: flutter
    echo   flutter_lints: ^3.0.0
    echo.
    echo flutter:
    echo   uses-material-design: true
) > "%TEMPLATES_DIR%\pubspec.yaml"

echo [✓] تم إنشاء قالب المشروع!
echo [→] المسار: %TEMPLATES_DIR%

echo [✓] Flutter SDK جاهز للاستخدام!
echo [→] Flutter SDK: C:\flutter
echo [→] للمشاريع: %USERPROFILE%\knoux_flutter_manager.bat
pause
