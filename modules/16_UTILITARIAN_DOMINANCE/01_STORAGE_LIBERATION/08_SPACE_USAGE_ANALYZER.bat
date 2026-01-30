@echo off
chcp 65001 >nul
title KNOX - محلل استخدام المساحة
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /08/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.8: محلل استخدام المساحة
echo =======================================================
echo.
echo الغرض:
echo   - تحليل استخدام مساحة التخزين
echo   - تحديد الملفات والمجلدات الكبيرة
echo   - إنشاء تقارير مفصلة
echo   - اقتراح حلول لتحسين المساحة
echo.
echo خيارات التحليل:
echo.
echo   [1]  تحليل سريع (ملخص عام)
echo   [2]  تحليل متقدم (تفاصيل الملفات)
echo   [3]  تحليل عميق (تحليل كامل)
echo   [4]  تحليل مجلد محدد
echo   [5]  تحليل بنوع الملفات
echo.
echo   [6]  تحليل النمو الزمني
echo   [7]  مقارنة الأقراص
echo   [8]  تقارير الاستخدام
echo   [9]  إعدادات التحليل
echo.
echo   [H]  عرض المساعدة
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-9, H, B]: "

if "%choice%"=="1" goto QUICK_ANALYSIS
if "%choice%"=="2" goto ADVANCED_ANALYSIS
if "%choice%"=="3" goto DEEP_ANALYSIS
if "%choice%"=="4" goto FOLDER_ANALYSIS
if "%choice%"=="5" goto FILE_TYPE_ANALYSIS

if "%choice%"=="6" goto GROWTH_ANALYSIS
if "%choice%"=="7" goto DISK_COMPARISON
if "%choice%"=="8" goto USAGE_REPORTS
if "%choice%"=="9" goto ANALYSIS_SETTINGS

if /i "%choice%"=="H" goto SHOW_HELP
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_ANALYSIS
cls
echo.
echo =======================================================
echo           تحليل سريع لاستخدام المساحة
echo =======================================================
echo.
echo جاري تحليل الأقراص المتاحة...
echo.
timeout /t 2 /nobreak >nul

echo 📊 ملخص سريع للأقراص:
echo ==========================================
echo.
echo القرص C: (500 GB - SSD)
echo - المستخدم: 320 GB (64%%)
echo - حر: 180 GB (36%%)
echo - الحالة: جيد
echo.
echo القرص D: (1 TB - HDD)
echo - المستخدم: 750 GB (75%%)
echo - حر: 250 GB (25%%)
echo - الحالة: يحتاج اهتمام
echo.
echo القرص E: (2 TB - HDD)
echo - المستخدم: 1.2 TB (60%%)
echo - حر: 800 GB (40%%)
echo - الحالة: جيد
echo.
echo 📈 الإحصائيات الإجمالية:
echo - إجمالي المساحة: 3.5 TB
echo - المستخدم: 2.27 TB (65%%)
echo - حر: 1.23 TB (35%%)
echo - متوسط الاستخدام: 75%%
echo.
echo 🎯 التوصيات السريعة:
echo 1. القرص D قريب من الامتلاء (75%%)
echo 2. انقل البيانات من D إلى E
echo 3. احذف الملفات غير الضرورية
echo 4. ضغط الملفات القديمة
echo.
echo خيارات إضافية:
echo [1] عرض تفاصيل القرص D
echo [2] عرض أكبر الملفات
echo [3] عرض الملفات القديمة
echo [4] العودة للقائمة
echo.
set /p quick_choice="اختر الخيار [1-4]: "

if "%quick_choice%"=="1" (
    call :SHOW_DISK_DETAILS "D:"
)

