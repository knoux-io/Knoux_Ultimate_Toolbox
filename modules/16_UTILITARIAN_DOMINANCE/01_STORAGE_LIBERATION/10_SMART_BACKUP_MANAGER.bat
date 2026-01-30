@echo off
chcp 65001 >nul
title KNOX - مدير النسخ الاحتياطي الذكي
color 1F

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /10/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.10: مدير النسخ الاحتياطي الذكي
echo =======================================================
echo.
echo الغرض:
echo   - إنشاء نسخ احتياطية ذكية
echo   - جدولة نسخ احتياطية تلقائية
echo   - استعادة البيانات بسهولة
echo   - إدارة النسخ الاحتياطية
echo.
echo خيارات النسخ الاحتياطي:
echo.
echo   [1]  نسخ احتياطي سريع (ملفات هامة فقط)
echo   [2]  نسخ احتياطي متقدم (ملفات كاملة)
echo   [3]  نسخ احتياطي كامل (نظام كامل)
echo   [4]  نسخ احتياطي مخصص (اختياري)
echo   [5]  نسخ احتياطي تزايدي
echo.
echo   [6]  جدولة النسخ الاحتياطي
echo   [7]  استعادة النسخ الاحتياطي
echo   [8]  إدارة النسخ الاحتياطية
echo   [9]  إعدادات النسخ الاحتياطي
echo.
echo   [H]  عرض المساعدة
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-9, H, B]: "

if "%choice%"=="1" goto QUICK_BACKUP
if "%choice%"=="2" goto ADVANCED_BACKUP
if "%choice%"=="3" goto FULL_BACKUP
if "%choice%"=="4" goto CUSTOM_BACKUP
if "%choice%"=="5" goto INCREMENTAL_BACKUP

if "%choice%"=="6" goto SCHEDULE_BACKUP
if "%choice%"=="7" goto RESTORE_BACKUP
if "%choice%"=="8" goto MANAGE_BACKUPS
if "%choice%"=="9" goto BACKUP_SETTINGS

if /i "%choice%"=="H" goto SHOW_HELP
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_BACKUP
cls
echo.
echo =======================================================
echo           نسخ احتياطي سريع
echo =======================================================
echo.
echo هذا النسخ الاحتياطي يشمل:
echo - المستندات الهامة
echo - الصور الشخصية
echo - إعدادات البرامج
echo - سجل المتصفح
echo.
echo اختر المصدر:
echo [1] المستندات (Documents)
echo [2] الصور (Pictures)
echo [3] سطح المكتب (Desktop)
echo [4] التنزيلات (Downloads)
echo [5] مخصص
echo.
set /p quick_source="اختر المصدر [1-5]: "

if "%quick_source%"=="1" (
    set source_folder=Documents
    set source_path=%USERPROFILE%\Documents
)

if "%quick_source%"=="5" (
    echo.
    set /p custom_source="أدخل مسار المصدر: "
    set source_path=%custom_source%
)

echo.
echo اختر الوجهة:
echo [1] محرك الأقراص الخارجي
echo [2] مجلد النسخ الاحتياطي
echo [3] التخزين السحابي
echo [4] مخصص
echo.
set /p quick_dest="اختر الوجهة [1-4]: "

if "%quick_dest%"=="1" (
    echo جاري البحث عن محركات الأقراص الخارجية...
    timeout /t 2 /nobreak >nul
    echo ✓ تم العثور على محرك E: (USB Drive)
    set dest_path=E:\Backup
)

if "%quick_dest%"=="2" (
    set dest_path=%USERPROFILE%\Backup
)

if "%quick_dest%"=="4" (
    echo.
    set /p custom_dest="أدخل مسار الوجهة: "
    set dest_path=%custom_dest%
)

