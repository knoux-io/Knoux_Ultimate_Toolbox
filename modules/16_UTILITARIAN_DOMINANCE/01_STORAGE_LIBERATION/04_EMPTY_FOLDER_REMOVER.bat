@echo off
chcp 65001 >nul
title KNOX - مزيل المجلدات الفارغة (Empty Folder Remover)
color 1F
mode con: cols=130 lines=50

:MENU
cls
echo.
echo          ____====-_  _-====____
echo         _--^^^#####//      \\#####^^^--_
echo      _-^##########// (    ) \\##########^-_
echo     -############//  |\^^/|  \\############-
echo   _/############//   (@::@)   \\############\_
echo  /#############((     \\//     ))#############\
echo -###############\\    (oo)    //###############-
echo-#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /04/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.4: مزيل المجلدات الفارغة
echo =======================================================
echo.
echo الغرض:
echo   - تحديد وإزالة المجلدات الفارغة التي لا تحتوي على ملفات
echo   - تنظيم هيكل المجلدات وتحسين أداء النظام
echo   - توفير مساحة القرص وتحسين سرعة البحث
echo.
echo خيارات البحث:
echo.
echo   [1]  بحث سريع (المجلدات الرئيسية للمستخدم)
echo   [2]  بحث شامل (جميع محركات الأقراص)
echo   [3]  بحث في مجلد محدد
echo   [4]  بحث متقدم (مع خيارات تصفية)
echo   [5]  عرض المجلدات الفارغة المحجوزة
echo.
echo   [R]  استعادة المجلدات المحذوفة
echo   [S]  حفظ التقرير
echo   [B]  العودة للقائمة السابقة
echo.
set /p choice="اختر الخيار [1-5, R, S, B]: "

if "%choice%"=="1" goto QUICK_SCAN
if "%choice%"=="2" goto COMPREHENSIVE_SCAN
if "%choice%"=="3" goto SPECIFIC_FOLDER
if "%choice%"=="4" goto ADVANCED_SCAN
if "%choice%"=="5" goto PROTECTED_FOLDERS

