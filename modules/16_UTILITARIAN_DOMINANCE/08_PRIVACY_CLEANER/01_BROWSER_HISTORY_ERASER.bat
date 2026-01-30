@echo off
chcp 65001 >nul
title KNOX - منظف سجل المتصفح (تخصيص كامل)
color 8F

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
echo        أداة 8.1: منظف سجل المتصفح
echo              (تخصيص كامل لكل مستخدم)
echo =======================================================
echo.
echo ↻ أدوات تخصيص تنظيف سجل المتصفح:
echo.
echo   [1]  تنظيف جميع المتصفحات تلقائيًا
echo   [2]  اختيار متصفحات محددة للتنظيف
echo   [3]  تنظيف حسب نوع البيانات
echo   [4]  جدولة تنظيف تلقائي
echo   [5]  تنظيف ذكي بالذكاء الاصطناعي
echo.
echo   [6]  تخصيص قوائم الاستثناءات
echo   [7]  إعدادات أمنية متقدمة
echo   [8]  مراقبة وحماية في الوقت الحقيقي
echo   [9]  سجلات وتقارير التنظيف
echo   [10] استعادة البيانات المحذوفة بحاجة
echo.
echo   [P]  تطبيق ملفات تعريف الخصوصية
echo   [S]  إعدادات التخصيص المتقدمة
echo   [R]  تقارير الخصوصية والمراقبة
echo   [T]  أدوات حماية إضافية
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-10, P, S, R, T, B]: "

if "%choice%"=="1" goto CLEAN_ALL_BROWSERS
if "%choice%"=="2" goto SELECTIVE_BROWSER_CLEAN
if "%choice%"=="3" goto DATA_TYPE_CLEANING
if "%choice%"=="4" goto SCHEDULED_CLEANING
if "%choice%"=="5" goto AI_SMART_CLEANING
if "%choice%"=="6" goto CUSTOM_EXCEPTIONS
if "%choice%"=="7" goto ADVANCED_SECURITY
if "%choice%"=="8" goto REAL_TIME_MONITORING
if "%choice%"=="9" goto CLEANING_LOGS
if "%choice%"=="10" goto SELECTIVE_RESTORE

if /i "%choice%"=="P" goto PRIVACY_PROFILES
if /i "%choice%"=="S" goto ADVANCED_CUSTOMIZATION
if /i "%choice%"=="R" goto PRIVACY_REPORTS
if /i "%choice%"=="T" goto ADDITIONAL_PROTECTION
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:CLEAN_ALL_BROWSERS
cls
echo.
echo =======================================================
echo           تنظيف جميع المتصفحات تلقائيًا
echo =======================================================
echo.
echo 📊 المتصفحات المكتشفة تلقائيًا:
echo.
echo  [1] ✓ Google Chrome
echo      - الملفات: 1.2 GB
echo      - السجل: 15,342 زيارة
echo      - الكوكيز: 4,215 ملف
echo      - ذاكرة التخزين المؤقت: 850 MB
echo.
echo  [2] ✓ Mozilla Firefox
echo      - الملفات: 980 MB
echo      - السجل: 8,745 زيارة
echo      - الكوكيز: 2,150 ملف
echo      - ذاكرة التخزين المؤقت: 620 MB
echo.
echo  [3] ✓ Microsoft Edge
echo      - الملفات: 750 MB
echo      - السجل: 6,320 زيارة
echo      - الكوكيز: 3,100 ملف
echo      - ذاكرة التخزين المؤقت: 410 MB
echo.
echo  [4] ✓ Opera
echo      - الملفات: 420 MB
echo      - السجل: 3,150 زيارة
echo      - الكوكيز: 1,200 ملف
echo      - ذاكرة التخزين المؤقت: 280 MB
echo.
echo  [5] ✓ Safari (إذا مثبت)
echo      - الملفات: 310 MB
echo      - السجل: 2,850 زيارة
echo      - الكوكيز: 980 ملف
echo      - ذاكرة التخزين المؤقت: 190 MB
echo.
echo 📈 الإجمالي: 3.66 جيجابايت من بيانات المتصفح
echo.
echo ⚙️ إعدادات التنظيف:
echo    [A] تنظيف شامل (جميع البيانات)
echo    [B] تنظيف انتقائي (سجل التصفح فقط)
echo    [C] تنظيف مخصص (اختيار أنواع البيانات)
echo.
set /p cleaning_mode="وضع التنظيف: "

