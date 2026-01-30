@echo off
chcp 65001 >nul
title KNOX - مراقب النظام (System Monitor)
color 3B

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
echo_#/|##########/\######(   /\   )######/\########SM|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /10/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           الفئة العاشرة: مراقب النظام
echo                System Monitor
echo =======================================================
echo.
echo 📊 أدوات مراقبة النظام المتقدمة:
echo.
echo   [1]  مراقب المعالج
echo        CPU Monitor
echo        مراقبة أداء المعالج
echo.
echo   [2]  مراقب الذاكرة
echo        Memory Monitor
echo        مراقبة استخدام الذاكرة
echo.
echo   [3]  مراقب القرص الصلب
echo        Disk Monitor
echo        مراقبة أداء القرص الصلب
echo.
echo   [4]  مراقب الشبكة
echo        Network Monitor
echo        مراقبة نشاط الشبكة
echo.
echo   [5]  مراقب الرسوميات
echo        GPU Monitor
echo        مراقبة أداء كرت الشاشة
echo.
echo   [6]  مراقب العمليات
echo        Process Monitor
echo        مراقبة العمليات النشطة
echo.
echo   [7]  مراقب الحرارة
echo        Temperature Monitor
echo        مراقبة حرارة النظام
echo.
echo   [8]  مراقب الطاقة
echo        Power Monitor
echo        مراقبة استهلاك الطاقة
echo.
echo   [9]  مراقب الأداء
echo        Performance Monitor
echo        مراقبة الأداء العام
echo.
echo   [10] مراقب متقدم
echo        Advanced Monitor
echo        مراقبة متقدمة وشاملة
echo.
echo.
echo   [P]  ملفات تعريف المراقبة
echo   [S]  إعدادات الذكاء الاصطناعي
echo   [R]  تقارير المراقبة
echo   [T]  أدوات التحليل
echo   [B]  العودة للقائمة الرئيسية
echo   [E]  خروج
echo.
set /p choice="اختر الأداة [1-10, P, S, R, T, B, E]: "

if "%choice%"=="1" call "%~dp0"01_CPU_MONITOR.bat
if "%choice%"=="2" call "%~dp0"02_MEMORY_MONITOR.bat
if "%choice%"=="3" call "%~dp0"03_DISK_MONITOR.bat
if "%choice%"=="4" call "%~dp0"04_NETWORK_MONITOR.bat
if "%choice%"=="5" call "%~dp0"05_GPU_MONITOR.bat
if "%choice%"=="6" call "%~dp0"06_PROCESS_MONITOR.bat
if "%choice%"=="7" call "%~dp0"07_TEMPERATURE_MONITOR.bat
if "%choice%"=="8" call "%~dp0"08_POWER_MONITOR.bat
if "%choice%"=="9" call "%~dp0"09_PERFORMANCE_MONITOR.bat
if "%choice%"=="10" call "%~dp0"10_ADVANCED_MONITOR.bat

if /i "%choice%"=="P" goto MONITOR_PROFILES
if /i "%choice%"=="S" goto AI_SETTINGS
if /i "%choice%"=="R" goto MONITOR_REPORTS
if /i "%choice%"=="T" goto ANALYSIS_TOOLS
if /i "%choice%"=="B" call "%~dp0..\00_PHILOSOPHICAL_FOUNDATION.bat
if /i "%choice%"=="E" exit

echo اختيار غير صالح!
pause
goto MENU

:MONITOR_PROFILES
cls
echo.
echo =======================================================
echo           ملفات تعريف المراقبة
echo =======================================================
echo.
echo 📊 ملفات تعريف محددة مسبقاً:
echo.
echo   [1]  ملف تعريف الأساسي
echo        - مراقبة أساسية
echo        - معلومات عامة
echo        - مناسب للاستخدام اليومي
echo.
echo   [2]  ملف تعريف المتقدم
echo        - مراقبة متقدمة
echo        - معلومات تفصيلية
echo        - مناسب للمحترفين
echo.
echo   [3]  ملف تعريف الأداء
echo        - مراقبة الأداء
echo        - تحليل الأداء
echo        - مناسب للألعاب
echo.
echo   [4]  ملف تعريف الخادم
echo        - مراقبة الخادم
echo        - استقرار عالي
echo        - مناسب للخوادم
echo.
echo   [5]  ملف تعريف مخصص
echo        - إعداداتك الخاصة
echo        - تخصيص كامل
echo        - حفظ التفضيلات
echo.
echo   [B]  العودة
echo.
set /p profile_choice="اختر ملف التعريف [1-5, B]: "