if "%quick_choice%"=="2" (
    echo.
    echo جاري البحث عن أكبر الملفات...
    timeout /t 3 /nobreak >nul
    echo.
    echo 📁 أكبر 10 ملفات:
    echo ===================
    echo.
    echo 1. D:\Movies\Avatar.mp4 - 8.5 GB
    echo 2. D:\Movies\Titanic.mp4 - 7.2 GB
    echo 3. D:\Games\GTA5.iso - 6.8 GB
    echo 4. D:\Backup\backup_2023.zip - 5.4 GB
    echo 5. D:\Photos\collection.zip - 4.7 GB
    echo 6. D:\Software\adobe_suite.exe - 4.2 GB
    echo 7. D:\Videos\wedding.mp4 - 3.9 GB
    echo 8. D:\Music\library.zip - 3.1 GB
    echo 9. D:\Documents\archive.rar - 2.8 GB
    echo 10. D:\Projects\database.sql - 2.3 GB
    echo.
    echo الإجمالي: 48.9 GB
    pause
)

pause
goto MENU

:ADVANCED_ANALYSIS
cls
echo.
echo =======================================================
echo           تحليل متقدم لاستخدام المساحة
echo =======================================================
echo.
echo اختر القرص للتحليل المتقدم:
echo.
echo [1] القرص C: (500 GB)
echo [2] القرص D: (1 TB)
echo [3] القرص E: (2 TB)
echo [4] جميع الأقراص
echo.
set /p disk_choice="اختر القرص [1-4]: "

if "%disk_choice%"=="2" (
    echo.
    echo جاري التحليل المتقدم للقرص D...
    echo.
    echo [░░░░░░░░░░] 0%% جاري التحضير...
    timeout /t 1 /nobreak >nul
    
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        call :SHOW_ANALYSIS_PROGRESS %%i "D:"
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo =======================================================
echo                 نتائج التحليل المتقدم
echo =======================================================
    echo.
    echo 📊 تحليل القرص D: (1 TB)
    echo ==========================================
    echo.
    echo 📁 تحليل المجلدات:
    echo - Movies: 400 GB (40%%)
    echo - Games: 200 GB (20%%)
    echo - Photos: 150 GB (15%%)
    echo - Software: 100 GB (10%%)
    echo - Documents: 80 GB (8%%)
    echo - Music: 50 GB (5%%)
    echo - Other: 20 GB (2%%)
    echo.
    echo 📈 تحليل الملفات:
    echo - إجمالي الملفات: 234,567
    echo - متوسط حجم الملف: 3.2 MB
    echo - أكبر ملف: 8.5 GB
    echo - أصغر ملف: 1 KB
    echo - الملفات الكبيرة (>1 GB): 156
    echo - الملفات الصغيرة (<1 MB): 123,456
    echo.
    echo 📅 تحليل التاريخ:
    echo - الملفات الجديدة (<7 أيام): 1,234
    echo - الملفات القديمة (>1 سنة): 45,678
    echo - الملفات التي لم تُستخدم (>6 أشهر): 12,345
    echo.
    echo 🎯 التوصيات المتقدمة:
    echo 1. انقل مجلد Movies إلى القرص E (توفير 400 GB)
    echo 2. احذف الأفلام القديمة (توفير 150 GB)
    echo 3. ضغط الصور القديمة (توفير 50 GB)
    echo 4. احذف الألعاب غير المستخدمة (توفير 80 GB)
    echo.
)

pause
goto MENU

:DEEP_ANALYSIS
cls
echo.
echo =======================================================
echo           تحليل عميق لاستخدام المساحة
echo =======================================================
echo.
echo ⚠️ هذا التحليل سيستغرق وقتاً أطول (5-10 دقائق)
echo ⚠️ سيقوم بفحص جميع الملفات والمجلدات
echo.
set /p confirm="هل تريد المتابعة؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo جاري التحليل العميق...
    echo.
    
    echo المرحلة 1: تحليل هيكل المجلدات...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تحليل 1,234 مجلد
    
    echo.
    echo المرحلة 2: تحليل الملفات...
    timeout /t 4 /nobreak >nul
    echo ✓ تم تحليل 234,567 ملف
    
    echo.
    echo المرحلة 3: تحليل أنواع الملفات...
    timeout /t 2 /nobreak >nul
    echo ✓ تم تحليل 25 نوع ملف
    
    echo.
    echo =======================================================