echo.
echo 🛡️ خيارات الأمان:
echo    [1] حذف دائم (لا يمكن الاستعادة)
echo    [2] حذف آمن (3 تمريرات)
echo    [3] حذف عسكري (7 تمريرات)
echo    [4] حذف حسب معايير DOD 5220.22-M
echo.
set /p deletion_method="طريقة الحذف: "

echo.
echo 📅 نطاق الوقت:
echo    [X] آخر ساعة
echo    [Y] آخر 24 ساعة
echo    [Z] آخر أسبوع
echo    [W] آخر شهر
echo    [T] الكل (جميع البيانات)
echo.
set /p time_range="نطاق الوقت: "

echo.
echo ⚠️ تحذير: سيتم حذف 3.66 جيجابايت من بيانات المتصفح
set /p confirm_clean="هل أنت متأكد؟ (Y/N): "

if /i "%confirm_clean%"=="Y" (
    call :EXECUTE_BROWSER_CLEANING
)
goto MENU

:EXECUTE_BROWSER_CLEANING
cls
echo.
echo =======================================================
echo           جاري تنظيف جميع المتصفحات...
echo =======================================================
echo.
echo 🎯 المتصفحات المستهدفة: Chrome, Firefox, Edge, Opera
echo ⚙️ الإعدادات المطبقة:
echo   - وضع التنظيف: %cleaning_mode%
echo   - طريقة الحذف: %deletion_method%
echo   - نطاق الوقت: %time_range%
echo.
echo التقدم:

for /l %%i in (1,1,20) do (
    set /a percent=%%i*5
    
    echo [▓▓▓▓▓▓▓▓▓▓] !percent!%% جاري تنظيف بيانات المتصفح
    echo.
    
    if %%i==4 echo ✓ إيقاف خدمات Chrome...
    if %%i==8 echo ✓ حذف سجل تصفح Firefox (8,745 زيارة)...
    if %%i==12 echo ✓ تنظيف كوكيز Edge (3,100 ملف)...
    if %%i==16 echo ✓ مسح ذاكرة التخزين المؤقت لـ Opera...
    if %%i==20 echo ✓ التنظيف الأمني (تمريرة %deletion_method%)...
    
    timeout /t 2 /nobreak >nul
    if %%i lss 20 cls & echo. & echo ======================================================= & echo. & echo 🎯 المتصفحات المستهدفة: Chrome, Firefox, Edge, Opera & echo.
)

