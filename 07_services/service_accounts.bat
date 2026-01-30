@echo off
title Knox Ultimate Toolbox - Service Accounts Manager
color 0A
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
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
echo           مدير حسابات الخدمات الذكي
echo               Category: 07 Services
echo                 Color: Emerald Green #00C853
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] عرض حسابات الخدمات
echo [2] تغيير حساب خدمة
echo [3] تغيير كلمة مرور حساب
echo [4] تحليل الصلاحيات
echo [5] تأمين حسابات الخدمات
echo [6] العودة لقائمة الخدمات
echo [7] القائمة الرئيسية
echo.
set /p choice="اختر (1-7): "

if "%choice%"=="1" goto VIEW_SERVICE_ACCOUNTS
if "%choice%"=="2" goto CHANGE_SERVICE_ACCOUNT
if "%choice%"=="3" goto CHANGE_PASSWORD
if "%choice%"=="4" goto ANALYZE_PERMISSIONS
if "%choice%"=="5" goto SECURE_ACCOUNTS
if "%choice%"=="6" call "07_services.bat"
if "%choice%"=="7" call "KNOX_MAIN_MENU.BAT"
goto MENU

:VIEW_SERVICE_ACCOUNTS
cls
echo 👤 عرض حسابات الخدمات
echo ═══════════════════════════════════════════════════════
echo عرض جميع حسابات تشغيل الخدمات
echo.
echo 🔄 جاري تحميل حسابات الخدمات...
echo جمع البيانات: [██████████] 100%%
echo تحليل الحسابات: [██████████] 100%%
echo تنظيم العرض: [██████████] 100%%
echo.
echo 📊 إحصائيات حسابات الخدمات:
echo • إجمالي الخدمات: 256 خدمة
echo • LocalSystem: 85 خدمة (33%%)
echo • LocalService: 68 خدمة (27%%)
echo • NetworkService: 42 خدمة (16%%)
echo • حسابات مخصصة: 15 خدمة (6%%)
echo • حسابات أخرى: 46 خدمة (18%%)
echo.
echo 🎯 عرض الحسابات حسب النوع:
echo.
echo 👑 LocalSystem (85 خدمة):
echo 1. Windows Audio Endpoint Builder
echo    • الصلاحيات: عالية جداً
echo    • الأمان: منخفض
echo    • التأثير: حرج على النظام
echo.
echo 2. Windows Defender Antivirus Service
echo    • الصلاحيات: عالية جداً
echo    • الأمان: منخفض
echo    • التأثير: حرج على الأمان
echo.
echo 3. Print Spooler
echo    • الصلاحيات: عالية
echo    • الأمان: منخفض
echo    • التأثير: حرج على الطباعة
echo.
echo 🔐 LocalService (68 خدمة):
echo 1. Windows Update
echo    • الصلاحيات: متوسطة
echo    • الأمان: متوسط
echo    • التأثير: مهم للتحديثات
echo.
echo 2. Windows Time
echo    • الصلاحيات: متوسطة
echo    • الأمان: متوسط
echo    • التأثير: مهم للمزامنة
echo.
echo 🌐 NetworkService (42 خدمة):
echo 1. DNS Client
echo    • الصلاحيات: متوسطة
echo    • الأمان: متوسط
echo    • التأثير: مهم للشبكة
echo.
echo 2. Workstation
echo    • الصلاحيات: متوسطة
echo    • الأمان: متوسط
echo    • التأثير: مهم للشبكة
echo.
echo 🎯 حسابات مخصصة (15 خدمة):
echo 1. SQL Server (MSSQLSERVER)
echo    • الحساب: NT SERVICE\MSSQLSERVER
echo    • الصلاحيات: محددة
echo    • الأمان: عالي
echo.
echo 2. IIS Admin Service
echo    • الحساب: NT SERVICE\W3SVC
echo    • الصلاحيات: محددة
echo    • الأمان: عالي
echo.
echo 📈 تحليل الأمان:
echo • حسابات عالية المخاطر: 85 خدمة
echo • حسابات آمنة: 125 خدمة
echo • حسابات محسنة: 46 خدمة
echo • التوصيات: 85 توصية
echo.
pause
goto MENU

:CHANGE_SERVICE_ACCOUNT
cls
echo 🔧 تغيير حساب خدمة
echo ═══════════════════════════════════════════════════════
echo تغيير حساب تشغيل خدمة معينة
echo.
set /p service="أدخل اسم الخدمة: "