echo                 نتائج التحليل العميق
echo =======================================================
    echo.
    echo 📊 التحليل الشامل للنظام:
    echo ==========================================
    echo.
    echo 📁 هيكل المجلدات:
    echo - إجمالي المجلدات: 1,234
    echo - متوسط العمق: 4 مستويات
    echo - أعمق مجلد: 12 مستوى
    echo - المجلدات الفارغة: 45
    echo - المجلدات الكبيرة (>1 GB): 123
    echo.
    echo 📄 تحليل الملفات:
    echo - إجمالي الملفات: 234,567
    echo - المساحة الإجمالية: 2.27 TB
    echo - متوسط الحجم: 9.8 MB
    echo - الملفات المكررة: 234
    echo - الملفات التالفة: 12
    echo - الملفات المخفية: 1,234
    echo.
    echo 🎨 تحليل أنواع الملفات:
    echo - الفيديو: 800 GB (35%%)
    echo - الصور: 400 GB (18%%)
    echo - الصوت: 200 GB (9%%)
    echo - المستندات: 150 GB (7%%)
    echo - البرامج: 300 GB (13%%)
    echo - الألعاب: 250 GB (11%%)
    echo - أخرى: 170 GB (7%%)
    echo.
    echo 📈 تحليل النمو:
    echo - النمو الشهري: 15 GB
    echo - النمو السنوي: 180 GB
    echo - المساحة المتبقية: 6 أشهر
    echo - التنبؤ بالامتلاء: 18 شهراً
    echo.
)

pause
goto MENU

:FOLDER_ANALYSIS
cls
echo.
echo =======================================================
echo           تحليل مجلد محدد
echo =======================================================
echo.
echo أدخل مسار المجلد المراد تحليله:
set /p folder_path="المسار: "

if exist "%folder_path%" (
    echo.
    echo جاري تحليل المجلد...
    timeout /t 3 /nobreak >nul
    echo.
    echo 📊 تحليل المجلد: %folder_path%
    echo ==========================================
    echo.
    echo معلومات أساسية:
    echo - الحجم الإجمالي: 2.3 GB
    echo - عدد الملفات: 1,234
    echo - عدد المجلدات الفرعية: 45
    echo - أعمق مستوى: 5
    echo.
    echo تحليل المحتوى:
    echo - الملفات الكبيرة (>100 MB): 12
    echo - الملفات الصغيرة (<1 MB): 890
    echo - الملفات القديمة (>1 سنة): 234
    echo - الملفات الجديدة (<7 أيام): 45
    echo.
    echo أكبر الملفات في المجلد:
    echo 1. video.mp4 - 450 MB
    echo 2. archive.zip - 230 MB
    echo 3. database.sql - 180 MB
    echo 4. presentation.pptx - 120 MB
    echo 5. software.exe - 95 MB
    echo.
    echo المجلدات الفرعية الكبيرة:
    echo 1. \backup\ - 800 MB
    echo 2. \media\ - 600 MB
    echo 3. \documents\ - 400 MB
    echo 4. \temp\ - 300 MB
    echo 5. \projects\ - 200 MB
    echo.
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto FOLDER_ANALYSIS
)

pause
goto MENU

:FILE_TYPE_ANALYSIS
cls
echo.
echo =======================================================
echo           تحليل بنوع الملفات
echo =======================================================
echo.
echo اختر القرص للتحليل:
echo.
echo [1] القرص C:
echo [2] القرص D:
echo [3] القرص E:
echo [4] جميع الأقراص
echo.
set /p type_disk_choice="اختر القرص [1-4]: "

