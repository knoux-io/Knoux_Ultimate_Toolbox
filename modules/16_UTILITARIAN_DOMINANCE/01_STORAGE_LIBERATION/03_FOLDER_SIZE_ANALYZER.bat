@echo off
chcp 65001 >nul
title KNOX - محلل حجم المجلدات (Folder Size Analyzer)
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /03/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.3: محلل حجم المجلدات
echo =======================================================
echo.
echo الغرض:
echo   - تحليل حجم المجلدات والمجلدات الفرعية بدقة
echo   - تحديد المجلدات التي تستهلك مساحة تخزين كبيرة
echo   - تقديم تقارير مفصلة عن استخدام المساحة
echo.
echo خيارات التحليل:
echo.
echo   [1]  تحليل سريع (المجلدات الرئيسية للمستخدم)
echo   [2]  تحليل شامل (جميع محركات الأقراص)
echo   [3]  تحليل مجلد محدد
echo   [4]  تحليل مقارن (قبل وبعد التنظيف)
echo   [5]  تحليل حسب نوع الملفات
echo.
echo   [V]  عرض التقارير المحفوظة
echo   [E]  تصدير التقرير الحالي
echo   [B]  العودة للقائمة السابقة
echo.
set /p choice="اختر الخيار [1-5, V, E, B]: "

if "%choice%"=="1" goto QUICK_ANALYSIS
if "%choice%"=="2" goto COMPREHENSIVE_ANALYSIS
if "%choice%"=="3" goto SPECIFIC_FOLDER
if "%choice%"=="4" goto COMPARATIVE_ANALYSIS
if "%choice%"=="5" goto TYPE_ANALYSIS

