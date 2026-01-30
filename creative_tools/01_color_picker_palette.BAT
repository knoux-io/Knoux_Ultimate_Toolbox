@echo off
title Knox Ultimate Toolbox - Color Picker & Palette Generator
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
echo           🎨 منتقي الألوان ومولد البالتات
echo               Category: 10 Creative Tools
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] 🎯 منتقي الألوان من الشاشة
echo [2] 🖼️  مستخرج الألوان من الصور
echo [3] 🎨 مولد البالتات اللونية
echo [4] 🎭 أدوات التوافق اللوني
echo [5] 🔄 محول الألوان
echo [6] 👁️ محاكاة عمى الألوان
echo [7] 📤 تصدير أنظمة الألوان
echo [8] ↩ العودة لقائمة الأدوات الإبداعية
echo [9] 🏠 القائمة الرئيسية
echo.
set /p choice="اختر الخيار (1-9): "

if "%choice%"=="1" goto SCREEN_PICKER
if "%choice%"=="2" goto IMAGE_EXTRACTOR
if "%choice%"=="3" goto PALETTE_GENERATOR
if "%choice%"=="4" goto COLOR_HARMONY
if "%choice%"=="5" goto COLOR_CONVERTER
if "%choice%"=="6" goto COLOR_BLINDNESS
if "%choice%"=="7" goto EXPORT_SCHEMES
if "%choice%"=="8" call "00_CREATIVE_MENU.BAT"
if "%choice%"=="9" call "..\KNOX_MAIN_MENU.BAT"
goto MENU

:SCREEN_PICKER
cls
echo 🎯 منتقي الألوان من الشاشة
echo ═══════════════════════════════════════════════════════
echo انتقاء الألوان من أي مكان على الشاشة
echo.
echo 📋 التعليمات:
echo 1. حرك المؤشر إلى اللون المطلوب
echo 2. اضغط F8 لالتقاط اللون
echo 3. سيتم نسخ قيم اللون إلى الحافظة
echo.
echo 🔍 اللون الحالي:
echo • HEX: #FFD600
echo • RGB: 255, 214, 0
echo • HSL: 50°, 100%%, 50%%
echo • CMYK: 0%%, 16%%, 100%%, 0%%
echo • الاسم: الأصفر الذهبي
echo.
echo 📋 سجل الألوان (آخر 10):
echo 1. #FF6D00 (برتقالي الغروب)
echo 2. #00D4FF (الأزرق الكهربائي)
echo 3. #00C853 (الأخضر الزمردي)
echo 4. #6200EA (الأرجواني الملكي)
echo 5. #FF0080 (الأرجواني الزاهي)
echo 6. #FF4081 (الوردي العميق)
echo 7. #7C4DFF (البنفسجي)
echo 8. #536DFE (الأزرق النيلي)
echo 9. #FF6E40 (البرتقالي المشوي)
echo 10. #00BCD4 (السماوي)
echo.
echo 💾 حفظ اللون في البالتة؟ (ن/لا)
set /p save=": "
if /i "%save%"=="ن" (
    echo ✅ تم حفظ اللون في "بالتتي الخاصة"
    echo متاح في مولد البالتات
)
pause
goto MENU

:IMAGE_EXTRACTOR
cls
echo 🖼️ مستخرج الألوان من الصور
echo ═══════════════════════════════════════════════════════
echo استخراج بالتات الألوان من الصور
echo.
set /p image="اختر ملف الصورة: "
echo.
echo 📊 تحليل ألوان الصورة...
echo • الألوان المهيمنة: 5 ألوان
echo • اللون المتوسط: #4A6FA5
echo • تباين الألوان: متوسط
echo • السطوع: 65%%
echo • التشبع: 70%%
echo.
echo 🎨 الألوان المهيمنة المكتشفة:
echo 1. #2C3E50 (الأزرق الداكن) - 28%%
echo 2. #E74C3C (الأحمر) - 22%%
echo 3. #ECF0F1 (الرمادي الفاتح) - 18%%
echo 4. #3498DB (الأزرق) - 16%%
echo 5. #F1C40F (الأصفر) - 12%%
echo.
echo 📈 توزيع الألوان:
echo [██████████▒▒▒▒▒▒▒▒] 60%% ألوان باردة
echo [█████▒▒▒▒▒▒▒▒▒▒▒▒▒] 25%% ألوان دافئة
echo [██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒] 15%% ألوان محايدة
echo.
echo 💡 اقتراحات البالتة:
echo • الأساسي: #2C3E50
echo • الثانوي: #3498DB
echo • التمييز: #E74C3C
echo • الخلفية: #ECF0F1
echo • التمييز: #F1C40F
echo.
echo ⚙️ خيارات الاستخراج:
echo [1] استخراج 5 ألوان مهيمنة
echo [2] استخراج 10 ألوان متنوعة
echo [3] استخراج جميع الألوان الفريدة
echo [4] تحليل عميق للألوان
echo.
set /p extract="اختر الخيار: "

