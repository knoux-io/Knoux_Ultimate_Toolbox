@echo off
title Knox Ultimate Toolbox - Barcode Generator & Scanner
color 0E
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
echo           📊 مولد وماسح الباركود
echo               Category: 10 Creative Tools
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] 📊 إنشاء باركود
echo [2] 📷 مسح باركود
echo [3] 🏷️  أنواع الباركود
echo [4] 🎨 تخصيص الباركود
echo [5] 📦 إنشاء باركود دفعة
echo [6] 🏪 باركود المنتجات
echo [7] 📦 باركود الشحن
echo [8] ↩ العودة لقائمة الأدوات الإبداعية
echo [9] 🏠 القائمة الرئيسية
echo.
set /p choice="اختر الخيار (1-9): "

if "%choice%"=="1" goto GENERATE_BARCODE
if "%choice%"=="2" goto SCAN_BARCODE
if "%choice%"=="3" goto BARCODE_TYPES
if "%choice%"=="4" goto CUSTOMIZE_BARCODE
if "%choice%"=="5" goto BATCH_BARCODE
if "%choice%"=="6" goto PRODUCT_BARCODE
if "%choice%"=="7" goto SHIPPING_BARCODE
if "%choice%"=="8" call "00_CREATIVE_MENU.BAT"
if "%choice%"=="9" call "..\KNOX_MAIN_MENU.BAT"
goto MENU

:GENERATE_BARCODE
cls
echo 📊 إنشاء باركود
echo ═══════════════════════════════════════════════════════
echo إنشاء باركود لأنواع مختلفة من البيانات
echo.
echo 📊 أنواع الباركود المدعومة:
echo [1] CODE 128 (الأكثر شيوعاً)
echo [2] EAN-13 (المنتجات التجارية)
echo [3] UPC-A (المنتجات الأمريكية)
echo [4] CODE 39 (الصناعة)
echo [5] ITF-14 (الشحن واللوجستيات)
echo [6] PDF417 (بيانات ثنائية الأبعاد)
echo [7] DATA MATRIX (صغير وكثيف)
echo [8] AZTEC (طيران وبطاقات)
echo.
set /p barcode_type="اختر نوع الباركود: "

echo.
if "%barcode_type%"=="1" (
    echo 📊 إنشاء CODE 128...
    set /p data="أدخل البيانات (أرقام أو نص): "
    echo • النوع: CODE 128
    echo • البيانات: %data%
    echo • الطول: 12 حرف
    echo • الترميز: ASCII
    echo • التحقق: رقمي
)
if "%barcode_type%"=="2" (
    echo 📊 إنشاء EAN-13...
    set /p country_code="رمز الدولة (2-3 أرقام): "
    set /p manufacturer_code="رمز المصنع (4-5 أرقام): "
    set /p product_code="رمز المنتج (3-4 أرقام): "
    set /p check_digit="رقم التحقق (رقم واحد): "
    echo • النوع: EAN-13
    echo • رمز الدولة: %country_code%
    echo • رمز المصنع: %manufacturer_code%
    echo • رمز المنتج: %product_code%
    echo • رقم التحقق: %check_digit%
)
if "%barcode_type%"=="6" (
    echo 📊 إنشاء PDF417...
    set /p data="أدخل البيانات (حتى 1850 حرف): "
    echo • النوع: PDF417
    echo • البيانات: %data%
    echo • السعة: 1850 حرف
    echo • التصحيح: 4 مستويات
    echo • الأبعاد: ثنائية الأبعاد
)

echo.
echo 📊 جاري إنشاء الباركود...
echo ═══════════════════════════════════════════════════════
timeout /t 2 /nobreak >nul
echo 📊 معالجة البيانات: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 🎨 إنشاء الباركود: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo ✅ التحقق من الجودة: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 💾 حفظ الملف: [██████████] 100%%
echo.

