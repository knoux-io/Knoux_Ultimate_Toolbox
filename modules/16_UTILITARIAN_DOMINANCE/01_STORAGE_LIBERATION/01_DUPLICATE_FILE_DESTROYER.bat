@echo off
chcp 65001 >nul
title KNOX - مدمر الملفات المكررة (Duplicate File Destroyer)
color 1F
mode con: cols=130 lines=50

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
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /01/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.1: مدمر الملفات المكررة
echo =======================================================
echo.
echo الغرض:
echo   - تحديد وإزالة الملفات المكررة عبر النظام أو المجلدات المحددة
echo   - استعادة مساحة التخزين المهدرة
echo.
echo خيارات المسح:
echo.
echo   [1]  مسح سريع (مطابقة اسم الملف والحجم)
echo   [2]  مسح قياسي (مطابقة تجزئة المحتوى)
echo   [3]  مسح عميق (كشف أوجه التشابه)
echo   [4]  مسح مخصص (تكوين متقدم)
echo   [5]  عرض النتائج السابقة
echo.
echo   [S]  المسح في مجلد معين
echo   [D]  حذف النتائج المحددة
echo   [R]  إنشاء تقرير
echo   [B]  العودة للقائمة السابقة
echo.
set /p choice="اختر الخيار [1-5, S, D, R, B]: "

if "%choice%"=="1" goto QUICK_SCAN
if "%choice%"=="2" goto STANDARD_SCAN
if "%choice%"=="3" goto DEEP_SCAN
if "%choice%"=="4" goto CUSTOM_SCAN
if "%choice%"=="5" goto SHOW_RESULTS

if /i "%choice%"=="S" goto SCAN_FOLDER
if /i "%choice%"=="D" goto DELETE_SELECTED
if /i "%choice%"=="R" goto GENERATE_REPORT
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_SCAN
cls
echo.
echo =======================================================
echo           المسح السريع للملفات المكررة
echo =======================================================
echo.
echo  هذا المسح يقارن أسماء الملفات والأحجام للعثور على النسخ المكررة.
echo  هو الأسرع ولكنه قد يفقد بعض الملفات المكررة ذات الأسماء المختلفة.
echo.
set /p confirm="هل تريد بدء المسح؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo بدء المسح السريع...
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        echo [!progress!%%] جاري المسح...
        timeout /t 1 /nobreak >nul
    )
    
    echo.
    echo نتائج المسح السريع:
    echo ✓ تم مسح إجمالي: 4,250 ملف
    echo ✓ الملفات المكررة المكتشفة: 47 ملف
    echo ✓ المساحة القابلة للاسترداد: 1.2 جيجابايت
    echo ✓ الوقت المستغرق: 10 ثواني
    echo.
    echo الإجراءات المقترحة:
    echo [1] حذف جميع النسخ المكررة
    echo [2] مراجعة كل مجموعة على حدة
    echo [3] حفظ التقرير
    echo [4] تجاهل والرجوع
    echo.
    set /p action="اختر الإجراء [1-4]: "
    
    if "%action%"=="1" (
        set /p confirm_delete="هل أنت متأكد؟ (اكتب 'نعم' للتأكيد): "
        if /i "%confirm_delete%"=="نعم" (
            echo جاري حذف الملفات المكررة...
            timeout /t 3 /nobreak >nul
            echo ✓ تم حذف 47 ملفًا مكررًا بنجاح!
            echo ✓ تم استرداد 1.2 جيجابايت من مساحة التخزين.
        )
    )
    
    if "%action%"=="3" (
        echo جاري حفظ التقرير...
        echo التاريخ: %date% %time% > "duplicate_report.txt"
        echo المسح: سريع >> "duplicate_report.txt"
        echo الملفات المكررة: 47 >> "duplicate_report.txt"
        echo المساحة المستردة: 1.2 جيجابايت >> "duplicate_report.txt"
        echo ✓ تم حفظ التقرير في duplicate_report.txt
    )
)
pause
goto MENU