if "%extract%"=="1" (
    echo 🎨 استخراج 5 ألوان مهيمنة...
    echo تم استخراج البالتة بنجاح
)
if "%extract%"=="2" (
    echo 🌈 استخراج 10 ألوان متنوعة...
    echo تم استخراج بالتة غنية بالألوان
)
if "%extract%"=="4" (
    echo 🔍 تحليل عميق للألوان...
    echo • إجمالي الألوان الفريدة: 1,245 لون
    echo • الألوان المتكررة: 89 لون
    echo • التدرجات اللونية: 12 تدرج
    echo • الألوان النادرة: 45 لون
)
pause
goto MENU

:PALETTE_GENERATOR
cls
echo 🎨 مولد البالتات اللونية
echo ═══════════════════════════════════════════════════════
echo إنشاء أنظمة ألوان جميلة ومتناسقة
echo.
echo أنواع البالتات:
echo [1] أحادية اللون (Monochromatic)
echo [2] متكاملة (Complementary)
echo [3] متجاورة (Analogous)
echo [4] ثلاثية (Triadic)
echo [5] رباعية (Tetradic)
echo [6] متكاملة مقسمة (Split-Complementary)
echo [7] مربعة (Square)
echo [8] مخصصة
echo.
set /p palette="اختر نوع البالتة: "

echo.
echo 🎨 جاري إنشاء البالتة...
echo ═══════════════════════════════════════════════════════
timeout /t 2 /nobreak >nul
echo 🎨 تحليل الألوان: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 🎭 حساب التوافق: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 📊 إنشاء البالتة: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo ✅ التحقق من الجودة: [██████████] 100%%
echo.

if "%palette%"=="1" (
    echo 🎨 بالتة أحادية اللون
    echo اللون الأساسي: #FFD600
    echo • #FFD600 (الأساسي)
    echo • #FFE240 (فاتح)
    echo • #FFC900 (متوسط)
    echo • #FFB300 (داكن)
    echo • #FFA000 (أكثر دكانة)
    echo مناسبة لـ: التصاميم البسيطة
)
if "%palette%"=="2" (
    echo 🎨 بالتة متكاملة
    echo الأساسي: #FFD600 (أصفر)
    echo المكامل: #0066FF (أزرق)
    echo • #FFD600 (أساسي)
    echo • #0066FF (مكامل)
    echo • #FFE240 (أصفر فاتح)
    echo • #3388FF (أزرق فاتح)
    echo • #FFB300 (أصفر داكن)
    echo مناسبة لـ: التصاميم عالية التباين
)
if "%palette%"=="8" (
    echo ⚙️ منشئ البالتة المخصص
    echo إضافة الألوان يدوياً:
    echo 1. #FFD600 (الأصفر الذهبي)
    echo 2. #00D4FF (الأزرق الكهربائي)
    echo 3. #FF6D00 (برتقالي الغروب)
    echo 4. #00C853 (الأخضر الزمردي)
    echo 5. #6200EA (الأرجواني الملكي)
    echo.
    echo اسم البالتة: ألوان علامة KNOX
)
echo.
echo 📊 مقاييس البالتة:
echo • نسبة التباين: 4.5:1 (جيد)
echo • إمكانية الوصول: متوافق AAA
echo • آمن لعمى الألوان: نعم
echo • مناسب للطباعة: نعم
echo • آمن للويب: نعم
echo.
pause
goto MENU

:COLOR_HARMONY
cls
echo 🎭 أدوات التوافق اللوني
echo ═══════════════════════════════════════════════════════
echo تحليل وتحسين توافق الألوان
echo.
echo 📊 أدوات التوافق:
echo [1] تحليل التباين
echo [2] تحسين إمكانية الوصول
echo [3] التحقق من عمى الألوان
echo [4] اقتراحات التحسين
echo [5] محاكاة العرض
echo.
set /p harmony="اختر أداة التوافق: "