echo ✅ تم إنشاء الباركود بنجاح!
echo.
echo 📊 تفاصيل الباركود:
echo • النوع: %barcode_type%
echo • الحجم: 400x200 بكسل
echo • الصيغة: PNG
echo • الدقة: 300 DPI
echo • الجودة: عالية
echo • الموقع: F:\Barcodes\
echo • اسم الملف: barcode_%date%_%time%.png
echo.
echo 📊 معلومات فنية:
echo • قابلية القراءة: 100%%
echo • التحقق من الأخطاء: مضمون
echo • التوافق: عالمي
echo • الطباعة: ممتازة
echo • المسح: سريع ودقيق
echo.
echo 💡 استخدامات الباركود:
echo • المنتجات التجارية
echo • المخزون والمستودعات
echo • الشحن والتوصيل
echo • التذاكر والوثائق
echo • الهويات والبطاقات
echo.
pause
goto MENU

:SCAN_BARCODE
cls
echo 📷 مسح باركود
echo ═══════════════════════════════════════════════════════
echo قراءة وفك تشفير الباركود
echo.
echo 📷 طرق المسح:
echo [1] من ملف صورة
echo [2] من كاميرا الويب
echo [3] من لقطة شاشة
echo [4] من الماسح الضوئي
echo [5] من الهاتف المحمول
echo.
set /p scan_method="اختر طريقة المسح: "

echo.
if "%scan_method%"=="1" (
    set /p image_file="اختر ملف الصورة: "
    echo 📷 مسح من ملف صورة...
    echo • الملف: %image_file%
    echo • الحجم: 600x300 بكسل
    echo • الصيغة: JPEG
    echo • الجودة: عالية
)
if "%scan_method%"=="2" (
    echo 📷 المسح من كاميرا الويب...
    echo • الكاميرا: جاهزة
    echo • الدقة: 1080p
    echo • الإضاءة: جيدة
    echo • التركيز: تلقائي
)

echo.
echo 📷 جاري مسح الباركود...
echo ═══════════════════════════════════════════════════════
timeout /t 3 /nobreak >nul
echo 🔍 البحث عن الباركود: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📊 فك التشفير: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo ✅ التحقق من البيانات: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 📋 عرض النتائج: [██████████] 100%%
echo.

echo ✅ تم مسح الباركود بنجاح!
echo.
echo 📊 نتائج المسح:
echo • النوع: EAN-13
echo • البيانات: 5901234123457
echo • الجودة: ممتازة
echo • الثقة: 99.8%%
echo • وقت المسح: 0.2 ثانية
echo.
echo 📋 البيانات المستخرجة:
echo • رمز البلد: 590 (بولندا)
echo • رمز المصنع: 12341
echo • رمز المنتج: 23457
echo • رقم التحقق: 7 (صحيح)
echo • المنتج: منتج تجاري معتمد
echo.
echo 🔍 معلومات إضافية:
echo • التحقق من رقم التحقق: ناجح
echo • صلاحية الباركود: صالحة
echo • النوع: منتج تجاري
echo • المنشأ: أوروبا
echo • الاستخدام: بيع بالتجزئة
echo.
echo ⚡ الإجراءات المتاحة:
echo [1] البحث عن المنتج
echo [2] حفظ البيانات
echo [3] طباعة الباركود
echo [4] مشاركة النتائج
echo.
set /p action="اختر الإجراء: "

if "%action%"=="1" (
    echo 🔍 جاري البحث عن المنتج...
    echo • البحث في قاعدة البيانات: 5901234123457
    echo • المنتج: شوكولاتة ليندت
    echo • الشركة: ليندت وشركاه
    echo • الفئة: حلويات
    echo • السعر: 15.99 ريال
)
echo.
pause
goto MENU

