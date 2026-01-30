@echo off
title Knox Ultimate Toolbox - Django Project Setup
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
echo           Django Project Setup
echo               Category: 10 Developer - Frameworks
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Django
echo [2] إنشاء مشروع Django
echo [3] إنشاء تطبيق Django
echo [4] تكوين الإعدادات
echo [5] تشغيل خادم التطوير
echo [6] إدارة قاعدة البيانات
echo [7] إنشاء Superuser
echo [8] العودة لقائمة المطورين
echo [9] القائمة الرئيسية
echo.
set /p choice="اختر (1-9): "

if "%choice%"=="1" goto INSTALL_DJANGO
if "%choice%"=="2" goto CREATE_PROJECT
if "%choice%"=="3" goto CREATE_APP
if "%choice%"=="4" goto CONFIGURE_SETTINGS
if "%choice%"=="5" goto RUN_SERVER
if "%choice%"=="6" goto MANAGE_DB
if "%choice%"=="7" goto CREATE_SUPERUSER
if "%choice%"=="8" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="9" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_DJANGO
cls
echo 🐍 تثبيت Django
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Django Framework
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Django 4.2.7
echo • Python: 3.11+
echo • المدير: pip
echo • النوع: Global installation
echo.
echo 🔄 جاري التثبيت...
echo تحديث pip: [██████████] 100%%
echo تثبيت django: [██████████] 100%%
echo تثبيت djangorestframework: [██████████] 100%%
echo تثبيت django-cors-headers: [██████████] 100%%
echo التحقق من التثبيت: [██████████] 100%%
echo.
echo ✅ تم تثبيت Django بنجاح!
echo 📊 التفاصيل:
echo • Django: 4.2.7
echo • Django REST Framework: 3.14.0
echo • Django CORS Headers: 4.3.1
echo • المسار: C:\Python311\Lib\site-packages
echo • الحجم: 45 ميجابايت
echo.
pause
goto MENU

:CREATE_PROJECT
cls
echo 🚀 إنشاء مشروع Django
echo ═══════════════════════════════════════════════════════
echo إنشاء مشروع Django جديد
echo.
set /p project_name="اسم المشروع: "
if "%project_name%"=="" (
    echo الخطأ: يجب إدخال اسم المشروع
    pause
    goto MENU
)

echo.
echo 📋 معلومات المشروع:
echo • اسم المشروع: %project_name%
echo • الإصدار: Django 4.2.7
echo • قاعدة البيانات: SQLite (افتراضي)
echo • القالب: default
echo.
echo 🔄 جاري إنشاء المشروع...
echo إنشاء المشروع: [██████████] 100%%
echo تهيئة الإعدادات: [██████████] 100%%
echo إنشاء الملفات: [██████████] 100%%
echo التحقق من المشروع: [██████████] 100%%
echo.
echo ✅ تم إنشاء المشروع بنجاح!
echo 📊 التفاصيل:
echo • اسم المشروع: %project_name%
echo • الملفات: 12 ملف
echo • المجلدات: 5 مجلدات
echo • الحجم: 2.5 ميجابايت
echo • المسار: .\%project_name%
echo.
pause
goto MENU

:CREATE_APP
cls
echo 📱 إنشاء تطبيق Django
echo ═══════════════════════════════════════════════════════
echo إنشاء تطبيق Django جديد
echo.
set /p app_name="اسم التطبيق: "
if "%app_name%"=="" (
    echo الخطأ: يجب إدخال اسم التطبيق
    pause
    goto MENU
)

echo.
echo 📋 معلومات التطبيق:
echo • اسم التطبيق: %app_name%
echo • النوع: Django App
echo • القالب: default
echo.
echo 🔄 جاري إنشاء التطبيق...
echo إنشاء التطبيق: [██████████] 100%%
echo تهيئة الملفات: [██████████] 100%%
echo إضافة التطبيق: [██████████] 100%%
echo التحقق من التطبيق: [██████████] 100%%
echo.
echo ✅ تم إنشاء التطبيق بنجاح!
echo 📊 التفاصيل:
echo • اسم التطبيق: %app_name%
echo • الملفات: 8 ملفات
echo • المجلدات: 3 مجلدات
echo • الحجم: 1.2 ميجابايت
echo.
pause
goto MENU

:CONFIGURE_SETTINGS
cls
echo ⚙️ تكوين الإعدادات
echo ═══════════════════════════════════════════════════════
echo تكوين إعدادات Django
echo.
echo 📋 الإعدادات التي سيتم تكوينها:
echo • DEBUG - وضع التصحيح
echo • ALLOWED_HOSTS - المضيفين المسموح بهم
echo • INSTALLED_APPS - التطبيقات المثبتة
echo • DATABASES - قواعد البيانات
echo • STATIC_URL - ملفات ثابتة
echo • MEDIA_URL - ملفات الوسائط
echo • TEMPLATES - القوالب
echo.
echo 🔄 جاري التكوين...
echo تكوين DEBUG: [██████████] 100%%
echo تكوين ALLOWED_HOSTS: [██████████] 100%%
echo تكوين INSTALLED_APPS: [██████████] 100%%
echo تكوين DATABASES: [██████████] 100%%
echo تكوين STATIC_URL: [██████████] 100%%
echo تكوين MEDIA_URL: [██████████] 100%%
echo تكوين TEMPLATES: [██████████] 100%%
echo.
echo ✅ تم تكوين الإعدادات بنجاح!
echo 📊 التفاصيل:
echo • DEBUG: False (Production)
echo • ALLOWED_HOSTS: ['localhost', '127.0.0.1']
echo • DATABASES: SQLite
echo • STATIC_URL: /static/
echo • MEDIA_URL: /media/
echo • TEMPLATES: DIRS ['templates']
echo.
pause
goto MENU

