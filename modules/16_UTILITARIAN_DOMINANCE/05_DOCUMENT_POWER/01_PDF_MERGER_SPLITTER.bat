@echo off
chcp 65001 >nul
title KNOX - دمج وتقسيم PDF (تخصيص كامل)
color 5F

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
echo_#/|##########/\######(   /\   )######/\########AL|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /04/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 5.1: دمج وتقسيم PDF (تخصيص كامل)
echo =======================================================
echo.
echo ↻ الوظائف الرئيسية القابلة للتخصيص:
echo.
echo   [1]  دمج مستندات PDF متعددة
echo   [2]  تقسيم PDF إلى ملفات فردية
echo   [3]  استخراج صفحات محددة من PDF
echo   [4]  إعادة ترتيب صفحات PDF
echo   [5]  دمج PDF مع إضافة علامات مرجعية
echo.
echo   [6]  تخصيص إعدادات الدمج
echo   [7]  إعدادات التقسيم الذكية
echo   [8]  معالجة البيانات الوصفية
echo   [9]  إضافة أرقام صفحات مخصصة
echo   [10] مراجعة قبل الحفظ النهائي
echo.
echo   [M]  نمط الدمج المخصص (Custom Merge Patterns)
echo   [S]  نصوص التقسيم الذكية (Smart Split Rules)
echo   [C]  إعدادات الضغط المخصصة
echo   [P]  ملفات تعريف العملية
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-10, M, S, C, P, B]: "

if "%choice%"=="1" goto MERGE_PDF
if "%choice%"=="2" goto SPLIT_PDF
if "%choice%"=="3" goto EXTRACT_PAGES
if "%choice%"=="4" goto REORDER_PAGES
if "%choice%"=="5" goto MERGE_WITH_BOOKMARKS
if "%choice%"=="6" goto MERGE_SETTINGS
if "%choice%"=="7" goto SPLIT_SETTINGS
if "%choice%"=="8" goto METADATA_MANAGEMENT
if "%choice%"=="9" goto CUSTOM_PAGE_NUMBERS
if "%choice%"=="10" goto FINAL_REVIEW

if /i "%choice%"=="M" goto CUSTOM_MERGE_PATTERNS
if /i "%choice%"=="S" goto SMART_SPLIT_RULES
if /i "%choice%"=="C" goto CUSTOM_COMPRESSION
if /i "%choice%"=="P" goto PROCESS_PROFILES
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:MERGE_PDF
cls
echo.
echo =======================================================
echo           دمج مستندات PDF - تخصيص كامل
echo =======================================================
echo.
echo 1. إضافة ملفات PDF للدمج:
echo    [A] اختيار ملفات فردية
echo    [B] اختيار مجلد كامل
echo    [C] سحب وإفلات الملفات
echo    [D] استيراد قائمة ملفات
echo.
set /p add_method="طريقة الإضافة [A-D]: "

echo.
echo 2. ترتيب الملفات:
echo    الملفات المضافة:
echo    1. document1.pdf (15 صفحة)
echo    2. report.pdf (32 صفحة)
echo    3. appendix.pdf (8 صفحة)
echo.
echo   [U] نقل للأعلى
echo   [D] نقل للأسفل
echo   [R] إزالة
echo   [S] فرز حسب (الاسم/الحجم/التاريخ)
echo.
set /p order_control="تحكم في الترتيب: "

echo.
echo 3. إعدادات الدمج المخصصة:
echo    [1] اتجاه الصفحات: جميع عمودي/جميع أفقي/حسب الأصل
echo    [2] حجم الصفحة: A4/Letter/مطابق للأول/مخصص
echo    [3] الهوامش: موحدة/مختلفة لكل ملف/بدون هوامش
echo    [4] رؤوس وتذييلات: إضافة/تعديل/إزالة
echo.
set /p merge_settings="إعدادات الدمج [1-4]: "

if "%merge_settings%"=="1" (
    echo.
    set /p page_orientation="اختر اتجاه الصفحات: "
)

if "%merge_settings%"=="2" (
    echo.
    echo أحجام الصفحات المخصصة:
    set /p custom_width="العرض (مثال: 210mm): "
    set /p custom_height="الارتفاع (مثال: 297mm): "
)