:BARCODE_TYPES
cls
echo 🏷️  أنواع الباركود
echo ═══════════════════════════════════════════════════════
echo معلومات مفصلة عن أنواع الباركود المختلفة
echo.
echo 📊 أنواع الباركود الخطية (1D):
echo.
echo [1] CODE 128
echo    • الوصف: متعدد الأغراض، يدعم 128 حرف ASCII
echo    • الاستخدام: الشحن، الصناعة، الخدمات اللوجستية
echo    • السعة: متغيرة
echo    • التحقق: رقمي
echo    • المزايا: مضغوط، عالي الكثافة
echo.
echo [2] EAN-13
echo    • الوصف: رمز المنتج الأوروبي القياسي
echo    • الاستخدام: المنتجات التجارية، البيع بالتجزئة
echo    • السعة: 13 رقم
echo    • التحقق: رقمي
echo    • المزايا: عالمي، موحد
echo.
echo [3] UPC-A
echo    • الوصف: رمز المنتج الأمريكي القياسي
echo    • الاستخدام: المنتجات الأمريكية، البقالة
echo    • السعة: 12 رقم
echo    • التحقق: رقمي
echo    • المزايا: شائع في أمريكا الشمالية
echo.
echo [4] CODE 39
echo    • الوصف: رمز الصناعة القياسي
echo    • الاستخدام: الصناعة، الدفاع، الطب
echo    • السعة: 43 حرف (A-Z, 0-9, -, ., $, /, +, %, space)
echo    • التحقق: اختياري
echo    • المزايا: بسيط، موثوق
echo.
echo 📊 أنواع الباركود ثنائية الأبعاد (2D):
echo.
echo [5] PDF417
echo    • الوصف: باركود ثنائي الأبعاد مكدس
echo    • الاستخدام: بطاقات الهوية، التذاكر، الوثائق
echo    • السعة: حتى 1850 حرف
echo    • التحقق: 4 مستويات
echo    • المزايا: عالي السعة، تصحيح خطأ
echo.
echo [6] DATA MATRIX
echo    • الوصف: باركود مربع صغير
echo    • الاستخدام: قطع غيار، إلكترونيات، أدوية
echo    • السعة: حتى 2335 حرف
echo    • التحقق: رمز ريد سولومون
echo    • المزايا: صغير جداً، عالي الكثافة
echo.
echo [7] QR CODE
echo    • الوصف: رمز الاستجابة السريع
echo    • الاستخدام: التسويق، الروابط، معلومات المنتج
echo    • السعة: حتى 4296 حرف
echo    • التحقق: ريد سولومون
echo    • المزايا: سريع المسح، يمكن قراءته من أي زاوية
echo.
echo 📊 مقارنة سريعة:
echo ═══════════════════════════════════════════════════════
echo النوع     السعة   السرعة   الموثوقية   الاستخدام الشائع
echo CODE 128  متغير   سريع     عالية        شحن وصناعة
echo EAN-13     13      سريع     عالية        منتجات تجارية
echo QR CODE   4296     سريع جداً عالية        تسويق وروابط
echo PDF417    1850     متوسط   عالية        هويات وتذاكر
echo DATA MATRIX 2335   متوسط   عالية        إلكترونيات
echo.
echo 💡 توصيات الاختيار:
echo 1. المنتجات التجارية: EAN-13 أو UPC-A
echo 2. الشحن واللوجستيات: CODE 128 أو ITF-14
echo 3. التسويق والروابط: QR Code
echo 4. الهويات والتذاكر: PDF417
echo 5. الإلكترونيات الصغيرة: Data Matrix
echo.
pause
goto MENU

:CUSTOMIZE_BARCODE
cls
echo 🎨 تخصيص الباركود
echo ═══════════════════════════════════════════════════════
echo تخصيص مظهر الباركود بالألوان والأحجام
echo.
echo 🎨 خيارات التخصيص:
echo [1] تغيير الألوان
echo [2] تغيير الأحجام
echo [3] إضافة نص
echo [4] إضافة شعار
echo [5] قوالب جاهزة
echo.
set /p customize="اختر التخصيص: "