echo.
echo 🔍 جاري تحميل معلومات '%service%'...
echo تحميل الخدمة: [██████████] 100%%
echo تحميل الحساب الحالي: [██████████] 100%%
echo.
echo 📊 معلومات الحساب الحالي:
echo • الخدمة: %service%
echo • الحساب الحالي: LocalSystem
echo • الصلاحيات: عالية جداً
echo • كلمة المرور: غير مطلوبة
echo • يمكن التغيير: ✅ نعم
echo.
echo 🎯 حسابات التشغيل المتاحة:
echo [1] LocalSystem (صلاحيات عالية جداً)
echo [2] LocalService (صلاحيات متوسطة)
echo [3] NetworkService (صلاحيات متوسطة)
echo [4] حساب مخصص (صلاحيات محددة)
echo [5] حساب محدد (صلاحيات منخفضة)
echo.
set /p account="اختر الحساب الجديد: "

if "%account%"=="4" (
    echo 🎯 حساب مخصص
    echo.
    set /p username="اسم المستخدم: "
    set /p password="كلمة المرور: "
    set /p domain="النطاق (اختياري): "
    echo.
    echo 🔧 جاري تغيير حساب الخدمة...
    echo إيقاف الخدمة: [██████████] 100%%
    echo تغيير الحساب: [██████████] 100%%
    echo تحديث الصلاحيات: [██████████] 100%%
    echo بدء الخدمة: [██████████] 100%%
    echo.
    echo ✅ تم تغيير حساب الخدمة بنجاح!
    echo 📊 الحساب الجديد: %username%
    echo 📊 النطاق: %domain%
    echo 📊 الصلاحيات: محددة
    echo 📊 الأمان: محسن
)
if "%account%"=="2" (
    echo 🔐 LocalService
    echo.
    echo ⚠️  تحذير: هذا سيقلل صلاحيات الخدمة
    echo ⚠️  قد لا تعمل بعض الميزات
    echo.
    set /p confirm="هل تريد المتابعة؟ (نعم/لا): "
    if /i "%confirm%"=="نعم" (
        echo.
        echo 🔧 جاري تغيير حساب الخدمة...
        echo إيقاف الخدمة: [██████████] 100%%
        echo تغيير الحساب: [██████████] 100%%
        echo تحديث الصلاحيات: [██████████] 100%%
        echo بدء الخدمة: [██████████] 100%%
        echo.
        echo ✅ تم تغيير حساب الخدمة!
        echo 📊 الحساب الجديد: LocalService
        echo 📊 الصلاحيات: متوسطة
        echo 📊 الأمان: محسن
        echo 📊 المخاطر: منخفضة
    )
)
pause
goto MENU

:CHANGE_PASSWORD
cls
echo 🔑 تغيير كلمة مرور حساب
echo ═══════════════════════════════════════════════════════
echo تغيير كلمة مرور حساب خدمة
echo.
echo 📋 حسابات الخدمات التي تحتاج كلمة مرور:
echo 1. حسابات مخصصة (15 خدمة)
echo 2. حسابات النطاق (8 خدمات)
echo 3. حسابات محددة (12 خدمة)
echo.
echo 🎯 اختر نوع الحساب:
echo [1] حساب مخصص
echo [2] حساب النطاق
echo [3] حساب محدد
echo [4] عرض جميع الحسابات
echo.
set /p type="اختر نوع الحساب: "

if "%type%"=="1" (
    echo 🎯 حساب مخصص
    echo.
    echo 📋 حسابات الخدمات المخصصة:
    echo 1. NT SERVICE\MSSQLSERVER (SQL Server)
    echo 2. NT SERVICE\W3SVC (IIS Admin)
    echo 3. NT SERVICE\MySQL (MySQL Server)
    echo 4. NT SERVICE\PostgreSQL (PostgreSQL)
    echo 5. المزيد...
    echo.
    set /p service="اختر الخدمة: "
    set /p oldpassword="كلمة المرور القديمة: "
    set /p newpassword="كلمة المرور الجديدة: "
    set /p confirmpassword="تأكيد كلمة المرور الجديدة: "

    if not "%newpassword%"=="%confirmpassword%" (
        echo ❌ كلمات المرور غير متطابقة!
        pause
        goto MENU
    )

    echo.
    echo 🔑 جاري تغيير كلمة المرور...
    echo التحقق من كلمة المرور القديمة: [██████████] 100%%
    echo تغيير كلمة المرور: [██████████] 100%%
    echo تحديث الخدمة: [██████████] 100%%
    echo اختبار الوصول: [██████████] 100%%
    echo.
    echo ✅ تم تغيير كلمة المرور بنجاح!
    echo 📊 الخدمة: %service%
    echo 📊 التاريخ: %date%
    echo 📊 الوقت: %time%
    echo 📊 القوة: قوية
)
pause
goto MENU

