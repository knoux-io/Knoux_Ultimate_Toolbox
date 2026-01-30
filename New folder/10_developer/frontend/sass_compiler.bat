@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  💎  Sass/SCSS - مترجم CSS المتقدم%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] تثبيت Sass عالميًا
echo   [2] إنشاء مشروع Sass جديد
echo   [3] تثبيت في مشروع React
echo   [4] تثبيت في مشروع Angular
echo   [5] تثبيت في مشروع Vue.js
echo   [6] تهيئة Watch Mode تلقائي
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :INSTALL_GLOBAL
if "!CHOICE!"=="2" goto :NEW_PROJECT
if "!CHOICE!"=="3" goto :REACT_PROJECT
if "!CHOICE!"=="4" goto :ANGULAR_PROJECT
if "!CHOICE!"=="5" goto :VUE_PROJECT
if "!CHOICE!"=="6" goto :WATCH_MODE
goto :MENU

:INSTALL_GLOBAL
echo %YELLOW%جارٍ تثبيت Sass عالميًا...%WHITE%
npm install -g sass >nul 2>&1

where sass >nul 2>&1 && (
    echo %GREEN%✓ تم تثبيت Sass بنجاح%WHITE%
    sass --version
) || (
    echo %RED%✗ فشل التثبيت%WHITE%
)
goto :MENU

:NEW_PROJECT
set /p "PROJECT_NAME=اسم المشروع: "
mkdir "%USERPROFILE%\!PROJECT_NAME!" >nul 2>&1
cd /d "%USERPROFILE%\!PROJECT_NAME!"

:: إنشاء هيكل المشروع
mkdir src scss dist >nul 2>&1

(
echo {
echo   "name": "!PROJECT_NAME!",
echo   "version": "1.0.0",
echo   "scripts": {
echo     "sass": "sass --watch scss:dist",
echo     "sass:build": "sass scss:dist --no-source-map",
echo     "sass:watch": "sass --watch scss:dist --poll"
echo   },
echo   "devDependencies": {
echo     "sass": "^1.69.0"
echo   }
echo }
) > package.json

npm install >nul 2>&1

:: إنشاء ملفات Sass تجريبية
(
echo // scss/_variables.scss
echo $primary-color: #3498db;
echo $secondary-color: #2ecc71;
echo $font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
echo $font-size-base: 16px;
) > scss\_variables.scss

(
echo // scss/_mixins.scss
echo @mixin button-style($bg-color) {
echo   background-color: $bg-color;
echo   border: none;
echo   padding: 10px 20px;
echo   border-radius: 5px;
echo   cursor: pointer;
echo   transition: all 0.3s ease;
echo 
echo   &:hover {
echo     opacity: 0.8;
echo     transform: translateY(-2px);
echo   }
echo }
) > scss\_mixins.scss

(
echo // scss/main.scss
echo @import 'variables';
echo @import 'mixins';
echo 
echo body {
echo   font-family: $font-family;
echo   font-size: $font-size-base;
echo   margin: 0;
echo   padding: 20px;
echo   direction: rtl;
echo }
echo 
echo .container {
echo   max-width: 1200px;
echo   margin: 0 auto;
echo   padding: 20px;
echo }
echo 
echo .btn-primary {
echo   @include button-style($primary-color);
echo   color: white;
echo }
echo 
echo .btn-success {
echo   @include button-style($secondary-color);
echo   color: white;
echo }
) > scss\main.scss

echo %GREEN%✓ تم إنشاء مشروع Sass جديد%WHITE%
echo %YELLOW%التشغيل:%WHITE% cd "%USERPROFILE%\!PROJECT_NAME!" && npm run sass
goto :MENU

:REACT_PROJECT
echo %YELLOW%جارٍ تثبيت Sass في مشروع React...%WHITE%
set /p "PROJECT_PATH=مسار مشروع React: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المشروع غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
npm install sass >nul 2>&1

:: تغيير امتداد الملفات من .css إلى .scss
for %%f in (src\App.css src\index.css) do (
    if exist "%%f" (
        ren "%%f" "%%~nf.scss"
    )
)

echo %GREEN%✓ تم تثبيت Sass في مشروع React%WHITE%
echo %YELLOW%ملاحظة:%WHITE% غير امتداد الملفات من .css إلى .scss في الاستدعاءات
goto :MENU

:ANGULAR_PROJECT
echo %YELLOW%جارٍ تثبيت Sass في مشروع Angular...%WHITE%
set /p "PROJECT_PATH=مسار مشروع Angular: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المشروع غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
ng config projects.!PROJECT_NAME!.architect.build.options.stylePreprocessorOptions.includePaths "['src/styles']" >nul 2>&1

:: تعديل angular.json لاستخدام SCSS
powershell -Command "(Get-Content 'angular.json' -Raw) -replace '\"inlineStyleLanguage\": \"css\"', '\"inlineStyleLanguage\": \"scss\"' | Set-Content 'angular.json'" >nul 2>&1

echo %GREEN%✓ تم تهيئة Sass في مشروع Angular%WHITE%
goto :MENU

:VUE_PROJECT
echo %YELLOW%جارٍ تثبيت Sass في مشروع Vue.js...%WHITE%
set /p "PROJECT_PATH=مسار مشروع Vue.js: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المشروع غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
npm install -D sass >nul 2>&1

:: تعديل المكونات لاستخدام SCSS
powershell -Command "(Get-Content 'src/App.vue' -Raw) -replace 'lang=\"css\"', 'lang=\"scss\"' | Set-Content 'src/App.vue'" >nul 2>&1

echo %GREEN%✓ تم تثبيت Sass في مشروع Vue.js%WHITE%
goto :MENU

:WATCH_MODE
echo %YELLOW%جارٍ إنشاء نص برمجي لـ Watch Mode...%WHITE%

(
echo @echo off
echo setlocal
echo echo Starting Sass Watch Mode...
echo echo Watching scss folder for changes...
echo sass --watch scss:dist --poll
) > watch-sass.bat

echo %GREEN%✓ تم إنشاء watch-sass.bat%WHITE%
echo %YELLOW%الاستخدام:%WHITE% double-click على watch-sass.bat أو من cmd: .\watch-sass.bat
goto :MENU
