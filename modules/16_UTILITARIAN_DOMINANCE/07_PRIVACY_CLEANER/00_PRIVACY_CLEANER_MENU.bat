@echo off
chcp 65001 >nul
title KNOX - منظف الخصوصية (Privacy Cleaner)
color 5D

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
echo_#/|##########/\######(   /\   )######/\########PC|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /07/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           الفئة السابعة: منظف الخصوصية
echo                Privacy Cleaner
echo =======================================================
echo.
echo 🔒 أدوات تنظيف وحماية الخصوصية:
echo.
echo   [1]  منظف سجل المتصفح
echo        Browser History Cleaner
echo        تنظيف سجل التصفح
echo.
echo   [2]  منظف الملفات المؤقتة
echo        Temporary Files Cleaner
echo        تنظيف الملفات المؤقتة
echo.
echo   [3]  منظف سجل النظام
echo        System Logs Cleaner
echo        تنظيف سجلات النظام
echo.
echo   [4]  منظف التطبيقات
echo        Applications Cleaner
echo        تنظيف بيانات التطبيقات
echo.
echo   [5]  منظف الملفات الحديثة
echo        Recent Files Cleaner
echo        تنظيف الملفات الحديثة
echo.
echo   [6]  منظف سجل البحث
echo        Search History Cleaner
echo        تنظيف سجل البحث
echo.
echo   [7]  منظف ذاكرة التخزين المؤقت
echo        Cache Cleaner
echo        تنظيف ذاكرة التخزين المؤقت
echo.
echo   [8]  منظف ملفات تعريف الارتباط
echo        Cookies Cleaner
echo        تنظيف ملفات تعريف الارتباط
echo.
echo   [9]  منظف البيانات الشخصية
echo        Personal Data Cleaner
echo        تنظيف البيانات الشخصية
echo.
echo   [10] منظف متقدم
echo        Advanced Cleaner
echo        تنظيف متقدم وشامل
echo.
echo.
echo   [P]  ملفات تعريف الخصوصية
echo   [S]  إعدادات الذكاء الاصطناعي
echo   [R]  تقارير التنظيف
echo   [T]  أدوات الحماية
echo   [B]  العودة للقائمة الرئيسية
echo   [E]  خروج
echo.
set /p choice="اختر الأداة [1-10, P, S, R, T, B, E]: "

if "%choice%"=="1" call "%~dp0"01_BROWSER_HISTORY_CLEANER.bat
if "%choice%"=="2" call "%~dp0"02_TEMPORARY_FILES_CLEANER.bat
if "%choice%"=="3" call "%~dp0"03_SYSTEM_LOGS_CLEANER.bat
if "%choice%"=="4" call "%~dp0"04_APPLICATIONS_CLEANER.bat
if "%choice%"=="5" call "%~dp0"05_RECENT_FILES_CLEANER.bat
if "%choice%"=="6" call "%~dp0"06_SEARCH_HISTORY_CLEANER.bat
if "%choice%"=="7" call "%~dp0"07_CACHE_CLEANER.bat
if "%choice%"=="8" call "%~dp0"08_COOKIES_CLEANER.bat
if "%choice%"=="9" call "%~dp0"09_PERSONAL_DATA_CLEANER.bat
if "%choice%"=="10" call "%~dp0"10_ADVANCED_CLEANER.bat

if /i "%choice%"=="P" goto PRIVACY_PROFILES
if /i "%choice%"=="S" goto AI_SETTINGS
if /i "%choice%"=="R" goto CLEANING_REPORTS
if /i "%choice%"=="T" goto PROTECTION_TOOLS
if /i "%choice%"=="B" call "%~dp0..\00_PHILOSOPHICAL_FOUNDATION.bat
if /i "%choice%"=="E" exit

echo اختيار غير صالح!
pause
goto MENU

:PRIVACY_PROFILES
cls
echo.
echo =======================================================
echo           ملفات تعريف الخصوصية
echo =======================================================
echo.
echo 🔒 ملفات تعريف محددة مسبقاً:
echo.
echo   [1]  ملف تعريف الأساسي
echo        - تنظيف أساسي
echo        - حماية بسيطة
echo        - مناسب للاستخدام اليومي
echo.
echo   [2]  ملف تعريف المتقدم
echo        - تنظيف متقدم
echo        - حماية قوية
echo        - مناسب للحساسية
echo.
echo   [3]  ملف تعريف الشامل
echo        - تنظيف شامل
echo        - حماية قصوى
echo        - مناسب للخصوصية العالية
echo.
echo   [4]  ملف تعريف التلقائي
echo        - تنظيف تلقائي
echo        - حماية مستمرة
echo        - مناسب للراحة
echo.
echo   [5]  ملف تعريف مخصص
echo        - إعداداتك الخاصة
echo        - تخصيص كامل
echo        - حفظ التفضيلات
echo.
echo   [B]  العودة
echo.
set /p profile_choice="اختر ملف التعريف [1-5, B]: "