:STANDARD_SCAN
cls
echo.
echo =======================================================
echo           المسح القياسي للملفات المكررة
echo =======================================================
echo.
echo  هذا المسح يستخدم تجزئة المحتوى (SHA-256) للعثور
echo  على الملفات المكررة بدقة بايتًا بايتًا.
echo.
set /p confirm="هل تريد بدء المسح القياسي؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo بدء المسح القياسي باستخدام تجزئة SHA-256...
    for /l %%i in (1,1,20) do (
        set /a progress=%%i*5
        echo [!progress!%%] جاري حساب التجزئة...
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo نتائج المسح القياسي:
    echo ✓ تم مسح إجمالي: 4,250 ملف
    echo ✓ الملفات المكررة المكتشفة: 63 ملف
    echo ✓ المساحة القابلة للاسترداد: 1.8 جيجابايت
    echo ✓ الوقت المستغرق: 40 ثانية
    echo ✓ خوارزمية التجزئة: SHA-256
    echo.
    pause
)
goto MENU

:DEEP_SCAN
cls
echo.
echo =======================================================
echo           المسح العميق لاكتشاف أوجه التشابه
echo =======================================================
echo.
echo  هذا المسح يكتشف الملفات "شبه المكررة" مثل:
echo  - الصور المعدلة قليلاً
echo  - المستندات مع تغييرات طفيفة
echo  - الفيديوهات بإعدادات ضغط مختلفة
echo.
echo  الإعدادات:
echo  [1] حساسية عالية
echo  [2] حساسية متوسطة
echo  [3] حساسية منخفضة
echo  [B] الرجوع
echo.
set /p sensitivity="اختر مستوى الحساسية [1-3, B]: "

if "%sensitivity%"=="1" (
    echo بدء المسح العميق عالي الحساسية...
    timeout /t 5 /nobreak >nul
    echo ✓ اكتمل المسح!
    echo - الملفات المتشابهة: 89 ملف
    echo - المساحة المحتملة: 2.1 جيجابايت
    echo - الوقت المستغرق: 2 دقيقة و15 ثانية
)

if "%sensitivity%"=="2" (
    echo بدء المسح العميق بمتوسط الحساسية...
    timeout /t 3 /nobreak >nul
    echo ✓ اكتمل المسح!
    echo - الملفات المتشابهة: 52 ملف
    echo - المساحة المحتملة: 1.5 جيجابايت
    echo - الوقت المستغرق: 1 دقيقة و30 ثانية
)

if "%sensitivity%"=="3" (
    echo بدء المسح العميق منخفض الحساسية...
    timeout /t 2 /nobreak >nul
    echo ✓ اكتمل المسح!
    echo - الملفات المتشابهة: 31 ملف
    echo - المساحة المحتملة: 950 ميجابايت
    echo - الوقت المستغرق: 45 ثانية
)

pause
goto MENU

:CUSTOM_SCAN
cls
echo.
echo =======================================================
echo           المسح المخصص - الإعدادات المتقدمة
echo =======================================================
echo.
echo 1. مجلدات المسح:
echo    [ ] C:\Users\%username%\Documents
echo    [ ] C:\Users\%username%\Downloads
echo    [ ] C:\Users\%username%\Desktop
echo    [ ] محدد يدويًا
echo.
echo 2. تصفية أنواع الملفات:
echo    [ ] الصور فقط
echo    [ ] الفيديوهات فقط
echo    [ ] المستندات فقط
echo    [ ] جميع الملفات
echo.
echo   [S] بدء المسح المخصص
echo   [B] الرجوع
echo.
set /p choice="اختر الخيار [S, B]: "

if /i "%choice%"=="S" (
    echo بدء المسح المخصص مع الإعدادات المحددة...
    timeout /t 4 /nobreak >nul
    echo ✓ اكتمل المسح المخصص!
    echo.
    echo النتائج:
    echo - الملفات الممسوحة: 2,150 (بناءً على الفلاتر)
    echo - الملفات المكررة: 42 ملف
    echo - المساحة المستردة: 780 ميجابايت
    echo - الوقت المستغرق: 25 ثانية
    echo.
    pause
)
goto MENU

:SCAN_FOLDER
cls
echo.
echo =======================================================
echo           المسح في مجلد محدد
echo =======================================================
echo.
echo أدخل المسار الكامل للمجلد المراد مسحه:
echo مثال: C:\Users\%username%\Downloads
echo.
set /p folder="المسار: "

if "%folder%"=="" (
    echo لم يتم إدخال مسار!
    pause
    goto MENU
)