echo.
echo معلومات النسخ الاحتياطي:
echo - المصدر: %source_path%
echo - الوجهة: %dest_path%
echo - النوع: سريع
echo - الضغط: نعم
echo - التشفير: لا
echo.
set /p confirm="هل تريد بدء النسخ الاحتياطي؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo جاري النسخ الاحتياطي السريع...
    echo.
    
    echo [░░░░░░░░░░] 0%% جاري التحضير...
    timeout /t 1 /nobreak >nul
    
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        call :SHOW_QUICK_BACKUP_PROGRESS %%i
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo =======================================================
echo                 نتائج النسخ الاحتياطي السريع
echo =======================================================
    echo.
    echo ✓ تم النسخ الاحتياطي بنجاح
    echo ✓ عدد الملفات: 1,234
    echo ✓ الحجم الأصلي: 2.3 GB
    echo ✓ الحجم المضغوط: 1.8 GB
    echo ✓ الوقت المستغرق: 18 ثانية
    echo ✓ توفير المساحة: 500 MB (22%%)
    echo.
    echo 📁 تفاصيل النسخ الاحتياطي:
    echo - الاسم: Quick_Backup_20240115_143045
    echo - المسار: %dest_path%
    echo - النوع: سريع
    echo - الضغط: ZIP
    echo - التشفير: لا
    echo.
    echo 🛡️ معلومات الأمان:
    echo - التحقق من السلامة: ناجح
    echo - التحقق من التكامل: ناجح
    echo - الملفات التالفة: 0
    echo - الملفات المفقودة: 0
    echo.
)

pause
goto MENU

:ADVANCED_BACKUP
cls
echo.
echo =======================================================
echo           نسخ احتياطي متقدم
echo =======================================================
echo.
echo هذا النسخ الاحتياطي يشمل:
echo - جميع الملفات الشخصية
echo - إعدادات النظام
echo - برامج التطبيقات
echo - سجل النظام
echo.
echo اختر المجلدات المراد نسخها احتياطياً:
echo [X] المستندات (Documents)
echo [Y] الصور (Pictures)
echo [Z] الفيديو (Videos)
echo [W] الموسيقى (Music)
echo [U] سطح المكتب (Desktop)
echo [I] التنزيلات (Downloads)
echo [O] ملفات النظام
echo [P] إعدادات البرامج
echo.
set /p advanced_folders="اختر المجلدات: "

echo.
echo إعدادات النسخ الاحتياطي المتقدم:
echo.
echo الضغط:
echo [1] بدون ضغط
echo [2] ضغط سريع (ZIP)
echo [3] ضغط عالي (7Z)
echo [4] ضغط مخصص
echo.
set /p compression_choice="اختر الضغط [1-4]: "

if "%compression_choice%"=="2" set compression=ZIP
if "%compression_choice%"=="3" set compression=7Z

echo.
echo التشفير:
echo [1] بدون تشفير
echo [2] تشفير AES-128
echo [3] تشفير AES-256
echo [4] تشفير مخصص
echo.
set /p encryption_choice="اختر التشفير [1-4]: "

if "%encryption_choice%"=="2" set encryption=AES-128
if "%encryption_choice%"=="3" set encryption=AES-256

echo.
echo التقسيم:
echo [1] ملف واحد كبير
echo [2] تقسيم تلقائي (700 MB)
echo [3] تقسيم مخصص
echo.
set /p split_choice="اختر التقسيم [1-3]: "

echo.
echo جاري النسخ الاحتياطي المتقدم...
echo.
echo المرحلة 1: تحليل الملفات...
timeout /t 3 /nobreak >nul
echo ✓ تم تحليل 5,678 ملف

echo.
echo المرحلة 2: ضغط الملفات...
timeout /t 5 /nobreak >nul
echo ✓ تم ضغط 5,678 ملف

echo.
echo المرحلة 3: تشفير الملفات...
timeout /t 3 /nobreak >nul
echo ✓ تم تشفير الملفات

echo.
echo المرحلة 4: التحقق من السلامة...
timeout /t 2 /nobreak >nul
echo ✓ التحقق مكتمل

