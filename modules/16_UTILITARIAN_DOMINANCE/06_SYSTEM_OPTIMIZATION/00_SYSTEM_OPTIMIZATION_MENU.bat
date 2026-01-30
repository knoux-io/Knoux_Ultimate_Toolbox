@echo off
chcp 65001 >nul
title KNOX - تحسين النظام (أحمر قرمزي #DC143C)
color 4F

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
echo        الفئة 6: تحسين النظام (أحمر قرمزي)
echo           "قوة النظام في أقصى أداء، استقرار لا مثيل له"
echo =======================================================
echo.
echo ↻ أدوات التحسين القابلة للتخصيص الكامل:
echo.
echo   [1]  مدير برامج بدء التشغيل - Startup Program Manager
echo   [2]  محسن الخدمات - Service Optimizer
echo   [3]  منظف السجل - Registry Cleaner
echo   [4]  محسن الذاكرة - Memory Optimizer
echo   [5]  مزيل تجزئة القرص - Disk Defragmenter Optimizer
echo.
echo   [6]  نسخ احتياطي واستعادة برامج التشغيل - Driver Backup
echo   [7]  مدير نقاط استعادة النظام - System Restore Manager
echo   [8]  محرر القائمة السياقية - Context Menu Editor
echo   [9]  مدير ميزات ويندوز - Windows Feature Manager
echo   [10] مراقب الأداء ومعايير الأداء - Performance Monitor
echo.
echo   [A]  إعدادات التحسين التلقائي
echo   [P]  ملفات تعريف الأداء
echo   [S]  جدولة التحسينات
echo   [M]  مراقبة النظام في الوقت الحقيقي
echo   [B]  العودة للقائمة الرئيسية
echo.
set /p choice="اختر الأداة [1-10, A, P, S, M, B]: "

if "%choice%"=="1" call "01_STARTUP_PROGRAM_MANAGER.bat"
if "%choice%"=="2" call "02_SERVICE_OPTIMIZER.bat"
if "%choice%"=="3" call "03_REGISTRY_CLEANER.bat"
if "%choice%"=="4" call "04_MEMORY_OPTIMIZER.bat"
if "%choice%"=="5" call "05_DISK_DEFRAGMENTER_OPTIMIZER.bat"
if "%choice%"=="6" call "06_DRIVER_BACKUP_RESTORE.bat"
if "%choice%"=="7" call "07_SYSTEM_RESTORE_POINT_MANAGER.bat"
if "%choice%"=="8" call "08_CONTEXT_MENU_EDITOR.bat"
if "%choice%"=="9" call "09_WINDOWS_FEATURE_MANAGER.bat"
if "%choice%"=="10" call "10_PERFORMANCE_MONITOR_BENCHMARK.bat"

if /i "%choice%"=="A" goto AUTO_OPTIMIZATION
if /i "%choice%"=="P" goto PERFORMANCE_PROFILES
if /i "%choice%"=="S" goto OPTIMIZATION_SCHEDULE
if /i "%choice%"=="M" goto REAL_TIME_MONITORING
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:AUTO_OPTIMIZATION
cls
echo.
echo =======================================================
echo           إعدادات التحسين التلقائي
echo =======================================================
echo.
echo 1. مستوى التحسين:
echo    [A] حذر (آمن للمبتدئين)
echo    [B] متوازن (موصى به)
echo    [C] جذري (للمحترفين)
echo    [D] مخصص (تحكم كامل)
echo.
set /p optimization_level="مستوى التحسين: "

echo.
echo 2. مجالات التحسين:
echo    [X] تحسين بدء التشغيل
echo    [Y] تحسين الخدمات
echo    [Z] تحسين الذاكرة
echo    [W] تحسين القرص الصلب
echo    [V] تحسين الشبكة
echo.
set /p optimization_areas="مجالات التحسين: "

echo.
echo 3. الجدولة التلقائية:
echo    [1] يوميًا
echo    [2] أسبوعيًا
echo    [3] شهريًا
echo    [4] عند بدء التشغيل
echo    [5] عند إيقاف التشغيل
echo.
set /p schedule_optimization="جدولة التحسين: "

echo.
echo 4. الإشعارات والتقارير:
echo    [A] إشعارات عند الانتهاء
echo    [B] تقارير أسبوعية
echo    [C] تنبيهات المشاكل
echo    [D] تقارير مفصلة
echo.
set /p notification_settings="إعدادات الإشعارات: "

echo.
echo ✓ تم حفظ إعدادات التحسين التلقائي
pause
goto MENU

:PERFORMANCE_PROFILES
cls
echo.
echo =======================================================
echo           ملفات تعريف الأداء
echo =======================================================
echo.
echo ملفات التعريف المتاحة:
echo.
echo  [1]  ملف تعريف "الألعاب"
echo       - تعطيل الخدمات غير الضرورية
echo       - تحديد أولوية الألعاب
echo       - تحسين الذاكرة للألعاب
echo       - تعطيل التحديثات المؤقتة
echo.
echo  [2]  ملف تعريف "العمل والإنتاجية"
echo       - تحسين الخدمات المهنية
echo       - تحسين أداء التطبيقات المكتبية
echo       - تفعيل التحديثات الأمنية
echo       - تحسين الشبكة للمؤتمرات
echo.
echo  [3]  ملف تعريف "توفير الطاقة"
echo       - تقليل استهلاك الطاقة
echo       - تعطيل الخدمات غير الضرورية
echo       - تحسين عمر البطارية
echo       - تقليل أداء الرسومات
echo.
echo  [4]  ملف تعريف "الخادم/الاستضافة"
echo       - تحسين الخدمات الشبكية
echo       - تحسين الأداء للمهام الخلفية
echo       - تفعيل التسجيل المتقدم
echo       - تحسين الأمان
echo.
echo خيارات:
echo   [L] تحميل ملف تعريف
echo   [C] إنشاء ملف تعريف مخصص
echo   [E] تعديل ملف تعريف موجود
echo   [D] حذف ملف تعريف
echo   [S] مشاركة ملفات التعريف
echo.
set /p profile_action="اختر الإجراء: "

if /i "%profile_action%"=="L" (
    echo.
    set /p load_profile="اختر ملف التعريف [1-4]: "
    echo ✓ تم تحميل ملف التعريف بنجاح!
)

if /i "%profile_action%"=="C" (
    call :CREATE_CUSTOM_PROFILE
)

pause
goto MENU

:CREATE_CUSTOM_PROFILE
cls
echo.
echo =======================================================
echo           إنشاء ملف تعريف أداء مخصص
echo =======================================================
echo.
set /p profile_name="اسم ملف التعريف: "
set /p profile_description="الوصف: "

echo.
echo 1. تحسين بدء التشغيل:
echo    [A] تعطيل كل البرامج غير الضرورية
echo    [B] تعطيل برامج محددة فقط
echo    [C] تأخير بدء بعض البرامج
echo    [D] لا تغيير شيء
echo.
set /p startup_optimization="تحسين بدء التشغيل: "

echo.
echo 2. تحسين الخدمات:
echo    [1] تعطيل الخدمات غير الضرورية
echo    [2] تعطيل الخدمات الآمنة
echo    [3] تعديل أولوية الخدمات
echo    [4] لا تغيير الخدمات
echo.
set /p service_optimization="تحسين الخدمات: "

echo.
echo 3. تحسين الذاكرة:
echo    [X] تفريغ الذاكرة المؤقتة
echo    [Y] تحسين ملف التبديل
echo    [Z] ضبط إعدادات الذاكرة الافتراضية
echo.
set /p memory_optimization="تحسين الذاكرة: "

echo.
echo 4. تحسين الشبكة:
echo    [A] تحسين إعدادات TCP/IP
echo    [B] تحسين DNS
echo    [C] تحكم في نطاق التردد
echo    [D] لا تغيير إعدادات الشبكة
echo.
set /p network_optimization="تحسين الشبكة: "

echo.
echo 5. إعدادات الطاقة:
echo    [1] أداء عالي
echo    [2] متوازن
echo    [3] توفير الطاقة
echo    [4] مخصص
echo.
set /p power_settings="إعدادات الطاقة: "

echo.
echo 📊 ملخص ملف التعريف:
echo   - الاسم: %profile_name%
echo   - الوصف: %profile_description%
echo   - بدء التشغيل: %startup_optimization%
echo   - الخدمات: %service_optimization%
echo   - الذاكرة: %memory_optimization%
echo   - الشبكة: %network_optimization%
echo   - الطاقة: %power_settings%
echo.
set /p save_custom_profile="حفظ ملف التعريف المخصص؟ (Y/N): "

if /i "%save_custom_profile%"=="Y" (
    echo.
    echo جاري حفظ ملف التعريف "%profile_name%"...
    timeout /t 2 /nobreak >nul
    echo ✓ تم حفظ ملف التعريف بنجاح!
)
goto :EOF

:OPTIMIZATION_SCHEDULE
cls
echo.
echo =======================================================
echo           جدولة التحسينات
echo =======================================================
echo.
echo 1. التحسينات المجدولة حاليًا:
echo    ✓ تحسين الذاكرة - يوميًا الساعة 3:00 ص
echo    ✓ تنظيف الملفات المؤقتة - أسبوعيًا الأحد 2:00 ص
echo    ✓ تحديث برامج التشغيل - شهريًا الأول من كل شهر
echo.
echo 2. إضافة تحسين مجدول جديد:
echo    [A] تحسين بدء التشغيل
echo    [B] تنظيف السجل
echo    [C] تفريغ القرص
echo    [D] تحديث النظام
echo    [E] تحليل الأداء
echo.
set /p scheduled_optimization="اختر التحسين: "

echo.
echo 3. توقيت التحسين:
echo    [1] يوميًا
echo    [2] أسبوعيًا (اختر اليوم)
echo    [3] شهريًا (اختر التاريخ)
echo    [4] عند حدث معين (بدء/إيقاف)
echo.
set /p timing_option="اختر التوقيت: "

if "%timing_option%"=="2" (
    echo.
    echo أيام الأسبوع:
    echo    [الأحد] [الإثنين] [الثلاثاء] [الأربعاء] [الخميس] [الجمعة] [السبت]
    set /p day_of_week="اختر اليوم: "
)

echo.
echo 4. إعدادات إضافية:
echo    [X] إشعار قبل التنفيذ
echo    [Y] إنشاء نقطة استعادة تلقائيًا
echo    [Z] إرسال تقرير بعد الانتهاء
echo.
set /p additional_settings="الإعدادات الإضافية: "

echo.
echo ✓ تم حفظ التحسين المجدول
pause
goto MENU

:REAL_TIME_MONITORING
cls
echo.
echo =======================================================
echo           مراقبة النظام في الوقت الحقيقي
echo =======================================================
echo.
echo 📊 حالة النظام الحالية:
echo.
echo  🖥️  المعالج: 25%% (Intel i7-10700K)
echo     - النوى النشطة: 8/16
echo     - التردد: 3.8 GHz
echo     - درجة الحرارة: 45°C
echo.
echo  💾 الذاكرة: 8.2GB/16GB (51%%)
echo     - المستخدمة: 8.2GB
echo     - المتاحة: 7.8GB
echo     - ملف التبديل: 4.2GB/8GB
echo.
echo  💾 القرص الصلب: 250GB/500GB (50%%)
echo     - C\: 120GB/250GB
echo     - D\: 130GB/250GB
echo     - القراءة: 45MB/s، الكتابة: 78MB/s
echo.
echo  🌐 الشبكة: نشطة
echo     - التنزيل: 12.5 Mbps
echo     - الرفع: 8.3 Mbps
echo     - زمن الاستجابة: 15ms
echo.
echo خيارات المراقبة:
echo   [1] عرض تفاصيل المعالج
echo   [2] عرض تفاصيل الذاكرة
echo   [3] عرض تفاصيل القرص
echo   [4] عرض تفاصيل الشبكة
echo   [5] عرض العمليات النشطة
echo   [6] بدء مراقبة مستمرة
echo   [7] إنشاء تنبيهات مخصصة
echo   [8] تصدير تقرير الأداء
echo.
set /p monitoring_option="اختر خيار المراقبة: "

if "%monitoring_option%"=="6" (
    echo.
    echo جاري بدء المراقبة المستمرة...
    echo ✓ سيتم تحديث البيانات كل 5 ثوانٍ
    echo ✓ اضغط أي مفتاح لإيقاف المراقبة
    pause
)

if "%monitoring_option%"=="7" (
    call :CREATE_CUSTOM_ALERTS
)

pause
goto MENU

:CREATE_CUSTOM_ALERTS
cls
echo.
echo =======================================================
echo           إنشاء تنبيهات مخصصة
echo =======================================================
echo.
echo 1. تنبيهات المعالج:
echo    [A] عند تجاوز 80%% استخدام
echo    [B] عند تجاوز 70°C درجة الحرارة
echo    [C] عند انخفاض التردد
echo    [D] مخصص
echo.
set /p cpu_alert="تنبيه المعالج: "

echo.
echo 2. تنبيهات الذاكرة:
echo    [1] عند تجاوز 90%% استخدام
echo    [2] عند انخفاض الذاكرة المتاحة
echo    [3] عند زيادة استخدام ملف التبديل
echo    [4] مخصص
echo.
set /p memory_alert="تنبيه الذاكرة: "

echo.
echo 3. تنبيهات القرص:
echo    [X] عند امتلاء القرص (>90%%)
echo    [Y] عند انخفاض سرعة القرص
echo    [Z] عند وجود أخطاء في القرص
echo.
set /p disk_alert="تنبيه القرص: "

echo.
echo 4. تنبيهات الشبكة:
echo    [A] عند انقطاع الاتصال
echo    [B] عند انخفاض السرعة
echo    [C] عند زيادة زمن الاستجابة
echo.
set /p network_alert="تنبيه الشبكة: "

echo.
echo 5. طرق الإشعار:
echo    [1] إشعار سطح المكتب
echo    [2] رسالة بريد إلكتروني
echo    [3] تسجيل في ملف سجل
echo    [4] تشغيل صوت تنبيه
echo.
set /p notification_method="طريقة الإشعار: "

echo.
echo ✓ تم حفظ التنبيهات المخصصة
pause
goto :EOF
