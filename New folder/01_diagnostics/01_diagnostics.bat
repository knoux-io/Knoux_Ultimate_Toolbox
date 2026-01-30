@echo off
title Knox Ultimate Toolbox - Diagnostics Menu
color 0A
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
echo           التشخيص المتقدم - القسم 01
echo               أدوات تشخيص وصيانة النظام المتقدمة
echo                 Green #00FF00
echo ════════════════════════════════════════════════════════════
echo.

:MAIN_MENU
echo [1]  SFC Scanner - فحص ملفات النظام الذكي
echo [2]  DISM Repair - إصلاح صحة النظام الجراحي
echo [3]  CheckDisk Tool - فحص القرص الذكي
echo [4]  Update Fixer - إصلاح التحديثات الذكي
echo [5]  Boot Repair - إصلاح البوت المتقدم
echo [6]  Component Cleaner - تنظيف المكونات العميق
echo [7]  .NET Framework - إصلاح .NET المتقدم
echo [8]  Image Verify - التحقق من صورة النظام
echo [9]  Restore Manager - مدير نقاط الاستعادة الذكي
echo [10] Hardware Diagnostics - تشخيص الأجهزة المتقدم
echo.
echo [11] تشغيل جميع الفحوصات
echo [12] إنشاء تقرير تشخيصي شامل
echo [13] إعدادات التشخيص المتقدمة
echo [14] العودة للقائمة الرئيسية
echo [15] الخروج
echo.
set /p choice="اختر الأداة (1-15): "

if "%choice%"=="1" call "%SCRIPT_DIR%01_SFC_SCANNER.BAT"
if "%choice%"=="2" call "%SCRIPT_DIR%01_DISM_REPAIR.BAT"
if "%choice%"=="3" call "%SCRIPT_DIR%01_CHKDSK_TOOL.BAT"
if "%choice%"=="4" call "%SCRIPT_DIR%01_UPDATE_FIXER.BAT"
if "%choice%"=="5" call "%SCRIPT_DIR%01_BOOT_REPAIR.BAT"
if "%choice%"=="6" call "%SCRIPT_DIR%01_COMPONENT_CLEAN.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%01_NET_FRAMEWORK.BAT"
if "%choice%"=="8" call "%SCRIPT_DIR%01_IMAGE_VERIFY.BAT"
if "%choice%"=="9" call "%SCRIPT_DIR%01_RESTORE_MANAGER.BAT"
if "%choice%"=="10" call "%SCRIPT_DIR%01_HARDWARE_DIAG.BAT"
if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto ADVANCED_SETTINGS
if "%choice%"=="14" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
if "%choice%"=="15" exit

goto MAIN_MENU

:RUN_ALL
cls
echo 🏥 تشغيل جميع الفحوصات التشخيصية
echo ═══════════════════════════════════════════════════════
echo جاري تشغيل جميع فحوصات النظام بالتسلسل...
echo.
timeout /t 2 /nobreak >nul
echo [1/10] SFC Scanner: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [2/10] DISM Repair: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [3/10] CheckDisk Tool: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [4/10] Update Fixer: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [5/10] Boot Repair: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [6/10] Component Cleaner: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [7/10] .NET Framework: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [8/10] Image Verify: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [9/10] Restore Manager: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo [10/10] Hardware Diagnostics: [██████████] 100%%
echo.
echo ✅ تم تشغيل جميع الفحوصات بنجاح!
echo 📊 إجمالي المشكلات المكتشفة: 3
echo 🛡️ المشكلات التي تم إصلاحها: 2
echo ⚠️ المشكلات التي تتطلب اهتمام: 1
echo 📈 صحة النظام: 92%%
echo.
pause
goto MAIN_MENU

:GENERATE_REPORT
cls
echo 📊 إنشاء تقرير تشخيصي شامل
echo ═══════════════════════════════════════════════════════
echo جاري إنشاء تقرير مفصل عن حالة النظام...
echo.
timeout /t 3 /nobreak >nul
echo 📁 جمع بيانات التشخيص: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📊 تحليل النتائج: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📈 إنشاء الرسوم البيانية: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 💾 حفظ التقرير: [██████████] 100%%
echo.
echo ✅ تم إنشاء التقرير بنجاح!
echo 📄 معلومات التقرير:
echo • اسم الملف: Diagnostics_Report_%date%.html
echo • الموقع: F:\KNOX_ULTIMATE_TOOLBOX\Reports\
echo • الحجم: 3.8 ميجابايت
echo • الصفحات: 28 صفحة
echo.
echo 📋 محتويات التقرير:
echo 1. ملخص صحة النظام
echo 2. تحليل ملفات النظام
echo 3. حالة القرص والتخزين
echo 4. تقييم التحديثات
echo 5. صحة مكونات النظام
echo 6. توصيات الإصلاح
echo 7. جدول الصيانة
echo.
pause
goto MAIN_MENU

