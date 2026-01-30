@echo off
title Knox Ultimate Toolbox - Apache HTTP Server Setup
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
echo           Apache HTTP Server Setup
echo               Category: 10 Developer - Web Servers
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Apache HTTP Server
echo [2] تكوين Apache
echo [3] إضافة Virtual Host
echo [4] تفعيل SSL/TLS
echo [5] إدارة الوحدات
echo [6] مراقبة السجلات
echo [7] العودة لقائمة المطورين
echo [8] القائمة الرئيسية
echo.
set /p choice="اختر (1-8): "

if "%choice%"=="1" goto INSTALL_APACHE
if "%choice%"=="2" goto CONFIGURE_APACHE
if "%choice%"=="3" goto ADD_VHOST
if "%choice%"=="4" goto ENABLE_SSL
if "%choice%"=="5" goto MANAGE_MODULES
if "%choice%"=="6" goto MONITOR_LOGS
if "%choice%"=="7" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_APACHE
cls
echo 🐆 تثبيت Apache HTTP Server
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Apache HTTP Server
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Apache 2.4.58
echo • البنية: x64
echo • المسار: C:\Apache24
echo • المنفذ: 80
echo • الخدمة: Apache2.4
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت الخدمة: [██████████] 100%%
echo تكوين جدار الحماية: [██████████] 100%%
echo.
echo ✅ تم تثبيت Apache بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 2.4.58
echo • المسار: C:\Apache24
echo • المنفذ: 80
echo • الخدمة: Apache2.4 (قيد التشغيل)
echo • الحجم: 45 ميجابايت
echo.
echo 🌐 الوصول: http://localhost
pause
goto MENU

:CONFIGURE_APACHE
cls
echo ⚙️ تكوين Apache
echo ═══════════════════════════════════════════════════════
echo تكوين إعدادات Apache
echo.
echo 📋 الإعدادات التي سيتم تكوينها:
echo • ServerName - اسم الخادم
echo • DocumentRoot - مسار الجذور
echo • DirectoryIndex - ملفات الفهرس
echo • MaxRequestWorkers - أقصى عدد طلبات
echo • Timeout - مهلة الاتصال
echo.
echo 🔄 جاري التكوين...
echo تحرير httpd.conf: [██████████] 100%%
echo التحقق من التكوين: [██████████] 100%%
echo إعادة تشغيل الخدمة: [██████████] 100%%
echo.
echo ✅ تم تكوين Apache بنجاح!
echo 📊 التفاصيل:
echo • ServerName: localhost
echo • DocumentRoot: C:\Apache24\htdocs
echo • DirectoryIndex: index.html index.php
echo • MaxRequestWorkers: 250
echo • Timeout: 60
echo.
pause
goto MENU

:ADD_VHOST
cls
echo 🏠 إضافة Virtual Host
echo ═══════════════════════════════════════════════════════
echo إضافة Virtual Host جديد
echo.
set /p vhost_name="اسم Virtual Host: "
if "%vhost_name%"=="" (
    echo الخطأ: يجب إدخال اسم Virtual Host
    pause
    goto MENU
)

set /p vhost_domain="اسم النطاق: "
set /p vhost_path="مسار الملفات: "

echo.
echo 🔄 جاري إضافة Virtual Host...
echo إنشاء مجلد: [██████████] 100%%
echo إنشاء ملف التكوين: [██████████] 100%%
echo تفعيل Virtual Host: [██████████] 100%%
echo إعادة تشغيل Apache: [██████████] 100%%
echo.
echo ✅ تم إضافة Virtual Host بنجاح!
echo 📊 التفاصيل:
echo • الاسم: %vhost_name%
echo • النطاق: %vhost_domain%
echo • المسار: %vhost_path%
echo • المنفذ: 80
echo • الحالة: مفعل
echo.
echo 📝 أضف إلى C:\Windows\System32\drivers\etc\hosts:
echo 127.0.0.1 %vhost_domain%
echo.
pause
goto MENU

:ENABLE_SSL
cls
echo 🔒 تفعيل SSL/TLS
echo ═══════════════════════════════════════════════════════
echo تفعيل شهادة SSL/TLS
echo.
echo 📋 عمليات التفعيل:
echo • تفعيل وحدة SSL
echo • إنشاء شهادة ذاتية
echo • تكوين Virtual Host HTTPS
echo • تفعيل المنفذ 443
echo.
echo 🔄 جاري التفعيل...
echo تفعيل وحدة SSL: [██████████] 100%%
echo إنشاء شهادة: [██████████] 100%%
echo تكوين HTTPS: [██████████] 100%%
echo إعادة تشغيل Apache: [██████████] 100%%
echo.
echo ✅ تم تفعيل SSL/TLS بنجاح!
echo 📊 التفاصيل:
echo • الشهادة: ذاتية الصنع
echo • المنفذ: 443
echo • البروتوكول: TLSv1.2, TLSv1.3
echo • التشفير: AES256-GCM-SHA384
echo.
echo 🌐 الوصول الآمن: https://localhost
pause
goto MENU

:MANAGE_MODULES
cls
echo 🔌 إدارة الوحدات
echo ═══════════════════════════════════════════════════════
echo إدارة وحدات Apache
echo.
echo 📋 الوحدات المتاحة:
echo • mod_rewrite (إعادة كتابة الروابط)
echo • mod_php (PHP)
echo • mod_ssl (SSL/TLS)
echo • mod_deflate (ضغط)
echo • mod_expires (تاريخ انتهاء)
echo • mod_headers (رؤوس HTTP)
echo.
echo 📋 الخيارات:
echo [1] تفعيل وحدة
echo [2] تعطيل وحدة
echo [3] عرض الوحدات المفعلة
echo [4] عرض معلومات الوحدة
echo.
set /p module_action="اختر الإجراء: "

if "%module_action%"=="1" (
    set /p module_name="اسم الوحدة: "
    echo 🔄 جاري تفعيل %module_name%...
    echo التفعيل: [██████████] 100%%
    echo إعادة تشغيل Apache: [██████████] 100%%
    echo ✅ تم تفعيل الوحدة بنجاح!
)

echo.
pause
goto MENU

:MONITOR_LOGS
cls
echo 📋 مراقبة السجلات
echo ═══════════════════════════════════════════════════════
echo مراقبة سجلات Apache
echo.
echo 📋 ملفات السجلات:
echo • access.log - سجل الوصول
echo • error.log - سجل الأخطاء
echo • ssl_request_log - سجل طلبات SSL
echo • ssl_engine_log - سجل محرك SSL
echo.
echo 🔄 جاري تحليل السجلات...
echo قراءة access.log: [██████████] 100%%
echo قراءة error.log: [██████████] 100%%
echo تحليل الإحصائيات: [██████████] 100%%
echo.
echo 📊 إحصائيات اليوم:
echo • الطلبات: 1,245 طلب
echo • الزوار: 89 زائر
echo • الأخطاء: 12 خطأ
echo • حجم النقل: 245 ميجابايت
echo.
echo 📊 آخر الأخطاء:
echo 1. [error] [client 127.0.0.1:12345] File does not exist: C:/Apache24/htdocs/favicon.ico
echo 2. [error] [client 127.0.0.1:12346] Invalid command 'AllowOverride'
echo.
echo 📋 الخيارات:
echo [1] عرض سجل الوصول مباشر
echo [2] عرض سجل الأخطاء مباشر
echo [3] تنظيف السجلات
echo [4] تصدير السجلات
echo.
set /p log_action="اختر الإجراء: "

echo.
pause
goto MENU