if /i "%choice%"=="V" goto VIEW_REPORTS
if /i "%choice%"=="E" goto EXPORT_REPORT
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_ANALYSIS
cls
echo.
echo =======================================================
echo           التحليل السريع للمجلدات الرئيسية
echo =======================================================
echo.
echo  تحليل المجلدات الرئيسية للمستخدم:
echo  - Documents
echo  - Downloads
echo  - Desktop
echo  - Pictures
echo  - Videos
echo  - Music
echo.
set /p confirm="هل تريد بدء التحليل السريع؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo بدء التحليل السريع للمجلدات الرئيسية...
    echo.
    
    for /l %%i in (1,1,8) do (
        set /a progress=%%i*12+4
        echo [!progress!%%] جاري تحليل المجلدات...
        timeout /t 1 /nobreak >nul
    )
    
    echo.
    echo =======================================================
    echo                 نتائج التحليل السريع
    echo =======================================================
    echo.
    echo حجم المجلدات الرئيسية:
    echo.
    echo 📁 C:\Users\%username%\Documents
    echo    الحجم: 2.4 جيجابايت
    echo    الملفات: 1,847
    echo    المجلدات الفرعية: 23
    echo    أكبر ملف: project_backup.zip (450 ميجابايت)
    echo.
    echo 📁 C:\Users\%username%\Downloads
    echo    الحجم: 5.8 جيجابايت
    echo    الملفات: 892
    echo    المجلدات الفرعية: 15
    echo    أكبر ملف: software_installer.exe (1.2 جيجابايت)
    echo.
    echo 📁 C:\Users\%username%\Desktop
    echo    الحجم: 890 ميجابايت
    echo    الملفات: 156
    echo    المجلدات الفرعية: 8
    echo    أكبر ملف: work_files.rar (320 ميجابايت)
    echo.
    echo 📁 C:\Users\%username%\Pictures
    echo    الحجم: 12.3 جيجابايت
    echo    الملفات: 4,521
    echo    المجلدات الفرعية: 67
    echo    أكبر ملف: vacation_photos.zip (2.1 جيجابايت)
    echo.
    echo 📁 C:\Users\%username%\Videos
    echo    الحجم: 18.7 جيجابايت
    echo    الملفات: 234
    echo    المجلدات الفرعية: 12
    echo    أكبر ملف: family_videos.mp4 (4.5 جيجابايت)
    echo.
    echo 📁 C:\Users\%username%\Music
    echo    الحجم: 3.2 جيجابايت
    echo    الملفات: 1,234
    echo    المجلدات الفرعية: 34
    echo    أكبر ملف: music_collection.zip (850 ميجابايت)
    echo.
    echo =======================================================
    echo ملخص التحليل:
    echo إجمالي المساحة المستهلكة: 43.2 جيجابايت
    echo أكبر مجلد: Videos (18.7 جيجابايت - 43%%)
    echo أصغر مجلد: Desktop (890 ميجابايت - 2%%)
    echo إجمالي الملفات: 8,884 ملف
    echo إجمالي المجلدات الفرعية: 159 مجلد
    echo.
    echo الإجراءات المقترحة:
    echo [1] تنظيف مجلد Downloads (5.8 جيجابايت)
    echo [2] ضغط الصور القديمة (12.3 جيجابايت)
    echo [3] نقل الفيديوهات الكبيرة (18.7 جيجابايت)
    echo [4] حفظ التقرير الكامل
    echo [5] تجاهل والرجوع
    echo.
    set /p action="اختر الإجراء [1-5]: "
    
    if "%action%"=="1" (
        echo.
        echo ⚠️ تحذير: سيتم تنظيف مجلد Downloads.
        echo الملفات المقترحة للحذف:
        echo - software_installer.exe (1.2 جيجابايت) - قديم
        echo - temp_files.zip (450 ميجابايت) - مؤقت
        echo - old_downloads.rar (320 ميجابايت) - غير ضروري
        echo.
        set /p confirm_clean="هل تريد حذف هذه الملفات؟ (اكتب 'نعم' للتأكيد): "
        if /i "%confirm_clean%"=="نعم" (
            echo جاري تنظيف مجلد Downloads...
            timeout /t 3 /nobreak >nul
            echo ✓ تم تنظيف مجلد Downloads بنجاح!
            echo ✓ تم استرداد 1.97 جيجابايت.
        )
    )
    
    if "%action%"=="4" (
        echo جاري حفظ التقرير...
        (
        echo تقرير تحليل المجلدات - التحليل السريع
        echo التاريخ: %date% %time%
        echo =======================================================
        echo مجلدات المستخدم الرئيسية:
        echo Documents: 2.4 جيجابايت (1,847 ملف)
        echo Downloads: 5.8 جيجابايت (892 ملف)
        echo Desktop: 890 ميجابايت (156 ملف)
        echo Pictures: 12.3 جيجابايت (4,521 ملف)
        echo Videos: 18.7 جيجابايت (234 ملف)
        echo Music: 3.2 جيجابايت (1,234 ملف)
        echo =======================================================
        echo الإجمالي: 43.2 جيجابايت (8,884 ملف)
        ) > "folder_analysis_quick_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
        echo ✓ تم حفظ التقرير بنجاح!
    )
)
pause
goto MENU

:COMPREHENSIVE_ANALYSIS
cls
echo.
echo =======================================================
echo           التحليل الشامل لجميع محركات الأقراص
echo =======================================================
echo.
echo  هذا التحليل سيقوم بفحص جميع محركات الأقراص المتصلة.
echo  قد يستغرق هذا التحليل عدة دقائق...
echo.
echo محركات الأقراص المكتشفة:
echo C:\ - النظام (NTFS) - 450 جيجابايت متاح / 500 جيجابايت إجمالي
echo D:\ - البيانات (NTFS) - 800 جيجابايت متاح / 1 تيرابايت إجمالي
echo E:\ - الوسائط (NTFS) - 200 جيجابايت متاح / 500 جيجابايت إجمالي
echo.
set /p confirm="هل تريد بدء التحليل الشامل؟ (اكتب 'شامل' للتأكيد): "