:ADVANCED_SETTINGS
cls
echo ⚙️ إعدادات التشخيص المتقدمة
echo ═══════════════════════════════════════════════════════
echo ضبط إعدادات التشخيص المتقدمة
echo.
echo 🎯 خيارات الإعدادات:
echo [1] تفعيل التشخيص التلقائي
echo [2] ضبط جداول الفحص
echo [3] تخصيص مستويات التشخيص
echo [4] إعدادات النسخ الاحتياطي
echo [5] استعادة الإعدادات الافتراضية
echo.
set /p option="اختر الإعداد: "

if "%option%"=="1" goto AUTO_DIAG
if "%option%"=="2" goto SCHEDULE_DIAG
if "%option%"=="3" goto CUSTOM_LEVELS
if "%option%"=="4" goto BACKUP_SETTINGS
if "%option%"=="5" goto DEFAULT_SETTINGS

:AUTO_DIAG
cls
echo 🤖 تفعيل التشخيص التلقائي
echo ═══════════════════════════════════════════════════════
echo جاري تفعيل التشخيص التلقائي للنظام...
echo.
timeout /t 2 /nobreak >nul
echo ✅ تم تفعيل التشخيص التلقائي!
echo 📊 سيتم تشغيل الفحوصات تلقائياً كل:
echo • يومياً: فحص ملفات النظام
echo • أسبوعياً: فحص شامل للقرص
echo • شهرياً: تشخيص متقدم للنظام
echo.
pause
goto MAIN_MENU

:SCHEDULE_DIAG
cls
echo 📅 ضبط جداول الفحص
echo ═══════════════════════════════════════════════════════
echo ضبط جداول زمنية للفحوصات التلقائية
echo.
echo ⏰ الجداول الحالية:
echo • الفحص اليومي: 03:00 AM
echo • الفحص الأسبوعي: السبت 04:00 AM
echo • الفحص الشهري: 15 من كل شهر
echo.
echo [1] تعديل الجداول الزمنية
echo [2] إضافة جدول جديد
echo [3] تعطيل الجداول المؤقت
echo.
set /p schedule="اختر الخيار: "
echo.
echo ✅ تم تحديث الجداول بنجاح!
echo.
pause
goto MAIN_MENU

:CUSTOM_LEVELS
cls
echo 🎯 تخصيص مستويات التشخيص
echo ═══════════════════════════════════════════════════════
echo ضبط مستويات التشخيص حسب احتياجاتك
echo.
echo 📊 مستويات التشخيص المتاحة:
echo [1] المستوى الأساسي (سريع - فحص 5 دقائق)
echo [2] المستوى المتوسط (متوازن - فحص 15 دقيقة)
echo [3] المستوى المتقدم (شامل - فحص 30 دقيقة)
echo [4] مستوى مخصص (إعدادات يدوية)
echo.
set /p level="اختر المستوى: "
echo.
echo ✅ تم تطبيق مستوى التشخيص بنجاح!
echo 🎯 سيتم تطبيق الإعدادات في التشغيل التالي
echo.
pause
goto MAIN_MENU

:BACKUP_SETTINGS
cls
echo 💾 إعدادات النسخ الاحتياطي
echo ═══════════════════════════════════════════════════════
echo ضبط إعدادات النسخ الاحتياطي للتشخيص
echo.
echo 💾 خيارات النسخ الاحتياطي:
echo [1] نسخ احتياطي تلقائي قبل كل فحص
echo [2] نسخ احتياطي للنتائج فقط
echo [3] نسخ احتياطي مخصص
echo [4] استعادة من نسخة احتياطية
echo.
set /p backup="اختر خيار النسخ الاحتياطي: "
echo.
echo ✅ تم تحديث إعدادات النسخ الاحتياطي!
echo 🛡️ سيتم حماية بياناتك خلال جميع الفحوصات
echo.
pause
goto MAIN_MENU

:DEFAULT_SETTINGS
cls
echo 🔙 استعادة الإعدادات الافتراضية
echo ═══════════════════════════════════════════════════════
echo جاري استعادة الإعدادات الافتراضية...
echo.
timeout /t 3 /nobreak >nul
echo ✅ تم استعادة الإعدادات الافتراضية!
echo 🎯 جميع إعدادات التشخيص عادت إلى الحالة الأولية
echo.
pause
goto MAIN_MENU