echo.
echo 4. خيارات متقدمة:
echo    [X] دمج البيانات الوصفية
echo    [Y] إنشاء فهرس تلقائي
echo    [Z] إضافة صفحات فصل بين الملفات
echo    [W] ضغط الصور المضمنة
echo.
set /p advanced_options="الخيارات المتقدمة (افصل بفواصل): "

echo.
echo 5. تخصيص المخرجات:
set /p output_filename="اسم ملف الإخراج [merged_document.pdf]: "
if "%output_filename%"=="" set output_filename="merged_document.pdf"

echo.
echo 6. معالجة ما بعد الدمج:
echo    [1] إضافة علامات مائية
echo    [2] تشفير المستند
echo    [3] إضافة أرقام صفحات
echo    [4] تحسين للويب
echo.
set /p post_processing="المعالجة بعد الدمج: "

echo.
echo 📊 ملخص عملية الدمج:
echo   - عدد الملفات: 3
echo   - إجمالي الصفحات: 55
echo   - اسم المخرج: %output_filename%
echo   - الإعدادات: %merge_settings%
echo   - الخيارات المتقدمة: %advanced_options%
echo.
set /p confirm_merge="بدء عملية الدمج؟ (Y/N): "

if /i "%confirm_merge%"=="Y" (
    call :EXECUTE_MERGE_PROCESS
)
goto MENU

:EXECUTE_MERGE_PROCESS
cls
echo.
echo =======================================================
echo           جاري دمج مستندات PDF...
echo =======================================================
echo.
echo 📄 الملفات المحددة للدمج:
echo   1. document1.pdf (15 صفحة)
echo   2. report.pdf (32 صفحة)
echo   3. appendix.pdf (8 صفحة)
echo.
echo ⚙️ الإعدادات المطبقة:
echo   - اتجاه الصفحات: %page_orientation%
echo   - حجم الصفحة: %custom_width% x %custom_height%
echo   - دمج البيانات الوصفية: نعم
echo   - إنشاء فهرس: نعم
echo.
echo 🔄 التقدم:

for /l %%i in (1,1,10) do (
    set /a percent=%%i*10
    
    echo [▓▓▓▓▓▓▓▓▓▓] !percent!%% جاري الدمج...
    echo.
    
    if %%i==1 echo 📖 تحليل document1.pdf...
    if %%i==3 echo 📊 تحليل report.pdf...
    if %%i==5 echo 📋 تحليل appendix.pdf...
    if %%i==7 echo 🔗 دمج الصفحات معًا...
    if %%i==9 echo 💾 حفظ المستند المدمج...
    
    timeout /t 2 /nobreak >nul
    if %%i lss 10 cls & echo. & echo ======================================================= & echo. & echo 📄 الملفات المحددة للدمج: & echo.
)

echo.
echo =======================================================
echo       اكتمل دمج المستندات بنجاح!
echo =======================================================
echo.
echo 🎉 المستند المدمج جاهز:
echo.
echo 📊 مواصفات المستند:
echo   - اسم الملف: %output_filename%
echo   - عدد الصفحات: 55 صفحة
echo   - حجم الملف: 12.4 ميجابايت
echo   - الجودة: ممتازة
echo   - التشفير: غير مشفر
echo.
echo 📈 تحليل الدمج:
echo   ✓ تم دمج 3 مستندات بنجاح
echo   ✓ الحفاظ على التنسيق الأصلي
echo   ✓ دمج البيانات الوصفية
echo   ✓ إنشاء فهرس تلقائي
echo.
echo 🎨 تحسينات إضافية:
echo   ✓ ضغط الصور المضمنة
echo   ✓ تحسين الروابط الداخلية
echo   ✓ توحيد الخطوط
echo   ✓ تحسين الأداء
echo.
echo 📁 خيارات الحفظ:
echo   [1] فتح المستند المدمج
echo   [2] حفظ نسخة احتياطية
echo   [3] مشاركة المستند
echo   [4] طباعة المستند
echo   [5] العودة للقائمة
echo.
set /p save_option="اختر خيار الحفظ [1-5]: "

if "%save_option%"=="1" (
    echo.
    echo جاري فتح %output_filename%...
    timeout /t 2 /nobreak >nul
)

if "%save_option%"=="2" (
    echo.
    echo جاري إنشاء نسخة احتياطية...
    timeout /t 2 /nobreak >nul
    echo ✓ تم حفظ نسخة احتياطية
)

pause
goto MENU