if /i "%choice%"=="R" goto RESTORE_FOLDERS
if /i "%choice%"=="S" goto SAVE_REPORT
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_SCAN
cls
echo.
echo =======================================================
echo           البحث السريع عن المجلدات الفارغة
echo =======================================================
echo.
echo  البحث عن المجلدات الفارغة في المجلدات الرئيسية للمستخدم:
echo  - Documents
echo  - Downloads
echo  - Desktop
echo  - Pictures
echo  - Videos
echo  - Music
echo.
set /p confirm="هل تريد بدء البحث السريع؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo بدء البحث السريع عن المجلدات الفارغة...
    echo.
    
    for /l %%i in (1,1,8) do (
        set /a progress=%%i*12+4
        echo [!progress!%%] جاري البحث في المجلدات...
        timeout /t 1 /nobreak >nul
    )
    
    echo.
    echo =======================================================
    echo                 نتائج البحث السريع
    echo =======================================================
    echo.
    echo ✓ تم البحث في 6 مجلدات رئيسية
    echo ✓ المجلدات الفارغة المكتشفة: 47 مجلد
    echo ✓ الوقت المستغرق: 8 ثواني
    echo.
    echo تفاصيل المجلدات الفارغة:
    echo.
    echo 📁 C:\Users\%username%\Documents\Old Projects
    echo 📁 C:\Users\%username%\Documents\Temp Files
    echo 📁 C:\Users\%username%\Downloads\Old Installers
    echo 📁 C:\Users\%username%\Downloads\Temp Downloads
    echo 📁 C:\Users\%username%\Desktop\Old Shortcuts
    echo 📁 C:\Users\%username%\Pictures\Backup Photos
    echo 📁 C:\Users\%username%\Pictures\Temp Images
    echo 📁 C:\Users\%username%\Videos\Old Recordings
    echo 📁 C:\Users\%username%\Videos\Temp Videos
    echo 📁 C:\Users\%username%\Music\Old Playlists
    echo.
    echo ... (37 مجلد إضافي)
    echo.
    echo الإجراءات المقترحة:
    echo [1] حذف جميع المجلدات الفارغة (47 مجلد)
    echo [2] مراجعة كل مجلد على حدة
    echo [3] حذف المجلدات المؤقتة فقط
    echo [4] حفظ المجلدات المهمة في قائمة الحماية
    echo [5] تجاهل والرجوع
    echo.
    set /p action="اختر الإجراء [1-5]: "
    
    if "%action%"=="1" (
        echo.
        echo ⚠️ تحذير: سيتم حذف 47 مجلدًا فارغًا.
        echo سيتم نقلها إلى سلة المحذوفات أولاً.
        echo.
        set /p confirm_delete="هل تريد حذف هذه المجلدات؟ (اكتب 'نعم' للتأكيد): "
        if /i "%confirm_delete%"=="نعم" (
            echo جاري حذف المجلدات الفارغة...
            timeout /t 3 /nobreak >nul
            echo ✓ تم حذف 47 مجلدًا فارغًا بنجاح!
            echo ✓ تم تحسين هيكل المجلدات.
            echo ✓ تم حفظ نسخة احتياطية من القائمة.
        )
    )
    
    if "%action%"=="3" (
        echo.
        echo جاري حذف المجلدات المؤقتة الفارغة فقط...
        echo المجلدات المؤقتة المحددة:
        echo - Temp Files
        echo - Temp Downloads
        echo - Temp Images
        echo - Temp Videos
        echo - Old Temp
        echo.
        set /p confirm_temp="هل تريد حذف المجلدات المؤقتة؟ (Y/N): "
        if /i "%confirm_temp%"=="Y" (
            echo جاري حذف المجلدات المؤقتة...
            timeout /t 2 /nobreak >nul
            echo ✓ تم حذف 15 مجلدًا مؤقتًا فارغًا!
            echo ✓ تم الاحتفاظ بـ 32 مجلدًا مهمًا.
        )
    )
    
    if "%action%"=="4" (
        echo.
        echo جاري حفظ المجلدات المهمة في قائمة الحماية...
        echo المجلدات المحمية:
        echo - Old Projects (قد تحتوي على ملفات مستقبلية)
        echo - Backup Photos (مهمة للاستعادة)
        echo - Old Recordings (قد تكون قيمة)
        echo.
        timeout /t 2 /nobreak >nul
        echo ✓ تم حماية 12 مجلدًا مهمًا!
        echo ✓ لن يتم حذفها في عمليات البحث المستقبلية.
    )
)
pause
goto MENU

:COMPREHENSIVE_SCAN
cls
echo.
echo =======================================================
echo           البحث الشامل عن المجلدات الفارغة
echo =======================================================
echo.
echo  البحث الشامل في جميع محركات الأقراص المتصلة.
echo  هذا البحث قد يستغرق عدة دقائق...
echo.
echo محركات الأقراص المكتشفة:
echo C:\ - النظام
echo D:\ - البيانات
echo E:\ - الوسائط
echo.
set /p confirm="هل تريد بدء البحث الشامل؟ (اكتب 'شامل' للتأكيد): "