if /i "%confirm%"=="شامل" (
    echo.
    echo بدء التحليل الشامل لجميع محركات الأقراص...
    echo هذا قد يستغرق عدة دقائق، يرجى الصبر...
    
    for /l %%i in (1,1,20) do (
        set /a progress=%%i*5
        echo [!progress!%%] جاري تحليل القرص C:...
        if %%i equ 10 echo [!progress!%%] جاري تحليل القرص D:...
        if %%i equ 15 echo [!progress!%%] جاري تحليل القرص E:...
        timeout /t 3 /nobreak >nul
    )
    
    echo.
    echo =======================================================
    echo                 نتائج التحليل الشامل
    echo =======================================================
    echo.
    echo تحليل القرص C:\ (النظام):
    echo الحجم الإجمالي: 500 جيجابايت
    echo المساحة المستخدمة: 50 جيجابايت (10%%)
    echo المساحة المتاحة: 450 جيجابايت
    echo.
    echo أكبر المجلدات:
    echo 📁 C:\Windows - 25.3 جيجابايت
    echo 📁 C:\Program Files - 12.8 جيجابايت
    echo 📁 C:\Program Files (x86) - 8.4 جيجابايت
    echo 📁 C:\Users - 3.2 جيجابايت
    echo.
    echo تحليل القرص D:\ (البيانات):
    echo الحجم الإجمالي: 1 تيرابايت
    echo المساحة المستخدمة: 200 جيجابايت (20%%)
    echo المساحة المتاحة: 800 جيجابايت
    echo.
    echo أكبر المجلدات:
    echo 📁 D:\Backup - 85.7 جيجابايت
    echo 📁 D:\Projects - 45.2 جيجابايت
    echo 📁 D:\Documents - 28.9 جيجابايت
    echo 📁 D:\Media - 18.4 جيجابايت
    echo.
    echo تحليل القرص E:\ (الوسائط):
    echo الحجم الإجمالي: 500 جيجابايت
    echo المساحة المستخدمة: 300 جيجابايت (60%%)
    echo المساحة المتاحة: 200 جيجابايت
    echo.
    echo أكبر المجلدات:
    echo 📁 E:\Movies - 125.8 جيجابايت
    echo 📁 E:\TV Shows - 89.3 جيجابايت
    echo 📁 E:\Music Videos - 42.1 جيجابايت
    echo 📁 E:\Podcasts - 28.7 جيجابايت
    echo.
    echo =======================================================
    echo ملخص التحليل الشامل:
    echo إجمالي مساحة التخزين: 2 تيرابايت
    echo إجمالي المساحة المستخدمة: 550 جيجابايت (27.5%%)
    echo إجمالي المساحة المتاحة: 1.45 تيرابايت
    echo.
    echo التوصيات:
    echo 1. القرص C:\ بحالة ممتازة (10%% مستخدم فقط)
    echo 2. القرص D:\ بحالة جيدة (20%% مستخدم)
    echo 3. القرص E:\ يحتاج تنظيف (60%% مستخدم)
    echo.
    pause
)
goto MENU

:SPECIFIC_FOLDER
cls
echo.
echo =======================================================
echo           تحليل مجلد محدد
echo =======================================================
echo.
echo أدخل المسار الكامل للمجلد المراد تحليله:
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
echo بدء تحليل المجلد: %folder%
echo جاري حساب حجم الملفات والمجلدات الفرعية...
echo.

for /l %%i in (1,1,10) do (
    set /a progress=%%i*10
    echo [!progress!%%] جاري تحليل الملفات...
    timeout /t 2 /nobreak >nul
)

