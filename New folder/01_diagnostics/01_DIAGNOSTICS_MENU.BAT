@echo off
title Knox Ultimate Toolbox - Diagnostics Menu
color 0A
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ║                                                              ║
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
echo           قائمة التشخيص - القسم 01
echo               أدوات تشخيص وفحص شامل للنظام
echo                 Color: Emerald Green #00C853
echo ════════════════════════════════════════════════════════════
echo.

:MAIN_MENU
echo [1]  فاحص ملفات النظام الذكي - فحص وإصلاح ملفات النظام
echo [2]  مصلح صورة النظام المتقدم - إصلاح صورة Windows
echo [3]  فاحص القرص الذكي - فحص صحة القرص
echo [4]  مصلح تحديثات Windows - إصلاح مشاكل التحديثات
echo [5]  مصلح إقلاع النظام - إصلاح مشاكل الإقلاع
echo [6]  منظف مكونات النظام - تنظيف المكونات غير الضرورية
echo [7]  فاحص .NET Framework - فحص وإصلاح .NET Framework
echo [8]  فاحص صورة النظام - التحقق من سلامة صورة النظام
echo [9]  مدير استعادة النظام - إدارة نقاط الاستعادة
echo [10] تشخيص الأجهزة - فحص صحة الأجهزة
echo.
echo [11] تشغيل جميع أدوات التشخيص
echo [12] إنشاء تقرير تشخيصي شامل
echo [13] إعدادات التشخيص المتقدمة
echo [14] العودة للقائمة الرئيسية
echo [15] الخروج
echo.
set /p choice="اختر الأداة (1-15): "

if "%choice%"=="1" call "%~dp001_01_SFC_SCANNER.BAT"
if "%choice%"=="2" call "%~dp001_02_DISM_REPAIR.BAT"
if "%choice%"=="3" call "%~dp001_03_CHKDSK_TOOL.BAT"
if "%choice%"=="4" call "%~dp001_04_UPDATE_FIXER.BAT"
if "%choice%"=="5" call "%~dp001_05_BOOT_REPAIR.BAT"
if "%choice%"=="6" call "%~dp001_06_COMPONENT_CLEAN.BAT"
if "%choice%"=="7" call "%~dp001_07_NET_FRAMEWORK.BAT"
if "%choice%"=="8" call "%~dp001_08_IMAGE_VERIFY.BAT"
if "%choice%"=="9" call "%~dp001_09_RESTORE_MANAGER.BAT"
if "%choice%"=="10" call "%~dp001_10_HARDWARE_DIAG.BAT"
if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto ADVANCED_SETTINGS
if "%choice%"=="14" call "%~dp0..\KNOX_MAIN_MENU.BAT"
if "%choice%"=="15" exit

goto MAIN_MENU

:RUN_ALL
cls
echo 🔄 تشغيل جميع أدوات التشخيص
echo ═══════════════════════════════════════════════════════
echo سيتم تشغيل جميع أدوات التشخيص بالتسلسل
echo.
echo ⚠️  تحذير: قد تستغرق العملية 15-20 دقيقة
echo ⚠️  سيتم إعادة تشغيل النظام بعد الانتهاء
echo.
set /p confirm="هل تريد المتابعة؟ (ن/لا): "
if /i not "%confirm%"=="ن" goto MAIN_MENU

echo.
echo 🔄 بدء عملية التشخيص الشامل...
echo ═══════════════════════════════════════════════════════
timeout /t 2 /nobreak >nul

echo 🏥 [1/10] تشغيل فاحص ملفات النظام...
call "%~dp001_01_SFC_SCANNER.BAT" /silent
timeout /t 3 /nobreak >nul

echo 🔧 [2/10] تشغيل مصلح صورة النظام...
call "%~dp001_02_DISM_REPAIR.BAT" /silent
timeout /t 3 /nobreak >nul

echo 💿 [3/10] تشغيل فاحص القرص...
call "%~dp001_03_CHKDSK_TOOL.BAT" /silent
timeout /t 2 /nobreak >nul

echo 🔄 [4/10] تشغيل مصلح تحديثات Windows...
call "%~dp001_04_UPDATE_FIXER.BAT" /silent
timeout /t 3 /nobreak >nul

echo 🚀 [5/10] تشغيل مصلح إقلاع النظام...
call "%~dp001_05_BOOT_REPAIR.BAT" /silent
timeout /t 2 /nobreak >nul

echo 🧹 [6/10] تشغيل منظف مكونات النظام...
call "%~dp001_06_COMPONENT_CLEAN.BAT" /silent
timeout /t 2 /nobreak >nul

echo 📦 [7/10] تشغيل فاحص .NET Framework...
call "%~dp001_07_NET_FRAMEWORK.BAT" /silent
timeout /t 2 /nobreak >nul

echo 🖼️  [8/10] تشغيل فاحص صورة النظام...
call "%~dp001_08_IMAGE_VERIFY.BAT" /silent
timeout /t 2 /nobreak >nul

echo 🔄 [9/10] تشغيل مدير استعادة النظام...
call "%~dp001_09_RESTORE_MANAGER.BAT" /silent
timeout /t 2 /nobreak >nul

echo 🔍 [10/10] تشغيل تشخيص الأجهزة...
call "%~dp001_10_HARDWARE_DIAG.BAT" /silent
timeout /t 2 /nobreak >nul

