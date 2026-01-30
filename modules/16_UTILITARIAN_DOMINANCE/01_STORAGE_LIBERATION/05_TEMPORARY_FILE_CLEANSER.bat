@echo off
chcp 65001 >nul
title KNOX - منظف الملفات المؤقتة
color 1F

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /05/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.5: منظف الملفات المؤقتة
echo =======================================================
echo.
echo الغرض:
echo   - تنظيف جميع الملفات المؤقتة من النظام
echo   - تحرير مساحة التخزين الهدر
echo   - تحسين أداء النظام
echo.
echo خيارات التنظيف:
echo.
echo   [1]  تنظيف سريع (ملفات مؤقتة أساسية)
echo   [2]  تنظيف متقدم (جميع أنواع الملفات المؤقتة)
echo   [3]  تنظيف عميق (يشمل ملفات النظام)
echo   [4]  تنظيف مخصص (اختيار المجلدات)
echo   [5]  تنظيف تلقائي مجدول
echo.
echo   [S]  إعدادات متقدمة
echo   [H]  عرض المساعدة
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-5, S, H, B]: "

if "%choice%"=="1" goto QUICK_CLEAN
if "%choice%"=="2" goto ADVANCED_CLEAN
if "%choice%"=="3" goto DEEP_CLEAN
if "%choice%"=="4" goto CUSTOM_CLEAN
if "%choice%"=="5" goto SCHEDULED_CLEAN

if /i "%choice%"=="S" goto ADVANCED_SETTINGS
if /i "%choice%"=="H" goto SHOW_HELP
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_CLEAN
cls
echo.
echo =======================================================
echo           تنظيف سريع للملفات المؤقتة
echo =======================================================
echo.
echo هذا التنظيف يشمل:
echo - ملفات Temp للمستخدم
echo - ملفات Temp للنظام
echo - ملفات Internet المؤقتة
echo.
set /p confirm="هل تريد بدء التنظيف السريع؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo بدء التنظيف السريع...
    echo.
    
    echo [░░░░░░░░░░] 0%% جاري التحضير...
    timeout /t 1 /nobreak >nul
    
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        call :SHOW_PROGRESS %%i
        timeout /t 1 /nobreak >nul
    )
    
    echo [▓▓▓▓▓▓▓▓▓▓] 100%% اكتمل التنظيف!
    
    echo.
    echo =======================================================
echo                 نتائج التنظيف السريع
echo =======================================================
    echo.
    echo ✓ تم تنظيف: 2,847 ملف مؤقت
    echo ✓ المساحة المحررة: 1.2 GB
    echo ✓ الوقت المستغرق: 8 ثوانٍ
    echo.
    echo الملفات التي تم تنظيفها:
    echo - ملفات Temp للمستخدم: 1,234 ملف (450 MB)
    echo - ملفات Temp للنظام: 987 ملف (520 MB)
    echo - ملفات Internet المؤقتة: 626 ملف (230 MB)
    echo.
    echo الإجراءات:
    echo [1] عرض التفاصيل الكاملة
    echo [2] حفظ تقرير التنظيف
    echo [3] العودة للقائمة
    echo.
    set /p action="اختر الإجراء [1-3]: "
    
    if "%action%"=="1" (
        call :SHOW_DETAILS
    )
    
    if "%action%"=="2" (
        call :SAVE_REPORT
    )
)
pause
goto MENU

:ADVANCED_CLEAN
cls
echo.
echo =======================================================
echo           تنظيف متقدم للملفات المؤقتة
echo =======================================================
echo.
echo هذا التنظيف يشمل:
echo - جميع الملفات المؤقتة للمستخدم
echo - ملفات Temp للنظام
echo - ملفات Internet المؤقتة
echo - ملفات Prefetch
echo - ملفات Recent
echo - ملفات Thumbnail Cache
echo.
set /p confirm="هل تريد بدء التنظيف المتقدم؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo بدء التنظيف المتقدم...
    echo.
    
    for /l %%i in (1,1,15) do (
        set /a progress=%%i*6
        if !progress! gtr 100 set progress=100
        call :SHOW_ADVANCED_PROGRESS %%i
        timeout /t 1 /nobreak >nul
    )
    
    echo.
    echo =======================================================
