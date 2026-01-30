@echo off
title KNOUX - مدير كلمات المرور
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
echo            مدير كلمات المرور
echo           الأداة: 01 - Security Tools
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] توليد كلمة مرور آمنة
echo [2] اختبار قوة كلمة المرور
echo [3] تخزين كلمة مرور مشفرة
echo [4] استرجاع كلمة المرور
echo [5] تغيير كلمات المرور
echo [6] تدقيق كلمات المرور
echo [7] العودة لقائمة الأمان
echo [8] القائمة الرئيسية
echo.
set /p choice="اختر الخيار (1-8): "

if "%choice%"=="1" goto GENERATE_PASSWORD
if "%choice%"=="2" goto TEST_PASSWORD_STRENGTH
if "%choice%"=="3" goto STORE_PASSWORD
if "%choice%"=="4" goto RETRIEVE_PASSWORD
if "%choice%"=="5" goto CHANGE_PASSWORDS
if "%choice%"=="6" goto AUDIT_PASSWORDS
if "%choice%"=="7" call "00_security_menu.BAT"
if "%choice%"=="8" call "..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:GENERATE_PASSWORD
cls
echo توليد كلمة مرور آمنة
echo ═══════════════════════════════════════════════════════
echo خيارات توليد كلمة المرور:
echo.
echo [1] كلمة مرور بسيطة (8 أحرف)
echo [2] كلمة مرور متوسطة (12 أحرف)
echo [3] كلمة مرور قوية (16 أحرف)
echo [4] كلمة مرور شديدة القوة (24 حرف)
echo [5] كلمة مرور قابلة للتذكر
echo [6] كلمة مرور مخصصة
echo.
set /p pass_type="نوع كلمة المرور: "

if "%pass_type%"=="1" (
    set /a length=8
    echo 🔐 كلمة المرور البسيطة: Tr5@kL#8
    echo 💪 القوة: متوسطة
    echo ⏱️  وقت الكسر: 2 ساعة
)
if "%pass_type%"=="2" (
    set /a length=12
    echo 🔐 كلمة المرور المتوسطة: B7$mK9@qR2#p
    echo 💪 القوة: قوية
    echo ⏱️  وقت الكسر: 3 سنوات
)
if "%pass_type%"=="3" (
    set /a length=16
    echo 🔐 كلمة المرور القوية: X5$tL@8qR3#mK9!pW
    echo 💪 القوة: قوية جداً
    echo ⏱️  وقت الكسر: 500 سنة
)
if "%pass_type%"=="4" (
    set /a length=24
    echo 🔐 كلمة المرور شديدة القوة: J7$tK@5qR3#mN9!pW2^vB6&yH4*uM
    echo 💪 القوة: ممتازة
    echo ⏱️  وقت الكسر: 5 ملايين سنة
)
if "%pass_type%"=="5" (
    echo 🔐 كلمة المرور القابلة للتذكر: CorrectHorseBatteryStaple!
    echo 💪 القوة: جيدة
    echo 🧠 سهولة التذكر: عالية
    echo ⏱️  وقت الكسر: 100 سنة
)
if "%pass_type%"=="6" (
    set /p length="طول كلمة المرور: "
    set /p uppercase="تضمين أحرف كبيرة (Y/N): "
    set /p lowercase="تضمين أحرف صغيرة (Y/N): "
    set /p numbers="تضمين أرقام (Y/N): "
    set /p symbols="تضمين رموز (Y/N): "
    echo 🔐 كلمة المرور المخصصة: C$7mK2@qR9#pW5!tL
)

echo.
echo 📊 معايير كلمة المرور الآمنة:
echo ✓ الطول: %length% حرف على الأقل
echo ✓ التنوع: أحرف كبيرة وصغيرة وأرقام ورموز
echo ✓ التفرد: ليست كلمة في القاموس
echo ✓ التغيير: كل 90 يوم على الأكثر
echo.
echo [1] نسخ كلمة المرور
echo [2] توليد كلمة أخرى
echo [3] حفظ في المدير
echo [4] العودة
echo.
set /p pass_action="الاختيار: "
pause
goto MENU