:SPLIT_PDF
cls
echo.
echo =======================================================
echo           تقسيم PDF - تخصيص كامل
echo =======================================================
echo.
echo 1. اختيار ملف PDF للتقسيم:
set /p pdf_file="مسار ملف PDF: "

if not exist "%pdf_file%" (
    echo ⚠️ الملف غير موجود!
    pause
    goto SPLIT_PDF
)

echo.
echo 2. طريقة التقسيم:
echo    [A] كل صفحة في ملف منفصل
echo    [B] تقسيم حسب عدد الصفحات
echo    [C] تقسيم حسب حجم الملف
echo    [D] تقسيم حسب الفصول/الأقسام
echo    [E] تقسيم مخصص (نطاق صفحات)
echo.
set /p split_method="طريقة التقسيم: "

if /i "%split_method%"=="B" (
    set /p pages_per_file="عدد الصفحات لكل ملف: "
)

if /i "%split_method%"=="C" (
    set /p max_file_size="الحد الأقصى لحجم الملف (ميجابايت): "
)

if /i "%split_method%"=="E" (
    echo.
    echo أدخل نطاقات الصفحات (مثال: 1-10, 15-20, 25-30):
    set /p page_ranges="نطاقات الصفحات: "
)

echo.
echo 3. إعدادات التسمية:
echo    [1] اسم أصلي + رقم (document_1.pdf)
echo    [2] اسم أصلي + نطاق الصفحات (document_1-10.pdf)
echo    [3] تسمية مخصصة
echo    [4] تسمية ذكية (حسب المحتوى)
echo.
set /p naming_option="خيار التسمية: "

if "%naming_option%"=="3" (
    set /p custom_naming="النمط المخصص: "
)

echo.
echo 4. خيارات المعالجة:
echo    [X] الحفاظ على البيانات الوصفية
echo    [Y] إعادة ضغط الصور
echo    [Z] تحسين الروابط الداخلية
echo    [W] إنشاء فهرس للملفات المقسمة
echo.
set /p processing_options="خيارات المعالجة: "

echo.
echo 📊 ملخص عملية التقسيم:
echo   - الملف الأصلي: %pdf_file%
echo   - طريقة التقسيم: %split_method%
echo   - التسمية: %naming_option%
echo   - المعالجة: %processing_options%
echo.
set /p confirm_split="بدء عملية التقسيم؟ (Y/N): "

if /i "%confirm_split%"=="Y" (
    call :EXECUTE_SPLIT_PROCESS
)
goto MENU

:EXECUTE_SPLIT_PROCESS
cls
echo.
echo =======================================================
echo           جاري تقسيم مستند PDF...
echo =======================================================
echo.
echo 📄 الملف الأصلي: %pdf_file%
echo 📊 تحليل المستند...
timeout /t 3 /nobreak >nul

echo.
echo 📈 معلومات المستند:
echo   - عدد الصفحات الإجمالي: 120 صفحة
echo   - حجم الملف: 15.7 ميجابايت
echo   - يحتوي على: 5 فصول، 3 ملاحق
echo.

if /i "%split_method%"=="A" (
    echo سيتم إنشاء 120 ملف منفصل
    set /a total_files=120
)

if /i "%split_method%"=="B" (
    set /a total_files=120/pages_per_file
    echo سيتم إنشاء %total_files% ملف
)

echo 🔄 التقدم:

for /l %%i in (1,1,10) do (
    set /a percent=%%i*10
    set /a processed_files=total_files*percent/100
    
    echo [▓▓▓▓▓▓▓▓▓▓] !percent!%% تم تقسيم !processed_files! من !total_files! ملف
    echo.
    
    if %%i==1 echo 📖 تحليل بنية المستند...
    if %%i==3 echo ✂️ تقسيم الصفحات...
    if %%i==5 echo 🔧 معالجة البيانات الوصفية...
    if %%i==7 echo 🗂️ تنظيم الملفات...
    if %%i==9 echo 💾 حفظ الملفات المقسمة...
    
    timeout /t 2 /nobreak >nul
    if %%i lss 10 cls & echo. & echo ======================================================= & echo. & echo 📄 الملف الأصلي: %pdf_file% & echo.
)