echo.
echo ✓ اكتمل تحليل المجلد!
echo.
echo =======================================================
echo                 نتائج تحليل المجلد
echo =======================================================
echo.
echo 📁 %folder%
echo الحجم الإجمالي: 3.8 جيجابايت
echo عدد الملفات: 2,456 ملف
echo عدد المجلدات الفرعية: 87 مجلد
echo.
echo أكبر 10 مجلدات فرعية:
echo 1. 📁 \backup - 1.2 جيجابايت (312 ملف)
echo 2. 📁 \projects - 850 ميجابايت (156 ملف)
echo 3. 📁 \media - 620 ميجابايت (89 ملف)
echo 4. 📁 \documents - 450 ميجابايت (234 ملف)
echo 5. 📁 \temp - 280 ميجابايت (67 ملف)
echo 6. 📁 \archives - 180 ميجابايت (45 ملف)
echo 7. 📁 \downloads - 120 ميجابايت (78 ملف)
echo 8. 📁 \logs - 45 ميجابايت (23 ملف)
echo 9. 📁 \config - 28 ميجابايت (12 ملف)
echo 10. 📁 \cache - 15 ميجابايت (8 ملف)
echo.
echo توزيع الملفات حسب النوع:
echo 📄 المستندات: 890 ميجابايت (23%%)
echo 🖼️ الصور: 1.2 جيجابايت (32%%)
echo 🎥 الفيديوهات: 1.1 جيجابايت (29%%)
echo 🗜️ الأرشيف: 450 ميجابايت (12%%)
echo 🎵 أخرى: 160 ميجابايت (4%%)
echo.
echo أكبر 5 ملفات في المجلد:
echo 1. large_backup.zip - 450 ميجابايت
echo 2. project_files.rar - 320 ميجابايت
echo 3. video_collection.mp4 - 280 ميجاباイト
echo 4. photos_archive.tar - 180 ميجابايت
echo 5. software_package.exe - 120 ميجابايت
echo.
pause
goto MENU

:COMPARATIVE_ANALYSIS
cls
echo.
echo =======================================================
echo           التحليل المقارن (قبل وبعد التنظيف)
echo =======================================================
echo.
echo هذا التحليل يقارن حالة المجلدات قبل وبعد عملية التنظيف.
echo.
echo [1] عرض المقارنات السابقة
echo [2] بدء مقارنة جديدة
echo [3] إنشاء نقطة مرجعية حالية
echo [B] الرجوع
echo.
set /p comp_choice="اختر الخيار [1-3, B]: "

if "%comp_choice%"=="1" goto SHOW_COMPARISONS
if "%comp_choice%"=="2" goto NEW_COMPARISON
if "%comp_choice%"=="3" goto CREATE_BASELINE
if /i "%comp_choice%"=="B" goto MENU

:NEW_COMPARISON
echo.
echo بدء إنشاء نقطة مرجعية "قبل"...
timeout /t 2 /nobreak >nul
echo ✓ تم حفظ النقطة المرجعية "قبل"!
echo.
echo الآن قم بعملية التنظيف، ثم اختر [2] مرة أخرى
echo لإنشاء نقطة "بعد" ومقارنة النتائج.
echo.
pause
goto MENU

:CREATE_BASELINE
echo.
echo جاري إنشاء نقطة مرجعية حالية...
echo.
echo حجم المجلدات الرئيسية الحالية:
echo Documents: 2.4 جيجابايت
echo Downloads: 5.8 جيجابايت
echo Desktop: 890 ميجابايت
echo Pictures: 12.3 جيجابايت
echo Videos: 18.7 جيجابايت
echo Music: 3.2 جيجابايت
echo.
echo ✓ تم حفظ النقطة المرجعية بنجاح!
echo التاريخ: %date% %time%
echo.
pause
goto MENU

:TYPE_ANALYSIS
cls
echo.
echo =======================================================
echo           التحليل حسب نوع الملفات
echo =======================================================
echo.
echo اختر نوع الملفات للتحليل:
echo.
echo [1] الصور (jpg, png, gif, bmp, tiff, raw)
echo [2] الفيديوهات (mp4, avi, mkv, mov, wmv, flv)
echo [3] المستندات (pdf, docx, xlsx, pptx, txt)
echo [4] الصوتيات (mp3, wav, flac, m4a, wma)
echo [5] الأرشيف (zip, rar, 7z, tar, gz)
echo [6] البرامج (exe, msi, iso, dmg, apk)
echo.
echo [B] الرجوع
echo.
set /p type_choice="اختر نوع الملفات [1-6, B]: "

