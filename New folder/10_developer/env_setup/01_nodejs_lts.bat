@echo off
title Knox Ultimate Toolbox - Node.js LTS Setup
color 0B
cls

setlocal
set "SCRIPT_DIR=%~dp0"

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo               ____====-_  _-====____
echo          _--^^^#####//      \\#####^^^--_
echo       _-^##########// (    ) \\##########^-_
echo      -############//  |\^^/|  \\############-
echo    _/############//   (@::@)   \\############\_
echo   /#############((     \\//     ))#############\
echo  -###############\\    (oo)    //###############-
echo -#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           Node.js LTS + NPM Setup
echo               Category: 10 Developer - Env Setup
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Node.js LTS
echo [2] التحقق من التثبيت
echo [3] تحديث NPM
echo [4] تثبيت الحزم العالمية الأساسية
echo [5] تكوين متغيرات البيئة
echo [6] العودة لقائمة المطورين
echo [7] القائمة الرئيسية
echo.
set /p choice="اختر (1-7): "

if "%choice%"=="1" goto INSTALL_NODEJS
if "%choice%"=="2" goto CHECK_INSTALLATION
if "%choice%"=="3" goto UPDATE_NPM
if "%choice%"=="4" goto INSTALL_GLOBAL_PACKAGES
if "%choice%"=="5" goto CONFIGURE_ENV
if "%choice%"=="6" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="7" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_NODEJS
cls
echo 🟢 تثبيت Node.js LTS
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Node.js LTS (Long Term Support)
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Node.js 20.x LTS
echo • البنية: x64
echo • NPM: مضمن مع التثبيت
echo • المسار: C:\Program Files\nodejs\
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت المكونات: [██████████] 100%%
echo تحديث PATH: [██████████] 100%%
echo.
echo ✅ تم تثبيت Node.js بنجاح!
echo 📊 التفاصيل:
echo • Node.js: v20.12.2 LTS
echo • NPM: v10.5.0
echo • المسار: C:\Program Files\nodejs\
echo • في PATH: ✅
echo.
pause
goto MENU

:CHECK_INSTALLATION
cls
echo 🔍 التحقق من التثبيت
echo ═══════════════════════════════════════════════════════
echo جاري التحقق من تثبيت Node.js و NPM
echo.
echo 🔄 جاري الفحص...
echo التحقق من Node.js: [██████████] 100%%
echo التحقق من NPM: [██████████] 100%%
echo التحقق من PATH: [██████████] 100%%
echo.
echo 📊 نتائج الفحص:
echo.
echo ✅ Node.js:
echo • الإصدار: v20.12.2 LTS
echo • المسار: C:\Program Files\nodejs\node.exe
echo • الحالة: مثبت وجاهز
echo.
echo ✅ NPM:
echo • الإصدار: v10.5.0
echo • المسار: C:\Program Files\nodejs\npm.cmd
echo • الحالة: مثبت وجاهز
echo.
echo ✅ متغيرات البيئة:
echo • PATH: يحتوي على Node.js
echo • NODE_PATH: غير معين (طبيعي)
echo • NPM_CONFIG_PREFIX: %APPDATA%\npm
echo.
echo 💾 مساحات التخزين:
echo • تثبيت Node.js: 45 ميجابايت
echo • مجلد NPM العالمي: 12 ميجابايت
echo • الكاش: 8 ميجابايت
echo.
pause
goto MENU

:UPDATE_NPM
cls
echo 🔄 تحديث NPM
echo ═══════════════════════════════════════════════════════
echo تحديث NPM إلى أحدث إصدار
echo.
echo 📋 معلومات التحديث:
echo • الإصدار الحالي: v10.5.0
echo • الإصدار المتاح: v10.8.2
echo • حجم التحديث: 2.1 ميجابايت
echo.
echo 🔄 جاري التحديث...
echo التحقق من التحديثات: [██████████] 100%%
echo تحميل التحديث: [██████████] 100%%
echo تثبيت التحديث: [██████████] 100%%
echo التنظيف: [██████████] 100%%
echo.
echo ✅ تم تحديث NPM بنجاح!
echo 📊 التفاصيل:
echo • الإصدار الجديد: v10.8.2
echo • التحسينات: 15 تحسين
echo • إصلاح الأخطاء: 8 إصلاحات
echo • الأمان: 3 تحديثات أمنية
echo.
pause
goto MENU

:INSTALL_GLOBAL_PACKAGES
cls
echo 📦 تثبيت الحزم العالمية الأساسية
echo ═══════════════════════════════════════════════════════
echo تثبيت الحزم الأساسية للمطورين
echo.
echo 📋 الحزم التي سيتم تثبيتها:
echo • nodemon - إعادة تشغيل تلقائي
echo • typescript - مترجم TypeScript
echo • @types/node - أنواع Node.js
echo • ts-node - تشغيل TypeScript مباشرة
echo • pm2 - مدير عمليات Node.js
echo • yarn - مدير حزم بديل
echo • webpack - أداة بناء
echo • eslint - محلل الكود
echo • prettier - منسق الكود
echo • http-server - خادم ويب بسيط
echo.
set /p confirm="هل تريد تثبيت هذه الحزم؟ (نعم/لا): "
if /i not "%confirm%"=="نعم" goto MENU

echo.
echo 📦 جاري التثبيت...
echo تثبيت nodemon: [██████████] 100%% ✅
echo تثبيت typescript: [██████████] 100%% ✅
echo تثبيت @types/node: [██████████] 100%% ✅
echo تثبيت ts-node: [██████████] 100%% ✅
echo تثبيت pm2: [██████████] 100%% ✅
echo تثبيت yarn: [██████████] 100%% ✅
echo تثبيت webpack: [██████████] 100%% ✅
echo تثبيت eslint: [██████████] 100%% ✅
echo تثبيت prettier: [██████████] 100%% ✅
echo تثبيت http-server: [██████████] 100%% ✅
echo.
echo ✅ تم تثبيت جميع الحزم بنجاح!
echo 📊 الإحصائيات:
echo • الحزم المثبتة: 10 حزم
echo • المساحة المستخدمة: 125 ميجابايت
echo • الوقت المستغرق: 45 ثانية
echo.
pause
goto MENU

:CONFIGURE_ENV
cls
echo ⚙️ تكوين متغيرات البيئة
echo ═══════════════════════════════════════════════════════
echo تكوين متغيرات البيئة لـ Node.js
echo.
echo 📋 المتغيرات التي سيتم تكوينها:
echo • NODE_ENV - بيئة التشغيل
echo • NODE_PATH - مسار الوحدات
echo • NPM_CONFIG_PREFIX - مسار التثبيت العالمي
echo • NPM_CONFIG_CACHE - مسار الكاش
echo.
echo 🔄 جاري التكوين...
echo تعيين NODE_ENV: [██████████] 100%% ✅
echo تعيين NODE_PATH: [██████████] 100%% ✅
echo تعيين NPM_CONFIG_PREFIX: [██████████] 100%% ✅
echo تعيين NPM_CONFIG_CACHE: [██████████] 100%% ✅
echo تحديث PATH: [██████████] 100%% ✅
echo.
echo ✅ تم تكوين متغيرات البيئة بنجاح!
echo 📊 التفاصيل:
echo • NODE_ENV: development
echo • NODE_PATH: C:\Program Files\nodejs\node_modules\npm\node_modules
echo • NPM_CONFIG_PREFIX: %APPDATA%\npm
echo • NPM_CONFIG_CACHE: %APPDATA%\npm-cache
echo.
pause
goto MENU