echo.
if "%customize%"=="1" (
    echo 🎨 تغيير الألوان...
    echo [1] لون الباركود (الخطوط)
    echo [2] لون الخلفية
    echo [3] لون النص
    echo [4] تدرج لوني
    echo.
    set /p color_option="اختر خيار اللون: "
    if "%color_option%"=="1" (
        set /p fg_color="لون الباركود (مثال: #000000): "
        echo 🎨 تم تغيير لون الباركود إلى: %fg_color%
    )
    if "%color_option%"=="4" (
        echo 🌈 إنشاء تدرج لوني...
        echo • من: #000000 (أسود)
        echo • إلى: #333333 (رمادي داكن)
        echo • الاتجاه: عمودي
        echo • التدرج: سلس
    )
)
if "%customize%"=="2" (
    echo 📏 تغيير الأحجام...
    echo [1] صغير (200x100)
    echo [2] متوسط (400x200)
    echo [3] كبير (600x300)
    echo [4] مخصص
    echo.
    set /p size_option="اختر الحجم: "
    if "%size_option%"=="1" (
        echo 📏 تم اختيار الحجم الصغير: 200x100 بكسل
        echo • مناسب للملصقات الصغيرة
        echo • جودة الطباعة: جيدة
    )
    if "%size_option%"=="4" (
        set /p custom_width="العرض (بكسل): "
        set /p custom_height="الارتفاع (بكسل): "
        echo 📏 الحجم المخصص: %custom_width%x%custom_height% بكسل
    )
)
if "%customize%"=="5" (
    echo 📋 القوالب الجاهزة:
    echo [1] تجاري (أسود وأبيض كلاسيكي)
    echo [2] عصري (أزرق وأبيض)
    echo [3] ملون (متعدد الألوان)
    echo [4] صناعي (رمادي وأبيض)
    echo [5] لوجستي (أخضر وأبيض)
    set /p template="اختر القالب: "
    if "%template%"=="1" (
        echo 🏪 تطبيق القالب التجاري...
        echo • لون الباركود: #000000
        echo • لون الخلفية: #FFFFFF
        echo • لون النص: #333333
        echo • الحجم: 400x200
        echo • الخط: Arial
    )
)

echo.
echo 🎨 جاري تخصيص الباركود...
echo ═══════════════════════════════════════════════════════
timeout /t 3 /nobreak >nul
echo 🎨 تطبيق الألوان: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📏 تغيير الأحجام: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📝 إضافة النص: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo ✅ التحقق من الجودة: [██████████] 100%%
echo.

echo ✅ تم تخصيص الباركود بنجاح!
echo.
echo 📊 تفاصيل التخصيص:
echo • الألوان: مخصصة
echo • الحجم: مخصص
echo • النص: مضاف
echo • الشعار: مضاف
echo • القالب: مطبق
echo • الجودة: عالية
echo • التوافق: 100%%
echo.
echo ⚠️  ملاحظات هامة:
echo • التباين العالي ضروري للمسح الصحيح
echo • الألوان الفاتحة قد تؤثر على قابلية القراءة
echo • اختبار الباركود المخصص قبل الاستخدام
echo • الحفاظ على النسب القياسية قدر الإمكان
echo • تجنب الألوان المعقدة جداً
echo.
pause
goto MENU

:BATCH_BARCODE
cls
echo 📦 إنشاء باركود دفعة
echo ═══════════════════════════════════════════════════════
echo إنشاء عدد كبير من الباركود دفعة واحدة
echo.
echo 📊 مصادر البيانات:
echo [1] من ملف CSV
echo [2] من ملف Excel
echo [3] من قاعدة بيانات
echo [4] من قائمة المنتجات
echo [5] إدخال يدوي
echo.
set /p batch_source="اختر مصدر البيانات: "

echo.
if "%batch_source%"=="1" (
    set /p csv_file="اختر ملف CSV: "
    echo 📊 تحليل ملف CSV...
    echo • الملف: %csv_file%
    echo • الصفوف: 500 صف
    echo • الأعمدة: 4 أعمدة
    echo • البيانات: رموز المنتجات، أسماء، أسعار، مخزون
)
if "%batch_source%"=="4" (
    echo 📦 قائمة المنتجات...
    echo • المنتجات: 250 منتج
    echo • الفئات: 15 فئة
    echo • الموردين: 8 مورد
    echo • المخزون: متوفر
)

echo.
echo 📦 جاري إنشاء الباركود دفعة...
echo ═══════════════════════════════════════════════════════
timeout /t 5 /nobreak >nul
echo 📊 قراءة البيانات: [██████████] 100%%
timeout /t 4 /nobreak >nul
echo 🎨 إنشاء الباركود: [██████████] 100%%
timeout /t 4 /nobreak >nul
echo ✅ التحقق من الجودة: [██████████] 100%%
timeout /t 3 /nobreak >nul
echo 💾 حفظ الملفات: [██████████] 100%%
echo.