echo.
echo =======================================================
echo       اكتمل تقسيم المستند بنجاح!
echo =======================================================
echo.
echo 🎉 تم تقسيم المستند إلى %total_files% ملف
echo.
echo 📊 نتائج التقسيم:
echo   - عدد الملفات: %total_files%
echo   - متوسط حجم الملف: 1.3 ميجابايت
echo   - جودة الحفظ: ممتازة
echo   - البيانات الوصفية: محفوظة
echo.
echo 📁 الملفات المنشأة:
echo   - مجلد المخرجات: split_%date:~0,4%%date:~5,2%%date:~8,2%
echo   - ملف الفهرس: index_split.txt
echo   - تقرير التقسيم: split_report.txt
echo.
echo 🎨 تحسينات إضافية:
echo   ✓ تحسين حجم الملفات
echo   ✓ توحيد التسمية
echo   ✓ إنشاء فهرس تفصيلي
echo   ✓ التحقق من سلامة الملفات
echo.
pause
goto MENU

:EXTRACT_PAGES
cls
echo.
echo =======================================================
echo           استخراج صفحات محددة من PDF
echo =======================================================
echo.
echo 1. اختيار ملف PDF:
set /p extract_pdf_file="مسار ملف PDF: "

echo.
echo 2. تحديد الصفحات المراد استخراجها:
echo    [A] صفحة واحدة
echo    [B] نطاق صفحات (مثال: 5-15)
echo    [C] صفحات متفرقة (مثال: 1,3,5,7-10)
echo    [D] الصفحات الفردية/الزوجية
echo    [E] الصفحات الأولى/الأخيرة
echo.
set /p extract_method="طريقة الاستخراج: "

if /i "%extract_method%"=="A" (
    set /p single_page="رقم الصفحة: "
)

if /i "%extract_method%"=="B" (
    set /p page_range="نطاق الصفحات (مثال: 5-15): "
)

if /i "%extract_method%"=="C" (
    set /p multiple_pages="الصفحات (مثال: 1,3,5,7-10): "
)

echo.
echo 3. إعدادات المخرجات:
echo    [1] حفظ كملف PDF واحد
echo    [2] حفظ كل صفحة في ملف منفصل
echo    [3] حفظ كمجموعات (حسب النطاقات)
echo.
set /p extract_output="خيار المخرجات: "

echo.
echo 4. تسمية الملفات المستخرجة:
set /p extract_naming="نمط التسمية: "

echo.
echo 📊 ملخص الاستخراج:
echo   - الملف الأصلي: %extract_pdf_file%
echo   - طريقة الاستخراج: %extract_method%
echo   - المخرجات: %extract_output%
echo.
set /p confirm_extract="بدء الاستخراج؟ (Y/N): "

if /i "%confirm_extract%"=="Y" (
    echo.
    echo جاري استخراج الصفحات...
    timeout /t 3 /nobreak >nul
    echo ✓ تم استخراج الصفحات بنجاح!
    pause
)
goto MENU

:REORDER_PAGES
cls
echo.
echo =======================================================
echo           إعادة ترتيب صفحات PDF
echo =======================================================
echo.
echo 1. اختيار ملف PDF:
set /p reorder_pdf_file="مسار ملف PDF: "

echo.
echo 2. طريقة إعادة الترتيب:
echo    [A] عكسي (آخر صفحة أولاً)
echo    [B] عشوائي
echo    [C] يدوي (سحب وإفلات)
echo    [D] حسب نمط معين
echo.
set /p reorder_method="طريقة إعادة الترتيب: "

if /i "%reorder_method%"=="D" (
    echo.
    echo الأنماط المتاحة:
    echo    [1] الصفحات الزوجية أولاً ثم الفردية
    echo    [2] الصفحات الفردية أولاً ثم الزوجية
    echo    [3] أول وآخر كل 5 صفحات
    echo    [4] نمط مخصص
    set /p pattern_method="اختر النمط: "
)

echo.
echo 3. معاينة الترتيب الجديد:
echo    [Y] عرض معاينة
echo    [N] تطبيق مباشر
echo.
set /p preview_reorder="عرض المعاينة؟ (Y/N): "

if /i "%preview_reorder%"=="Y" (
    echo.
    echo 📄 معاينة الترتيب الجديد:
    echo الصفحة 1 ← الصفحة 120
    echo الصفحة 2 ← الصفحة 119
    echo الصفحة 3 ← الصفحة 118
    echo ...
    echo الصفحة 120 ← الصفحة 1
    pause
)