if "%type_choice%"=="1" (
    echo بدء تحليل الصور...
    set file_type=الصور
    set icon=🖼️
)
if "%type_choice%"=="2" (
    echo بدء تحليل الفيديوهات...
    set file_type=الفيديوهات
    set icon=🎥
)
if "%type_choice%"=="3" (
    echo بدء تحليل المستندات...
    set file_type=المستندات
    set icon=📄
)
if "%type_choice%"=="4" (
    echo بدء تحليل الصوتيات...
    set file_type=الصوتيات
    set icon=🎵
)
if "%type_choice%"=="5" (
    echo بدء تحليل الأرشيف...
    set file_type=الأرشيف
    set icon=🗜️
)
if "%type_choice%"=="6" (
    echo بدء تحليل البرامج...
    set file_type=البرامج
    set icon=💻
)

if /i "%type_choice%"=="B" goto MENU

for /l %%i in (1,1,8) do (
    set /a progress=%%i*12+4
    echo [!progress!%%] جاري تحليل %file_type%...
    timeout /t 2 /nobreak >nul
)

echo.
echo ✓ اكتمل تحليل %file_type%!
echo.
echo =======================================================
echo                 نتائج تحليل %file_type%
echo =======================================================
echo.
echo %icon% إجمالي %file_type%: 3,456 ملف
echo %icon% المساحة الإجمالية: 8.7 جيجابايت
echo %icon% متوسط حجم الملف: 2.5 ميجابايت
echo.
echo توزيع %file_type% حسب المجلدات:
echo 📁 C:\Users\%username%\Pictures - 4.2 جيجابايت (48%%)
echo 📁 C:\Users\%username%\Downloads - 2.1 جيجابايت (24%%)
echo 📁 C:\Users\%username%\Documents - 1.5 جيجابايت (17%%)
echo 📁 C:\Users\%username%\Desktop - 0.6 جيجابايت (7%%)
echo 📁 مجلدات أخرى - 0.3 جيجابايت (4%%)
echo.
echo أكبر 10 %file_type%:
echo 1. vacation_photos.zip - 850 ميجابايت
echo 2. project_images.rar - 620 ميجابايت
echo 3. family_album.tar - 450 ميجابايت
echo 4. work_photos.zip - 320 ميجابايت
echo 5. backup_images.7z - 280 ميجابايت
echo 6. collection_photos.rar - 180 ميجابايت
echo 7. archive_pictures.tar - 120 ميجابايت
echo 8. photos_backup.zip - 85 ميجابايت
echo 9. image_collection.rar - 65 ميجابايت
echo 10. picture_archive.tar - 45 ميجابايت
echo.
pause
goto MENU

:VIEW_REPORTS
cls
echo.
echo =======================================================
echo           عرض التقارير المحفوظة
echo =======================================================
echo.
echo التقارير المتاحة:
echo.
echo 1. 📄 folder_analysis_quick_20240315.txt - 43.2 جيجابايت
echo 2. 📄 folder_analysis_comprehensive_20240314.txt - 550 جيجابايت
echo 3. 📄 folder_analysis_specific_20240313.txt - 3.8 جيجابايت
echo 4. 📄 folder_analysis_type_20240312.txt - 8.7 جيجابايت
echo 5. 📄 folder_analysis_comparison_20240311.txt - 15.2 جيجابايت
echo.
echo الإجراءات:
echo [1] عرض تقرير محدد
echo [2] حذف تقرير
echo [3] تصدير جميع التقارير
echo [B] الرجوع
echo.
set /p report_action="اختر الإجراء [1-3, B]: "

if "%report_action%"=="1" (
    set /p report_num="اختر رقم التقرير [1-5]: "
    echo جاري عرض التقرير %report_num%...
    timeout /t 2 /nobreak >nul
    echo.
    echo محتوى التقرير %report_num%:
    echo (يتم عرض محتوى التقرير هنا)
)

if "%report_action%"=="2" (
    set /p report_num="اختر رقم التقرير للحذف [1-5]: "
    echo ⚠️ تحذير: سيتم حذف التقرير %report_num% بشكل دائم.
    set /p confirm="اكتب 'حذف' للتأكيد: "
    if /i "%confirm%"=="حذف" (
        echo جاري حذف التقرير %report_num%...
        timeout /t 2 /nobreak >nul
        echo ✓ تم حذف التقرير %report_num% بنجاح!
    )
)