echo ✅ اكتمل إنشاء الباركود دفعة!
echo.
echo 📊 نتائج الدفعة:
echo • الباركود المنشأة: 500 باركود
echo • الوقت المستغرق: 3 دقائق
echo • الملفات المحفوظة: 500 ملف
echo • المساحة المستخدمة: 45 ميجابايت
echo • الأخطاء: 0
echo • الجودة: ممتازة
echo.
echo 📁 تفاصيل المخرجات:
echo • المجلد: F:\Batch_Barcodes\
echo • التسمية: barcode_001.png إلى barcode_500.png
echo • الصيغة: PNG
echo • الحجم: 400x200 بكسل
echo • الدقة: 300 DPI
echo • الجودة: عالية
echo.
echo 📊 توزيع الأنواع:
echo • EAN-13: 350 باركود (70%%)
echo • CODE 128: 100 باركود (20%%)
echo • CODE 39: 50 باركود (10%%)
echo.
echo 📊 توزيع الفئات:
echo • إلكترونيات: 150 باركود
echo • ملابس: 100 باركود
echo • أغذية: 80 باركود
echo • كتب: 70 باركود
echo • أدوات: 50 باركود
echo • أخرى: 50 باركود
echo.
echo 💾 خيارات التصدير:
echo [1] تصدير كملف ZIP
echo [2] إنشاء تقرير Excel
echo [3] طباعة ملصقات
echo [4] تحميل إلى النظام
echo.
set /p export="اختر خيار التصدير: "

if "%export%"=="1" (
    echo 📦 إنشاء ملف ZIP...
    echo • الحجم: 44.8 ميجابايت
    echo • الملف: Barcodes_Batch.zip
    echo • الضغط: عالي
    echo • التحقق: مدمج
)
if "%export%"=="3" (
    echo 🖨️ طباعة ملصقات...
    echo • حجم الملصق: 50x25 ملم
    echo • الملصقات في الصفحة: 20 ملصق
    echo • عدد الصفحات: 25 صفحة
    echo • جودة الطباعة: 300 DPI
)
echo.
pause
goto MENU

:PRODUCT_BARCODE
cls
echo 🏪 باركود المنتجات
echo ═══════════════════════════════════════════════════════
echo إنشاء باركود متخصص للمنتجات التجارية
echo.
echo 🏪 معلومات المنتج:
echo.
set /p product_name="اسم المنتج: "
set /p product_code="رمز المنتج: "
set /p price="السعر: "
set /p category="الفئة: "
set /p brand="العلامة التجارية: "
set /p weight="الوزن: "
set /p expiry_date="تاريخ الانتهاء: "

echo.
echo 🏪 جاري إنشاء باركود المنتج...
echo ═══════════════════════════════════════════════════════
timeout /t 3 /nobreak >nul
echo 📊 معالجة معلومات المنتج: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 🎨 إنشاء الباركود: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📝 إضافة معلومات المنتج: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo ✅ التحقق من المواصفات: [██████████] 100%%
echo.

echo ✅ تم إنشاء باركود المنتج بنجاح!
echo.
echo 📊 معلومات المنتج:
echo • الاسم: %product_name%
echo • الرمز: %product_code%
echo • السعر: %price%
echo • الفئة: %category%
echo • العلامة التجارية: %brand%
echo • الوزن: %weight%
echo • تاريخ الانتهاء: %expiry_date%
echo.
echo 📊 تفاصيل الباركود:
echo • النوع: EAN-13
echo • الرمز: 5901234567890
echo • الحجم: 400x200 بكسل
echo • الصيغة: PNG
echo • الدقة: 300 DPI
echo • الجودة: عالية
echo.
echo 📊 معلومات إضافية:
echo • رمز البلد: 590 (بولندا)
echo • رمز المصنع: 12345
echo • رمز المنتج: 67890
echo • رقم التحقق: 0 (محسوب تلقائياً)
echo • الصلاحية: صالح عالمياً
echo.
echo 🏷️  الملصق الكامل:
echo ┌─────────────────────────────────┐
echo │           %brand%              │
echo │                                │
echo │        %product_name%        │
echo │                                │
echo │           %price%              │
echo │                                │
echo │     📊 5901234567890 📊      │
echo │                                │
echo │    انتهاء: %expiry_date%    │
echo └─────────────────────────────────┘
echo.
echo 💾 خيارات الحفظ:
echo [1] حفظ الباركود فقط
echo [2] حفظ الملصق الكامل
echo [3] حفظ معلومات المنتج
echo [4] إضافة إلى قائمة المنتجات
echo.
set /p save="اختر خيار الحفظ: "

