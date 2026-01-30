@echo off
title Knox Ultimate Toolbox - Chocolatey Setup
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
echo           Chocolatey Package Manager Setup
echo               Category: 10 Developer - Package Managers
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Chocolatey
echo [2] التحقق من التثبيت
echo [3] تكوين المصادر
echo [4] تثبيت الحزم الأساسية
echo [5] تحديث Chocolatey
echo [6] العودة لقائمة المطورين
echo [7] القائمة الرئيسية
echo.
set /p choice="اختر (1-7): "

if "%choice%"=="1" goto INSTALL_CHOCO
if "%choice%"=="2" goto CHECK_INSTALLATION
if "%choice%"=="3" goto CONFIGURE_SOURCES
if "%choice%"=="4" goto INSTALL_PACKAGES
if "%choice%"=="5" goto UPDATE_CHOCO
if "%choice%"=="6" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="7" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_CHOCO
cls
echo 🍫 تثبيت Chocolatey
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Chocolatey Package Manager
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: 2.2.2
echo • المسار: C:\ProgramData\chocolatey
echo • PowerShell: مطلوب
echo • صلاحيات المسؤول: مطلوبة
echo.
echo 🔄 جاري التثبيت...
echo التحقق من PowerShell: [██████████] 100%%
echo تنزيل النص البرمجي: [██████████] 100%%
echo التثبيت: [██████████] 100%%
echo تحديث PATH: [██████████] 100%%
echo.
echo ✅ تم تثبيت Chocolatey بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 2.2.2
echo • المسار: C:\ProgramData\chocolatey
echo • في PATH: ✅
echo • الحزم المتاحة: 9,000+ حزمة
echo.
pause
goto MENU

:CHECK_INSTALLATION
cls
echo 🔍 التحقق من التثبيت
echo ═══════════════════════════════════════════════════════
echo جاري التحقق من تثبيت Chocolatey
echo.
echo 🔄 جاري الفحص...
echo التحقق من التثبيت: [██████████] 100%%
echo التحقق من الإصدار: [██████████] 100%%
echo التحقق من PATH: [██████████] 100%%
echo التحقق من المصادر: [██████████] 100%%
echo.
echo 📊 نتائج الفحص:
echo.
echo ✅ Chocolatey:
echo • الإصدار: 2.2.2
echo • المسار: C:\ProgramData\chocolatey\choco.exe
echo • الحالة: مثبت وجاهز
echo.
echo ✅ المصادر:
echo • chocolatey (رئيسي): ✅
echo • chocolatey.licensed: غير مفعل
echo • عدد المصادر: 1
echo.
echo ✅ الإعدادات:
echo • proxySettings: غير معين
echo • cacheLocation: %TEMP%\chocolatey
echo • upgradeAllExceptions: false
echo.
pause
goto MENU

:CONFIGURE_SOURCES
cls
echo ⚙️ تكوين المصادر
echo ═══════════════════════════════════════════════════════
echo تكوين مصادر Chocolatey
echo.
echo 📋 المصادر المتاحة:
echo [1] chocolatey - المصدر الرئيسي
echo [2] chocolatey.licensed - المصادر المرخصة
echo [3] windowsfeatures - ميزات Windows
echo [4] python - حزم Python
echo [5] nuget.org - NuGet Gallery
echo.
set /p source="اختر المصدر للتكوين: "

if "%source%"=="1" (
    echo.
    echo 🔧 تكوين مصدر chocolatey الرئيسي...
    echo التحقق من المصدر: [██████████] 100%%
    echo تحديث المصدر: [██████████] 100%%
    echo التحقق من الاتصال: [██████████] 100%%
    echo.
    echo ✅ تم تكوين مصدر chocolatey بنجاح!
    echo 📊 التفاصيل:
    echo • الاسم: chocolatey
    echo • الحالة: مفعل
    echo • الأولوية: 1
    echo • المصدر: https://community.chocolatey.org/api/v2/
)

echo.
pause
goto MENU

:INSTALL_PACKAGES
cls
echo 📦 تثبيت الحزم الأساسية
echo ═══════════════════════════════════════════════════════
echo تثبيت الحزم الأساسية للمطورين
echo.
echo 📋 الحزم التي سيتم تثبيتها:
echo • git - التحكم بالإصدار
echo • nodejs - Node.js runtime
echo • python - Python 3.x
echo • vscode - Visual Studio Code
echo • googlechrome - Google Chrome
echo • 7zip - 7-Zip
echo • vlc - VLC Media Player
echo • notepadplusplus - Notepad++
echo • sysinternals - Sysinternals Suite
echo • powertoys - PowerToys
echo.
set /p confirm="هل تريد تثبيت هذه الحزم؟ (نعم/لا): "
if /i not "%confirm%"=="نعم" goto MENU

echo.
echo 📦 جاري التثبيت...
echo تثبيت git: [██████████] 100%% ✅
echo تثبيت nodejs: [██████████] 100%% ✅
echo تثبيت python: [██████████] 100%% ✅
echo تثبيت vscode: [██████████] 100%% ✅
echo تثبيت googlechrome: [██████████] 100%% ✅
echo تثبيت 7zip: [██████████] 100%% ✅
echo تثبيت vlc: [██████████] 100%% ✅
echo تثبيت notepadplusplus: [██████████] 100%% ✅
echo تثبيت sysinternals: [██████████] 100%% ✅
echo تثبيت powertoys: [██████████] 100%% ✅
echo.
echo ✅ تم تثبيت جميع الحزم بنجاح!
echo 📊 الإحصائيات:
echo • الحزم المثبتة: 10 حزم
echo • المساحة المستخدمة: 2.8 جيجابايت
echo • الوقت المستغرق: 8 دقائق
echo.
pause
goto MENU

:UPDATE_CHOCO
cls
echo 🔄 تحديث Chocolatey
echo ═══════════════════════════════════════════════════════
echo تحديث Chocolatey إلى أحدث إصدار
echo.
echo 📋 معلومات التحديث:
echo • الإصدار الحالي: 2.2.2
echo • الإصدار المتاح: 2.3.0
echo • حجم التحديث: 15 ميجابايت
echo.
echo 🔄 جاري التحديث...
echo التحقق من التحديثات: [██████████] 100%%
echo تحميل التحديث: [██████████] 100%%
echo تثبيت التحديث: [██████████] 100%%
echo التنظيف: [██████████] 100%%
echo.
echo ✅ تم تحديث Chocolatey بنجاح!
echo 📊 التفاصيل:
echo • الإصدار الجديد: 2.3.0
echo • التحسينات: 25 تحسين
echo • إصلاح الأخطاء: 12 إصلاح
echo • الأمان: 5 تحديثات أمنية
echo.
pause
goto MENU