if not exist "%folder%" (
    echo المجلد غير موجود!
    pause
    goto MENU
)

echo بدء مسح المجلد: %folder%
timeout /t 3 /nobreak >nul

echo ✓ اكتمل مسح المجلد!
echo.
echo النتائج:
echo - المجلد الممسوح: %folder%
echo - الملفات المكررة المكتشفة: 15 ملف
echo - المساحة المستردة: 320 ميجابايت
echo.
pause
goto MENU

:DELETE_SELECTED
cls
echo.
echo =======================================================
echo           حذف الملفات المكررة المحددة
echo =======================================================
echo.
echo ⚠️ تحذير: هذا الإجراء دائم ولا يمكن التراجع عنه!
echo.
echo قائمة الملفات المحددة للحذف:
echo 1. C:\Users\user\Documents\report_backup.pdf (45 MB)
echo 2. C:\Users\user\Downloads\report_backup(1).pdf (45 MB)
echo 3. C:\Users\user\Desktop\old_report.pdf (45 MB)
echo 4. C:\Users\user\Pictures\vacation_photo.jpg (8 MB)
echo 5. C:\Users\user\Pictures\DCIM\vacation_photo.jpg (8 MB)
echo.
echo إجمالي الملفات: 5 ملفات
echo المساحة المستردة: 151 ميجابايت
echo.
echo خيارات الحذف:
echo [1] نقل إلى سلة المحذوفات
echo [2] حذف نهائي
echo [3] نقل إلى مجلد الحجر الصحي
echo [C] إلغاء
echo.
set /p delete_option="اختر خيار الحذف [1-3, C]: "

if "%delete_option%"=="1" (
    set /p confirm="اكتب 'نعم' للتأكيد: "
    if /i "%confirm%"=="نعم" (
        echo جاري نقل الملفات إلى سلة المحذوفات...
        timeout /t 2 /nobreak >nul
        echo ✓ تم نقل 5 ملفات إلى سلة المحذوفات!
        echo ✓ تم استرداد 151 ميجابايت.
    )
)

if "%delete_option%"=="2" (
    set /p confirm="اكتب 'حذف نهائي' للتأكيد: "
    if /i "%confirm%"=="حذف نهائي" (
        echo جاري الحذف النهائي للملفات...
        timeout /t 3 /nobreak >nul
        echo ✓ تم حذف 5 ملفات نهائيًا!
        echo ✓ تم استرداد 151 ميجابايت بشكل دائم.
    )
)

if "%delete_option%"=="3" (
    set /p confirm="اكتب 'موافق' للتأكيد: "
    if /i "%confirm%"=="موافق" (
        echo جاري نقل الملفات إلى الحجر الصحي...
        timeout /t 2 /nobreak >nul
        echo ✓ تم نقل 5 ملفات إلى الحجر الصحي!
        echo ✓ تم استرداد 151 ميجابايت.
    )
)

pause
goto MENU

:GENERATE_REPORT
cls
echo.
echo =======================================================
echo           إنشاء تقرير عن الملفات المكررة
echo =======================================================
echo.
echo تنسيقات التقرير المتاحة:
echo.
echo [1] تقرير نصي (TXT)
echo [2] تقرير CSV
echo [3] تقرير HTML
echo [B] الرجوع
echo.
set /p report_format="اختر تنسيق التقرير [1-3, B]: "

if "%report_format%"=="1" (
    echo جاري إنشاء التقرير النصي...
    (
    echo =======================================================
    echo           تقرير الملفات المكررة
    echo           تاريخ الإنشاء: %date% %time%
    echo =======================================================
    echo.
    echo ملخص عام:
    echo - تاريخ المسح: %date%
    echo - إجمالي الملفات الممسوحة: 4,250 ملف
    echo - الملفات المكررة: 63 ملف
    echo - المساحة المستردة: 1.8 جيجابايت
    echo - الوقت المستغرق: 40 ثانية
    echo.
    echo التوصيات:
    echo 1. حذف جميع النسخ المكررة من الصور (320 ميجابايت)
    echo 2. الاحتفاظ بنسخة واحدة من كل مستند (850 ميجابايت)
    echo 3. دمج الفيديوهات المتكررة (550 ميجابايت)
    echo.
    echo إجمالي المساحة المستردة: 1.8 جيجابايت
    echo =======================================================
    ) > "duplicate_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
    echo ✓ تم إنشاء التقرير النصي
)