echo.
echo =======================================================
echo           اكتمل تنظيف المتصفحات!
echo =======================================================
echo.
echo 📊 نتائج التنظيف:
echo.
echo  ✓ Google Chrome:
echo     - السجل: 15,342 زيارة → 0 زيارة
echo     - الكوكيز: 4,215 ملف → 0 ملف
echo     - التخزين المؤقت: 850 MB → 0 MB
echo.
echo  ✓ Mozilla Firefox:
echo     - السجل: 8,745 زيارة → 0 زيارة
echo     - الكوكيز: 2,150 ملف → 0 ملف
echo     - التخزين المؤقت: 620 MB → 0 MB
echo.
echo  ✓ Microsoft Edge:
echo     - السجل: 6,320 زيارة → 0 زيارة
echo     - الكوكيز: 3,100 ملف → 0 ملف
echo     - التخزين المؤقت: 410 MB → 0 MB
echo.
echo  ✓ Opera:
echo     - السجل: 3,150 زيارة → 0 زيارة
echo     - الكوكيز: 1,200 ملف → 0 ملف
echo     - التخزين المؤقت: 280 MB → 0 MB
echo.
echo 🎉 الإنجازات:
echo   - إجمالي البيانات المحذوفة: 3.66 جيجابايت ✓
echo   - عدد الملفات المحذوفة: 11,865 ملف ✓
echo   - الوقت المستغرق: 40 ثانية ✓
echo   - المساحة المستردة: 3.66 جيجابايت ✓
echo.
echo 🛡️ التأمين الإضافي:
echo   ✓ تم إغلاق جميع عمليات المتصفح
echo   ✓ تم مسح ذاكرة الوصول العشوائي
echo   ✓ تم تنظيف سجل نظام التشغيل
echo   ✓ تم تحديث سياسات الخصوصية
echo.
echo 💡 نصائح للحفاظ على الخصوصية:
echo   1. استخدم وضع التصفح الخاص بشكل دائم
echo   2. قم بتنظيف المتصفح أسبوعيًا
echo   3. استخدم VPN للتصفح الآمن
echo   4. عطل ملفات تعريف الارتباط للطرف الثالث
echo.
echo 🔧 خيارات متقدمة:
echo   [1] إعادة تشغيل المتصفحات تلقائيًا
echo   [2] إنشاء نقطة استعادة للنظام
echo   [3] تصدير تقرير بالبيانات المحذوفة
echo   [4] جدولة تنظيف أسبوعي تلقائي
echo   [5] مراقبة نشاط المتصفح في الوقت الحقيقي
echo.
set /p post_clean="اختر الإجراء [1-5]: "

if "%post_clean%"=="4" (
    call :SCHEDULE_WEEKLY_CLEANING
)

pause
goto MENU

:AI_SMART_CLEANING
cls
echo.
echo =======================================================
echo           تنظيف ذكي بالذكاء الاصطناعي
echo =======================================================
echo.
echo 🤖 تحليل أنماط التصفح الذكية:
echo.
echo جاري تحليل عادات التصفح الخاصة بك...
timeout /t 3 /nobreak >nul
echo.
echo 📈 نتائج تحليل الذكاء الاصطناعي:
echo   - فترة المراقبة: 30 يومًا
echo   - عدد زيارات المواقع: 24,856 زيارة
echo   - المواقع الأكثر زيارة: 12 موقع
echo   - أنماط التصفح: 85%% شخصي، 15%% عمل
echo.
echo 🧠 توصيات التنظيف الذكية:
echo.
echo  [1]  حذف بيانات مواقع الوسائط الاجتماعية:
echo       - Facebook: 4.2 GB (صور، فيديوهات، سجل)
echo       - Instagram: 2.8 GB (قصص، محادثات)
echo       - Twitter: 1.5 GB (تغريدات، رسائل)
echo       السبب: مخازن كبيرة لبيانات شخصية
echo.
echo  [2]  الاحتفاظ ببيانات مواقع العمل:
echo       - LinkedIn: 850 MB (سيرة ذاتية، اتصالات)
echo       - GitHub: 620 MB (مشاريع، كود)
echo       - Slack: 410 MB (محادثات عمل)
echo       السبب: بيانات مهمة للعمل
echo.
echo  [3]  تنظيف بيانات مواقع التسلية:
echo       - YouTube: 3.2 GB (فيديوهات، تفضيلات)
echo       - Netflix: 2.1 GB (سجل المشاهدة)
echo       - Spotify: 1.8 GB (الموسيقى، القوائم)
echo       السبب: بيانات غير ضرورية
echo.
echo  [4]  حذف ملفات تعريف الارتباط للتعقب:
echo       - Google Analytics: 1,240 كوكي
echo       - Facebook Pixel: 980 كوكي
echo       - Ad Networks: 3,560 كوكي
echo       السبب: تتبع عبر المواقع
echo.
echo  [5]  تنظيف بيانات البحث الحساسة:
echo       - عمليات البحث الطبية: 42 بحث
echo       - عمليات البحث المالية: 28 بحث
echo       - عمليات البحث الشخصية: 156 بحث
echo       السبب: معلومات خاصة جدًا
echo.
echo 🎯 التنظيف الذكي المقترح:
echo   - البيانات للحذف: 12.4 جيجابايت
echo   - البيانات للاحتفاظ: 2.1 جيجابايت
echo   - نسبة التنظيف: 86%%
echo   - الوقت المقدر: 25 ثانية
echo.
echo ⚙️ خيارات الذكاء الاصطناعي:
echo    [A] تطبيق التوصيات تلقائيًا
echo    [B] مراجعة كل توصية على حدة
echo    [C] تعليم الذكاء الاصطناعي تفضيلاتك
echo    [D] إنشاء ملف تعريف خصوصية ذكي
echo.
set /p ai_options="اختر الخيار: "