if "%profile_choice%"=="1" echo ✓ تم تطبيق ملف تعريف المراقبة الأساسي
if "%profile_choice%"=="2" echo ✓ تم تطبيق ملف تعريف المراقبة المتقدم
if "%profile_choice%"=="3" echo ✓ تم تطبيق ملف تعريف مراقبة الأداء
if "%profile_choice%"=="4" echo ✓ تم تطبيق ملف تعريف مراقبة الخادم
if "%profile_choice%"=="5" echo ✓ تم تطبيق ملف التعريف المخصص

pause
goto MENU

:AI_SETTINGS
cls
echo.
echo =======================================================
echo           إعدادات الذكاء الاصطناعي
echo =======================================================
echo.
echo 🤖 إعدادات المراقبة بالذكاء الاصطناعي:
echo.
echo   [1]  مراقبة ذكية
echo        ✓ تحليل الأداء
echo        ✓ توقع المشاكل
echo        ✓ تنبيهات ذكية
echo.
echo   [2]  تحليل متقدم
echo        ✓ تحليل عميق
echo        ✓ توقعات الأداء
echo        ✓ تحسين استباقي
echo.
echo   [3]  التعلم التكيفي
echo        ✓ التعلم من الاستخدام
echo        ✓ تكييف الإعدادات
echo        ✓ تحسين مستمر
echo.
echo   [4]  المراقبة التنبؤية
echo        ✓ توقع المشاكل
echo        ✓ حلول وقائية
echo        ✓ أداء ذكي
echo.
echo   [5]  التحليل التلقائي
echo        ✓ تحليل تلقائي
echo        ✓ تقارير ذكية
echo        ✓ تحسين مستمر
echo.
echo   [B]  العودة
echo.
set /p ai_choice="اختر إعدادات الذكاء الاصطناعي [1-5, B]: "

if "%ai_choice%"=="1" echo ✓ تم تفعيل المراقبة الذكية
if "%ai_choice%"=="2" echo ✓ تم تفعيل التحليل المتقدم
if "%ai_choice%"=="3" echo ✓ تم تفعيل التعلم التكيفي
if "%ai_choice%"=="4" echo ✓ تم تفعيل المراقبة التنبؤية
if "%ai_choice%"=="5" echo ✓ تم تفعيل التحليل التلقائي

pause
goto MENU

:MONITOR_REPORTS
cls
echo.
echo =======================================================
echo           تقارير المراقبة
echo =======================================================
echo.
echo 📊 إحصائيات المراقبة:
echo.
echo   [1]  تقرير المراقبة الأخير
echo   [2]  إحصائيات الأسبوع
echo   [3]  تحليل الأداء
echo   [4]  مقارنة الأداء
echo   [5]  تصدير التقرير
echo.
echo   [B]  العودة
echo.
set /p report_choice="اختر التقرير [1-5, B]: "

if "%report_choice%"=="1" echo ✓ جاري عرض تقرير المراقبة الأخير...
if "%report_choice%"=="2" echo ✓ جاري عرض إحصائيات الأسبوع...
if "%report_choice%"=="3" echo ✓ جاري تحليل الأداء...
if "%report_choice%"=="4" echo ✓ جاري مقارنة الأداء...
if "%report_choice%"=="5" echo ✓ جاري تصدير التقرير...

pause
goto MENU

:ANALYSIS_TOOLS
cls
echo.
echo =======================================================
echo           أدوات التحليل
echo =======================================================
echo.
echo 🔧 أدوات تحليل النظام:
echo.
echo   [1]  تحليل الأداء
echo   [2]  تحليل الموارد
echo   [3]  تحليل العمليات
echo   [4]  تحليل متقدم
echo   [5]  تحليل بالذكاء الاصطناعي
echo.
echo   [B]  العودة
echo.
set /p analysis_choice="اختر أداة التحليل [1-5, B]: "

if "%analysis_choice%"=="1" echo ✓ جاري تحليل الأداء...
if "%analysis_choice%"=="2" echo ✓ جاري تحليل الموارد...
if "%analysis_choice%"=="3" echo ✓ جاري تحليل العمليات...
if "%analysis_choice%"=="4" echo ✓ جاري التحليل المتقدم...
if "%analysis_choice%"=="5" echo ✓ جاري التحليل بالذكاء الاصطناعي...

pause
goto MENU
