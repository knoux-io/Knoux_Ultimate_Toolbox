@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  ⚡ Ionic Framework - تطوير تطبيقات الهجين%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:CHECK_EXISTING
where ionic >nul 2>&1 && (
    echo %GREEN%✓ Ionic CLI مثبت مسبقًا%WHITE%
    ionic --version
    goto :GLOBAL_INSTALL
)

:GLOBAL_INSTALL
echo %YELLOW%جارٍ تثبيت Ionic CLI عالميًا...%WHITE%
npm install -g @ionic/cli >nul 2>&1

where ionic >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Ionic CLI%WHITE%

echo %YELLOW%جارٍ تثبيت أدوات Cordova (لدعم الأندرويد/iOS)...%WHITE%
npm install -g cordova >nul 2>&1

echo %YELLOW%جارٍ إنشاء مشروع Ionic تجريبي...%WHITE%
set "IONIC_PROJECT=%USERPROFILE%\ionic-demo"
if not exist "!IONIC_PROJECT!" (
    ionic start ionic-demo blank --type=angular >nul 2>&1
    if errorlevel 1 (
        npx @ionic/cli start ionic-demo blank --type=angular >nul 2>&1
    )
)

if exist "!IONIC_PROJECT!" (
    echo %GREEN%✓ تم إنشاء مشروع Ionic: !IONIC_PROJECT!%WHITE%
) else (
    echo %YELLOW%جارٍ إنشاء يدوي...%WHITE%
    mkdir "!IONIC_PROJECT!" >nul
    cd /d "!IONIC_PROJECT!" && npm init -y >nul 2>&1
    npm install @ionic/cli >nul 2>&1
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Ionic!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   CLI: %GRAY%ionic%WHITE%
echo   مشروع تجريبي: %GRAY%!IONIC_PROJECT!%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%مزايا Ionic:%WHITE%
echo   ✓ استخدام HTML/CSS/JavaScript
echo   ✓ دعم Angular, React, Vue
echo   ✓ مكونات UI جاهزة
echo   ✓ نشر عبر الإنترنت (Ionic Pro)
echo.
echo %CYAN%الخطوات التالية:%WHITE%
echo   1. cd "!IONIC_PROJECT!"
echo   2. ionic serve ← لتشغيل على الويب
echo   3. ionic capacitor add android ← لإضافة دعم الأندرويد
echo   4. ionic capacitor run android ← لتشغيل على جهاز الأندرويد
echo.
echo %YELLOW%ملاحظات:%WHITE%
echo   • يتطلب Android SDK لتطوير الأندرويد
echo   • لتطوير iOS: يتطلب جهاز Mac
echo   • Cordova/Capacitor لربط مع وظائف الجهاز

:: تعديل package.json لدعم العربية
if exist "!IONIC_PROJECT!\package.json" (
    powershell -Command "(Get-Content '!IONIC_PROJECT!\package.json' -Raw) -replace '\"scripts\": {', '\"scripts\": {\n    \"ionic:serve\": \"ionic serve\",\n    \"ionic:build\": \"ionic build\",\n    \"ionic:cap\": \"ionic capacitor run android\",'," | Set-Content '!IONIC_PROJECT!\package.json'" >nul 2>&1
)

echo %GREEN%✓ تم تعديل scripts في package.json%WHITE%

:: إنشاء صفحة عربية تجريبية
if exist "!IONIC_PROJECT!\src\app" (
    (
    echo import { Component } from '@angular/core';
    echo 
    echo @Component({
    echo   selector: 'app-home',
    echo   templateUrl: 'home.page.html',
    echo   styleUrls: ['home.page.scss'],
    echo })
    echo export class HomePage {
    echo   constructor() {}
    echo 
    echo   arabicMessage = 'مرحباً بك في Ionic!';
    echo   framework = 'Ionic Framework';
    echo }
    ) > "!IONIC_PROJECT!\src\app\home\home.page.ts"
    
    (
    echo ^<ion-header [translucent]="true"^>
    echo   ^<ion-toolbar^>
    echo     ^<ion-title^>
    echo       Ionic - تطوير تطبيقات الهجين
    echo     ^</ion-title^>
    echo   ^</ion-toolbar^>
    echo ^</ion-header^>
    echo 
    echo ^<ion-content [fullscreen]="true"^>
    echo   ^<ion-header collapse="condense"^>
    echo     ^<ion-toolbar^>
    echo       ^<ion-title size="large"^>{{ framework }}^</ion-title^>
    echo     ^</ion-toolbar^>
    echo   ^</ion-header^>
    echo 
    echo   ^<div class="container" text-center^>
    echo     ^<h2^>{{ arabicMessage }}^</h2^>
    echo     ^<p^>تم الإنشاء باستخدام Ionic CLI^</p^>
    echo     ^<ion-button color="primary" fill="solid"^>ابدأ^</ion-button^>
    echo   ^</div^>
    echo ^</ion-content^>
    ) > "!IONIC_PROJECT!\src\app\home\home.page.html"
)

echo %GREEN%✓ تم إنشاء مكون تجريبي باللغة العربية%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Ionic Framework with demo project >> "!LOG_FILE!"

timeout /t 8 >nul