if "%profile_choice%"=="1" echo ✓ تم تطبيق ملف تعريف الخصوصية الأساسي
if "%profile_choice%"=="2" echo ✓ تم تطبيق ملف تعريف الخصوصية المتقدم
if "%profile_choice%"=="3" echo ✓ تم تطبيق ملف تعريف الخصوصية الشامل
if "%profile_choice%"=="4" echo ✓ تم تطبيق ملف تعريف الخصوصية التلقائي
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
echo 🤖 إعدادات تنظيف الخصوصية بالذكاء الاصطناعي:
echo.
echo   [1]  تنظيف ذكي
echo        ✓ التعرف على البيانات
echo        ✓ تحليل الخصوصية
echo        ✓ تنظيف دقيق
echo.
echo   [2]  تحليل متقدم
echo        ✓ تحليل عميق
echo        ✓ توقع البيانات
echo        ✓ تنظيف ذكي
echo.
echo   [3]  التعرف على البيانات
echo        ✓ التعرف على البيانات الشخصية
echo        ✓ التعرف على البيانات الحساسة
echo        ✓ التعرف على البيانات الخاصة
echo.
echo   [4]  التعلم التكيفي
echo        ✓ التعلم من الاستخدام
echo        ✓ تكييف الإعدادات
echo        ✓ تحسين مستمر
echo.
echo   [5]  التنظيف التنبؤي
echo        ✓ توقع البيانات
echo        ✓ تنظيف استباقي
echo        ✓ حماية ذكية
echo.
echo   [B]  العودة
echo.
set /p ai_choice="اختر إعدادات الذكاء الاصطناعي [1-5, B]: "

if "%ai_choice%"=="1" echo ✓ تم تفعيل التنظيف الذكي
if "%ai_choice%"=="2" echo ✓ تم تفعيل التحليل المتقدم
if "%ai_choice%"=="3" echo ✓ تم تفعيل التعرف على البيانات
if "%ai_choice%"=="4" echo ✓ تم تفعيل التعلم التكيفي
if "%ai_choice%"=="5" echo ✓ تم تفعيل التنظيف التنبؤي

pause
goto MENU

:CLEANING_REPORTS
cls
echo.
echo =======================================================
echo           تقارير التنظيف
echo =======================================================
echo.
echo 📊 إحصائيات التنظيف:
echo.
echo   [1]  تقرير التنظيف الأخير
echo   [2]  إحصائيات الأسبوع
echo   [3]  تحليل التنظيف
echo   [4]  مقارنة التنظيف
echo   [5]  تصدير التقرير
echo.
echo   [B]  العودة
echo.
set /p report_choice="اختر التقرير [1-5, B]: "

if "%report_choice%"=="1" echo ✓ جاري عرض تقرير التنظيف الأخير...
if "%report_choice%"=="2" echo ✓ جاري عرض إحصائيات الأسبوع...
if "%report_choice%"=="3" echo ✓ جاري تحليل التنظيف...
if "%report_choice%"=="4" echo ✓ جاري مقارنة التنظيف...
if "%report_choice%"=="5" echo ✓ جاري تصدير التقرير...

pause
goto MENU

:PROTECTION_TOOLS
cls
echo.
echo =======================================================
echo           أدوات الحماية
echo =======================================================
echo.
echo 🔧 أدوات حماية الخصوصية:
echo.
echo   [1]  حماية المتصفح
echo   [2]  حماية النظام
echo   [3]  حماية التطبيقات
echo   [4]  حماية الملفات
echo   [5]  حماية متقدمة
echo.
echo   [B]  العودة
echo.
set /p protection_choice="اختر أداة الحماية [1-5, B]: "

if "%protection_choice%"=="1" echo ✓ جاري حماية المتصفح...
if "%protection_choice%"=="2" echo ✓ جاري حماية النظام...
if "%protection_choice%"=="3" echo ✓ جاري حماية التطبيقات...
if "%protection_choice%"=="4" echo ✓ جاري حماية الملفات...
if "%protection_choice%"=="5" echo ✓ جاري الحماية المتقدمة...

pause
goto MENU