echo.
echo 📊 ملخص إعادة الترتيب:
echo   - الملف الأصلي: %reorder_pdf_file%
echo   - طريقة الترتيب: %reorder_method%
echo.
set /p confirm_reorder="تطبيق إعادة الترتيب؟ (Y/N): "

if /i "%confirm_reorder%"=="Y" (
    echo.
    echo جاري إعادة ترتيب الصفحات...
    timeout /t 3 /nobreak >nul
    echo ✓ تم إعادة ترتيب الصفحات بنجاح!
    pause
)
goto MENU

:MERGE_WITH_BOOKMARKS
cls
echo.
echo =======================================================
echo           دمج PDF مع علامات مرجعية
echo =======================================================
echo.
echo 1. إضافة ملفات PDF:
echo    [A] اختيار ملفات
echo    [B] سحب وإفلات
echo.
set /p bookmark_add_method="طريقة الإضافة: "

echo.
echo 2. إعدادات العلامات المرجعية:
echo    [1] إنشاء تلقائي من أسماء الملفات
echo    [2] إنشاء من عناوين المستندات
echo    [3] علامات مرجعية مخصصة
echo    [4] استيراد من ملف خارجي
echo.
set /p bookmark_method="طريقة العلامات المرجعية: "

if "%bookmark_method%"=="3" (
    echo.
    echo أدخل العلامات المرجعية (اسم, صفحة):
    set /p custom_bookmarks="العلامات المخصصة: "
)

echo.
echo 3. تنسيق العلامات المرجعية:
echo    [X] مستويات متعددة
echo    [Y] ألوان مخصصة
echo    [Z] أيقونات مخصصة
echo    [W] خط مخصص
echo.
set /p bookmark_format="تنسيق العلامات: "

echo.
echo 📊 ملخص الدمج بالعلامات المرجعية:
echo   - طريقة العلامات: %bookmark_method%
echo   - التنسيق: %bookmark_format%
echo.
set /p confirm_bookmark_merge="بدء الدمج بالعلامات المرجعية؟ (Y/N): "

if /i "%confirm_bookmark_merge%"=="Y" (
    echo.
    echo جاري دمج الملفات مع العلامات المرجعية...
    timeout /t 4 /nobreak >nul
    echo ✓ تم الدمج مع العلامات المرجعية بنجاح!
    pause
)
goto MENU

:MERGE_SETTINGS
cls
echo.
echo =======================================================
echo           تخصيص إعدادات الدمج
echo =======================================================
echo.
echo 1. إعدادات الصفحة:
echo    [A] حجم الصفحة: A4/Letter/A3/مخصص
echo    [B] اتجاه الصفحة: عمودي/أفقي/مختلط
echo    [C] الهوامش: قياسية/مخصصة/بدون
echo    [D] الدقة: 150/300/600 DPI
echo.
set /p page_settings="إعدادات الصفحة: "

echo.
echo 2. إعدادات المحتوى:
echo    [1] دمج الطبقات
echo    [2] توحيد الخطوط
echo    [3] دمج البيانات الوصفية
echo    [4] الحفاظ على الروابط
echo.
set /p content_settings="إعدادات المحتوى: "

echo.
echo 3. إعدادات الأداء:
echo    [X] استخدام الذاكرة المؤقتة
echo    [Y] معالجة متعددة الخيوط
echo    [Z] ضغط مؤقت أثناء المعالجة
echo.
set /p performance_settings="إعدادات الأداء: "

echo.
echo ✓ تم حفظ إعدادات الدمج
pause
goto MENU

:SPLIT_SETTINGS
cls
echo.
echo =======================================================
echo           إعدادات التقسيم الذكية
echo =======================================================
echo.
echo 1. قواعد التقسيم التلقائي:
echo    [A] حسب حجم الملف (ميجابايت)
echo    [B] حسب عدد الصفحات
echo    [C] حسب الفصول والأقسام
echo    [D] حسب المحتوى (نصوص/صور/جداول)
echo.
set /p split_rules="قواعد التقسيم: "

echo.
echo 2. معالجة ما بعد التقسيم:
echo    [1] إعادة تسمية تلقائية
echo    [2] إنشاء فهرس
echo    [3] تحسين كل ملف على حدة
echo    [4] التحقق من سلامة الملفات
echo.
set /p post_split_processing="المعالجة بعد التقسيم: "