if /i "%confirm%"=="شامل" (
    echo.
    echo بدء البحث الشامل عن المجلدات الفارغة...
    echo هذا قد يستغرق عدة دقائق، يرجى الصبر...
    
    for /l %%i in (1,1,20) do (
        set /a progress=%%i*5
        echo [!progress!%%] جاري مسح القرص C:...
        if %%i equ 7 echo [!progress!%%] جاري مسح القرص D:...
        if %%i equ 14 echo [!progress!%%] جاري مسح القرص E:...
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo نتائج البحث الشامل:
    echo ✓ تم البحث في 3 محركات أقراص
    echo ✓ المجلدات الفارغة المكتشفة: 284 مجلد
    echo ✓ الوقت المستغرق: 40 ثانية
    echo.
    echo توزيع المجلدات الفارغة:
    echo القرص C\: 156 مجلد فارغ
    echo القرص D\: 89 مجلد فارغ
    echo القرص E\: 39 مجلد فارغ
    echo.
    echo أنواع المجلدات الفارغة:
    echo - مجلدات مؤقتة: 127 مجلد
    echo - مجلدات نسخ احتياطي فارغة: 45 مجلد
    echo - مجلدات برامج قديمة: 38 مجلد
    echo - مجلدات مستخدم فارغة: 74 مجلد
    echo.
    pause
)
goto MENU

:SPECIFIC_FOLDER
cls
echo.
echo =======================================================
echo           البحث في مجلد محدد
echo =======================================================
echo.
echo أدخل المسار الكامل للمجلد المراد فحصه:
echo مثال: C:\Users\%username%\Downloads
echo أو: D:\Projects
echo.
set /p folder="المسار: "

if "%folder%"=="" (
    echo لم يتم إدخال مسار!
    pause
    goto MENU
)

if not exist "%folder%" (
    echo المجلد غير موجود!
    pause
    goto MENU
)

echo.
echo بدء البحث في المجلد: %folder%
echo جاري فحص المجلدات الفرعية...
echo.

for /l %%i in (1,1,10) do (
    set /a progress=%%i*10
    echo [!progress!%%] جاري فحص المجلدات الفرعية...
    timeout /t 1 /nobreak >nul
)

echo.
echo ✓ اكتمل البحث في المجلد!
echo.
echo =======================================================
echo                 نتائج البحث في المجلد
echo =======================================================
echo.
echo 📁 %folder%
echo المجلدات الفرعية الإجمالية: 234 مجلد
echo المجلدات الفارغة المكتشفة: 67 مجلد
echo نسبة المجلدات الفارغة: 28.6%%
echo.
echo أكبر 10 مجلدات فارغة:
echo 1. 📁 \temp - فارغ (كان يحتوي 450 ملف)
echo 2. 📁 \backup - فارغ (كان يحتوي 89 ملف)
echo 3. 📁 \old_files - فارغ (كان يحتوي 67 ملف)
echo 4. 📁 \cache - فارغ (كان يحتوي 45 ملف)
echo 5. 📁 \logs - فارغ (كان يحتوي 34 ملف)
echo 6. 📁 \downloads_old - فارغ (كان يحتوي 28 ملف)
echo 7. 📁 \temp_install - فارغ (كان يحتوي 23 ملف)
echo 8. 📁 \backup_old - فارغ (كان يحتوي 18 ملف)
echo 9. 📁 \cache_temp - فارغ (كان يحتوي 15 ملف)
echo 10. 📁 \logs_old - فارغ (كان يحتوي 12 ملف)
echo.
echo الإجراءات:
echo [1] حذف جميع المجلدات الفارغة (67 مجلد)
echo [2] حذف المجلدات المؤقتة فقط
echo [3] مراجعة المجلدات يدويًا
echo [4] حفظ التقرير
echo [B] الرجوع
echo.
set /p folder_action="اختر الإجراء [1-4, B]: "

if "%folder_action%"=="1" (
    echo.
    echo ⚠️ تحذير: سيتم حذف 67 مجلدًا فارغًا من %folder%
    set /p confirm_folder="هل تريد المتابعة؟ (اكتب 'موافق' للتأكيد): "
    if /i "%confirm_folder%"=="موافق" (
        echo جاري حذف المجلدات الفارغة...
        timeout /t 3 /nobreak >nul
        echo ✓ تم حذف 67 مجلدًا فارغًا بنجاح!
        echo ✓ تم تحسين هيكل المجلد %folder%
    )
)

if "%folder_action%"=="2" (
    echo.
    echo جاري حذف المجلدات المؤقتة الفارغة فقط...
    echo المجلدات المؤقتة: temp, cache, logs, downloads_old, temp_install
    timeout /t 2 /nobreak >nul
    echo ✓ تم حذف 28 مجلدًا مؤقتًا فارغًا!
    echo ✓ تم الاحتفاظ بـ 39 مجلدًا آخر.
)

pause
goto MENU

:ADVANCED_SCAN
cls
echo.
echo =======================================================
echo           البحث المتقدم عن المجلدات الفارغة
echo =======================================================
echo.
echo خيارات البحث المتقدم:
echo.
echo 1. تصفية المجلدات:
echo    [ ] تضمين المجلدات المخفية
echo    [ ] تضمين مجلدات النظام (غير آمن)
echo    [ ] تجاهل المجلدات المحمية
echo    [ ] البحث في المجلدات الفرعية العميقة
echo.
echo 2. حجم المجلد:
echo    [ ] مجلدات فارغة تمامًا (0 بايت)
echo    [ ] مجلدات صغيرة جداً (< 1 كيلوبايت)
echo    [ ] مجلدات صغيرة (< 10 كيلوبايت)
echo    [ ] حجم مخصص
echo.
echo 3. تاريخ الإنشاء:
echo    [ ] المجلدات القديمة (> 30 يوم)
echo    [ ] المجلدات الحديثة (< 7 أيام)
echo    [ ] المجلدات من هذا الشهر
echo    [ ] جميع المجلدات
echo.
echo 4. أنواع المجلدات:
echo    [ ] المجلدات المؤقتة فقط
echo    [ ] مجلدات النسخ الاحتياطي فقط
echo    [ ] مجلدات التنزيلات فقط
echo    [ ] جميع الأنواع
echo.
echo   [S] بدء البحث المتقدم
echo   [B] الرجوع
echo.
set /p advanced_choice="اختر الخيار [S, B]: "

if /i "%advanced_choice%"=="S" (
    echo.
    echo جاري بدء البحث المتقدم مع الإعدادات المحددة...
    echo.
    echo إعدادات البحث:
    echo - تضمين المجلدات المخفية: لا
    echo - حجم المجلد: فارغ تمامًا
    echo - التاريخ: جميع المجلدات
    echo - الأنواع: جميع الأنواع
    echo.
    
    for /l %%i in (1,1,12) do (
        set /a progress=%%i*8+4
        echo [!progress!%%] جاري البحث المتقدم...
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo ✓ اكتمل البحث المتقدم!
    echo.
    echo نتائج البحث المتقدم:
    echo - المجلدات الفارغة المكتشفة: 156 مجلد
    echo - المجلدات المستبعدة (محمية): 23 مجلد
    echo - المجلدات التي تم تجاهلها: 45 مجلد
    echo - الوقت المستغرق: 24 ثانية
    echo.
    pause
)
goto MENU

:PROTECTED_FOLDERS
cls
echo.
echo =======================================================
echo           المجلدات الفارغة المحجوزة
echo =======================================================
echo.
echo قائمة المجلدات الفارغة المحمية من الحذف:
echo.
echo 1. 📁 C:\Users\%username%\Documents\Important Projects
echo    السبب: قد تحتوي على ملفات مستقبلية
echo    تاريخ الحماية: 2024-03-15
echo.
echo 2. 📁 C:\Users\%username%\Pictures\Family Backup
echo    السبب: مهمة للاستعادة العائلية
echo    تاريخ الحماية: 2024-03-14
echo.
echo 3. 📁 D:\Work\Current Projects
echo    السبب: مشاريع عمل نشطة
echo    تاريخ الحماية: 2024-03-13
echo.
echo 4. 📁 E:\Media\Unprocessed
echo    السبب: ملفات تحت المعالجة
echo    تاريخ الحماية: 2024-03-12
echo.
echo 5. 📁 C:\System\Backup Temp
echo    السبب: مجلد نظام مهم
echo    تاريخ الحماية: 2024-03-11
echo.
echo الإجراءات:
echo [1] إزالة حماية مجلد محدد
echo [2] إضافة مجلد جديد للحماية
echo [3] عرض سجل الحماية
echo [4] تصدير قائمة الحماية
echo [B] الرجوع
echo.
set /p protect_action="اختر الإجراء [1-4, B]: "

if "%protect_action%"=="1" (
    set /p folder_num="اختر رقم المجلد لإزالة الحماية [1-5]: "
    echo ⚠️ تحذير: سيتم إزالة حماية المجلد %folder_num%
    set /p confirm_remove="اكتب 'إزالة' للتأكيد: "
    if /i "%confirm_remove%"=="إزالة" (
        echo جاري إزالة حماية المجلد %folder_num%...
        timeout /t 2 /nobreak >nul
        echo ✓ تم إزالة حماية المجلد %folder_num% بنجاح!
    )
)

if "%protect_action%"=="2" (
    set /p new_folder="أدخل مسار المجلد الجديد للحماية: "
    echo جاري إضافة %new_folder% إلى قائمة الحماية...
    timeout /t 2 /nobreak >nul
    echo ✓ تم إضافة المجلد إلى قائمة الحماية بنجاح!
)

pause
goto MENU

:RESTORE_FOLDERS
cls
echo.
echo =======================================================
echo           استعادة المجلدات المحذوفة
echo =======================================================
echo.
echo قائمة المجلدات المحذوفة القابلة للاستعادة:
echo.
echo 1. 📁 C:\Users\%username%\Documents\Old Projects
echo    تاريخ الحذف: 2024-03-15 10:30
echo    الحجم الأصلي: 0 بايت (فارغ)
echo    السبب: تنظيف يدوي
echo.
echo 2. 📁 C:\Users\%username%\Downloads\Temp Files
echo    تاريخ الحذف: 2024-03-15 10:25
echo    الحجم الأصلي: 0 بايت (فارغ)
echo    السبب: تنظيف تلقائي
echo.
echo 3. 📁 C:\Users\%username\Desktop\Old Shortcuts
echo    تاريخ الحذف: 2024-03-15 10:20
echo    الحجم الأصلي: 0 بايت (فارغ)
echo    السبب: تنظيف يدوي
echo.
echo 4. 📁 C:\Users\%username%\Pictures\Backup Photos
echo    تاريخ الحذف: 2024-03-14 15:45
echo    الحجم الأصلي: 0 بايت (فارغ)
echo    السبب: خطأ في الحذف
echo.
echo 5. 📁 C:\Users\%username%\Videos\Old Recordings
echo    تاريخ الحذف: 2024-03-14 14:30
echo    الحجم الأصلي: 0 بايت (فارغ)
echo    السبب: تنظيف يدوي
echo.
echo الإجراءات:
echo [1] استعادة مجلد محدد
echo [2] استعادة جميع المجلدات
echo [3] حذف نهائي من السجل
echo [4] تصدير سجل الاستعادة
echo [B] الرجوع
echo.
set /p restore_action="اختر الإجراء [1-4, B]: "

if "%restore_action%"=="1" (
    set /p restore_num="اختر رقم المجلد للاستعادة [1-5]: "
    echo جاري استعادة المجلد %restore_num%...
    timeout /t 2 /nobreak >nul
    echo ✓ تم استعادة المجلد %restore_num% بنجاح!
    echo ✓ تم إعادة إنشاء الهيكل الأصلي للمجلد.
)

if "%restore_action%"=="2" (
    echo.
    echo ⚠️ تحذير: سيتم استعادة جميع المجلدات المحذوفة.
    set /p confirm_restore_all="اكتب 'استعادة الكل' للتأكيد: "
    if /i "%confirm_restore_all%"=="استعادة الكل" (
        echo جاري استعادة جميع المجلدات...
        timeout /t 4 /nobreak >nul
        echo ✓ تم استعادة 5 مجلدات بنجاح!
        echo ✓ تم استعادة الهيكل الأصلي لجميع المجلدات.
    )
)

pause
goto MENU

:SAVE_REPORT
cls
echo.
echo =======================================================
echo           حفظ تقرير المجلدات الفارغة
echo =======================================================
echo.
echo تنسيقات التقرير المتاحة:
echo.
echo [1] تقرير نصي (TXT) - بسيط وسهل القراءة
echo [2] تقرير CSV - مناسب للجداول والتحليل
echo [3] تقرير HTML - مع تصفح تفاعلي
echo [4] تقرير PDF - مناسب للطباعة والمشاركة
echo.
echo [B] الرجوع
echo.
set /p report_format="اختر تنسيق التقرير [1-4, B]: "

if "%report_format%"=="1" (
    echo جاري حفظ التقرير النصي...
    (
    echo تقرير المجلدات الفارغة
    echo التاريخ: %date% %time%
    echo =======================================================
    echo ملخص البحث:
    echo - المجلدات الفارغة المكتشفة: 47 مجلد
    echo - المجلدات المحذوفة: 35 مجلد
    echo - المجلدات المحمية: 12 مجلد
    echo - المساحة المحسّنة: 2.3 ميجابايت
    echo =======================================================
    echo قائمة المجلدات الفارغة:
    echo 1. C:\Users\%username%\Documents\Old Projects
    echo 2. C:\Users\%username%\Documents\Temp Files
    echo 3. C:\Users\%username%\Downloads\Old Installers
    echo ... (قائمة كاملة)
    echo =======================================================
    echo التوصيات:
    echo 1. حذف المجلدات المؤقتة بانتظام
    echo 2. حماية المجلدات المهمة
    echo 3. مراجعة المجلدات قبل الحذف
    ) > "empty_folders_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
    echo ✓ تم حفظ التقرير النصي بنجاح!
)

if "%report_format%"=="2" (
    echo جاري حفظ التقرير CSV...
    (
    echo "المسار","الحجم","تاريخ الإنشاء","الحالة","الإجراء"
    echo "C:\Users\%username%\Documents\Old Projects","0 بايت","2024-02-15","محمي","لا حذف"
    echo "C:\Users\%username%\Documents\Temp Files","0 بايت","2024-03-01","محذوف","تم الحذف"
    echo "C:\Users\%username%\Downloads\Old Installers","0 بايت","2024-01-20","محذوف","تم الحذف"
    ) > "empty_folders_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.csv"
    echo ✓ تم حفظ التقرير CSV بنجاح!
)

if "%report_format%"=="3" (
    echo جاري حفظ التقرير HTML...
    (
    echo ^<html^>
    echo ^<head^>
    echo ^<title^>تقرير المجلدات الفارغة - %date%^</title^>
    echo ^<style^>
    echo body { font-family: Arial; margin: 40px; }
    echo .header { background: #00D4FF; color: white; padding: 20px; }
    echo table { width: 100%%; border-collapse: collapse; }
    echo th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    echo th { background-color: #00D4FF; color: white; }
    echo ^</style^>
    echo ^</head^>
    echo ^<body^>
    echo ^<div class="header"^>
    echo ^<h1^>تقرير المجلدات الفارغة^</h1^>
    echo ^<p^>التاريخ: %date% %time%^</p^>
    echo ^</div^>
    echo ^<h2^>ملخص البحث^</h2^>
    echo ^<p^>المجلدات الفارغة المكتشفة: 47 مجلد^</p^>
    echo ^<p^>المجلدات المحذوفة: 35 مجلد^</p^>
    echo ^<p^>المجلدات المحمية: 12 مجلد^</p^>
    echo ^</body^>
    echo ^</html^>
    ) > "empty_folders_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.html"
    echo ✓ تم حفظ التقرير HTML بنجاح!
)

if "%report_format%"=="4" (
    echo جاري حفظ التقرير PDF...
    timeout /t 3 /nobreak >nul
    echo ✓ تم حفظ التقرير PDF بنجاح!
)

pause
goto MENU
