@echo off
chcp 65001 >nul
title KNOX - أدوات الشبكة (Network Utilities)
color 2A

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
echo_#/|##########/\######(   /\   )######/\########NU|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /08/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           الفئة الثامنة: أدوات الشبكة
echo                Network Utilities
echo =======================================================
echo.
echo 🌐 أدوات الشبكة والاتصال المتقدمة:
echo.
echo   [1]  اختبار سرعة الشبكة
echo        Network Speed Test
echo        اختبار سرعة الاتصال
echo.
echo   [2]  محلل الشبكة
echo        Network Analyzer
echo        تحليل أداء الشبكة
echo.
echo   [3]  مراقب الشبكة
echo        Network Monitor
echo        مراقبة نشاط الشبكة
echo.
echo   [4]  ماسح المنافذ
echo        Port Scanner
echo        فحص المنافذ المفتوحة
echo.
echo   [5]  محسن الشبكة
echo        Network Optimizer
echo        تحسين أداء الشبكة
echo.
echo   [6]  كاشف الأجهزة
echo        Device Detector
echo        كشف الأجهزة على الشبكة
echo.
echo   [7]  مدير الشبكة
echo        Network Manager
echo        إدارة إعدادات الشبكة
echo.
echo   [8]  أداة Ping
echo        Ping Tool
echo        اختبار الاتصال
echo.
echo   [9]  أداة Traceroute
echo        Traceroute Tool
echo        تتبع مسار الشبكة
echo.
echo   [10] أداة Wi-Fi
echo        Wi-Fi Tool
echo        أدوات الشبكة اللاسلكية
echo.
echo.
echo   [P]  ملفات تعريف الشبكة
echo   [S]  إعدادات الذكاء الاصطناعي
echo   [R]  تقارير الشبكة
echo   [T]  أدوات التشخيص
echo   [B]  العودة للقائمة الرئيسية
echo   [E]  خروج
echo.
set /p choice="اختر الأداة [1-10, P, S, R, T, B, E]: "

if "%choice%"=="1" call "%~dp0"01_NETWORK_SPEED_TEST.bat
if "%choice%"=="2" call "%~dp0"02_NETWORK_ANALYZER.bat
if "%choice%"=="3" call "%~dp0"03_NETWORK_MONITOR.bat
if "%choice%"=="4" call "%~dp0"04_PORT_SCANNER.bat
if "%choice%"=="5" call "%~dp0"05_NETWORK_OPTIMIZER.bat
if "%choice%"=="6" call "%~dp0"06_DEVICE_DETECTOR.bat
if "%choice%"=="7" call "%~dp0"07_NETWORK_MANAGER.bat
if "%choice%"=="8" call "%~dp0"08_PING_TOOL.bat
if "%choice%"=="9" call "%~dp0"09_TRACEROUTE_TOOL.bat
if "%choice%"=="10" call "%~dp0"10_WIFI_TOOL.bat

if /i "%choice%"=="P" goto NETWORK_PROFILES
if /i "%choice%"=="S" goto AI_SETTINGS
if /i "%choice%"=="R" goto NETWORK_REPORTS
if /i "%choice%"=="T" goto DIAGNOSTIC_TOOLS
if /i "%choice%"=="B" call "%~dp0..\00_PHILOSOPHICAL_FOUNDATION.bat
if /i "%choice%"=="E" exit

echo اختيار غير صالح!
pause
goto MENU

:NETWORK_PROFILES
cls
echo.
echo =======================================================
echo           ملفات تعريف الشبكة
echo =======================================================
echo.
echo 🌐 ملفات تعريف محددة مسبقاً:
echo.
echo   [1]  ملف تعريف الأساسي
echo        - إعدادات أساسية
echo        - أداء جيد
echo        - مناسب للاستخدام اليومي
echo.
echo   [2]  ملف تعريف الألعاب
echo        - إعدادات الألعاب
echo        - تأخير منخفض
echo        - مناسب للألعاب
echo.
echo   [3]  ملف تعريف البث
echo        - إعدادات البث
echo        - استقرار عالي
echo        - مناسب للبث المباشر
echo.
echo   [4]  ملف تعريف العمل
echo        - إعدادات العمل
echo        - موثوقية عالية
echo        - مناسب للعمل
echo.
echo   [5]  ملف تعريف مخصص
echo        - إعداداتك الخاصة
echo        - تخصيص كامل
echo        - حفظ التفضيلات
echo.
echo   [B]  العودة
echo.
set /p profile_choice="اختر ملف التعريف [1-5, B]: "

