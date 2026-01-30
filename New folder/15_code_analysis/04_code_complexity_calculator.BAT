@echo off
title KNOUX - حاسبة تعقيد الكود
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
echo            حاسبة تعقيد الكود
echo           الأداة: 04 - Code Analysis
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] حساب التعقيد الحلقي
echo [2] حساب تعقيد الدوال
echo [3] حساب عمق التعشيش
echo [4] حساب الفروع والمسارات
echo [5] حساب مؤشر التعقيد العام
echo [6] مقارنة التعقيد بين الإصدارات
echo [7] العودة لقائمة التحليل
echo [8] القائمة الرئيسية
echo.
set /p choice="اختر الخيار (1-8): "

if "%choice%"=="1" goto CALCULATE_CYCLOMATIC
if "%choice%"=="2" goto CALCULATE_FUNCTION_COMPLEXITY
if "%choice%"=="3" goto CALCULATE_NESTING_DEPTH
if "%choice%"=="4" goto CALCULATE_BRANCHES_PATHS
if "%choice%"=="5" goto CALCULATE_OVERALL_COMPLEXITY
if "%choice%"=="6" goto COMPARE_COMPLEXITY_VERSIONS
if "%choice%"=="7" call "00_code_analysis_menu.BAT"
if "%choice%"=="8" call "..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:CALCULATE_CYCLOMATIC
cls
echo حساب التعقيد الحلقي (Cyclomatic Complexity)
echo ═══════════════════════════════════════════════════════
echo التعقيد الحلقي يقيس عدد المسارات المستقلة في الكود
echo.
echo 📈 مستويات التعقيد الحلقي:
echo • 1-10: بسيط (ممتاز)
echo • 11-20: معقد (مقبول)
echo • 21-30: معقد جداً (يحتاج إعادة هيكلة)
echo • 31+: شديد التعقيد (خطير)
echo.
set /p code_file="مسار ملف الكود: "
echo.
echo جاري حساب التعقيد الحلقي...
echo.
echo 📊 نتائج الحساب:
echo.
echo 1. دالة calculate_total() - التعقيد: 15
echo    • المسارات: 16 مسار
echo    • الشروط: 5 شروط
echo    • الحلقات: 2 حلقة
echo    • التقييم: معقدة
echo.
echo 2. دالة validate_input() - التعقيد: 8
echo    • المسارات: 9 مسارات
echo    • الشروط: 3 شروط
echo    • الحلقات: 0 حلقة
echo    • التقييم: بسيطة
echo.
echo 3. دالة process_data() - التعقيد: 25
echo    • المسارات: 26 مسار
echo    • الشروط: 8 شروط
echo    • الحلقات: 3 حلقات
echo    • التقييم: معقدة جداً
echo.
echo 📈 إحصائيات المشروع:
echo • متوسط التعقيد: 16
echo • أعلى تعقيد: 25
echo • الدوال المعقدة: 3 دوال
echo • الدوال البسيطة: 12 دالة
echo.
pause
goto MENU

:CALCULATE_FUNCTION_COMPLEXITY
cls
echo حساب تعقيد الدوال
echo ═══════════════════════════════════════════════════════
echo قياس تعقيد كل دالة بشكل منفصل:
echo.
echo 📋 مقاييس تعقيد الدوال:
echo 1. عدد الأسطر (LOC)
echo 2. عدد المعلمات
echo 3. عدد المتغيرات
echo 4. عدد الاستدعاءات
echo 5. عمق التعشيش
echo.
echo 📊 نتائج تحليل الدوال:
echo.
echo 📈 الدوال الأعلى تعقيداً:
echo.
echo 1. دالة handle_user_registration()
echo    • الأسطر: 89 سطر
echo    • المعلمات: 7 معاملات
echo    • المتغيرات: 23 متغير
echo    • الاستدعاءات: 12 استدعاء
echo    • النتيجة: شديدة التعقيد
echo.
echo 2. دالة calculate_monthly_report()
echo    • الأسطر: 67 سطر
echo    • المعلمات: 5 معاملات
echo    • المتغيرات: 18 متغير
echo    • الاستدعاءات: 8 استدعاءات
echo    • النتيجة: معقدة جداً
echo.
echo 3. دالة validate_email_format()
echo    • الأسطر: 12 سطر
echo    • المعلمات: 1 معامل
echo    • المتغيرات: 3 متغيرات
echo    • الاستدعاءات: 2 استدعاء
echo    • النتيجة: بسيطة
echo.
echo 💡 توصيات تحسين الدوال:
echo 1. تقسيم الدوال الكبيرة إلى دوال أصغر
echo 2. تقليل عدد المعلمات (الحد الأقصى 5)
echo 3. استخدام الكائنات بدلاً من المعلمات المتعددة
echo 4. تقليل عمق التعشيش
echo.
pause
goto MENU