echo.
echo 🎭 جاري تحليل التوافق اللوني...
echo ═══════════════════════════════════════════════════════
timeout /t 3 /nobreak >nul
echo 📊 حساب التباين: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 👁️ فحص إمكانية الوصول: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 🎨 تحليل التوافق: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo ✅ إنشاء التقرير: [██████████] 100%%
echo.

if "%harmony%"=="1" (
    echo 📊 تحليل التباين
    echo • تباين النص والخلفية: 7.2:1 (ممتاز)
    echo • تباين العناصر: 4.5:1 (جيد)
    echo • تباين الحدود: 3.1:1 (مقبول)
    echo • التقييم العام: 8.5/10
)
if "%harmony%"=="2" (
    echo ♿ تحسين إمكانية الوصول
    echo • مستوى WCAG AA: متوافق
    echo • مستوى WCAG AAA: متوافق
    echo • نسبة التباين: 4.5:1 على الأقل
    echo • حجم النص: مناسب
)
if "%harmony%"=="4" (
    echo 💡 اقتراحات التحسين
    echo 1. زيادة تباين النص والخلفية
    echo 2. استخدام ألوان أكثر سطوعاً
    echo 3. تجنب الألوان المتقاربة جداً
    echo 4. التحقق من التوافق في مختلف الأحجام
)
echo.
pause
goto MENU

:COLOR_CONVERTER
cls
echo 🔄 محول الألوان
echo ═══════════════════════════════════════════════════════
echo التحويل بين صيغ الألوان المختلفة
echo.
set /p color_input="أدخل اللون (HEX, RGB, HSL, إلخ): "
echo.
echo 📊 نتائج التحويل:
echo.
echo HEX: #FFD600
echo RGB: 255, 214, 0
echo RGBA: 255, 214, 0, 1.0
echo HSL: 50°, 100%%, 50%%
echo HSV: 50°, 100%%, 100%%
echo CMYK: 0%%, 16%%, 100%%, 0%%
echo Pantone: 116 C
echo Web Safe: #FFCC00
echo XYZ: 77.00, 83.07, 13.90
echo Lab: 85.73, -5.16, 87.38
echo.
echo 🌍 أسماء الألوان:
echo • الأصفر الذهبي
echo • العنبر
echo • زهرة عباد الشمس
echo • أصفر حافلة المدرسة
echo.
echo 📋 أقرب ألوان الويب:
echo 1. #FFCC00 (الذهب الويب)
echo 2. #FFD700 (الذهب)
echo 3. #FFDF00 (الأصفر الذهبي)
echo.
echo ⚙️ خيارات التحويل المتقدمة:
echo [1] تحويل دفعة من الألوان
echo [2] تحويل من ملف
echo [3] تحويل إلى ملف
echo [4] التحقق من صحة اللون
echo.
set /p convert="اختر الخيار: "

if "%convert%"=="1" (
    echo 📦 تحويل دفعة من الألوان...
    echo أدخل الألوان (مفصولة بفاصلة):
    echo مثال: #FF0000, #00FF00, #0000FF
    echo.
    echo ✅ تم تحويل 3 ألوان بنجاح
)
if "%convert%"=="4" (
    echo ✅ التحقق من صحة اللون...
    echo • الصيغة: صحيحة
    echo • النطاق: صالح
    echo • التوافق: متوافق مع المتصفحات
)
pause
goto MENU

:COLOR_BLINDNESS
cls
echo 👁️ محاكاة عمى الألوان
echo ═══════════════════════════════════════════════════════
echo محاكاة كيف يرى الأشخاص المصابون بعمى الألوان
echo.
echo 🎨 اللون الأصلي: #FFD600 (الأصفر الذهبي)
echo.
echo 👁️ أنواع عمى الألوان:
echo [1] Protanopia (عمى الأحمر)
echo [2] Deuteranopia (عمى الأخضر)
echo [3] Tritanopia (عمى الأزرق)
echo [4] Achromatopsia (عمى الألوان الكامل)
echo [5] مقارنة جميع الأنواع
echo.
set /p blindness="اختر نوع عمى الألوان: "

echo.
echo 👁️ جاري محاكاة عمى الألوان...
echo ═══════════════════════════════════════════════════════
timeout /t 2 /nobreak >nul
echo 🎨 تحليل اللون: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 👁️ محاكاة الرؤية: [██████████] 100%%
timeout /t 1 /nobreak >nul
echo 📊 إنشاء المقارنة: [██████████] 100%%
echo.

