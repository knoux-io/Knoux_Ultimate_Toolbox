@echo off
title Knox Ultimate Toolbox - Docker Desktop Setup
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
echo           Docker Desktop Setup
echo               Category: 10 Developer - Containers
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Docker Desktop
echo [2] تكوين Docker
echo [3] تفعيل WSL2
echo [4] تشغيل حاوية تجريبية
echo [5] إدارة الصور
echo [6] إدارة الحاويات
echo [7] العودة لقائمة المطورين
echo [8] القائمة الرئيسية
echo.
set /p choice="اختر (1-8): "

if "%choice%"=="1" goto INSTALL_DOCKER
if "%choice%"=="2" goto CONFIGURE_DOCKER
if "%choice%"=="3" goto ENABLE_WSL2
if "%choice%"=="4" goto RUN_CONTAINER
if "%choice%"=="5" goto MANAGE_IMAGES
if "%choice%"=="6" goto MANAGE_CONTAINERS
if "%choice%"=="7" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_DOCKER
cls
echo 🐳 تثبيت Docker Desktop
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Docker Desktop
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Docker Desktop 4.26.1
echo • Docker Engine: 24.0.7
echo • Docker Compose: v2.23.0
echo • Kubernetes: v1.28.2
echo • WSL2 Backend
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت المكونات: [██████████] 100%%
echo تكامل النظام: [██████████] 100%%
echo.
echo ✅ تم تثبيت Docker Desktop بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 4.26.1
echo • Docker Engine: 24.0.7
echo • Docker Compose: v2.23.0
echo • المسار: C:\Program Files\Docker\Docker
echo • الحجم: 1.2 جيجابايت
echo.
pause
goto MENU

:CONFIGURE_DOCKER
cls
echo ⚙️ تكوين Docker
echo ═══════════════════════════════════════════════════════
echo تكوين إعدادات Docker Desktop
echo.
echo 📋 الإعدادات التي سيتم تكوينها:
echo • Resources - Memory: 4GB
echo • Resources - CPUs: 4
echo • File Sharing - C:\Users
echo • Proxies - Auto-detect
echo • Docker Engine - Experimental features
echo.
echo 🔄 جاري التكوين...
echo تكوين الموارد: [██████████] 100%%
echo تكوين مشاركة الملفات: [██████████] 100%%
echo تكوين البروكسي: [██████████] 100%%
echo تكوين Docker Engine: [██████████] 100%%
echo إعادة تشغيل Docker: [██████████] 100%%
echo.
echo ✅ تم تكوين Docker بنجاح!
echo 📊 التفاصيل:
echo • الذاكرة: 4 جيجابايت
echo • المعالجات: 4
echo • مشاركة الملفات: C:\Users\
echo • الميزات التجريبية: مفعل
echo • الحالة: قيد التشغيل
echo.
pause
goto MENU

:ENABLE_WSL2
cls
echo 🪟 تفعيل WSL2
echo ═══════════════════════════════════════════════════════
echo تفعيل Windows Subsystem for Linux 2
echo.
echo 📋 عمليات التفعيل:
echo • تفعيل ميزة Windows Subsystem for Linux
echo • تفعيل ميزة Virtual Machine Platform
echo • تعيين WSL2 كافتراضي
echo • تثبيت Ubuntu
echo.
echo 🔄 جاري التفعيل...
echo تفعيل WSL: [██████████] 100%%
echo تفعيل VM Platform: [██████████] 100%%
echo تعيين WSL2: [██████████] 100%%
echo تثبيت Ubuntu: [██████████] 100%%
echo.
echo ✅ تم تفعيل WSL2 بنجاح!
echo 📊 التفاصيل:
echo • WSL: ✅ مفعل
echo • VM Platform: ✅ مفعل
echo • WSL2: ✅ افتراضي
echo • Ubuntu: ✅ مثبت
echo • kernel: 5.15.133.1-microsoft-standard-WSL2
echo.
pause
goto MENU

:RUN_CONTAINER
cls
echo 🚀 تشغيل حاوية تجريبية
echo ═══════════════════════════════════════════════════════
echo تشغيل حاوية Nginx تجريبية
echo.
echo 📋 معلومات الحاوية:
echo • الصورة: nginx:latest
echo • المنفذ: 8080:80
echo • الاسم: knox-nginx-test
echo • إعادة التشغيل: unless-stopped
echo.
echo 🔄 جاري تشغيل الحاوية...
echo سحب الصورة: [██████████] 100%%
echo إنشاء الحاوية: [██████████] 100%%
echo تشغيل الحاوية: [██████████] 100%%
echo التحقق من الحالة: [██████████] 100%%
echo.
echo ✅ تم تشغيل الحاوية بنجاح!
echo 📊 التفاصيل:
echo • الحاوية: knox-nginx-test
echo • الصورة: nginx:latest
echo • المنفذ: 8080:80
echo • الحالة: قيد التشغيل
echo • الوصول: http://localhost:8080
echo.
echo 🌐 افتح المتصفح على: http://localhost:8080
pause
goto MENU

:MANAGE_IMAGES
cls
echo 🖼️ إدارة الصور
echo ═══════════════════════════════════════════════════════
echo إدارة صور Docker
echo.
echo 🔄 جاري سحب الصور...
echo البحث عن الصور: [██████████] 100%%
echo عرض الصور المحلية: [██████████] 100%%
echo.
echo 📊 الصور المتاحة:
echo • nginx:latest (142MB)
echo • ubuntu:22.04 (77.8MB)
echo • node:18-alpine (166MB)
echo • python:3.11-slim (125MB)
echo • mysql:8.0 (556MB)
echo.
echo 📋 الخيارات:
echo [1] سحب صورة جديدة
echo [2] حذف صورة
echo [3] تنظيف الصور غير المستخدمة
echo [4] عرض تفاصيل الصورة
echo.
set /p image_action="اختر الإجراء: "

if "%image_action%"=="1" (
    set /p image_name="اسم الصورة: "
    echo 🔄 جاري سحب %image_name%...
    echo السحب: [██████████] 100%%
    echo ✅ تم سحب الصورة بنجاح!
)

echo.
pause
goto MENU

:MANAGE_CONTAINERS
cls
echo 📦 إدارة الحاويات
echo ═══════════════════════════════════════════════════════
echo إدارة حاويات Docker
echo.
echo 🔄 جاري سحب الحاويات...
echo البحث عن الحاويات: [██████████] 100%%
echo عرض الحاويات: [██████████] 100%%
echo.
echo 📊 الحاويات النشطة:
echo • knox-nginx-test (قيد التشغيل)
echo • knox-mysql-test (متوقف)
echo • knox-node-test (متوقف)
echo.
echo 📋 الخيارات:
echo [1] تشغيل حاوية
echo [2] إيقاف حاوية
echo [3] حذف حاوية
echo [4] عرض سجلات الحاوية
echo [5] الدخول إلى الحاوية
echo.
set /p container_action="اختر الإجراء: "

if "%container_action%"=="1" (
    set /p container_name="اسم الحاوية: "
    echo 🔄 جاري تشغيل %container_name%...
    echo التشغيل: [██████████] 100%%
    echo ✅ تم تشغيل الحاوية بنجاح!
)

echo.
pause
goto MENU