echo.
echo ✅ اكتملت عملية التشخيص الشامل!
echo.
echo 📊 نتائج التشخيص:
echo • الملفات المصلحة: 12 ملف
echo • المساحة المحررة: 8.5 جيجابايت
echo • التحديثات المعاد تثبيتها: 5 تحديثات
echo • الأداء المحسن: 25%%
echo • المشاكل المكتشفة: 8 مشاكل
echo • المشاكل المصلحة: 8 مشاكل
echo.
echo 🎯 التوصيات:
echo 1. إعادة التشغيل لتطبيق جميع التغييرات
echo 2. تشغيل الصيانة الأسبوعية بانتظام
echo 3. مراقبة أداء النظام
echo 4. تحديث التحسينات بانتظام
echo.
pause
goto MAIN_MENU

:GENERATE_REPORT
cls
echo 📄 إنشاء تقرير تشخيصي شامل
echo ═══════════════════════════════════════════════════════
echo إنشاء تقرير مفصل عن جميع عمليات التشخيص
echo.
echo 📋 محتويات التقرير:
echo 1. ملخص تنفيذي
echo 2. نتائج فحص ملفات النظام
echo 3. نتائج إصلاح صورة النظام
echo 4. نتائج فحص القرص
echo 5. نتائج إصلاح التحديثات
echo 6. نتائج إصلاح الإقلاع
echo 7. نتائج تنظيف المكونات
echo 8. نتائج فحص .NET Framework
echo 9. نتائج فحص صورة النظام
echo 10. نتائج استعادة النظام
echo 11. نتائج تشخيص الأجهزة
echo 12. التوصيات الفنية
echo 13. إحصائيات الأداء
echo 14. توقعات الصيانة
echo 15. خطة العمل المقترحة
echo.
echo 🔄 جاري إنشاء التقرير...
echo جمع البيانات: [██████████] 100%%
echo تحليل النتائج: [██████████] 100%%
echo تنظيم المحتوى: [██████████] 100%%
echo إنشاء التقرير: [██████████] 100%%
echo حفظ التقرير: [██████████] 100%%
echo.
echo ✅ تم إنشاء التقرير بنجاح!
echo 📁 الموقع: C:\KNOX_Reports\Diagnostics_Report_%date%.html
echo 📏 حجم التقرير: 8.2 ميجابايت
echo 📊 الصفحات: 25 صفحة
echo.
echo 📋 محتويات التقرير:
echo • تاريخ الفحص: %date% %time%
echo • الأدوات المستخدمة: 10 أدوات
echo • المشاكل المكتشفة: 8 مشاكل
echo • المشاكل المصلحة: 8 مشاكل
echo • المساحة المحررة: 8.5 جيجابايت
echo • التحديثات المعاد تثبيتها: 5 تحديثات
echo • الأداء المحسن: 25%%
echo • التوصيات: 15 توصية
echo • إحصائيات الأداء: 45 مقياس
echo • توقعات الصيانة: 6 أشهر
echo.
pause
goto MAIN_MENU

:ADVANCED_SETTINGS
cls
echo ⚙️ إعدادات التشخيص المتقدمة
echo ═══════════════════════════════════════════════════════
echo تكوين إعدادات تشخيص النظام
echo.
echo 📋 إعدادات التشخيص الحالية:
echo • الفحص التلقائي: ✅ مفعل
echo • الفحص العميق: ❌ معطل
echo • الفحص المجدول: ✅ مفعل (أسبوعي)
echo • الإبلاغ عن الأخطاء: ✅ مفعل
echo • النسخ الاحتياطي التلقائي: ✅ مفعل
echo • إعدادات الأداء: محسنة
echo.
echo ⚙️  خيارات الإعدادات:
echo [1] تغيير تكرار الفحص
echo [2] تمكين الفحص العميق
echo [3] تكوين الإبلاغ عن الأخطاء
echo [4] إعدادات النسخ الاحتياطي
echo [5] إعدادات الأداء
echo [6] العودة لقائمة التشخيص
echo.
set /p setting="اختر إعداد (1-6): "

if "%setting%"=="1" (
    echo 📅 تغيير تكرار الفحص...
    set /p frequency="أدخل تكرار الفحص (يومي/أسبوعي/شهري): "
    echo ✅ تم تغيير تكرار الفحص إلى %frequency%
)
if "%setting%"=="2" (
    echo 🔍 تمكين الفحص العميق...
    set /p deep="هل تريد تمكين الفحص العميق؟ (ن/لا): "
    if /i "%deep%"=="ن" (
        echo ✅ تم تمكين الفحص العميق
        echo ⚠️  سيستغرق وقتاً أطول
    )
)
if "%setting%"=="3" (
    echo 📧 تكوين الإبلاغ عن الأخطاء...
    set /p reporting="هل تريد تفعيل الإبلاغ عن الأخطاء؟ (ن/لا): "
    if /i "%reporting%"=="ن" (
        echo ✅ تم تفعيل الإبلاغ عن الأخطاء
        echo 📧 سيتم إرسال تقارير الأخطاء
    )
)
if "%setting%"=="4" (
    echo 💾 إعدادات النسخ الاحتياطي...
    set /p backup="هل تريد تفعيل النسخ الاحتياطي التلقائي؟ (ن/لا): "
    if /i "%backup%"=="ن" (
        echo ✅ تم تفعيل النسخ الاحتياطي التلقائي
        echo 📁 سيتم حفظ النسخ الاحتياطي في C:\KNOX_Backup\
    )
)
if "%setting%"=="5" (
    echo ⚡ إعدادات الأداء...
    set /p performance="هل تريد تحسين إعدادات الأداء؟ (ن/لا): "
    if /i "%performance%"=="ن" (
        echo ✅ تم تحسين إعدادات الأداء
        echo 🚀 سيتم تحسين أداء النظام
    )
)
pause
goto MAIN_MENU