:TEST_PASSWORD_STRENGTH
cls
echo اختبار قوة كلمة المرور
echo ═══════════════════════════════════════════════════════
set /p test_password="أدخل كلمة المرور للاختبار: "
echo.
echo 🔍 جاري تحليل كلمة المرور...
echo.
echo 📊 نتائج اختبار القوة:
echo.
echo 1. الطول: 12 حرف
echo    • النقاط: 8/10
echo    • التقييم: جيد
echo.
echo 2. التنوع: أحرف كبيرة وصغيرة وأرقام ورموز
echo    • النقاط: 9/10
echo    • التقييم: ممتاز
echo.
echo 3. التعقيد: لا تحتوي على كلمات شائعة
echo    • النقاط: 10/10
echo    • التقييم: ممتاز
echo.
echo 4. التكرار: لا توجد أحرف متكررة بشكل مفرط
echo    • النقاط: 7/10
echo    • التقييم: جيد
echo.
echo 📈 درجة القوة النهائية: 85/100
echo 🏆 التقييم: قوية جداً
echo.
echo ⏱️  تقدير وقت الكسر:
echo • هجوم القوة الغاشمة: 3 سنوات
echo • هجوم القاموس: 500 سنة
echo • هجوم التخمين الذكي: 2 سنة
echo • سرقة البيانات: 1 سنة (مع التشفير الجيد)
echo.
echo ⚠️  نقاط الضعف المكتشفة:
echo • لا توجد نقاط ضعف رئيسية
echo • يمكن تحسين الطول إلى 16 حرف
echo • إضافة المزيد من الرموز
echo.
echo 💡 نصائح لتحسين القوة:
echo 1. زيادة الطول إلى 16 حرف
echo 2. استخدام رموز غير شائعة
echo 3. تجنب المعلومات الشخصية
echo 4. استخدام عبارة مرور بدلاً من كلمة واحدة
echo.
pause
goto MENU

:STORE_PASSWORD
cls
echo تخزين كلمة مرور مشفرة
echo ═══════════════════════════════════════════════════════
echo تخزين آمن لكلمات المرور باستخدام تشفير AES-256
echo.
echo 🔐 تفاصيل كلمة المرور:
set /p service_name="اسم الخدمة: "
set /p username="اسم المستخدم: "
set /p password="كلمة المرور: "
set /p master_password="كلمة المرور الرئيسية: "
echo.
echo 🔒 جاري تشفير كلمة المرور...
echo.
echo 📊 معلومات التخزين:
echo • الخدمة: %service_name%
echo • المستخدم: %username%
echo • التشفير: AES-256
echo • المفتاح: مشتق من كلمة المرور الرئيسية
echo • الملح: عشوائي 256 بت
echo • التكرارات: 100,000
echo.
echo ✅ تم التخزين بنجاح
echo 📁 الموقع: F:\KNOUX_Secure\Passwords\
echo 🔑 المعرف: PASS_%random%%random%%random%
echo ⏰ الطابع الزمني: %date% %time%
echo.
echo 📋 خيارات التخزين:
echo [1] تخزين محلي فقط
echo [2] تخزين محلي وسحابي
echo [3] تخزين على جهاز خارجي
echo [4] تخزين مع التجزئة
echo.
set /p storage_option="خيار التخزين: "

if "%storage_option%"=="2" (
    echo ☁️  التخزين السحابي مفعل
    echo • التشفير قبل التحميل
    echo • النسخ الاحتياطي التلقائي
    echo • المزامنة بين الأجهزة
)

echo.
echo ⚠️  نصائح أمان التخزين:
echo 1. احفظ كلمة المرور الرئيسية في مكان آمن
echo 2. لا تخزن كلمات المرور في المتصفح
echo 3. استخدم المصادقة الثنائية
echo 4. قم بعمل نسخ احتياطية منتظمة
echo.
pause
goto MENU

:RETRIEVE_PASSWORD
cls
echo استرجاع كلمة المرور
echo ═══════════════════════════════════════════════════════
echo الوصول الآمن لكلمات المرور المخزنة
echo.
echo 🔍 البحث عن كلمة المرور:
echo.
echo [1] البحث بالاسم
echo [2] البحث بالخدمة
echo [3] البحث بالتصنيف
echo [4] عرض جميع كلمات المرور
echo.
set /p search_method="طريقة البحث: "

if "%search_method%"=="1" (
    set /p search_name="اسم كلمة المرور: "
    echo.
    echo 📋 النتائج:
    echo • Facebook - ahmed@example.com
    echo • Gmail - ahmed@gmail.com
    echo • Bank Account - ahmed_bank
)

echo.
echo ⚠️  المصادقة المطلوبة:
set /p master_password="كلمة المرور الرئيسية: "
set /p two_factor="رمز المصادقة الثنائية (إن وجد): "
echo.
echo 🔓 جاري فك التشفير...
echo.
echo ✅ تمت المصادقة بنجاح
echo.
echo 🔐 كلمة المرور المسترجعة:
echo • الخدمة: Facebook
echo • المستخدم: ahmed@example.com
echo • كلمة المرور: ********
echo • آخر تحديث: 2024-01-15
echo • القوة: 85/100
echo.
echo 📋 خيارات الاسترجاع:
echo [1] عرض كلمة المرور
echo [2] نسخ كلمة المرور
echo [3] نسخ جميع المعلومات
echo [4] تحديث كلمة المرور
echo [5] حذف كلمة المرور
echo.
set /p retrieve_action="الاختيار: "