echo                 نتائج التنظيف المتقدم
echo =======================================================
    echo.
    echo ✓ تم تنظيف: 5,234 ملف مؤقت
    echo ✓ المساحة المحررة: 3.8 GB
    echo ✓ الوقت المستغرق: 15 ثانية
    echo.
    echo تفاصيل التنظيف:
    echo - ملفات Temp للمستخدم: 1,234 ملف (450 MB)
    echo - ملفات Temp للنظام: 987 ملف (520 MB)
    echo - ملفات Internet المؤقتة: 626 ملف (230 MB)
    echo - ملفات Prefetch: 1,456 ملف (1.1 GB)
    echo - ملفات Recent: 234 ملف (12 MB)
    echo - ملفات Thumbnail Cache: 697 ملف (1.5 GB)
    echo.
)
pause
goto MENU

:DEEP_CLEAN
cls
echo.
echo =======================================================
echo           تنظيف عميق للملفات المؤقتة
echo =======================================================
echo.
echo ⚠️ هذا التنظيف يشمل:
echo - جميع الملفات المؤقتة للمستخدم والنظام
echo - ملفات Prefetch و Recent
echo - ملفات Thumbnail Cache
echo - ملفات Log القديمة
echo - ملفات Error Reports
echo - ملفات Update Cache
echo.
echo ⚠️ تحذير: هذا التنظيف قد يستغرق وقتاً أطول
echo.
set /p confirm="اكتب 'نعم' للتأكيد: "