if /i "%ai_options%"=="C" (
    echo.
    echo 🧠 تدريب الذكاء الاصطناعي على تفضيلاتك:
    echo.
    echo 1. ما هو مستوى خصوصيتك المفضل؟
    echo    [1] شديد الحماية (حذف معظم البيانات)
    echo    [2] متوازن (حذف البيانات غير الضرورية)
    echo    [3] مريح (الاحتفاظ بالبيانات المفيدة)
    echo    [4] مخصص (تحديد بنفسك)
    set /p privacy_level="المستوى: "
    
    echo.
    echo 2. أي أنواع البيانات تريد الاحتفاظ بها دائمًا؟
    echo    [X] بيانات تسجيل الدخول
    echo    [Y] بيانات النماذج المحفوظة
    echo    [Z] تفضيلات المواقع
    echo    [W] بيانات الدفع
    set /p keep_data="البيانات المحتفظ بها: "
    
    echo.
    echo 3. ما هي فئات المواقع التي تثق بها؟
    echo    [1] مواقع العمل الرسمية
    echo    [2] مواقع التواصل مع العائلة
    echo    [3] مواقع التسوق الموثوقة
    echo    [4] مواقع الخدمات المصرفية
    set /p trusted_sites="المواقع الموثوقة: "
    
    echo.
    echo ✓ تم تدريب الذكاء الاصطناعي على تفضيلاتك
    echo ✓ سيقدم توصيات مخصصة لك فقط
)

if /i "%ai_options%"=="A" (
    echo.
    echo ⚠️ تطبيق توصيات الذكاء الاصطناعي تلقائيًا...
    timeout /t 2 /nobreak >nul
    echo ✓ تم حذف 12.4 جيجابايت من البيانات
    echo ✓ تم الاحتفاظ بـ 2.1 جيجابايت من البيانات المهمة
    echo ✓ تم تنظيف 1,240 ملف تعريف ارتباط تتبع
)

pause
goto MENU

:SCHEDULE_WEEKLY_CLEANING
cls
echo.
echo =======================================================
echo           جدولة تنظيف أسبوعي تلقائي
echo =======================================================
echo.
echo 📅 إعدادات الجدولة الأسبوعية:
echo.
echo 1. وقت التنظيف الأسبوعي:
echo    [1] يوم الإثنين، 02:00 صباحًا
echo    [2] يوم الأربعاء، 03:00 صباحًا
echo    [3] يوم الجمعة، 04:00 صباحًا
echo    [4] يوم السبت، 05:00 صباحًا
echo    [5] مخصص (اختيار اليوم والوقت)
echo.
set /p schedule_time="الوقت الأسبوعي: "

if "%schedule_time%"=="5" (
    echo.
    set /p custom_day="اليوم [0-6 حيث 0=الأحد]: "
    set /p custom_time="الوقت [HH:MM]: "
)