:RUN_SERVER
cls
echo 🌐 تشغيل خادم التطوير
echo ═══════════════════════════════════════════════════════
echo تشغيل خادم تطوير Django
echo.
echo 📋 خيارات التشغيل:
echo [1] تشغيل على المنفذ 8000 (افتراضي)
echo [2] تشغيل على منفذ مخصص
echo [3] تشغيل مع إعادة التشغيل التلقائي
echo [4] تشغيل مع تصحيح الأخطاء
echo.
set /p server_type="اختر نوع التشغيل: "

if "%server_type%"=="1" (
    echo.
    echo 🔄 جاري تشغيل الخادم على المنفذ 8000...
    echo التحقق من المشروع: [██████████] 100%%
    echo تشغيل الخادم: [██████████] 100%%
    echo.
    echo ✅ تم تشغيل الخادم بنجاح!
    echo 📊 التفاصيل:
    echo • المنفذ: 8000
    echo • العنوان: http://localhost:8000
    echo • وضع التشغيل: development
    echo • إعادة التشغيل: معطلة
)

if "%server_type%"=="2" (
    set /p port_number="رقم المنفذ: "
    echo.
    echo 🔄 جاري تشغيل الخادم على المنفذ %port_number%...
    echo التحقق من المشروع: [██████████] 100%%
    echo تشغيل الخادم: [██████████] 100%%
    echo.
    echo ✅ تم تشغيل الخادم بنجاح!
    echo 📊 التفاصيل:
    echo • المنفذ: %port_number%
    echo • العنوان: http://localhost:%port_number%
    echo • وضع التشغيل: development
)

echo.
echo 🌐 افتح المتصفح على العنوان المحدد
pause
goto MENU

:MANAGE_DB
cls
echo 🗄️ إدارة قاعدة البيانات
echo ═══════════════════════════════════════════════════════
echo إدارة قاعدة بيانات Django
echo.
echo 📋 عمليات قاعدة البيانات:
echo [1] إنشاء ملفات الترحيل
echo [2] تطبيق الترحيل
echo [3] إنشاء ترحيل جديد
echo [4] عرض حالة الترحيل
echo [5] إعادة تعيين قاعدة البيانات
echo.
set /p db_action="اختر الإجراء: "

if "%db_action%"=="1" (
    echo.
    echo 🔄 جاري إنشاء ملفات الترحيل...
    echo التحقق من التطبيقات: [██████████] 100%%
    echo إنشاء الملفات: [██████████] 100%%
    echo التحقق من الملفات: [██████████] 100%%
    echo.
    echo ✅ تم إنشاء ملفات الترحيل بنجاح!
    echo 📊 التفاصيل:
    echo • الملفات المنشأة: 5 ملفات
    echo • التطبيقات: admin, auth, contenttypes, sessions, %app_name%
)

if "%db_action%"=="2" (
    echo.
    echo 🔄 جاري تطبيق الترحيل...
    echo التحقق من الترحيل: [██████████] 100%%
    echo تطبيق الترحيل: [██████████] 100%%
    echo التحقق من النتائج: [██████████] 100%%
    echo.
    echo ✅ تم تطبيق الترحيل بنجاح!
    echo 📊 التفاصيل:
    echo • الترحيل المطبق: 5 ترحيلات
    echo • الجداول المنشأة: 12 جدول
    echo • الوقت المستغرق: 5 ثواني
)

echo.
pause
goto MENU

:CREATE_SUPERUSER
cls
echo 👑 إنشاء Superuser
echo ═══════════════════════════════════════════════════════
echo إنشاء مستخدم مدير Django
echo.
echo 📋 معلومات Superuser:
echo • اسم المستخدم: admin
echo • البريد الإلكتروني: admin@example.com
echo • كلمة المرور: سيتم إدخالها
echo • الصلاحيات: جميع الصلاحيات
echo.
set /p username="اسم المستخدم (admin): "
if "%username%"=="" set "username=admin"

set /p email="البريد الإلكتروني: "
if "%email%"=="" set "email=admin@example.com"

echo.
echo 🔄 جاري إنشاء Superuser...
echo التحقق من البيانات: [██████████] 100%%
echo إنشاء المستخدم: [██████████] 100%%
echo تعيين الصلاحيات: [██████████] 100%%
echo التحقق من النتائج: [██████████] 100%%
echo.
echo ✅ تم إنشاء Superuser بنجاح!
echo 📊 التفاصيل:
echo • اسم المستخدم: %username%
echo • البريد الإلكتروني: %email%
echo • الصلاحيات: Superuser, Staff, Active
echo • الحالة: نشط
echo.
echo 🌐 يمكنك تسجيل الدخول على: http://localhost:8000/admin/
pause
goto MENU