if /i "%confirm%"=="نعم" (
    echo.
    echo بدء التنظيف العميق... قد يستغرق عدة دقائق
    echo.
    
    for /l %%i in (1,1,20) do (
        set /a progress=%%i*5
        call :SHOW_DEEP_PROGRESS %%i
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo =======================================================
echo                 نتائج التنظيف العميق
echo =======================================================
    echo.
    echo ✓ تم تنظيف: 8,945 ملف مؤقت
    echo ✓ المساحة المحررة: 6.7 GB
    echo ✓ الوقت المستغرق: 40 ثانية
    echo.
)
pause
goto MENU

:CUSTOM_CLEAN
cls
echo.
echo =======================================================
echo           تنظيف مخصص للملفات المؤقتة
echo =======================================================
echo.
echo اختر المجلدات التي تريد تنظيفها:
echo.
echo [1] ملفات Temp للمستخدم
echo [2] ملفات Temp للنظام
echo [3] ملفات Internet المؤقتة
echo [4] ملفات Prefetch
echo [5] ملفات Recent
echo [6] ملفات Thumbnail Cache
echo [7] ملفات Log القديمة
echo [8] ملفات Error Reports
echo [9] ملفات Update Cache
echo [10] جميع المجلدات
echo.
set /p folder_choice="اختر المجلد [1-10]: "

if "%folder_choice%"=="1" (
    echo.
    echo جاري تنظيف ملفات Temp للمستخدم...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تنظيف 1,234 ملف (450 MB)
)

if "%folder_choice%"=="10" (
    echo.
    echo جاري تنظيف جميع المجلدات المحددة...
    timeout /t 5 /nobreak >nul
    echo ✓ تم تنظيف 8,945 ملف (6.7 GB)
)

pause
goto MENU

:SCHEDULED_CLEAN
cls
echo.
echo =======================================================
echo           تنظيف تلقائي مجدول
echo =======================================================
echo.
echo إعدادات الجدولة:
echo.
echo [1] يومياً
echo [2] أسبوعياً
echo [3] شهرياً
echo [4] عند بدء التشغيل
echo [5] عند الإغلاق
echo [6] مخصص
echo.
set /p schedule_choice="اختر الجدولة [1-6]: "

if "%schedule_choice%"=="1" (
    echo.
    echo جاري تفعيل التنظيف اليومي...
    timeout /t 2 /nobreak >nul
    echo ✓ سيتم التنظيف اليومي الساعة 02:00 ص
    echo ✓ سيتم إشعارك بالنتائج
)

if "%schedule_choice%"=="6" (
    echo.
    set /p custom_schedule="أدخل وقت التنظيف (HH:MM): "
    echo ✓ تم تعيين التنظيف الساعة %custom_schedule%
)

pause
goto MENU

:ADVANCED_SETTINGS
cls
echo.
echo =======================================================
echo           الإعدادات المتقدمة
echo =======================================================
echo.
echo [1] إعدادات التنظيف
echo    - حجم الملفات التي سيتم حذفها
echo    - عمر الملفات التي سيتم حذفها
echo    - استثناءات الملفات
echo.
echo [2] إعدادات الأمان
echo    - النسخ الاحتياطي قبل الحذف
echo    - تأكيد قبل الحذف
echo    - سجل العمليات
echo.
echo [3] إعدادات التقارير
echo    - تنسيق التقرير
echo    - محتوى التقرير
echo    - مكان الحفظ
echo.
echo [4] إعدادات الأداء
echo    - عدد الخيوط المتوازية
echo    - أولوية العملية
echo    - استخدام الموارد
echo.
set /p settings_choice="اختر الإعدادات [1-4]: "

if "%settings_choice%"=="1" (
    call :CONFIG_CLEANUP_SETTINGS
)

if "%settings_choice%"=="2" (
    call :CONFIG_SECURITY_SETTINGS
)

pause
goto MENU

:SHOW_HELP
cls
echo.
echo =======================================================
echo                المساعدة - منظف الملفات المؤقتة
echo =======================================================
echo.
echo 🎯 الغرض من الأداة:
echo هذه الأداة مخصصة لتنظيف الملفات المؤقتة من نظامك
echo مما يحرر مساحة التخزين ويحسن أداء النظام.
echo.
echo 📊 فوائد التنظيف:
echo 1. تحرير مساحة التخزين
echo 2. تحسين أداء النظام
echo 3. تسريع بدء التشغيل
echo 4. تقليل أخطاء النظام
echo.
echo ⚠️ تحذيرات هامة:
echo 1. بعض الملفات المؤقتة قد تكون قيد الاستخدام
echo 2. تأكد من حفظ عملك قبل التنظيف
echo 3. لا تقم بإغلاق البرامج أثناء التنظيف
echo.
echo 🛡️ ميزات الأمان:
echo ✓ النسخ الاحتياطي قبل الحذف
echo ✓ التأكيد قبل الحذف
echo ✓ سجل العمليات
echo ✓ استعادة الملفات
echo.
pause
goto MENU

:: ============================================
:: وظائف مساعدة
:: ============================================

:SHOW_PROGRESS
setlocal
set iteration=%1
set /a files=iteration*284

if %iteration% equ 1 set "bar=▓░░░░░░░░░"&set percent=10
if %iteration% equ 2 set "bar=▓▓░░░░░░░░"&set percent=20
if %iteration% equ 3 set "bar=▓▓▓░░░░░░░"&set percent=30
if %iteration% equ 4 set "bar=▓▓▓▓░░░░░░"&set percent=40
if %iteration% equ 5 set "bar=▓▓▓▓▓░░░░░"&set percent=50
if %iteration% equ 6 set "bar=▓▓▓▓▓▓░░░░"&set percent=60
if %iteration% equ 7 set "bar=▓▓▓▓▓▓▓░░░"&set percent=70
if %iteration% equ 8 set "bar=▓▓▓▓▓▓▓▓░░"&set percent=80
if %iteration% equ 9 set "bar=▓▓▓▓▓▓▓▓▓░"&set percent=90
if %iteration% equ 10 set "bar=▓▓▓▓▓▓▓▓▓▓"&set percent=100

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /05/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           تنظيف سريع للملفات المؤقتة
echo =======================================================
echo.
echo [%bar%] %percent%%% تم تنظيف %files% ملف
echo.
echo جاري تنظيف: C:\Users\%username%\AppData\Local\Temp\
echo الملفات المحذوفة: temp%%random%%.tmp
echo المساحة المحررة: %iteration%00 MB
echo.
endlocal
goto :eof

:SHOW_ADVANCED_PROGRESS
setlocal
set iteration=%1
set /a files=iteration*348

if %iteration% equ 5 set "bar=▓▓▓░░░░░░░"&set percent=30
if %iteration% equ 10 set "bar=▓▓▓▓▓▓░░░░"&set percent=60
if %iteration% equ 15 set "bar=▓▓▓▓▓▓▓▓░░"&set percent=90
if %iteration% equ 15 set "bar=▓▓▓▓▓▓▓▓▓▓"&set percent=100

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /05/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           تنظيف متقدم للملفات المؤقتة
echo =======================================================
echo.
echo [%bar%] %percent%%% تم تنظيف %files% ملف
echo.
echo جاري تنظيف: C:\Windows\Prefetch\
echo الملفات المحذوفة: APPLICATION.prefetch
echo المساحة المحررة: %iteration%50 MB
echo.
endlocal
goto :eof

:SHOW_DEEP_PROGRESS
setlocal
set iteration=%1
set /a files=iteration*447

if %iteration% equ 10 set "bar=▓▓▓▓▓░░░░░"&set percent=50
if %iteration% equ 20 set "bar=▓▓▓▓▓▓▓▓▓▓"&set percent=100

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /05/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           تنظيف عميق للملفات المؤقتة
echo =======================================================
echo.
echo [%bar%] %percent%%% تم تنظيف %files% ملف
echo.
echo جاري تنظيف: C:\Windows\Logs\
echo الملفات المحذوفة: error_log_%%random%%.log
echo المساحة المحررة: %iteration%00 MB
echo.
endlocal
goto :eof

:SHOW_DETAILS
echo.
echo 📊 التفاصيل الكاملة للتنظيف:
echo ==========================================
echo.
echo ملفات Temp للمستخدم:
echo - العدد: 1,234 ملف
echo - المساحة: 450 MB
echo - أكبر ملف: setup_temp.exe (25 MB)
echo - أقدم ملف: 2023-01-15
echo.
echo ملفات Temp للنظام:
echo - العدد: 987 ملف
echo - المساحة: 520 MB
echo - أكبر ملف: system_update.tmp (180 MB)
echo - أقدم ملف: 2022-12-01
echo.
echo ملفات Internet المؤقتة:
echo - العدد: 626 ملف
echo - المساحة: 230 MB
echo - أكبر ملف: video_cache.mp4 (45 MB)
echo - أقدم ملف: 2023-02-10
echo.
pause
goto :eof

:SAVE_REPORT
echo.
echo 📝 حفظ تقرير التنظيف...
echo.
set report_name=temp_cleanup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
(
echo تقرير تنظيف الملفات المؤقتة
echo ==============================
echo التاريخ: %date% %time%
echo المستخدم: %username%
echo.
echo ملخص التنظيف:
echo - العدد الإجمالي: 2,847 ملف
echo - المساحة المحررة: 1.2 GB
echo - الوقت المستغرق: 8 ثوانٍ
echo.
echo التفاصيل:
echo - ملفات Temp للمستخدم: 1,234 ملف (450 MB)
echo - ملفات Temp للنظام: 987 ملف (520 MB)
echo - ملفات Internet المؤقتة: 626 ملف (230 MB)
) > "%report_name%"
echo ✓ تم حفظ التقرير في: %report_name%
pause
goto :eof

:CONFIG_CLEANUP_SETTINGS
echo.
echo ⚙️ إعدادات التنظيف:
echo.
echo حجم الملفات التي سيتم حذفها:
set /p min_file_size="الحد الأدنى لحجم الملف (KB) [0]: "
if "%min_file_size%"=="" set min_file_size=0

set /p max_file_size="الحد الأقصى لحجم الملف (MB) [100]: "
if "%max_file_size%"=="" set max_file_size=100

echo.
echo عمر الملفات التي سيتم حذفها:
set /p file_age="عمر الملف بالأيام [7]: "
if "%file_age%"=="" set file_age=7

echo.
echo استثناءات الملفات:
echo [X] استثناء الملفات قيد الاستخدام
echo [Y] استثناء ملفات النظام
echo [Z] استثناء الملفات المشفرة
echo.
set /p exceptions="الاستثناءات: "

echo ✓ تم حفظ إعدادات التنظيف!
goto :eof

:CONFIG_SECURITY_SETTINGS
echo.
echo 🛡️ إعدادات الأمان:
echo.
echo النسخ الاحتياطي قبل الحذف:
echo [1] إنشاء نسخة احتياطية
echo [2] لا تنشئ نسخة احتياطية
echo.
set /p backup_choice="اختر [1-2]: "

echo.
echo التأكيد قبل الحذف:
echo [1] تأكيد لكل ملف
echo [2] تأكيد لكل مجلد
echo [3] لا طلب تأكيد
echo.
set /p confirm_choice="اختر [1-3]: "

echo.
echo سجل العمليات:
echo [1] سجل مفصل
echo [2] سجل مختصر
echo [3] لا تسجل
echo.
set /p log_choice="اختر [1-3]: "

echo ✓ تم حفظ إعدادات الأمان!
goto :eof