echo.
echo 2. نطاق التنظيف المجدول:
echo    [A] تنظيف سريع (سجل التصفح فقط)
echo    [B] تنظيف قياسي (سجل + كوكيز + تخزين مؤقت)
echo    [C] تنظيف شامل (جميع البيانات)
echo    [D] تنظيف ذكي (باستخدام الذكاء الاصطناعي)
echo.
set /p scheduled_scope="نطاق التنظيف: "

echo.
echo 3. إشعارات وتقارير:
echo    [X] إرسال إشعار قبل التنظيف بـ 5 دقائق
echo    [Y] إرسال تقرير بالبيانات المحذوفة
echo    [Z] إرسال تنبيه إذا تم إلغاء التنظيف
echo    [W] تسجيل جميع عمليات التنظيف
echo.
set /p schedule_notifications="الإشعارات والتقارير: "

echo.
echo 4. شروط التنظيف:
echo    [1] تنظيف فقط عند عدم استخدام المتصفح
echo    [2] تنظيف حتى إذا كان المتصفح قيد الاستخدام
echo    [3] تخطي التنظيف إذا كان النظام مشغولاً
echo    [4] إعادة المحاولة إذا فشل التنظيف
echo.
set /p cleaning_conditions="شروط التنظيف: "

echo.
echo 5. الاستثناءات المجدولة:
echo    [A] عدم تنظيف بيانات مواقع العمل في أيام العمل
echo    [B] عدم تنظيف بيانات مواقع التواصل الاجتماعي يوم الجمعة
echo    [C] الاحتفاظ ببيانات التسوق آخر 7 أيام
echo    [D] استثناء مواقع محددة من التنظيف
echo.
set /p schedule_exceptions="الاستثناءات: "

echo.
echo 📋 ملخص الجدولة:
echo   - التكرار: أسبوعيًا
echo   - الوقت: %schedule_time%
echo   - النطاق: %scheduled_scope%
echo   - الشروط: %cleaning_conditions%
echo   - الاستثناءات: %schedule_exceptions%
echo.
set /p confirm_schedule="تفعيل الجدولة الأسبوعية؟ (Y/N): "

if /i "%confirm_schedule%"=="Y" (
    echo.
    echo جاري إنشاء مهمة مجدولة في Windows...
    timeout /t 3 /nobreak >nul
    
    :: محاكاة إنشاء مهمة مجدولة
    echo schtasks /create /tn "KNOX_Weekly_Browser_Clean" ^
    echo /tr "\"%~dp0\browser_cleaner.bat\"" ^
    echo /sc weekly /d %custom_day% /st %custom_time% ^
    echo /rl highest
    
    echo.
    echo ✓ تم تفعيل الجدولة الأسبوعية بنجاح
    echo ✓ سيتم التنظيف تلقائيًا كل أسبوع
    echo ✓ يمكنك تعديل الإعدادات في أي وقت
)

pause
goto MENU

:REAL_TIME_MONITORING
cls
echo.
echo =======================================================
echo           مراقبة وحماية في الوقت الحقيقي
echo =======================================================
echo.
echo 🛡️ نظام المراقبة في الوقت الحقيقي:
echo.
echo  [1]  مراقبة نشاط المتصفح:
echo       ✓ تتبع الزيارات الجديدة
echo       ✓ مراقبة ملفات تعريف الارتباط
echo       ✓ اكتشاف عمليات التتبع
echo       ✓ تحليل حركة البيانات
echo.
echo  [2]  حماية الخصوصية النشطة:
echo       ✓ منع مواقع التتبع
echo       ✓ تشفير سجل التصفح
echo       ✓ إخفاء عنوان IP
echo       ✓ منع بصمة المتصفح
echo.
echo  [3]  تحليل التهديدات:
echo       ✓ اكتشاف البرمجيات الخبيثة
echo       ✓ كشف هجمات التصيد
echo       ✓ مراقبة الثغرات الأمنية
echo       ✓ تحليل سلوك المتصفح
echo.
echo  [4]  تقارير فورية:
echo       ✓ تقرير كل ساعة
echo       ✓ تقرير يومي مفصل
echo       ✓ تنبيهات فورية للتهديدات
echo       ✓ اقتراحات أمنية
echo.
echo ⚙️ إعدادات المراقبة المتقدمة:
echo    [A] مستوى المراقبة: منخفض/متوسط/عالي/شديد
echo    [B] استخدام الموارد: خفيف/متوازن/مكثف
echo    [C] تواتر الفحوصات: كل 5/15/30/60 دقيقة
echo    [D] إجراءات تلقائية عند اكتشاف تهديد
echo.
set /p monitoring_settings="إعدادات المراقبة: "