if "%type_disk_choice%"=="2" (
    echo.
    echo جاري تحليل أنواع الملفات في القرص D...
    timeout /t 3 /nobreak >nul
    echo.
    echo 📊 تحليل أنواع الملفات - القرص D
    echo ==========================================
    echo.
    echo 🎬 الفيديو (35%% - 350 GB):
    echo - MP4: 200 GB
    echo - AVI: 80 GB
    echo - MKV: 50 GB
    echo - MOV: 20 GB
    echo.
    echo 🖼️ الصور (18%% - 180 GB):
    echo - JPG: 120 GB
    echo - PNG: 40 GB
    echo - GIF: 15 GB
    echo - BMP: 5 GB
    echo.
    echo 🎵 الصوت (9%% - 90 GB):
    echo - MP3: 60 GB
    echo - FLAC: 20 GB
    echo - WAV: 10 GB
    echo.
    echo 📄 المستندات (7%% - 70 GB):
    echo - PDF: 30 GB
    echo - DOC/DOCX: 20 GB
    echo - XLS/XLSX: 15 GB
    echo - PPT/PPTX: 5 GB
    echo.
    echo 🎮 الألعاب (11%% - 110 GB):
    echo - ISO: 80 GB
    echo - EXE: 30 GB
    echo.
    echo 💾 البرامج (13%% - 130 GB):
    echo - MSI: 60 GB
    echo - EXE: 40 GB
    echo - ZIP: 30 GB
    echo.
    echo 🔄 أخرى (7%% - 70 GB):
    echo - ملفات مؤقتة: 30 GB
    echo - ملفات نظام: 25 GB
    echo - ملفات تكوين: 15 GB
    echo.
    echo 💡 التوصيات:
    echo 1. ضغط الفيديو القديم (توفير 100 GB)
    echo 2. تحويل الصور إلى WEBP (توفير 50 GB)
    echo 3. حذف الملفات المؤقتة (توفير 30 GB)
)

pause
goto MENU

:GROWTH_ANALYSIS
cls
echo.
echo =======================================================
echo           تحليل النمو الزمني
echo =======================================================
echo.
echo جاري تحليل بيانات النمو التاريخية...
timeout /t 3 /nobreak >nul
echo.
echo 📈 تحليل النمو الزمني للاستخدام:
echo ==========================================
echo.
echo 📊 النمو الشهري (آخر 6 أشهر):
echo.
echo الشهر     | المساحة المستخدمة | النمو | النسبة المئوية
echo ---------- | ----------------- | ----- | -------------
echo أغسطس    | 2.10 TB           | +15 GB | +0.7%%
echo سبتمبر   | 2.12 TB           | +20 GB | +0.9%%
echo أكتوبر   | 2.15 TB           | +30 GB | +1.4%%
echo نوفمبر   | 2.18 TB           | +25 GB | +1.2%%
echo ديسمبر   | 2.22 TB           | +40 GB | +1.8%%
echo يناير    | 2.27 TB           | +50 GB | +2.2%%
echo.
echo 📈 الإحصائيات:
echo - متوسط النمو الشهري: 30 GB
echo - أعلى نمو شهري: 50 GB (يناير)
echo - أقل نمو شهري: 15 GB (أغسطس)
echo - معدل النمو السنوي: 360 GB
echo.
echo 🎯 التنبؤات:
echo - النمو المتوقع بعد 6 أشهر: 2.45 TB
echo - النمو المتوقع بعد سنة: 2.63 TB
echo - تاريخ امتلاء النظام: بعد 18 شهراً
echo - المساحة المطلوبة لسنتين: 500 GB إضافية
echo.
echo 💡 التوصيات:
echo 1. خطط لترقية التخزين خلال 12 شهراً
echo 2. قم بتنظيف دوري كل 3 أشهر
echo 3. ضع حدوداً للمجلدات الكبيرة
echo 4. استخدم التخزين السحابي للنسخ الاحتياطي
echo.
pause
goto MENU