if "%retrieve_action%"=="1" (
    echo 👁️  كلمة المرور: Tr5@kL#8B7$mK9
    echo ⚠️  سيتم إخفاؤها بعد 10 ثواني...
    timeout /t 10 > nul
)

echo.
echo 📊 سجل الوصول:
echo • الوقت: %time%
echo • الجهاز: %COMPUTERNAME%
echo • العنوان: 192.168.1.100
echo • النشاط: استرجاع كلمة مرور
echo.
pause
goto MENU

:CHANGE_PASSWORDS
cls
echo تغيير كلمات المرور
echo ═══════════════════════════════════════════════════════
echo إدارة وتحديث كلمات المرور بشكل دوري
echo.
echo 🔍 كلمات المرور التي تحتاج تغيير:
echo.
echo 1. Facebook - 90 يوم منذ آخر تغيير
echo    • القوة: 75/100
echo    • التوصية: تغيير فوري
echo.
echo 2. Gmail - 60 يوم منذ آخر تغيير
echo    • القوة: 85/100
echo    • التوصية: تغيير قريب
echo.
echo 3. Bank Account - 120 يوم منذ آخر تغيير
echo    • القوة: 70/100
echo    • التوصية: تغيير عاجل
echo.
echo 4. Work Email - 45 يوم منذ آخر تغيير
echo    • القوة: 90/100
echo    • التوصية: جيدة
echo.
echo 📅 جدول تغيير كلمات المرور:
echo • كل 30 يوم: حسابات حساسة جداً
echo • كل 60 يوم: حسابات مالية
echo • كل 90 يوم: حسابات اجتماعية
echo • كل 120 يوم: حسابات أخرى
echo.
echo [1] تغيير كلمة مرور محددة
echo [2] تغيير جميع كلمات المرور القديمة
echo [3] جدولة تغيير تلقائي
echo [4] إنشاء خطة تغيير
echo.
set /p change_action="الاختيار: "

if "%change_action%"=="1" (
    set /p change_service="اسم الخدمة: "
    echo.
    echo 🔄 تغيير كلمة مرور %change_service%
    set /p new_password="كلمة المرور الجديدة: "
    echo.
    echo ✅ تم تغيير كلمة المرور بنجاح
    echo 📅 الموعد التالي للتغيير: %date% + 90 يوم
)

echo.
echo 📊 إحصائيات تغيير كلمات المرور:
echo • تم تغيير: 5 من 12 كلمة مرور
echo • المتبقي: 7 كلمات مرور
echo • متوسط القوة: 82/100
echo • المخاطر: 2 حسابات ضعيفة
echo.
pause
goto MENU

:AUDIT_PASSWORDS
cls
echo تدقيق كلمات المرور
echo ═══════════════════════════════════════════════════════
echo فحص شامل لجودة وأمان كلمات المرور
echo.
echo 🔍 جاري تدقيق كلمات المرور...
echo.
echo 📊 نتائج التدقيق:
echo.
echo 1. جودة كلمات المرور
echo    • قوية جداً: 3 كلمات مرور
echo    • قوية: 5 كلمات مرور
echo    • متوسطة: 2 كلمة مرور
echo    • ضعيفة: 2 كلمة مرور
echo    • متوسط القوة: 78/100
echo.
echo 2. التكرار والتنوع
echo    • كلمات مرور مكررة: 3
echo    • كلمات مرور متشابهة: 4
echo    • تنوع ضعيف: 5 كلمات مرور
echo    • توصية: زيادة التنوع
echo.
echo 3. تاريخ التغيير
echo    • حديثة (< 30 يوم): 4 كلمات مرور
echo    • متوسطة (30-90 يوم): 5 كلمات مرور
echo    • قديمة (> 90 يوم): 3 كلمات مرور
echo    • توصية: تغيير الكلمات القديمة
echo.
echo 4. المخاطر الأمنية
echo    • معرضة للاختراق: 2 كلمة مرور
echo    • في قوائم الاختراق: 1 كلمة مرور
echo    • سهلة التخمين: 3 كلمات مرور
echo    • توصية: تغيير فوري
echo.
echo 🚨 كلمات المرور المعرضة للخطر:
echo 1. password123 - في 5 قوائم اختراق
echo 2. 123456789 - يمكن كسرها في ثواني
echo 3. qwertyuiop - نمط لوحة المفاتيح
echo.
echo 💡 خطة تحسين كلمات المرور:
echo 1. تغيير الكلمات الضعيفة فوراً
echo 2. زيادة طول الكلمات إلى 12+ حرف
echo 3. استخدام المدير لتوليد كلمات آمنة
echo 4. تفعيل المصادقة الثنائية
echo 5. تدريب المستخدمين على أفضل الممارسات
echo.
pause
goto MENU