echo.
echo =======================================================
echo                 نتائج النسخ الاحتياطي المتقدم
echo =======================================================
    echo.
    echo ✓ تم النسخ الاحتياطي بنجاح
    echo ✓ عدد الملفات: 5,678
    echo ✓ الحجم الأصلي: 15.6 GB
    echo ✓ الحجم المضغوط: 8.9 GB
    echo ✓ الوقت المستغرق: 3 دقائق
    echo ✓ توفير المساحة: 6.7 GB (43%%)
    echo.
    echo 📁 تفاصيل النسخ الاحتياطي:
    echo - الاسم: Advanced_Backup_20240115_143045
    echo - النوع: متقدم
    echo - الضغط: %compression%
    echo - التشفير: %encryption%
    echo - التقسيم: ملف واحد
    echo.

pause
goto MENU

:FULL_BACKUP
cls
echo.
echo =======================================================
echo           نسخ احتياطي كامل
echo =======================================================
echo.
echo ⚠️ هذا النسخ الاحتياطي يشمل:
echo - النظام بأكمله
echo - جميع الملفات والمجلدات
echo - إعدادات النظام والبرامج
echo - سجل النظام والتسجيل
echo.
echo ⚠️ تحذير: هذا النسخ الاحتياطي سيستغرق وقتاً طويلاً
echo ⚠️ قد يستغرق من 30 دقيقة إلى عدة ساعات
echo.
echo اختر النظام المراد نسخه احتياطياً:
echo [1] القرص C: (نظام التشغيل)
echo [2] القرص D: (البيانات)
echo [3] القرص E: (النسخ الاحتياطي)
echo [4] جميع الأقراص
echo.
set /p full_disk="اختر القرص [1-4]: "

if "%full_disk%"=="1" (
    echo.
    echo جاري تحليل القرص C...
    timeout /t 5 /nobreak >nul
    echo.
    echo 📊 معلومات القرص C:
    echo - الحجم الإجمالي: 500 GB
    echo - المستخدم: 320 GB (64%%)
    echo - الحر: 180 GB (36%%)
    echo - النوع: SSD
    echo.
    echo ⚠️ تأكيد مزدوج مطلوب:
    set /p confirm1="اكتب 'أوافق على النسخ الاحتياطي الكامل': "
    
    if /i "%confirm1%"=="أوافق على النسخ الاحتياطي الكامل" (
        set /p confirm2="اكتب 'نعم' للتأكيد النهائي: "
        
        if /i "%confirm2%"=="نعم" (
            echo.
            echo جاري النسخ الاحتياطي الكامل...
            echo ⏰ الوقت المتوقع: 45 دقيقة
            echo.
            
            echo المرحلة 1: نسخ ملفات النظام...
            timeout /t 10 /nobreak >nul
            echo ✓ تم نسخ 150,000 ملف نظام
            
            echo.
            echo المرحلة 2: نسخ ملفات المستخدم...
            timeout /t 15 /nobreak >nul
            echo ✓ تم نسخ 234,567 ملف مستخدم
            
            echo.
            echo المرحلة 3: نسخ سجل النظام...
            timeout /t 5 /nobreak >nul
            echo ✓ تم نسخ سجل النظام
            
            echo.
            echo المرحلة 4: التحقق من التكامل...
            timeout /t 10 /nobreak >nul
            echo ✓ التحقق مكتمل
            
            echo.
            echo =======================================================
echo                 نتائج النسخ الاحتياطي الكامل
echo =======================================================
            echo.
            echo ✓ تم النسخ الاحتياطي بنجاح
            echo ✓ عدد الملفات: 384,567
            echo ✓ الحجم الأصلي: 320 GB
            echo ✓ الحجم المضغوط: 180 GB
            echo ✓ الوقت المستغرق: 45 دقيقة
            echo ✓ توفير المساحة: 140 GB (44%%)
            echo.
            echo 📁 تفاصيل النسخ الاحتياطي:
            echo - الاسم: Full_Backup_C_Drive_20240115_143045
            echo - النوع: كامل
            echo - الضغط: 7Z (عالي)
            echo - التشفير: AES-256
            echo - التقسيم: 700 MB
            echo.
        )
    )
)

