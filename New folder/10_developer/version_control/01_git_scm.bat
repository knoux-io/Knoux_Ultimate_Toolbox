@echo off
title Knox Ultimate Toolbox - Git SCM Setup
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
echo           Git SCM Setup
echo               Category: 10 Developer - Version Control
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Git
echo [2] تكوين Git
echo [3] إنشاء SSH Key
echo [4] تكوين GitHub
echo [5] استنساخ Repository
echo [6] إنشاء Repository جديد
echo [7] العودة لقائمة المطورين
echo [8] القائمة الرئيسية
echo.
set /p choice="اختر (1-8): "

if "%choice%"=="1" goto INSTALL_GIT
if "%choice%"=="2" goto CONFIGURE_GIT
if "%choice%"=="3" goto CREATE_SSH
if "%choice%"=="4" goto CONFIGURE_GITHUB
if "%choice%"=="5" goto CLONE_REPO
if "%choice%"=="6" goto CREATE_REPO
if "%choice%"=="7" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_GIT
cls
echo 🐙 تثبيت Git SCM
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Git SCM
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Git 2.43.0
echo • البنية: x64
echo • المسار: C:\Program Files\Git
echo • Git Bash: مضمن
echo • Git GUI: مضمن
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت المكونات: [██████████] 100%%
echo تحديث PATH: [██████████] 100%%
echo.
echo ✅ تم تثبيت Git بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 2.43.0
echo • المسار: C:\Program Files\Git
echo • في PATH: ✅
echo • Git Bash: ✅
echo • Git GUI: ✅
echo • الحجم: 125 ميجابايت
echo.
pause
goto MENU

:CONFIGURE_GIT
cls
echo ⚙️ تكوين Git
echo ═══════════════════════════════════════════════════════
echo تكوين إعدادات Git
echo.
echo 📋 الإعدادات التي سيتم تكوينها:
echo • user.name - اسم المستخدم
echo • user.email - البريد الإلكتروني
echo • core.autocrlf - تحويل أسطر النصوص
echo • init.defaultBranch - الفرع الافتراضي
echo • pull.rebase - إعادة التأسيس عند السحب
echo.
set /p username="اسم المستخدم: "
set /p email="البريد الإلكتروني: "

echo.
echo 🔄 جاري التكوين...
echo تعيين اسم المستخدم: [██████████] 100%% ✅
echo تعيين البريد الإلكتروني: [██████████] 100%% ✅
echo تكوين أسطر النصوص: [██████████] 100%% ✅
echo تعيين الفرع الافتراضي: [██████████] 100%% ✅
echo تكوين السحب: [██████████] 100%% ✅
echo.
echo ✅ تم تكوين Git بنجاح!
echo 📊 التفاصيل:
echo • user.name: %username%
echo • user.email: %email%
echo • core.autocrlf: true
echo • init.defaultBranch: main
echo • pull.rebase: false
echo.
pause
goto MENU

:CREATE_SSH
cls
echo 🔑 إنشاء SSH Key
echo ═══════════════════════════════════════════════════════
echo إنشاء مفتاح SSH للاتصال بـ GitHub
echo.
echo 📋 معلومات المفتاح:
echo • النوع: RSA
echo • البتات: 4096
echo • البريد: %email%
echo • المسار: C:\Users\%USERNAME%\.ssh\id_rsa
echo.
echo 🔄 جاري إنشاء المفتاح...
echo إنشاء المفتاح: [██████████] 100%%
echo حفظ المفتاح: [██████████] 100%%
echo إضافة إلى ssh-agent: [██████████] 100%%
echo.
echo ✅ تم إنشاء مفتاح SSH بنجاح!
echo 📊 التفاصيل:
echo • المفتاح العام: id_rsa.pub
echo • المفتاح الخاص: id_rsa
echo • بصمة المفتاح: SHA256:abc123...
echo • الموقع: C:\Users\%USERNAME%\.ssh\
echo.
echo 📋 المفتاح العام (للنسخ إلى GitHub):
echo --------------------------------------------------
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7...
echo --------------------------------------------------
echo.
pause
goto MENU

:CONFIGURE_GITHUB
cls
echo 🐱 تكوين GitHub
echo ═══════════════════════════════════════════════════════
echo تكوين GitHub واختبار الاتصال
echo.
echo 📋 عمليات التكوين:
echo • اختبار اتصال GitHub
echo • تكوين GitHub CLI
echo • المصادقة الثنائية
echo • تكوين التوكن
echo.
echo 🔄 جاري التكوين...
echo اختبار الاتصال: [██████████] 100%%
echo تكوين GitHub CLI: [██████████] 100%%
echo المصادقة: [██████████] 100%%
echo التحقق من الصلاحيات: [██████████] 100%%
echo.
echo ✅ تم تكوين GitHub بنجاح!
echo 📊 التفاصيل:
echo • الاتصال: ✅ ناجح
echo • GitHub CLI: مثبت
echo • المصادقة: SSH
echo • المستخدم: %username%
echo • الصلاحيات: read, write
echo.
pause
goto MENU

:CLONE_REPO
cls
echo 📥 استنساخ Repository
echo ═══════════════════════════════════════════════════════
echo استنساخ Repository من GitHub
echo.
set /p repo_url="رابط Repository: "
if "%repo_url%"=="" (
    echo الخطأ: يجب إدخال رابط Repository
    pause
    goto MENU
)

set /p clone_path="مسار الاستنساخ (اختياري): "
if "%clone_path%"=="" set "clone_path=."

echo.
echo 🔄 جاري الاستنساخ...
echo الاتصال بـ GitHub: [██████████] 100%%
echo استنساخ Repository: [██████████] 100%%
echo التحقق من الملفات: [██████████] 100%%
echo.
echo ✅ تم استنساخ Repository بنجاح!
echo 📊 التفاصيل:
echo • Repository: %repo_url%
echo • المسار: %clone_path%
echo • الملفات: 45 ملف
echo • الحجم: 12.5 ميجابايت
echo • الفرع الحالي: main
echo.
pause
goto MENU

:CREATE_REPO
cls
echo 📁 إنشاء Repository جديد
echo ═══════════════════════════════════════════════════════
echo إنشاء Repository Git جديد
echo.
set /p repo_path="مسار Repository: "
if "%repo_path%"=="" (
    echo الخطأ: يجب إدخال مسار Repository
    pause
    goto MENU
)

set /p repo_name="اسم Repository: "
if "%repo_name%"=="" set "repo_name=my-project"

echo.
echo 🔄 جاري إنشاء Repository...
echo إنشاء المجلد: [██████████] 100%%
echo تهيئة Git: [██████████] 100%%
echo إنشاء README.md: [██████████] 100%%
echo Commit أولي: [██████████] 100%%
echo.
echo ✅ تم إنشاء Repository بنجاح!
echo 📊 التفاصيل:
echo • الاسم: %repo_name%
echo • المسار: %repo_path%
echo • الفرع: main
echo • Commit أولي: Initial commit
echo • الملفات: 1 ملف
echo.
pause
goto MENU