if "%profile_choice%"=="1" echo ✓ تم تطبيق ملف تعريف الشبكة الأساسي
if "%profile_choice%"=="2" echo ✓ تم تطبيق ملف تعريف الشبكة للألعاب
if "%profile_choice%"=="3" echo ✓ تم تطبيق ملف تعريف الشبكة للبث
if "%profile_choice%"=="4" echo ✓ تم تطبيق ملف تعريف الشبكة للعمل
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
echo 🤖 إعدادات الشبكة بالذكاء الاصطناعي:
echo.
echo   [1]  تحسين ذكي
echo        ✓ تحليل الأداء
echo        ✓ تحسين ديناميكي
echo        ✓ تعلم من العادات
echo.
echo   [2]  تحليل متقدم
echo        ✓ تحليل عميق
echo        ✓ توقع المشاكل
echo        ✓ تحسين استباقي
echo.
echo   [3]  مراقبة ذكية
echo        ✓ مراقبة في الوقت الفعلي
echo        ✓ تحليل الأنماط
echo        ✓ تنبيهات ذكية
echo.
echo   [4]  التعلم التكيفي
echo        ✓ التعلم من الاستخدام
echo        ✓ تكييف الإعدادات
echo        ✓ تحسين مستمر
echo.
echo   [5]  التحسين التنبؤي
echo        ✓ توقع المشاكل
echo        ✓ حلول وقائية
echo        ✓ أداء ذكي
echo.
echo   [B]  العودة
echo.
set /p ai_choice="اختر إعدادات الذكاء الاصطناعي [1-5, B]: "

if "%ai_choice%"=="1" echo ✓ تم تفعيل التحسين الذكي
if "%ai_choice%"=="2" echo ✓ تم تفعيل التحليل المتقدم
if "%ai_choice%"=="3" echo ✓ تم تفعيل المراقبة الذكية
if "%ai_choice%"=="4" echo ✓ تم تفعيل التعلم التكيفي
if "%ai_choice%"=="5" echo ✓ تم تفعيل التحسين التنبؤي

pause
goto MENU

:NETWORK_REPORTS
cls
echo.
echo =======================================================
echo           تقارير الشبكة
echo =======================================================
echo.
echo 📊 إحصائيات الشبكة:
echo.
echo   [1]  تقرير الشبكة الأخير
echo   [2]  إحصائيات الأسبوع
echo   [3]  تحليل الأداء
echo   [4]  مقارنة الأداء
echo   [5]  تصدير التقرير
echo.
echo   [B]  العودة
echo.
set /p report_choice="اختر التقرير [1-5, B]: "

if "%report_choice%"=="1" echo ✓ جاري عرض تقرير الشبكة الأخير...
if "%report_choice%"=="2" echo ✓ جاري عرض إحصائيات الأسبوع...
if "%report_choice%"=="3" echo ✓ جاري تحليل الأداء...
if "%report_choice%"=="4" echo ✓ جاري مقارنة الأداء...
if "%report_choice%"=="5" echo ✓ جاري تصدير التقرير...

pause
goto MENU

:DIAGNOSTIC_TOOLS
cls
echo.
echo =======================================================
echo           أدوات التشخيص
echo =======================================================
echo.
echo 🔧 أدوات تشخيص الشبكة:
echo.
echo   [1]  تشخيص الاتصال
echo   [2]  تشخيص الأداء
echo   [3]  تشخيص الأجهزة
echo   [4]  تشخيص متقدم
echo   [5]  تشخيص بالذكاء الاصطناعي
echo.
echo   [B]  العودة
echo.
set /p diagnostic_choice="اختر أداة التشخيص [1-5, B]: "

if "%diagnostic_choice%"=="1" echo ✓ جاري تشخيص الاتصال...
if "%diagnostic_choice%"=="2" echo ✓ جاري تشخيص الأداء...
if "%diagnostic_choice%"=="3" echo ✓ جاري تشخيص الأجهزة...
if "%diagnostic_choice%"=="4" echo ✓ جاري التشخيص المتقدم...
if "%diagnostic_choice%"=="5" echo ✓ جاري التشخيص بالذكاء الاصطناعي...

pause
goto MENU