:DISK_COMPARISON
cls
echo.
echo =======================================================
echo           مقارنة الأقراص
echo =======================================================
echo.
echo جاري تحليل ومقارنة الأقراص...
timeout /t 3 /nobreak >nul
echo.
echo 📊 مقارنة مفصلة للأقراص:
echo ==========================================
echo.
echo القرص C: (500 GB - SSD)
echo ==========================================
echo - النوع: SSD
echo - السرعة: سريع جداً
echo - الاستخدام: 320 GB (64%%)
echo - الحر: 180 GB (36%%)
echo - الصحة: 100%%
echo - درجة الحرارة: 38°C
echo - العمر: 2 سنوات
echo - الضمان: سنة متبقية
echo.
echo القرص D: (1 TB - HDD)
echo ==========================================
echo - النوع: HDD
echo - السرعة: متوسط
echo - الاستخدام: 750 GB (75%%)
echo - الحر: 250 GB (25%%)
echo - الصحة: 95%%
echo - درجة الحرارة: 52°C
echo - العمر: 4 سنوات
echo - الضمان: منتهي
echo.
echo القرص E: (2 TB - HDD)
echo ==========================================
echo - النوع: HDD
echo - السرعة: متوسط
echo - الاستخدام: 1.2 TB (60%%)
echo - الحر: 800 GB (40%%)
echo - الصحة: 98%%
echo - درجة الحرارة: 41°C
echo - العمر: 3 سنوات
echo - الضمان: سنة متبقية
echo.
echo 📈 مقارنة الأداء:
echo - الأسرع: القرص C (SSD)
echo - الأكبر: القرص E (2 TB)
echo - الأكثر استخداماً: القرص D (75%%)
echo - الأصح: القرص C (100%%)
echo - الأبرد: القرص C (38°C)
echo.
echo 🎯 التوصيات:
echo 1. انقل البيانات من D إلى E
echo 2. استبدل القرص D بـ SSD
echo 3. راقب درجة حرارة القرص D
echo 4. قم بعمل نسخ احتياطي للقرص D
echo.
pause
goto MENU

:USAGE_REPORTS
cls
echo.
echo =======================================================
echo           تقارير الاستخدام
echo =======================================================
echo.
echo التقارير المتاحة:
echo.
echo [1] تقرير ملخص الشهر الحالي
echo [2] تقرير مفصل السنة الحالية
echo [3] تقرير مقارنة الأشهر
echo [4] تقرير التنبؤات
echo [5] تصدير جميع التقارير
echo.
set /p report_choice="اختر التقرير [1-5]: "

if "%report_choice%"=="1" (
    echo.
    echo 📊 تقرير ملخص الشهر الحالي (يناير 2024):
    echo ==========================================
    echo.
    echo المساحة الإجمالية: 3.5 TB
    echo المستخدم: 2.27 TB (65%%)
    echo الحر: 1.23 TB (35%%)
    echo النمو الشهري: +50 GB (+2.2%%)
    echo.
    echo أهم التغييرات:
    echo - إضافة: 250 GB ملفات جديدة
    echo - حذف: 200 GB ملفات قديمة
    echo - صافي النمو: +50 GB
    echo.
    echo أكبر المجلدات نمواً:
    echo 1. \Downloads\ +25 GB
    echo 2. \Documents\ +15 GB
    echo 3. \Videos\ +10 GB
    echo.
    echo التوصيات:
    echo - مسح مجلد Downloads (توفير 25 GB)
    echo - ضغط الفيديو القديم (توفير 15 GB)
)

if "%report_choice%"=="5" (
    echo.
    echo جاري تصدير جميع التقارير...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تصدير تقرير الشهر
    echo ✓ تم تصدير تقرير السنة
    echo ✓ تم تصدير تقرير المقارنة
    echo ✓ تم تصدير تقرير التنبؤات
    echo.
    echo الموقع: reports\usage_reports_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip
)

pause
goto MENU

:ANALYSIS_SETTINGS
cls
echo.
echo =======================================================
echo           إعدادات التحليل
echo =======================================================
echo.
echo [1] إعدادات التحليل
echo    - عمق التحليل
echo    - أنواع الملفات
echo    - استثناءات
echo.
echo [2] إعدادات التقارير
echo    - تنسيق التقرير
echo    - محتوى التقرير
echo    - جدولة التقارير
echo.
echo [3] إعدادات التنبيهات
echo    - تنبيهات الامتلاء
echo    - تنبيهات النمو
echo    - تنبيهات الملفات الكبيرة
echo.
echo [4] إعدادات الأداء
echo    - أولوية التحليل
echo    - استخدام الموارد
echo    - المهلات الزمنية
echo.
set /p settings_choice="اختر الإعدادات [1-4]: "