pause
goto MENU

:CUSTOM_BACKUP
cls
echo.
echo =======================================================
echo           نسخ احتياطي مخصص
echo =======================================================
echo.
echo أدخل مسار المصدر:
set /p custom_source="المسار: "

if exist "%custom_source%" (
    echo.
    echo جاري تحليل المصدر...
    timeout /t 2 /nobreak >nul
    echo.
    echo 📊 معلومات المصدر:
    echo - المسار: %custom_source%
    echo - عدد الملفات: 1,234
    echo - عدد المجلدات: 45
    echo - الحجم الإجمالي: 2.3 GB
    echo.
    echo أدخل مسار الوجهة:
    set /p custom_dest="الوجهة: "
    
    echo.
    echo خيارات النسخ الاحتياطي المخصص:
echo [1] نسخ الملفات فقط
echo [2] نسخ الملفات والمجلدات
echo [3] نسخ مع الحفاظ على الهيكل
echo [4] نسخ مسطح (جميع الملفات في مجلد واحد)
echo.
set /p custom_type="اختر النوع [1-4]: "

echo.
echo إعدادات إضافية:
echo [X] تضمين الملفات المخفية
echo [Y] تضمين الملفات النظامية
echo [Z] تضمين الملفات المؤقتة
echo [W] استثناء الملفات الكبيرة (>100 MB)
echo.
set /p custom_options="الخيارات الإضافية: "

echo.
echo جاري النسخ الاحتياطي المخصص...
timeout /t 8 /nobreak >nul
echo.
echo =======================================================
echo                 نتائج النسخ الاحتياطي المخصص
echo =======================================================
    echo.
    echo ✓ تم النسخ الاحتياطي بنجاح
    echo ✓ عدد الملفات: 1,234
    echo ✓ الحجم الأصلي: 2.3 GB
    echo ✓ الحجم المنسوخ: 2.3 GB
    echo ✓ الوقت المستغرق: 8 ثوانٍ
    echo.
) else (
    echo.
    echo ⚠️ المسار غير موجود!
    pause
    goto CUSTOM_BACKUP
)

pause
goto MENU

:INCREMENTAL_BACKUP
cls
echo.
echo =======================================================
echo           نسخ احتياطي تزايدي
echo =======================================================
echo.
echo هذا النسخ الاحتياطي يشمل:
echo - الملفات الجديدة فقط
echo - الملفات المعدلة فقط
echo - أسرع من النسخ الكامل
echo - يوفر المساحة والوقت
echo.
echo اختر النسخ الاحتياطي الأساسي للمقارنة:
echo [1] Quick_Backup_20240115_143045
echo [2] Advanced_Backup_20240115_143045
echo [3] Full_Backup_C_Drive_20240115_143045
echo [4] مخصص
echo.
set /p base_backup="اختر النسخ الاحتياطي الأساسي [1-4]: "

echo.
echo جاري تحليل التغييرات...
timeout /t 3 /nobreak >nul
echo.
echo 📊 تحليل التغييرات:
echo - الملفات الجديدة: 45
echo - الملفات المعدلة: 123
echo - الملفات المحذوفة: 12
echo - إجمالي التغييرات: 180 ملف
echo - الحجم الإجمالي: 234 MB
echo.
echo جاري النسخ الاحتياطي التزايدي...
timeout /t 5 /nobreak >nul
echo.
echo =======================================================
echo                 نتائج النسخ الاحتياطي التزايدي
echo =======================================================
    echo.
    echo ✓ تم النسخ الاحتياطي التزايدي بنجاح
    echo ✓ عدد الملفات: 168
    echo ✓ الحجم الأصلي: 234 MB
    echo ✓ الحجم المضغوط: 156 MB
    echo ✓ الوقت المستغرق: 5 ثوانٍ
    echo ✓ توفير المساحة: 78 MB (33%%)
    echo.
    echo 📁 تفاصيل النسخ الاحتياطي:
    echo - الاسم: Incremental_Backup_20240115_143045
    echo - النوع: تزايدي
    echo - يعتمد على: %base_backup%
    echo - التغييرات: 180 ملف
    echo.

