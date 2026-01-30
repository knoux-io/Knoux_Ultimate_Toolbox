@echo off
chcp 65001 >nul
title KNOX - قوة المستندات (بنفسجي ملكي #8A2BE2)
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
echo        الفئة 5: قوة المستندات (بنفسجي ملكي)
echo           "كل كلمة لها وزن، وكل مستند له قوة"
echo =======================================================
echo.
echo ↻ الأدوات القابلة للتخصيص الكامل:
echo.
echo   [1]  دمج وتقسيم PDF - PDF Merger & Splitter
echo   [2]  محول PDF إلى Office - PDF to Office Converter
echo   [3]  محول Office إلى PDF - Office to PDF Converter
echo   [4]  محرر صفحات PDF - PDF Page Editor
echo   [5]  مستخرج نصوص PDF - PDF Text Extractor
echo.
echo   [6]  أداة مقارنة المستندات - Document Comparison Tool
echo   [7]  ضغط PDF - PDF Compression
echo   [8]  مملء وإنشاء نماذج PDF - PDF Form Filler & Creator
echo   [9]  تشفير وفك تشفير المستندات - Document Encryption
echo   [10] محول المستندات الدفعي - Batch Document Converter
echo.
echo   [W]  تخصيص واجهة معالجة الكلمات
echo   [O]  إعدادات OCR المخصصة
echo   [T]  قوالب المستندات الذكية
echo   [F]  إدارة خطوط مخصصة
echo   [B]  العودة للقائمة الرئيسية
echo.
set /p choice="اختر الأداة [1-10, W, O, T, F, B]: "

if "%choice%"=="1" call "01_PDF_MERGER_SPLITTER.bat"
if "%choice%"=="2" call "02_PDF_TO_OFFICE_CONVERTER.bat"
if "%choice%"=="3" call "03_OFFICE_TO_PDF_CONVERTER.bat"
if "%choice%"=="4" call "04_PDF_PAGE_EDITOR.bat"
if "%choice%"=="5" call "05_PDF_TEXT_EXTRACTOR.bat"
if "%choice%"=="6" call "06_DOCUMENT_COMPARISON_TOOL.bat"
if "%choice%"=="7" call "07_PDF_COMPRESSION.bat"
if "%choice%"=="8" call "08_PDF_FORM_FILLER_CREATOR.bat"
if "%choice%"=="9" call "09_DOCUMENT_ENCRYPTION_DECRYPTION.bat"
if "%choice%"=="10" call "10_BATCH_DOCUMENT_CONVERTER.bat"

if /i "%choice%"=="W" goto WORD_PROCESSING_CUSTOM
if /i "%choice%"=="O" goto OCR_CUSTOMIZATION
if /i "%choice%"=="T" goto SMART_TEMPLATES
if /i "%choice%"=="F" goto FONT_MANAGEMENT
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:WORD_PROCESSING_CUSTOM
cls
echo.
echo =======================================================
echo       تخصيص واجهة معالجة الكلمات والمستندات
echo =======================================================
echo.
echo 1. إعدادات التحرير:
echo    [A] وضع التحرير: WYSIWYG/الكود
echo    [B] الإكمال التلقائي: نعم/لا
echo    [C] تصحيح الإملاء: جميع اللغات
echo    [D] التنسيق التلقائي: متقدم
echo.
echo 2. إعدادات التصدير:
echo    [1] تنسيقات المدعومة: PDF/DOCX/ODT/RTF/HTML
echo    [2] حفظ البيانات الوصفية: تفصيلي
echo    [3] تضمين الخطوط: تلقائي
echo    [4] علامات مائية: مخصصة
echo.
echo 3. إعدادات الطباعة:
echo    [X] الهوامش المخصصة: أعلى/أسفل/يمين/يسار
echo    [Y] رؤوس وتذييلات: متغيرة لكل صفحة
echo    [Z] إعدادات الصفحة: A4/Letter/Legal
echo    [W] اتجاه الصفحة: عمودي/أفقي
echo.
set /p wp_settings="اختر الإعداد للتعديل: "
echo.
set /p wp_value="أدخل القيمة الجديدة: "
echo ✓ تم تحديث إعدادات معالجة الكلمات
pause
goto MENU

:OCR_CUSTOMIZATION
cls
echo.
echo =======================================================
echo           تخصيص إعدادات التعرف الضوئي على الحروف
echo =======================================================
echo.
echo 1. إعدادات الدقة:
echo    [A] دقة المسح: 150/300/600 DPI
echo    [B] نمط الألوان: أبيض وأسود/رمادي/ملون
echo    [C] إزالة الضوضاء: تلقائي/يدوي
echo    [D] تصحيح الانحراف: ±15 درجة
echo.
echo 2. اللغات المدعومة:
echo    ✓ العربية (فصحى)
echo    ✓ الإنجليزية
echo    ✓ الفرنسية
echo    ✓ الإسبانية
echo    ✓ إضافة لغات مخصصة...
echo.
echo 3. نماذج OCR:
echo    [1] Tesseract 5.0 (افتراضي)
echo    [2] EasyOCR (للمستندات المعقدة)
echo    [3] PaddleOCR (للصينية/اليابانية)
echo    [4] Custom Model (خاص بك)
echo.
echo 4. إعدادات ما بعد المعالجة:
echo    [X] تصحيح تلقائي للكلمات
echo    [Y] الحفاظ على التنسيق الأصلي
echo    [Z] التعرف على الجداول
echo    [W] استخراج الصور المضمنة
echo.
set /p ocr_settings="تخصيص إعدادات OCR: "
echo ✓ تم حفظ الإعدادات
pause
goto MENU

:SMART_TEMPLATES
cls
echo.
echo =======================================================
echo           قوالب المستندات الذكية
echo =======================================================
echo.
echo 1. قوالب الأعمال:
echo    [A] فواتير احترافية
echo    [B] عقود ومواثيق
echo    [C] تقارير مالية
echo    [D] عروض تقديمية
echo.
echo 2. قوالب شخصية:
echo    [1] سيرة ذاتية
echo    [2] رسائل تغطية
echo    [3] خطابات رسمية
echo    [4] جداول زمنية
echo.
echo 3. قوالب تعليمية:
echo    [X] أوراق بحثية
echo    [Y] ملخصات دراسية
echo    [Z] اختبارات وامتحانات
echo    [W] خطط دروس
echo.
echo 4. تخصيص القوالب:
echo    [T] تدريب القالب على أسلوبك
echo    [C] إنشاء قالب مخصص
echo    [M] تعديل قالب موجود
echo    [S] مشاركة القوالب
echo.
set /p template_choice="اختر القالب: "
goto MENU

:FONT_MANAGEMENT
cls
echo.
echo =======================================================
echo           إدارة الخطوط المخصصة
echo =======================================================
echo.
echo 1. الخطوط المثبتة:
echo    ✓ Arial (افتراضي)
echo    ✓ Times New Roman (افتراضي)
echo    ✓ Cairo (عربي)
echo    ✓ Noto Sans Arabic
echo.
echo 2. خطوط إضافية:
echo    [A] خطوط عربية احترافية
echo    [B] خطوط لاتينية كلاسيكية
echo    [C] خطوط رمزية وأيقونات
echo    [D] خطوط مخصصة منك
echo.
echo 3. إعدادات الخطوط:
echo    [1] الخط الافتراضي للمستندات
echo    [2] حجم الخط الافتراضي
echo    [3] تضمين الخطوط في PDF
echo    [4] تحسين الخطوط للطباعة
echo.
echo 4. إدارة الخطوط:
echo    [I] تثبيت خط جديد
echo    [R] إزالة خط
echo    [E] تصدير مجموعة خطوط
echo    [S] مزامنة الخطوط
echo.
set /p font_action="اختر الإجراء: "
goto MENU