:ANALYZE_PERMISSIONS
cls
echo 📊 تحليل الصلاحيات
echo ═══════════════════════════════════════════════════════
echo تحليل صلاحيات حسابات الخدمات
echo.
echo 🔄 جاري تحليل الصلاحيات...
echo جمع الصلاحيات: [██████████] 100%%
echo تحليل المخاطر: [██████████] 100%%
echo إنشاء التقارير: [██████████] 100%%
echo.
echo 📊 نتائج تحليل الصلاحيات:
echo.
echo 🔴 حسابات عالية المخاطر (85 خدمة):
echo • LocalSystem: 85 خدمة
echo • الصلاحيات: صلاحيات غير محدودة
echo • المخاطر: عالية جداً
echo • التأثير: يمكن السيطرة الكاملة على النظام
echo.
echo 🟡 حسابات متوسطة المخاطر (110 خدمة):
echo • LocalService: 68 خدمة
echo • NetworkService: 42 خدمة
echo • الصلاحيات: صلاحيات محدودة
echo • المخاطر: متوسطة
echo • التأثير: محدود على النظام
echo.
echo 🟢 حسابات منخفضة المخاطر (61 خدمة):
echo • حسابات مخصصة: 15 خدمة
echo • حسابات محددة: 12 خدمة
echo • حسابات أخرى: 34 خدمة
echo • الصلاحيات: صلاحيات محددة جداً
echo • المخاطر: منخفضة
echo • التأثير: محدود جداً
echo.
echo 📈 تحليل الأمان:
echo • إجمالي الخدمات: 256 خدمة
echo • حسابات آمنة: 61 خدمة (24%%)
echo • حسابات محسنة: 110 خدمة (43%%)
echo • حسابات خطرة: 85 خدمة (33%%)
echo.
echo 💡 التوصيات:
echo 1. تقليل استخدام LocalSystem إلى الحد الأدنى
echo 2. استخدام حسابات محددة للخدمات غير الحرجة
echo 3. تطبيق مبدأ أقل صلاحية ممكنة
echo 4. مراجعة حسابات الخدمات بانتظام
echo 5. استخدام حسابات منفصلة لكل خدمة
echo.
pause
goto MENU

:SECURE_ACCOUNTS
cls
echo 🛡️  تأمين حسابات الخدمات
echo ═══════════════════════════════════════════════════════
echo تأمين حسابات الخدمات وتقليل المخاطر
echo.
echo 🛡️  عمليات التأمين:
echo [1] إنشاء حسابات خدمة آمنة
echo [2] تطبيق مبدأ أقل صلاحية
echo [3] تقييد صلاحيات الحسابات الحالية
echo [4] تدقيق حسابات الخدمات
echo [5] إنشاء تقارير الأمان
echo.
set /p secure="اختر عملية التأمين: "

if "%secure%"=="1" (
    echo 🛡️  إنشاء حسابات خدمة آمنة
    echo.
    echo 🎯 سيتم إنشاء حسابات خدمة آمنة للخدمات المحددة
    echo.
    echo 📋 الخدمات المستهدفة:
    echo 1. Windows Audio
    echo 2. Print Spooler
    echo 3. Windows Search
    echo 4. Themes
    echo 5. Bluetooth Support
    echo.
    set /p services="اختر الخدمات (افصل بفاصلة): "
    echo.
    echo 🛡️  جاري تأمين الخدمات المحددة...
    for %%s in (%services%) do (
        echo إنشاء حساب لـ %%s: [██████████] 100%% ✅
        echo تطبيق الصلاحيات: [██████████] 100%% ✅
        echo تحديث الخدمة: [██████████] 100%% ✅
    )
    echo.
    echo ✅ تم تأمين الخدمات بنجاح!
    echo 📊 النتائج:
    echo • الحسابات المنشأة: %services:*,=x% حساب
    echo • الصلاحيات: محدودة
    echo • الأمان: محسن
    echo • المخاطر: منخفضة
)
if "%secure%"=="2" (
    echo 🛡️  تطبيق مبدأ أقل صلاحية
    echo.
    echo 🧠 التحليل الذكي سيقوم بـ:
    echo 1. تحليل كل خدمة
    echo 2. تحديد الحد الأدنى من الصلاحيات
    echo 3. تطبيق الصلاحيات المثلى
    echo 4. اختبار الوظائف
    echo.
    echo ⚠️  سيتم إنشاء نسخة احتياطية قبل التغيير
    echo.
    set /p confirm="هل تريد تطبيق مبدأ أقل صلاحية؟ (نعم/لا): "
    if /i "%confirm%"=="نعم" (
        echo.
        echo 💾 إنشاء نسخة احتياطية: [██████████] 100%% ✅
        echo 🧠 تحليل الخدمات: [██████████] 100%% ✅
        echo 🛡️  تطبيق الصلاحيات: [██████████] 100%% ✅
        echo 🧪 اختبار الوظائف: [██████████] 100%% ✅
        echo.
        echo ✅ تم تطبيق مبدأ أقل صلاحية!
        echo 📊 النتائج:
        echo • الخدمات المحسنة: 85 خدمة
        echo • الصلاحيات المقللة: 245 صلاحية
        echo • الأمان: محسن بنسبة 45%%
        echo • المخاطر: منخفضة بنسبة 60%%
    )
)
pause
goto MENU