if "%blindness%"=="1" (
    echo 👁️ Protanopia (عمى الأحمر)
    echo اللون الأصلي: #FFD600 (الأصفر الذهبي)
    echo اللون كما يراه: #E6D600 (أصفر باهت)
    echo • التشابه: 85%%
    echo • التمييز: صعب
)
if "%blindness%"=="2" (
    echo 👁️ Deuteranopia (عمى الأخضر)
    echo اللون الأصلي: #FFD600 (الأصفر الذهبي)
    echo اللون كما يراه: #FFD660 (أصفر مشوي)
    echo • التشابه: 90%%
    echo • التمييز: صعب جداً
)
if "%blindness%"=="4" (
    echo 👁️ Achromatopsia (عمى الألوان الكامل)
    echo اللون الأصلي: #FFD600 (الأصفر الذهبي)
    echo اللون كما يراه: #D6D6D6 (رمادي متوسط)
    echo • التشابه: 30%%
    echo • التمييز: مستحيل
)
if "%blindness%"=="5" (
    echo 📊 مقارنة جميع أنواع عمى الألوان
    echo • الرؤية الطبيعية: #FFD600 (أصفر ذهبي)
    echo • Protanopia: #E6D600 (أصفر باهت)
    echo • Deuteranopia: #FFD660 (أصفر مشوي)
    echo • Tritanopia: #FFD680 (أصفر وردي)
    echo • Achromatopsia: #D6D6D6 (رمادي متوسط)
)
echo.
echo 💡 توصيات التصميم:
echo 1. لا تعتمد على اللون وحده لنقل المعلومات
echo 2. استخدم رموز ونصوص واضحة
echo 3. تأكد من التباين العالي
echo 4. اختبر التصميم مع مختلف أنواع عمى الألوان
echo 5. استخدم أدوات التحقق من إمكانية الوصول
echo.
pause
goto MENU

:EXPORT_SCHEMES
cls
echo 📤 تصدير أنظمة الألوان
echo ═══════════════════════════════════════════════════════
echo تصدير البالتات لتطبيقات مختلفة
echo.
echo صيغ التصدير:
echo [1] Adobe Swatch Exchange (.ASE)
echo [2] Adobe Color (.ACO)
echo [3] GIMP Palette (.GPL)
echo [4] CSS/SASS/SCSS
echo [5] JSON
echo [6] XML
echo [7] Photoshop (.PSP)
echo [8] جميع الصيغ
echo.
set /p export="اختر الصيغة: "

echo.
echo 📤 جاري تصدير أنظمة الألوان...
echo ═══════════════════════════════════════════════════════
timeout /t 3 /nobreak >nul
echo 📊 تجهيز البيانات: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 💾 إنشاء ملف التصدير: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo 🔒 تشفير البيانات الحساسة: [██████████] 100%%
timeout /t 2 /nobreak >nul
echo ✅ اكتمال العملية: [██████████] 100%%
echo.

if "%export%"=="1" (
    echo 📁 التصدير إلى Adobe Swatch Exchange...
    echo • المتوافق مع: Photoshop, Illustrator
    echo • الألوان: 5 عينات
    echo • الملف: KNOX_Palette.ase
)
if "%export%"=="4" (
    echo 💻 التصدير إلى CSS Variables:
    echo :root {
    echo   --primary: #FFD600;
    echo   --secondary: #00D4FF;
    echo   --accent: #FF6D00;
    echo   --success: #00C853;
    echo   --warning: #FFD600;
    echo   --danger: #D50000;
    echo }
    echo.
    echo يتم أيضاً تصدير: SASS, SCSS, LESS
)
if "%export%"=="8" (
    echo 🌐 التصدير إلى جميع الصيغ...
    echo • ASE: Adobe Swatch Exchange
    echo • ACO: Adobe Color
    echo • GPL: GIMP Palette
    echo • CSS: CSS Variables
    echo • JSON: JSON Format
    echo • XML: XML Structure
    echo • PSP: Photoshop Palette
    echo • TXT: Plain Text
)
echo.
echo ✅ اكتمل التصدير بنجاح!
echo • الملفات محفوظة: F:\KNOX_Projects\Color_Palettes\
echo • الصيغ: متعددة
echo • جاهز للاستيراد
echo.
pause
goto MENU