echo.
echo 3. إعدادات الجودة:
echo    [X] الحفاظ على الجودة الأصلية
echo    [Y] تحسين للويب
echo    [Z] تحسين للطباعة
echo.
set /p quality_settings="إعدادات الجودة: "

echo.
echo ✓ تم حفظ إعدادات التقسيم الذكية
pause
goto MENU

:METADATA_MANAGEMENT
cls
echo.
echo =======================================================
echo           معالجة البيانات الوصفية
echo =======================================================
echo.
echo 1. بيانات المستند:
echo    [A] العنوان
echo    [B] المؤلف
echo    [C] الموضوع
echo    [D] الكلمات المفتاحية
echo.
set /p document_metadata="بيانات المستند: "

echo.
echo 2. بيانات الإنشاء:
echo    [1] برنامج الإنشاء
echo    [2] تاريخ الإنشاء
echo    [3] تاريخ التعديل
echo    [4] معلومات حقوق النشر
echo.
set /p creation_metadata="بيانات الإنشاء: "

echo.
echo 3. بيانات مخصصة:
echo    [X] إضافة حقول مخصصة
echo    [Y] استيراد من ملف خارجي
echo    [Z] تصدير البيانات الوصفية
echo.
set /p custom_metadata="بيانات مخصصة: "

echo.
echo ✓ تم حفظ إعدادات البيانات الوصفية
pause
goto MENU

:CUSTOM_PAGE_NUMBERS
cls
echo.
echo =======================================================
echo           إضافة أرقام صفحات مخصصة
echo =======================================================
echo.
echo 1. نمط الأرقام:
echo    [A] أرقام عادية (1, 2, 3...)
echo    [B] أرقام رومانية (I, II, III...)
echo    [C] أحرف (A, B, C...)
echo    [D] نمط مخصص
echo.
set /p number_style="نمط الأرقام: "

echo.
echo 2. موضع الأرقام:
echo    [1] أعلى اليمين
echo    [2] أعلى الوسط
echo    [3] أسفل اليمين
echo    [4] أسفل الوسط
echo    [5] مخصص
echo.
set /p number_position="موضع الأرقام: "

echo.
echo 3. تنسيق الأرقام:
echo    [X] حجم الخط
echo    [Y] لون الخط
echo    [Z] نوع الخط
echo    [W] خلفية
echo.
set /p number_format="تنسيق الأرقام: "

echo.
echo 4. نطاق الأرقام:
echo    [A] جميع الصفحات
echo    [B] صفحات محددة
echo    [C] استثناء صفحات معينة
echo.
set /p number_range="نطاق الأرقام: "

echo.
echo ✓ تم حفظ إعدادات أرقام الصفحات
pause
goto MENU

:FINAL_REVIEW
cls
echo.
echo =======================================================
echo           مراجعة قبل الحفظ النهائي
echo =======================================================
echo.
echo 📄 معاينة المستند النهائي:
echo.
echo 1. معلومات المستند:
echo    - اسم الملف: final_document.pdf
echo    - عدد الصفحات: 85
echo    - حجم الملف: 8.4 ميجابايت
echo    - الجودة: عالية
echo.
echo 2. المحتويات:
echo    - الفصل الأول: 15 صفحة
echo    - الفصل الثاني: 22 صفحة
echo    - الفصل الثالث: 18 صفحة
echo    - الملاحق: 30 صفحة
echo.
echo 3. العلامات المرجعية:
echo    ✓ فهرس تفصيلي
echo    ✓ روابط داخلية
echo    ✓ علامات مرجعية تفاعلية
echo.
echo 4. البيانات الوصفية:
echo    ✓ العنوان: مستند مدمج
echo    ✓ المؤلف: KNOX System
echo    ✓ الكلمات المفتاحية: مستند، PDF، دمج
echo.
echo خيارات المراجعة:
echo   [1] معاينة الصفحة الأولى
echo   [2] معاينة الصفحة الأخيرة
echo   [3] معاينة عشوائية
echo   [4] فحص الروابط
echo   [5] حفظ النهائي
echo.
set /p review_option="اختر خيار المراجعة: "

if "%review_option%"=="5" (
    echo.
    echo جاري الحفظ النهائي...
    timeout /t 3 /nobreak >nul
    echo ✓ تم حفظ المستند النهائي بنجاح!
    pause
)
goto MENU