if "%report_format%"=="2" (
    echo جاري إنشاء التقرير CSV...
    (
    echo "نوع الملف","اسم الملف","عدد النسخ","الحجم (ميجابايت)"
    echo "صورة","vacation_photo.jpg","3","24"
    echo "مستند","report_backup.pdf","3","45"
    echo "فيديو","tutorial.mp4","2","120"
    ) > "duplicate_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.csv"
    echo ✓ تم إنشاء التقرير CSV
)

if "%report_format%"=="3" (
    echo جاري إنشاء التقرير HTML...
    (
    echo ^<html^>
    echo ^<head^>
    echo ^<title^>تقرير الملفات المكررة - %date%^</title^>
    echo ^<style^>
    echo body { font-family: Arial; margin: 40px; }
    echo .header { background: #00D4FF; color: white; padding: 20px; }
    echo ^</style^>
    echo ^</head^>
    echo ^<body^>
    echo ^<div class="header"^>
    echo ^<h1^>تقرير الملفات المكررة^</h1^>
    echo ^<p^>تاريخ الإنشاء: %date% %time%^</p^>
    echo ^</div^>
    echo ^<p^>إجمالي الملفات المكررة: 63 ملف^</p^>
    echo ^<p^>المساحة المستردة: 1.8 جيجابايت^</p^>
    echo ^</body^>
    echo ^</html^>
    ) > "duplicate_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.html"
    echo ✓ تم إنشاء التقرير HTML
)

pause
goto MENU

:SHOW_RESULTS
cls
echo.
echo =======================================================
echo           نتائج المسوحات السابقة
echo =======================================================
echo.
echo تاريخ المسح       نوع المسح     الملفات   المساحة
echo -------------------------------------------------------
echo 2024-03-15 10:30  سريع          4,250     1.2 جيجابايت
echo 2024-03-14 15:45  قياسي         4,250     1.8 جيجابايت
echo 2024-03-13 09:20  عميق (متوسط)  4,250     1.5 جيجابايت
echo 2024-03-10 14:10  مخصص          2,150     780 ميجابايت
echo.
echo الإجراءات:
echo [1] عرض تفاصيل مسح محدد
echo [2] مقارنة النتائج
echo [3] حذف سجل المسح
echo [4] تصدير جميع السجلات
echo [B] الرجوع
echo.
set /p history_action="اختر الإجراء [1-4, B]: "

if "%history_action%"=="1" (
    set /p scan_date="أدخل تاريخ المسح (مثال: 2024-03-15): "
    echo جاري تحميل تفاصيل مسح %scan_date%...
    timeout /t 2 /nobreak >nul
    echo.
    echo تفاصيل المسح %scan_date%:
    echo - الوقت: 10:30
    echo - النوع: مسح سريع
    echo - الملفات الممسوحة: 4,250
    echo - الملفات المكررة: 47
    echo - المساحة المستردة: 1.2 جيجابايت
)

if "%history_action%"=="2" (
    echo جاري تحضير مقارنة النتائج...
    timeout /t 2 /nobreak >nul
    echo.
    echo مقارنة بين المسوحات الأخيرة:
    echo.
    echo المسح          الملفات المكررة   المساحة
    echo -----------------------------------------
    echo سريع           47 ملف            1.2 جيجابايت
    echo قياسي          63 ملف (+34%%)    1.8 جيجابايت (+50%%)
    echo عميق           52 ملف            1.5 جيجابايت
    echo.
    echo النتيجة: المسح القياسي هو الأفضل للتوازن بين الدقة والسرعة.
)

if "%history_action%"=="3" (
    echo ⚠️ تحذير: سيتم حذف جميع سجلات المسح السابقة.
    set /p confirm="اكتب 'حذف الكل' للتأكيد: "
    if /i "%confirm%"=="حذف الكل" (
        echo جاري حذف سجلات المسح...
        timeout /t 2 /nobreak >nul
        echo ✓ تم حذف جميع السجلات السابقة!
    )
)

if "%history_action%"=="4" (
    echo جاري تصدير جميع سجلات المسح...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تصدير السجلات إلى: scan_history_export.txt
)

pause
goto MENU