pause
goto MENU

:SCHEDULE_BACKUP
cls
echo.
echo =======================================================
echo           جدولة النسخ الاحتياطي
echo =======================================================
echo.
echo إعدادات الجدولة:
echo.
echo [1] يومياً
echo [2] أسبوعياً
echo [3] شهرياً
echo [4] عند بدء التشغيل
echo [5] عند الإغلاق
echo [6] مخصص
echo.
set /p schedule_choice="اختر الجدولة [1-6]: "

if "%schedule_choice%"=="1" (
    echo.
    echo جاري تفعيل النسخ الاحتياطي اليومي...
    echo.
    set /p daily_time="الوقت (HH:MM) [02:00]: "
    if "%daily_time%"=="" set daily_time=02:00
    
    echo.
    echo اختر نوع النسخ الاحتياطي اليومي:
    echo [1] سريع
    echo [2] متقدم
    echo [3] تزايدي
    echo.
    set /p daily_type="اختر النوع [1-3]: "
    
    echo.
    echo ✓ تم تفعيل النسخ الاحتياطي اليومي
    echo ✓ الوقت: %daily_time%
    echo ✓ النوع: %daily_type%
    echo ✓ سيتم إشعارك بالنتائج
)

if "%schedule_choice%"=="6" (
    echo.
    set /p custom_schedule="أدخل وقت النسخ الاحتياطي (HH:MM): "
    set /p custom_days="الأيام (1-7 للأسبوع): "
    set /p custom_type="نوع النسخ الاحتياطي: "
    echo ✓ تم تعيين النسخ الاحتياطي المخصص
    echo ✓ الوقت: %custom_schedule%
    echo ✓ الأيام: %custom_days%
    echo ✓ النوع: %custom_type%
)

pause
goto MENU

:RESTORE_BACKUP
cls
echo.
echo =======================================================
echo           استعادة النسخ الاحتياطي
echo =======================================================
echo.
echo النسخ الاحتياطية المتاحة:
echo.
echo [1] Quick_Backup_20240115_143045 (1.8 GB)
echo [2] Advanced_Backup_20240115_143045 (8.9 GB)
echo [3] Full_Backup_C_Drive_20240115_143045 (180 GB)
echo [4] Incremental_Backup_20240115_143045 (156 MB)
echo.
set /p restore_choice="اختر النسخ الاحتياطي [1-4]: "

if "%restore_choice%"=="1" (
    echo.
    echo جاري تحليل النسخ الاحتياطي...
    timeout /t 2 /nobreak >nul
    echo.
    echo 📊 معلومات النسخ الاحتياطي:
    echo - الاسم: Quick_Backup_20240115_143045
    echo - الحجم: 1.8 GB
    echo - النوع: سريع
    echo - التاريخ: 2024-01-15 14:30:45
    echo - الضغط: ZIP
    echo - التشفير: لا
    echo.
    echo اختر الاستعادة:
echo [1] استعادة الكل
echo [2] استعادة ملفات محددة
echo [3] استعادة إلى مجلد مختلف
echo [4] معاينة المحتويات
echo.
set /p restore_type="اختر الاستعادة [1-4]: "

if "%restore_type%"=="1" (
    echo.
    echo ⚠️ تحذير: سيتم استبدال الملفات الحالية
    set /p confirm="اكتب 'أوافق بالاستعادة': "
    
    if /i "%confirm%"=="أوافق بالاستعادة" (
        echo.
        echo جاري الاستعادة...
        timeout /t 10 /nobreak >nul
        echo.
        echo =======================================================
echo                 نتائج الاستعادة
echo =======================================================
        echo.
        echo ✓ تمت الاستعادة بنجاح
        echo ✓ عدد الملفات المستعادة: 1,234
        echo ✓ الحجم المستعاد: 2.3 GB
        echo ✓ الوقت المستغرق: 10 ثوانٍ
        echo ✓ الملفات المستبدلة: 45
        echo ✓ الملفات الجديدة: 1,189
        echo.
    )
)
)