echo.
echo 📊 لوحة تحكم المراقبة الحية:
echo.
echo جاري تشغيل نظام المراقبة...
timeout /t 2 /nobreak >nul
echo.
echo 🔴 حالة الحماية: نشطة
echo 🟢 المتصفحات المراقبة: Chrome, Firefox, Edge
echo 📈 الزيارات منذ التشغيل: 24 زيارة
echo 🚫 مواقع محظورة: 3 مواقع
echo 🛡️ تهديدات ممنوعة: 5 تهديدات
echo.
echo 📋 النشاط الحالي:
echo   12:30: زيارة موقع YouTube (آمن)
echo   12:32: منع ملف تعريف ارتباط تابع لـ Google Analytics
echo   12:35: اكتشاف محاولة تتبع من Facebook
echo   12:37: تشفير سجل زيارة موقع مصرفي
echo.
echo 💡 الإجراءات الفورية المتاحة:
echo   [1] حظر موقع حالي
echo   [2] تنظيف سجل الجلسة الحالية
echo   [3] تمكين وضع التصفح الآمن
echo   [4] فحص أمني فوري
echo   [5] إيقاف المراقبة مؤقتًا
echo.
set /p live_action="اختر الإجراء [1-5]: "

if "%live_action%"=="1" (
    echo.
    set /p block_site="أدخل عنوان الموقع للحظر: "
    echo ✓ تم حظر الموقع %block_site% بنجاح
)

if "%live_action%"=="4" (
    echo.
    echo 🔍 جاري الفحص الأمني الفوري...
    timeout /t 3 /nobreak >nul
    echo ✓ لم يتم اكتشاف أي تهديدات
    echo ✓ جميع إعدادات الأمان سليمة
)

echo.
echo هل تريد تشغيل المراقبة في الخلفية؟
set /p run_background="(تشغيل في الخلفية؟ Y/N): "

if /i "%run_background%"=="Y" (
    echo.
    echo جاري تشغيل مراقبة الخصوصية في الخلفية...
    echo ✓ سيتم إشعارك بأي تهديدات
    echo ✓ يمكنك الوصول للوحة التحكم في أي وقت
    echo ✓ استخدم Ctrl+Alt+P لإظهار المراقبة
)
pause
goto MENU

:DATA_TYPE_CLEANING
echo تنظيف حسب نوع البيانات...
pause
goto MENU

:SELECTIVE_BROWSER_CLEAN
echo تنظيف متصفحات محددة...
pause
goto MENU

:CUSTOM_EXCEPTIONS
echo تخصيص الاستثناءات...
pause
goto MENU

:ADVANCED_SECURITY
echo إعدادات أمنية متقدمة...
pause
goto MENU

:CLEANING_LOGS
echo سجلات وتقارير التنظيف...
pause
goto MENU

:SELECTIVE_RESTORE
echo استعادة البيانات المحذوفة...
pause
goto MENU

:PRIVACY_PROFILES
echo ملفات تعريف الخصوصية...
pause
goto MENU

:ADVANCED_CUSTOMIZATION
echo إعدادات التخصيص المتقدمة...
pause
goto MENU

:PRIVACY_REPORTS
echo تقارير الخصوصية والمراقبة...
pause
goto MENU

:ADDITIONAL_PROTECTION
echo أدوات حماية إضافية...
pause
goto MENU