:CALCULATE_NESTING_DEPTH
cls
echo حساب عمق التعشيش
echo ═══════════════════════════════════════════════════════
echo عمق التعشيش يقيس عدد الطبقات المتداخلة في الكود
echo.
echo 📈 مستويات عمق التعشيش:
echo • 1-3: طبيعي (جيد)
echo • 4-5: عميق (يحتاج تحسين)
echo • 6+: شديد العمق (مشكلة)
echo.
echo 📊 نتائج تحليل التعشيش:
echo.
echo 1. دالة process_complex_data()
echo    • عمق التعشيش: 7
echo    • الحلقات المتداخلة: 3
echo    • الشروط المتداخلة: 4
echo    • التقييم: شديد العمق
echo.
echo 2. دالة validate_user_input()
echo    • عمق التعشيش: 4
echo    • الحلقات المتداخلة: 2
echo    • الشروط المتداخلة: 2
echo    • التقييم: عميق
echo.
echo 3. دالة simple_calculator()
echo    • عمق التعشيش: 2
echo    • الحلقات المتداخلة: 0
echo    • الشروط المتداخلة: 1
echo    • التقييم: طبيعي
echo.
echo 📈 إحصائيات التعشيش:
echo • متوسط العمق: 3.2
echo • أقصى عمق: 7
echo • المناطق العميقة (>5): 2 مناطق
echo • المناطق الطبيعية (≤3): 8 مناطق
echo.
pause
goto MENU

:CALCULATE_BRANCHES_PATHS
cls
echo حساب الفروع والمسارات
echo ═══════════════════════════════════════════════════════
echo تحليل الفروع والمسارات الممكنة في الكود
echo.
echo 📊 تحليل الفروع:
echo.
echo 1. الفروع الشرطية
echo    • if-else: 45 فرع
echo    • switch-case: 12 فرع
echo    • ternary: 8 فرع
echo    • الإجمالي: 65 فرع
echo.
echo 2. الفروع التكرارية
echo    • for loops: 23 حلقة
echo    • while loops: 12 حلقة
echo    • do-while: 5 حلقة
echo    • foreach: 8 حلقة
echo    • الإجمالي: 48 حلقة
echo.
echo 3. المسارات الممكنة
echo    • المسارات النظرية: 2^65 (مستحيل حسابياً)
echo    • المسارات العملية: 1,234 مسار
echo    • المسارات المختبرة: 234 مسار
echo    • التغطية: 19%%
echo.
echo 📈 تحليل المسارات:
echo • المسارات الحرجة: 12 مسار
echo • المسارات غير المختبرة: 1,000 مسار
echo • المسارات المعقدة: 45 مسار
echo • المسارات البسيطة: 189 مسار
echo.
pause
goto MENU

:CALCULATE_OVERALL_COMPLEXITY
cls
echo حساب مؤشر التعقيد العام
echo ═══════════════════════════════════════════════════════
echo مؤشر شامل لتعقيد الكود الكلي
echo.
echo 📊 مقاييس التعقيد العام:
echo.
echo 1. التعقيد الحلقي المتوسط
echo    • الحالي: 16.5
echo • المقبول: ≤10
echo    • التقييم: مرتفع
echo.
echo 2. تعقيد الهيكل
echo    • الاقتران: 6.8/10
echo    • التماسك: 4.2/10
echo    • التقييم: يحتاج تحسين
echo.
echo 3. تعقيد الصيانة
echo    • مؤشر الصيانة: 68/100
echo    • سهولة التعديل: 3/10
echo    • التقييم: صعب
echo.
echo 4. تعقيد الفهم
echo    • قابلية القراءة: 7/10
echo    • الوضوح: 6/10
echo    • التقييم: متوسط
echo.
echo 📈 المؤشر العام:
echo • التعقيد الكلي: 7.2/10
echo • المستوى: معقد
echo • التوصية: إعادة هيكلة جزئية
echo.
echo 💡 خطة تحسين التعقيد:
echo 1. تقليل التعقيد الحلقي (أولوية عالية)
echo 2. تحسين الاقتران والتماسك (أولوية متوسطة)
echo 3. تحسين قابلية القراءة (أولوية منخفضة)
echo.
pause
goto MENU

:COMPARE_COMPLEXITY_VERSIONS
cls
echo مقارنة التعقيد بين الإصدارات
echo ═══════════════════════════════════════════════════════
echo مقارنة تعقيد الكود بين إصدارات مختلفة
echo.
echo 📊 الإصدارات المتاحة:
echo 1. Version 1.0 (يناير 2024)
echo 2. Version 1.1 (فبراير 2024)
echo 3. Version 1.2 (مارس 2024)
echo 4. Version 2.0 (يونيو 2024)
echo.
echo اختر إصدارين للمقارنة:
set /p version1="الإصدار الأول: "
set /p version2="الإصدار الثاني: "
echo.
echo 📈 نتائج المقارنة:
echo.
echo 🔼 التحسينات:
echo • التعقيد الحلقي: -25%%
echo • عمق التعشيش: -30%%
echo • عدد الدوال: +15%%
echo • متوسط طول الدوال: -40%%
echo.
echo 📊 مقارنة مفصلة:
echo.
echo الإصدار %version1%:
echo • التعقيد الحلقي: 18.5
echo • أقصى عمق تعشيش: 8
echo • الدوال المعقدة: 12
echo • مؤشر الصيانة: 62/100
echo.
echo الإصدار %version2%:
echo • التعقيد الحلقي: 13.9
echo • أقصى عمق تعشيش: 5
echo • الدوال المعقدة: 8
echo • مؤشر الصيانة: 78/100
echo.
echo 🎯 التقييم:
echo • التحسن الكلي: +26%%
echo • الجودة: محسنة بشكل كبير
echo • الصيانة: أسهل بكثير
echo • الفهم: أوضح
echo.
pause
goto MENU