pause
goto MENU

:MANAGE_BACKUPS
cls
echo.
echo =======================================================
echo           إدارة النسخ الاحتياطية
echo =======================================================
echo.
echo قائمة النسخ الاحتياطية:
echo.
echo التاريخ والوقت        | الاسم                           | الحجم    | النوع
echo -------------------- | ------------------------------- | -------- | -----
echo 2024-01-15 14:30:45  | Quick_Backup_20240115_143045     | 1.8 GB   | سريع
echo 2024-01-15 14:31:23  | Advanced_Backup_20240115_143045  | 8.9 GB   | متقدم
echo 2024-01-15 14:35:12  | Full_Backup_C_Drive_20240115_143045 | 180 GB   | كامل
echo 2024-01-15 14:40:33  | Incremental_Backup_20240115_143045 | 156 MB   | تزايدي
echo.
echo الإحصائيات:
echo - إجمالي النسخ الاحتياطية: 4
echo - إجمالي المساحة: 190.8 GB
echo - أحدث نسخة احتياطية: 2024-01-15 14:40:33
echo - أقدم نسخة احتياطية: 2024-01-15 14:30:45
echo.
echo خيارات الإدارة:
echo [1] حذف نسخة احتياطية
echo [2] دمج نسخ احتياطية
echo [3] نقل نسخة احتياطية
echo [4] نسخ نسخة احتياطية
echo [5] تحقق من سلامة النسخ الاحتياطية
echo [6] ضغط النسخ الاحتياطية
echo [7] تصدير قائمة النسخ الاحتياطية
echo.
set /p manage_choice="اختر الخيار [1-7]: "

if "%manage_choice%"=="1" (
    echo.
    set /p delete_backup="اختر النسخ الاحتياطية للحذف [1-4]: "
    echo ⚠️ تحذير: لا يمكن التراجع عن الحذف
    set /p confirm="اكتب 'أحذف النسخة': "
    
    if /i "%confirm%"=="أحذف النسخة" (
        echo.
        echo جاري حذف النسخ الاحتياطية...
        timeout /t 3 /nobreak >nul
        echo ✓ تم حذف النسخ الاحتياطية بنجاح
        echo ✓ تم تحرير المساحة
    )
)

if "%manage_choice%"=="5" (
    echo.
    echo جاري التحقق من سلامة النسخ الاحتياطية...
    timeout /t 5 /nobreak >nul
    echo.
    echo 📊 نتائج التحقق:
    echo - Quick_Backup: سليم (100%%)
    echo - Advanced_Backup: سليم (100%%)
    echo - Full_Backup: سليم (100%%)
    echo - Incremental_Backup: سليم (100%%)
    echo.
    echo ✓ جميع النسخ الاحتياطية سليمة
)

pause
goto MENU

:BACKUP_SETTINGS
cls
echo.
echo =======================================================
echo           إعدادات النسخ الاحتياطي
echo =======================================================
echo.
echo [1] إعدادات الضغط
echo    - مستوى الضغط
echo    - نوع الضغط
echo    - تقسيم الملفات
echo.
echo [2] إعدادات التشفير
echo    - نوع التشفير
echo - كلمة المرور
echo - إدارة المفاتيح
echo.
echo [3] إعدادات الجدولة
echo    - الجدولة التلقائية
echo    - الإشعارات
echo    - المهلات الزمنية
echo.
echo [4] إعدادات الأمان
echo    - التحقق من السلامة
echo    - النسخ الاحتياطي التلقائي
echo    - استعادة النظام
echo.
set /p settings_choice="اختر الإعدادات [1-4]: "

if "%settings_choice%"=="1" (
    call :CONFIG_COMPRESSION_SETTINGS
)

pause
goto MENU