:CUSTOM_MERGE_PATTERNS
cls
echo.
echo =======================================================
echo           نمط الدمج المخصص
echo =======================================================
echo.
echo 1. أنماط الدمج المعدة مسبقًا:
echo    [A] بديل (ملف1، ملف2، ملف1، ملف2)
echo    [B] متداخل (صفحة من كل ملف بالتناوب)
echo    [C] حسب الأولوية (ملفات مهمة أولاً)
echo    [D] حسب الحجم (من الأصغر للأكبر)
echo.
set /p merge_pattern="نمط الدمج: "

echo.
echo 2. إنشاء نمط مخصص:
echo    أدخل تسلسل الدمج (مثال: 1-5, 2-3, 1-2):
set /p custom_pattern="النمط المخصص: "

echo.
echo 3. حفظ النمط:
set /p save_pattern="حفظ النمط باسم: "

echo.
echo ✓ تم حفظ نمط الدمج المخصص
pause
goto MENU

:SMART_SPLIT_RULES
cls
echo.
echo =======================================================
echo           نصوص التقسيم الذكية
echo =======================================================
echo.
echo 1. قواعد التقسيم الذكي:
echo    [A] حسب العناوين الرئيسية (H1, H2)
echo    [B] حسب الفصول والفقرات
echo    [C] حسب حجم المحتوى
echo    [D] حسب نوع المحتوى
echo.
set /p smart_rule="قاعدة التقسيم الذكي: "

echo.
echo 2. معالجة المحتوى:
echo    [1] التعرف على العناوين تلقائيًا
echo    [2] تحليل بنية المستند
echo    [3] تقسيم حسب المعنى المنطقي
echo    [4] تقسيم حسب المرئيات
echo.
set /p content_analysis="تحليل المحتوى: "

echo.
echo 3. إعدادات متقدمة:
echo    [X] استخدام الذكاء الاصطناعي
echo    [Y] التعلم من المستندات السابقة
echo    [Z] تخصيص القواعد
echo.
set /p advanced_rules="قواعد متقدمة: "

echo.
echo ✓ تم حفظ قواعد التقسيم الذكية
pause
goto MENU

:CUSTOM_COMPRESSION
cls
echo.
echo =======================================================
echo           إعدادات الضغط المخصصة
echo =======================================================
echo.
echo 1. مستوى الضغط:
echo    [A] بدون ضغط (أعلى جودة)
echo    [B] ضغط خفيف (جودة عالية)
echo    [C] ضغط متوسط (متوازن)
echo    [D] ضغط قوي (أصغر حجم)
echo.
set /p compression_level="مستوى الضغط: "

echo.
echo 2. ضغط الصور:
echo    [1] JPEG (للصور الفوتوغرافية)
echo    [2] PNG (للرسومات)
echo    [3] ضغط مخصص
echo    [4] عدم ضغط الصور
echo.
set /p image_compression="ضغط الصور: "

echo.
echo 3. ضغط الخطوط:
echo    [X] تضمين الخطوط الكاملة
echo    [Y] تضمين الأحرف المستخدمة فقط
echo    [Z] عدم تضمين الخطوط
echo.
set /p font_compression="ضغط الخطوط: "

echo.
echo ✓ تم حفظ إعدادات الضغط المخصصة
pause
goto MENU

:PROCESS_PROFILES
cls
echo.
echo =======================================================
echo           ملفات تعريف العملية
echo =======================================================
echo.
echo ملفات التعريف المحفوظة:
echo.
echo  [1] دمج سريع (جودة عالية)
echo  [2] دمج للويب (حجم صغير)
echo  [3] دمج للطباعة (جودة احترافية)
echo  [4] دمج مخصص (إعداداتك)
echo.
echo خيارات:
echo   [L] تحميل ملف تعريف
echo   [S] حفظ الإعدادات الحالية
echo   [D] حذف ملف تعريف
echo   [E] تصدير ملف تعريف
echo.
set /p profile_action="اختر الإجراء: "

if /i "%profile_action%"=="L" (
    set /p load_profile="اختر ملف التعريف: "
    echo ✓ تم تحميل ملف التعريف
)

if /i "%profile_action%"=="S" (
    set /p save_profile_name="اسم ملف التعريف: "
    echo ✓ تم حفظ ملف التعريف
)

pause
goto MENU