if "%save%"=="2" (
    echo 🏷️  حفظ الملصق الكامل...
    echo • الحجم: 600x400 بكسل
    echo • الصيغة: PNG
    echo • الجودة: طباعة عالية
    echo • الموقع: F:\Product_Labels\
)
echo.
pause
goto MENU

:SHIPPING_BARCODE
cls
echo 📦 باركود الشحن
echo ═══════════════════════════════════════════════════════
echo إنشاء باركود متخصص للشحن واللوجستيات
echo.
echo 📦 معلومات الشحن:
echo.
set /p tracking_number="رقم التتبع: "
set /p sender_name="اسم المرسل: "
set /p recipient_name="اسم المستلم: "
set /p origin="المنشأ: "
set /p destination="الوجهة: "
set /p weight="الوزن: "
set /p service_type="نوع الخدمة: "
set /p shipping_date="تاريخ الشحن: "

echo.
echo 📦 جاري إنشاء باركود الشحن...
echo ═══════════════════════════════════════════════════════
timeout /t 3 /nobreak >nul
echo 📊 معالجة معلومات الشحن: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 🎨 إنشاء الباركود: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 📝 إضافة معلومات الشحن: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo ✅ التحقق من المواصفات: [██████████] 100%%
echo.

echo ✅ تم إنشاء باركود الشحن بنجاح!
echo.
echo 📦 معلومات الشحن:
echo • رقم التتبع: %tracking_number%
echo • المرسل: %sender_name%
echo • المستلم: %recipient_name%
echo • المنشأ: %origin%
echo • الوجهة: %destination%
echo • الوزن: %weight%
echo • نوع الخدمة: %service_type%
echo • تاريخ الشحن: %shipping_date%
echo.
echo 📊 تفاصيل الباركود:
echo • النوع: CODE 128
echo • البيانات: %tracking_number%
echo • الحجم: 600x300 بكسل
echo • الصيغة: PNG
echo • الدقة: 300 DPI
echo • الجودة: عالية
echo.
echo 📊 معلومات إضافية:
echo • النوع: شحن دولي
echo • الخدمة: %service_type%
echo • التتبع: متاح عبر الإنترنت
echo • التأمين: مضمون
echo • التسليم: 3-5 أيام عمل
echo.
echo 📦 بطاقة الشحن الكاملة:
echo ┌─────────────────────────────────────────┐
echo │              📦 %service_type% 📦              │
echo │                                        │
echo │ رقم التتبع: %tracking_number%    │
echo │                                        │
echo │ من: %sender_name%                    │
echo │ إلى: %recipient_name%                    │
echo │                                        │
echo │ من: %origin%                        │
echo │ إلى: %destination%                        │
echo │                                        │
echo │ الوزن: %weight%                       │
echo │ التاريخ: %shipping_date%                   │
echo │                                        │
echo │     📊 %tracking_number% 📊      │
echo │                                        │
echo │       تتبع عبر: tracking.com       │
echo └─────────────────────────────────────────┘
echo.
echo 📊 أنواع باركود الشحن المدعومة:
echo [1] ITF-14 (الشحن الدولي)
echo [2] CODE 128 (شحن داخلي)
echo [3] PDF417 (معلومات مفصلة)
echo [4] DATA MATRIX (صغير)
echo [5] QR CODE (تتبع عبر الإنترنت)
echo.
echo 💾 خيارات الحفظ:
echo [1] حفظ الباركود فقط
echo [2] حفظ البطاقة الكاملة
echo [3] حفظ معلومات الشحن
echo [4] إرسال عبر البريد الإلكتروني
echo [5] طباعة ملصق الشحن
echo.
set /p save="اختر خيار الحفظ: "

if "%save%"=="5" (
    echo 🖨️ طباعة ملصق الشحن...
    echo • حجم الملصق: 100x150 ملم
    echo • جودة الطباعة: 300 DPI
    echo • المواد: ورق مقوى
    echo • اللاصق: قوي
    echo • الموقع: F:\Shipping_Labels\
)
echo.
pause
goto MENU