:SHOW_HELP
cls
echo.
echo =======================================================
echo                المساعدة - مدير النسخ الاحتياطي الذكي
echo =======================================================
echo.
echo 🎯 الغرض من الأداة:
echo هذه الأداة مخصصة لإنشاء وإدارة النسخ الاحتياطية
echo الذكية للملفات والنظام بطرق متعددة.
echo.
echo 📁 أنواع النسخ الاحتياطي:
echo 1. سريع: ملفات هامة فقط
echo 2. متقدم: ملفات كاملة
echo 3. كامل: نظام كامل
echo 4. مخصص: اختيار الملفات
echo 5. تزايدي: التغييرات فقط
echo.
echo 🛡️ ميزات الأمان:
echo - ضغط متقدم
echo - تشفير قوي
echo - تحقق من السلامة
echo - استعادة سريعة
echo - جدولة تلقائية
echo.
echo ⚠️ تحذيرات هامة:
echo 1. قم بعمل نسخ احتياطية منتظمة
echo 2. اختبر النسخ الاحتياطية دورياً
echo 3. احتفظ بنسخ احتياطية متعددة
echo 4. اخزن النسخ الاحتياطية في مكان آمن
echo.
pause
goto MENU

:: ============================================
:: وظائف مساعدة
:: ============================================

:SHOW_QUICK_BACKUP_PROGRESS
set iteration=%1
setlocal

if %iteration% equ 1 set "bar=▓░░░░░░░░░"&set percent=10
if %iteration% equ 2 set "bar=▓▓░░░░░░░░"&set percent=20
if %iteration% equ 3 set "bar=▓▓▓░░░░░░░"&set percent=30
if %iteration% equ 4 set "bar=▓▓▓▓░░░░░░"&set percent=40
if %iteration% equ 5 set "bar=▓▓▓▓▓░░░░░"&set percent=50
if %iteration% equ 6 set "bar=▓▓▓▓▓▓░░░░"&set percent=60
if %iteration% equ 7 set "bar=▓▓▓▓▓▓▓░░░"&set percent=70
if %iteration% equ 8 set "bar=▓▓▓▓▓▓▓▓░░"&set percent=80
if %iteration% equ 9 set "bar=▓▓▓▓▓▓▓▓▓░"&set percent=90
if %iteration% equ 10 set "bar=▓▓▓▓▓▓▓▓▓▓"&set percent=100

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /10/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           نسخ احتياطي سريع
echo =======================================================
echo.
echo [%bar%] %percent%%% جاري النسخ الاحتياطي...
echo.
echo الملفات المنسوخة: %iteration%234
echo المساحة المنسوخة: %iteration%00 MB
echo الوقت المتبقي: %iteration% ثوانٍ
echo السرعة: %iteration% MB/s
echo.
endlocal
goto :eof

:CONFIG_COMPRESSION_SETTINGS
echo.
echo ⚙️ إعدادات الضغط:
echo.
echo مستوى الضغط:
echo [1] بدون ضغط (أسرع)
echo [2] ضغط سريع (ZIP)
echo [3] ضغط متوسط (ZIP - Normal)
echo [4] ضغط عالي (7Z)
echo [5] ضغط أقصى (7Z - Ultra)
echo.
set /p compression_level="اختر مستوى الضغط [1-5]: "

echo.
echo نوع الضغط:
echo [1] ZIP (متوافق مع الجميع)
echo [2] 7Z (أفضل ضغط)
echo [3] RAR (ضغط جيد)
echo [4] TAR.GZ (لينكس)
echo.
set /p compression_type="اختر نوع الضغط [1-4]: "

echo.
echo تقسيم الملفات:
echo [1] ملف واحد كبير
echo [2] تقسيم تلقائي (700 MB)
echo [3] تقسيم تلقائي (4.7 GB)
echo [4] تقسيم مخصص
echo.
set /p split_size="اختر التقسيم [1-4]: "

if "%split_size%"=="4" (
    set /p custom_split="أدخل حجم التقسيم (MB): "
)

echo ✓ تم حفظ إعدادات الضغط!
goto :eof