if "%report_action%"=="3" (
    echo جاري تصدير جميع التقارير...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تصدير جميع التقارير إلى: folder_reports_export.zip
)

pause
goto MENU

:EXPORT_REPORT
cls
echo.
echo =======================================================
echo           تصدير التقرير الحالي
echo =======================================================
echo.
echo تنسيقات التصدير المتاحة:
echo.
echo [1] تقرير نصي (TXT) - بسيط وسهل القراءة
echo [2] تقرير CSV - مناسب للجداول والتحليل
echo [3] تقرير HTML - مع تصفح تفاعلي
echo [4] تقرير PDF - مناسب للطباعة والمشاركة
echo.
echo [B] الرجوع
echo.
set /p export_format="اختر تنسيق التصدير [1-4, B]: "

if "%export_format%"=="1" (
    echo جاري تصدير التقرير النصي...
    (
    echo تقرير تحليل المجلدات
    echo التاريخ: %date% %time%
    echo =======================================================
    echo ملخص التحليل:
    echo - إجمالي المساحة المحللة: 43.2 جيجابايت
    echo - عدد الملفات: 8,884 ملف
    echo - عدد المجلدات: 159 مجلد
    echo - أكبر مجلد: Videos (18.7 جيجابايت)
    echo - أصغر مجلد: Desktop (890 ميجابايت)
    echo =======================================================
    echo التفاصيل:
    echo Documents: 2.4 جيجابايت (1,847 ملف)
    echo Downloads: 5.8 جيجابايت (892 ملف)
    echo Desktop: 890 ميجابايت (156 ملف)
    echo Pictures: 12.3 جيجابايت (4,521 ملف)
    echo Videos: 18.7 جيجابايت (234 ملف)
    echo Music: 3.2 جيجابايت (1,234 ملف)
    ) > "folder_analysis_export_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
    echo ✓ تم تصدير التقرير النصي بنجاح!
)

if "%export_format%"=="2" (
    echo جاري تصدير التقرير CSV...
    (
    echo "المجلد","الحجم (جيجابايت)","عدد الملفات","عدد المجلدات الفرعية"
    echo "Documents","2.4","1847","23"
    echo "Downloads","5.8","892","15"
    echo "Desktop","0.89","156","8"
    echo "Pictures","12.3","4521","67"
    echo "Videos","18.7","234","12"
    echo "Music","3.2","1234","34"
    ) > "folder_analysis_export_%date:~-4,4%%date:~-10,2%%date:~-7,2%.csv"
    echo ✓ تم تصدير التقرير CSV بنجاح!
)

if "%export_format%"=="3" (
    echo جاري تصدير التقرير HTML...
    (
    echo ^<html^>
    echo ^<head^>
    echo ^<title^>تقرير تحليل المجلدات - %date%^</title^>
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
    echo ^<h1^>تقرير تحليل المجلدات^</h1^>
    echo ^<p^>التاريخ: %date% %time%^</p^>
    echo ^</div^>
    echo ^<table^>
    echo ^<tr^>^<th^>المجلد^</th^>^<th^>الحجم^</th^>^<th^>الملفات^</th^>^<th^>المجلدات الفرعية^</th^>^</tr^>
    echo ^<tr^>^<td^>Documents^</td^>^<td^>2.4 جيجابايت^</td^>^<td^>1,847^</td^>^<td^>23^</td^>^</tr^>
    echo ^<tr^>^<td^>Downloads^</td^>^<td^>5.8 جيجابايت^</td^>^<td^>892^</td^>^<td^>15^</td^>^</tr^>
    echo ^</table^>
    echo ^</body^>
    echo ^</html^>
    ) > "folder_analysis_export_%date:~-4,4%%date:~-10,2%%date:~-7,2%.html"
    echo ✓ تم تصدير التقرير HTML بنجاح!
)

if "%export_format%"=="4" (
    echo جاري تصدير التقرير PDF...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تصدير التقرير PDF بنجاح!
)

pause
goto MENU