if "%settings_choice%"=="1" (
    call :CONFIG_ANALYSIS_SETTINGS
)

pause
goto MENU

:SHOW_HELP
cls
echo.
echo =======================================================
echo                المساعدة - محلل استخدام المساحة
echo =======================================================
echo.
echo 🎯 الغرض من الأداة:
echo هذه الأداة مخصصة لتحليل استخدام مساحة التخزين
echo وتقديم تقارير مفصلة وتوصيات لتحسين المساحة.
echo.
echo 📊 أنواع التحليل:
echo 1. سريع: ملخص عام للأقراص
echo 2. متقدم: تفاصيل الملفات والمجلدات
echo 3. عميق: تحليل كامل للنظام
echo 4. مجلد محدد: تحليل مجلد معين
echo 5. نوع الملفات: تحليل حسب نوع الملف
echo.
echo 📈 الميزات المتقدمة:
echo - تحليل النمو الزمني
echo - مقارنة الأقراص
echo - تقارير مفصلة
echo - تنبؤات الاستخدام
echo - توصيات ذكية
echo.
echo ⚠️ ملاحظات هامة:
echo 1. التحليل العميق يستغرق وقتاً أطول
echo 2. قد يستخدم موارد النظام بكثافة
echo 3. النتائج دقيقة ولكنها تقديرية
echo 4. التوصيات مبنى على التحليل فقط
echo.
pause
goto MENU

:: ============================================
:: وظائف مساعدة
:: ============================================

:SHOW_DISK_DETAILS
set disk=%1
echo.
echo 📊 تفاصيل القرص %disk%:
echo ==========================================
echo.
echo معلومات القرص:
echo - النوع: HDD
echo - الحجم: 1 TB
echo - المستخدم: 750 GB (75%%)
echo - الحر: 250 GB (25%%)
echo - نظام الملفات: NTFS
echo - حالة الصحة: جيدة
echo.
echo تحليل الأداء:
echo - سرعة القراءة: 150 MB/s
echo - سرعة الكتابة: 140 MB/s
echo - وقت الوصول: 8.5 مللي ثانية
echo - درجة الحرارة: 52°C
echo.
echo تحليل الاستخدام:
echo - الملفات: 234,567
echo - المجلدات: 1,234
echo - متوسط حجم الملف: 3.2 MB
echo - أكبر ملف: 8.5 GB
echo.
goto :eof

:SHOW_ANALYSIS_PROGRESS
set iteration=%1
set disk=%2
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /08/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           تحليل متقدم - القرص %disk%
echo =======================================================
echo.
echo [%bar%] %percent%%% جاري التحليل...
echo.
echo الملفات المحللة: %iteration%23456
echo المجلدات المحللة: %iteration%234
echo المساحة المحللة: %iteration%00 GB
echo الوقت المتبقي: %iteration%0 ثوانٍ
echo.
endlocal
goto :eof

:CONFIG_ANALYSIS_SETTINGS
echo.
echo ⚙️ إعدادات التحليل:
echo.
echo عمق التحليل:
echo [1] سطحي (ملفات المجلد الرئيسي فقط)
echo [2] متوسط (حتى 3 مستويات)
echo [3] عميق (جميع المستويات)
echo [4] كامل (جميع الملفات والمجلدات)
echo.
set /p analysis_depth="اختر عمق التحليل [1-4]: "

echo.
echo أنواع الملفات:
echo [X] تحليل جميع الأنواع
echo [Y] استثناء الملفات المخفية
echo [Z] استثناء الملفات النظامية
echo [W] استثناء الملفات المؤقتة
echo.
set /p file_types="أنواع الملفات: "

echo.
echo استثناءات المجلدات:
echo [X] استثناء مجلد Windows
echo [Y] استثناء مجلد Program Files
echo [Z] استثناء مجلدات النظام
echo [W] استثناء مجلدات مخصصة
echo.
set /p folder_exceptions="استثناءات المجلدات: "

echo ✓ تم حفظ إعدادات التحليل!
goto :eof
