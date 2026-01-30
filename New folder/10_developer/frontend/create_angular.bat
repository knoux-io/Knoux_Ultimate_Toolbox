@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🔴  إنشاء مشروع Angular مع CLI%WHITE%
echo %RED%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:: التحقق من Angular CLI
where ng >nul 2>&1 || (
    echo %YELLOW%جارٍ تثبيت Angular CLI...%WHITE%
    npm install -g @angular/cli >nul 2>&1
    if errorlevel 1 (
        echo %RED%✗ فشل تثبيت Angular CLI%WHITE%
        exit /b 1
    )
)

:INPUT
set /p "PROJECT_NAME=اسم المشروع: "
if "!PROJECT_NAME!"=="" goto :INPUT

set /p "USE_ROUTING= Routing؟ (y/n): "
set /p "STYLE= نوع CSS: [1] CSS [2] SCSS [3] SASS [4] LESS: "

:: تحويل رقم إلى نوع CSS
if "!STYLE!"=="1" set "STYLE_TYPE=css"
if "!STYLE!"=="2" set "STYLE_TYPE=scss"
if "!STYLE!"=="3" set "STYLE_TYPE=sass"
if "!STYLE!"=="4" set "STYLE_TYPE=less"

set "ROUTING_FLAG="
if /i "!USE_ROUTING!"=="y" set "ROUTING_FLAG=--routing"

echo %YELLOW%جارٍ إنشاء مشروع Angular...%WHITE%

ng new "!PROJECT_NAME!" --style=!STYLE_TYPE! !ROUTING_FLAG! --strict --standalone=false --routing >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل إنشاء المشروع%WHITE%
    exit /b 1
)

cd /d "%USERPROFILE%\!PROJECT_NAME!"

:: تعديل الإعدادات للغة العربية
(
echo {
echo   "name": "!PROJECT_NAME!",
echo   "version": "0.0.0",
echo   "scripts": {
echo     "ng": "ng",
echo     "start": "ng serve",
echo     "build": "ng build",
echo     "watch": "ng build --watch --configuration development",
echo     "test": "ng test"
echo   },
echo   "private": true,
echo   "dependencies": {
echo     "@angular/animations": "^17.0.0",
echo     "@angular/common": "^17.0.0",
echo     "@angular/compiler": "^17.0.0",
echo     "@angular/core": "^17.0.0",
echo     "@angular/forms": "^17.0.0",
echo     "@angular/platform-browser": "^17.0.0",
echo     "@angular/platform-browser-dynamic": "^17.0.0",
echo     "@angular/router": "^17.0.0",
echo     "rxjs": "~7.8.0",
echo     "tslib": "^2.3.0",
echo     "zone.js": "~0.14.0"
echo   },
echo   "devDependencies": {
echo     "@angular-devkit/build-angular": "^17.0.0",
echo     "@angular/cli": "^17.0.0",
echo     "@angular/compiler-cli": "^17.0.0",
echo     "@types/jasmine": "~5.1.0",
echo     "jasmine-core": "~5.1.0",
echo     "karma": "~6.4.0",
echo     "karma-chrome-launcher": "~3.2.0",
echo     "karma-coverage": "~2.2.0",
echo     "karma-jasmine": "~5.1.0",
echo     "karma-jasmine-html-reporter": "~2.1.0",
echo     "typescript": "~5.2.0"
echo   }
echo }
) > package.json

:: إنشاء مكون رئيسي بالعربية
(
echo import { Component } from '@angular/core';
echo import { RouterOutlet } from '@angular/router';
echo 
echo @Component({
echo   selector: 'app-root',
echo   standalone: true,
echo   imports: [RouterOutlet],
echo   template: `
echo     ^<div class="container"^>
echo       ^<header^>
echo         ^<h1^>{{ title }}^</h1^>
echo       ^</header^>
echo       ^<main^>
echo         ^<router-outlet/^>
echo       ^</main^>
echo       ^<footer^>
echo         ^<p^>© 2024 - {{ title }}^</p^>
echo       ^</footer^>
echo     ^</div^>
echo   `,
echo   styles: [`
echo     body {
echo       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
echo       margin: 0;
echo       padding: 0;
echo       direction: rtl;
echo     }
echo     .container {
echo       max-width: 1200px;
echo       margin: 0 auto;
echo       padding: 20px;
echo     }
echo     header {
echo       background-color: #b30000;
echo       color: white;
echo       padding: 1rem;
echo       text-align: center;
echo     }
echo     footer {
echo       background-color: #333;
echo       color: white;
echo       padding: 1rem;
echo       text-align: center;
echo       margin-top: 2rem;
echo     }
echo   `]
echo })
echo export class AppComponent {
echo   title = 'Angular مشروع';
echo }
) > src\app\app.component.ts

(
echo import { NgModule } from '@angular/core';
echo import { BrowserModule } from '@angular/platform-browser';
echo 
echo import { AppRoutingModule } from './app-routing.module';
echo import { AppComponent } from './app.component';
echo 
echo @NgModule({
echo   declarations: [
echo     AppComponent
echo   ],
echo   imports: [
echo     BrowserModule,
echo     AppRoutingModule
echo   ],
echo   providers: [],
echo   bootstrap: [AppComponent]
echo })
echo export class AppModule { }
) > src\app\app.module.ts

(
echo import { NgModule } from '@angular/core';
echo import { RouterModule, Routes } from '@angular/router';
echo 
echo const routes: Routes = [];
echo 
echo @NgModule({
echo   imports: [RouterModule.forRoot(routes)],
echo   exports: [RouterModule]
echo })
echo export class AppRoutingModule { }
) > src\app\app-routing.module.ts

:: تعديل angular.json للدعم العربي
powershell -Command "(Get-Content 'angular.json' -Raw) -replace '\"outputPath\": \"dist/.*', '\"outputPath\": \"dist/!PROJECT_NAME!\", \"baseHref\": \"/\", \"deployUrl\": \"/\"' | Set-Content 'angular.json'" >nul 2>&1

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم إنشاء مشروع Angular بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المسار: %GRAY%%USERPROFILE%\!PROJECT_NAME!%WHITE%
echo   التشغيل: %GRAY%cd "%USERPROFILE%\!PROJECT_NAME!" && ng serve%WHITE%
echo   المتصفح: %CYAN%http://localhost:4200%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%الميزات:%WHITE%
echo   • Angular CLI مع جميع الأدوات
echo   • TypeScript مدمج
echo   • Angular Router (إذا تم اختياره)
echo   • أنماط CSS حسب الاختيار
echo   • اختبارات Jasmine/Karma جاهزة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Created Angular project "!PROJECT_NAME!" with CLI and routing >> "!LOG_FILE!"

timeout /t 8 >nul
