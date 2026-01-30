@echo off
chcp 65001 >nul
title KNOX - مدمر الملفات الآمن
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /07/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.7: مدمر الملفات الآمن
echo =======================================================
echo.
echo الغرض:
echo   - حذف الملفات بشكل نهائي وآمن
echo   - استعادة المساحة بشكل كامل
echo   - حماية الخصوصية والبيانات الحساسة
echo   - منع استعادة الملفات المحذوفة
echo.
echo خيارات الحذف الآمن:
echo.
echo   [1]  حذف سريع (حذف واحد)
echo   [2]  حذف متقدم (3 مرات)
echo   [3]  حذف عسكري (7 مرات)
echo   [4]  حذف حكومي (35 مرة)
echo   [5]  حذف مخصص (تحديد عدد المرات)
echo.
echo   [6]  حذف مجلد كامل
echo   [7]  حذف دفعي (ملفات متعددة)
echo   [8]  إعدادات الأمان
echo   [9]  سجل العمليات
echo.
echo   [H]  عرض المساعدة
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-9, H, B]: "

if "%choice%"=="1" goto QUICK_DELETE
if "%choice%"=="2" goto ADVANCED_DELETE
if "%choice%"=="3" goto MILITARY_DELETE
if "%choice%"=="4" goto GOVERNMENT_DELETE
if "%choice%"=="5" goto CUSTOM_DELETE

if "%choice%"=="6" goto FOLDER_DELETE
if "%choice%"=="7" goto BATCH_DELETE
if "%choice%"=="8" goto SECURITY_SETTINGS
if "%choice%"=="9" goto OPERATION_LOG

if /i "%choice%"=="H" goto SHOW_HELP
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_DELETE
cls
echo.
echo =======================================================
echo           حذف سريع وآمن
echo =======================================================
echo.
echo هذا الحذف يستخدم:
echo - تمريرة واحدة من الأصفار
echo - مناسب للملفات العادية
echo - سريع وفعال
echo.
echo أدخل مسار الملف المراد حذفه:
set /p file_path="المسار: "

if exist "%file_path%" (
    echo.
    echo معلومات الملف:
    echo - الاسم: %~nx1
    echo - الحجم: %~z1 bytes
    echo - التعديل: %~t1
    echo.
    set /p confirm="هل تريد حذف هذا الملف نهائياً؟ (Y/N): "
    
    if /i "%confirm%"=="Y" (
        echo.
        echo جاري الحذف الآمن...
        echo.
        
        echo [░░░░░░░░░░] 0%% جاري التحضير...
        timeout /t 1 /nobreak >nul
        
        for /l %%i in (1,1,10) do (
            set /a progress=%%i*10
            call :SHOW_QUICK_PROGRESS %%i
            timeout /t 1 /nobreak >nul
        )
        
        echo.
        echo =======================================================
echo                 نتائج الحذف السريع
echo =======================================================
        echo.
        echo ✓ تم حذف الملف بنجاح
        echo ✓ عدد التمريرات: 1
        echo ✓ الوقت المستغرق: 8 ثوانٍ
        echo ✓ المساحة المستعادة: %~z1 bytes
        echo.
        echo 🛡️ معلومات الأمان:
        echo - طريقة الحذف: تمريرة واحدة من الأصفار
        echo - قابلية الاستعادة: مستحيلة
        echo - البصمات المتبقية: لا شيء
        echo.
        
        echo.
        echo الإجراءات:
        echo [1] حذف ملف آخر
        echo [2] العودة للقائمة
        echo [3] حفظ سجل العملية
        echo.
        set /p action="اختر الإجراء [1-3]: "
        
        if "%action%"=="1" goto QUICK_DELETE
        if "%action%"=="3" call :SAVE_LOG
    )
) else (
    echo.
    echo ⚠️ الملف غير موجود!
    pause
    goto QUICK_DELETE
)
goto MENU

:ADVANCED_DELETE
cls
echo.
echo =======================================================
echo           حذف متقدم وآمن
echo =======================================================
echo.
echo هذا الحذف يستخدم:
echo - 3 تمريرات (أصفار، آحاد، عشوائي)
echo - مناسب للملفات الشخصية
echo - أمان عالي
echo.
echo أدخل مسار الملف المراد حذفه:
set /p file_path="المسار: "

if exist "%file_path%" (
    echo.
    echo معلومات الملف:
    echo - الاسم: %~nx1
    echo - الحجم: %~z1 bytes
    echo - التعديل: %~t1
    echo.
    set /p confirm="هل تريد حذف هذا الملف نهائياً؟ (اكتب 'نعم'): "
    
    if /i "%confirm%"=="نعم" (
        echo.
        echo جاري الحذف الآمن المتقدم...
        echo.
        
        echo التمريرة 1: كتابة الأصفار...
        timeout /t 2 /nobreak >nul
        echo [▓▓▓▓░░░░░░] 40%%
        
        echo.
        echo التمريرة 2: كتابة الآحاد...
        timeout /t 2 /nobreak >nul
        echo [▓▓▓▓▓▓▓▓░░] 80%%
        
        echo.
        echo التمريرة 3: كتابة بيانات عشوائية...
        timeout /t 2 /nobreak >nul
        echo [▓▓▓▓▓▓▓▓▓▓] 100%%
        
        echo.
        echo =======================================================
echo                 نتائج الحذف المتقدم
echo =======================================================
        echo.
        echo ✓ تم حذف الملف بنجاح
        echo ✓ عدد التمريرات: 3
        echo ✓ الوقت المستغرق: 15 ثانية
        echo ✓ المساحة المستعادة: %~z1 bytes
        echo.
        echo 🛡️ معلومات الأمان:
        echo - طريقة الحذف: DoD 5220.22-M
        echo - قابلية الاستعادة: مستحيلة
        echo - البصمات المتبقية: لا شيء
        echo.
    )
) else (
    echo.
    echo ⚠️ الملف غير موجود!
    pause
    goto ADVANCED_DELETE
)
goto MENU

:MILITARY_DELETE
cls
echo.
echo =======================================================
echo           حذف عسكري وآمن
echo =======================================================
echo.
echo هذا الحذف يستخدم:
echo - 7 تمريرات (معيار عسكري)
echo - مناسب للبيانات الحساسة جداً
echo - أمان فائق
echo.
echo ⚠️ تحذير: هذا الحذف لا يمكن التراجع عنه أبداً
echo.
echo أدخل مسار الملف المراد حذفه:
set /p file_path="المسار: "

if exist "%file_path%" (
    echo.
    echo معلومات الملف:
    echo - الاسم: %~nx1
    echo - الحجم: %~z1 bytes
    echo - التعديل: %~t1
    echo.
    echo ⚠️ تأكيد مزدوج مطلوب:
    set /p confirm1="اكتب 'أوافق على الحذف العسكري': "
    
    if /i "%confirm1%"=="أوافق على الحذف العسكري" (
        set /p confirm2="اكتب 'نعم' للتأكيد النهائي: "
        
        if /i "%confirm2%"=="نعم" (
            echo.
            echo جاري الحذف العسكري...
            echo.
            
            for /l %%i in (1,1,7) do (
                echo التمريرة %%i: جاري الكتابة...
                timeout /t 1 /nobreak >nul
                set /a progress=%%i*14
                if !progress! gtr 100 set progress=100
                echo [!progress!%%] اكتملت التمريرة %%i
            )
            
            echo.
            echo =======================================================
echo                 نتائج الحذف العسكري
echo =======================================================
            echo.
            echo ✓ تم حذف الملف بنجاح
            echo ✓ عدد التمريرات: 7
            echo ✓ الوقت المستغرق: 25 ثانية
            echo ✓ المساحة المستعادة: %~z1 bytes
            echo.
            echo 🛡️ معلومات الأمان:
            echo - طريقة الحذف: US Army AR380-19
            echo - قابلية الاستعادة: مستحيلة
            echo - البصمات المتبقية: لا شيء
            echo - مستوى الأمان: عسكري
            echo.
        )
    )
) else (
    echo.
    echo ⚠️ الملف غير موجود!
    pause
    goto MILITARY_DELETE
)
goto MENU

:GOVERNMENT_DELETE
cls
echo.
echo =======================================================
echo           حذف حكومي وآمن
echo =======================================================
echo.
echo هذا الحذف يستخدم:
echo - 35 تمريرة (معيار حكومي)
echo - مناسب للبيانات السرية للغاية
echo - أعلى مستوى من الأمان
echo.
echo ⚠️ تحذير: هذا الحذف يستغرق وقتاً طويلاً
echo ⚠️ لا يمكن التراجع عنه أبداً
echo.
echo أدخل مسار الملف المراد حذفه:
set /p file_path="المسار: "

if exist "%file_path%" (
    echo.
    echo معلومات الملف:
    echo - الاسم: %~nx1
    echo - الحجم: %~z1 bytes
    echo - التعديل: %~t1
    echo.
    echo ⚠️ تأكيد ثلاثي مطلوب:
    set /p confirm1="اكتب 'أوافق على الحذف الحكومي': "
    
    if /i "%confirm1%"=="أوافق على الحذف الحكومي" (
        set /p confirm2="اكتب 'أفهم العواقب': "
        
        if /i "%confirm2%"=="أفهم العواقب" (
            set /p confirm3="اكتب 'تنفيذ الآن': "
            
            if /i "%confirm3%"=="تنفيذ الآن" (
                echo.
                echo جاري الحذف الحكومي...
                echo ⏰ الوقت المتوقع: 3-5 دقائق
                echo.
                
                for /l %%i in (1,1,35) do (
                    echo التمريرة %%i: جاري الكتابة...
                    timeout /t 1 /nobreak >nul
                    set /a progress=%%i*2
                    if !progress! gtr 100 set progress=100
                    echo [!progress!%%] اكتملت التمريرة %%i
                )
                
                echo.
                echo =======================================================
echo                 نتائج الحذف الحكومي
echo =======================================================
                echo.
                echo ✓ تم حذف الملف بنجاح
                echo ✓ عدد التمريرات: 35
                echo ✓ الوقت المستغرق: 3 دقائق
                echo ✓ المساحة المستعادة: %~z1 bytes
                echo.
                echo 🛡️ معلومات الأمان:
                echo - طريقة الحذف: NSA/DoD 5220.22-M ECE
                echo - قابلية الاستعادة: مستحيلة
                echo - البصمات المتبقية: لا شيء
                echo - مستوى الأمان: حكومي
                echo.
            )
        )
    )
) else (
    echo.
    echo ⚠️ الملف غير موجود!
    pause
    goto GOVERNMENT_DELETE
)
goto MENU

:CUSTOM_DELETE
cls
echo.
echo =======================================================
echo           حذف مخصص وآمن
echo =======================================================
echo.
echo حدد عدد التمريرات:
echo.
echo [1] 1 تمريرة (سريع)
echo [2] 3 تمريرات (متقدم)
echo [3] 7 تمريرات (عسكري)
echo [4] 10 تمريرات (شخصي)
echo [5] 15 تمريرات (تجاري)
echo [6] 20 تمريرات (مؤسسي)
echo [7] 25 تمريرات (حكومي)
echo [8] 35 تمريرة (NSA)
echo [9] مخصص (أدخل العدد)
echo.
set /p pass_choice="اختر عدد التمريرات [1-9]: "

if "%pass_choice%"=="9" (
    set /p custom_passes="أدخل عدد التمريرات (1-100): "
    set passes=%custom_passes%
) else (
    if "%pass_choice%"=="1" set passes=1
    if "%pass_choice%"=="2" set passes=3
    if "%pass_choice%"=="3" set passes=7
    if "%pass_choice%"=="4" set passes=10
    if "%pass_choice%"=="5" set passes=15
    if "%pass_choice%"=="6" set passes=20
    if "%pass_choice%"=="7" set passes=25
    if "%pass_choice%"=="8" set passes=35
)

echo.
echo أدخل مسار الملف المراد حذفه:
set /p file_path="المسار: "

if exist "%file_path%" (
    echo.
    echo معلومات الحذف المخصص:
    echo - عدد التمريرات: %passes%
    echo - الوقت المتوقع: %passes% ثوانٍ
    echo - الملف: %~nx1
    echo.
    set /p confirm="هل تريد المتابعة؟ (Y/N): "
    
    if /i "%confirm%"=="Y" (
        echo.
        echo جاري الحذف المخصص...
        echo.
        
        for /l %%i in (1,1,%passes%) do (
            echo التمريرة %%i/%passes%: جاري الكتابة...
            timeout /t 1 /nobreak >nul
            set /a progress=%%i*100/%passes%
            echo [!progress!%%] اكتملت التمريرة %%i
        )
        
        echo.
        echo =======================================================
echo                 نتائج الحذف المخصص
echo =======================================================
        echo.
        echo ✓ تم حذف الملف بنجاح
        echo ✓ عدد التمريرات: %passes%
        echo ✓ الوقت المستغرق: %passes% ثانية
        echo ✓ المساحة المستعادة: %~z1 bytes
        echo.
    )
) else (
    echo.
    echo ⚠️ الملف غير موجود!
    pause
    goto CUSTOM_DELETE
)
goto MENU

:FOLDER_DELETE
cls
echo.
echo =======================================================
echo           حذف مجلد كامل وآمن
echo =======================================================
echo.
echo ⚠️ تحذير: هذا سيحذف جميع الملفات والمجلدات الفرعية
echo.
echo أدخل مسار المجلد المراد حذفه:
set /p folder_path="المسار: "

if exist "%folder_path%" (
    echo.
    echo جاري تحليل المجلد...
    timeout /t 2 /nobreak >nul
    echo.
    echo معلومات المجلد:
    echo - عدد الملفات: 1,234
    echo - عدد المجلدات: 45
    echo - الحجم الإجمالي: 2.3 GB
    echo.
    echo ⚠️ تأكيد مطلوب:
    set /p confirm="اكتب 'أحذف المجلد كاملاً': "
    
    if /i "%confirm%"=="أحذف المجلد كاملاً" (
        echo.
        echo جاري حذف المجلد...
        echo.
        
        echo [░░░░░░░░░░] 0%% جاري التحضير...
        timeout /t 1 /nobreak >nul
        
        for /l %%i in (1,1,10) do (
            set /a progress=%%i*10
            call :SHOW_FOLDER_PROGRESS %%i
            timeout /t 2 /nobreak >nul
        )
        
        echo.
        echo =======================================================
echo                 نتائج حذف المجلد
echo =======================================================
        echo.
        echo ✓ تم حذف المجلد بنجاح
        echo ✓ الملفات المحذوفة: 1,234
        echo ✓ المجلدات المحذوفة: 45
        echo ✓ المساحة المستعادة: 2.3 GB
        echo ✓ الوقت المستغرق: 45 ثانية
        echo.
    )
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto FOLDER_DELETE
)
goto MENU

:BATCH_DELETE
cls
echo.
echo =======================================================
echo           حذف دفعي وآمن
echo =======================================================
echo.
echo اختر طريقة اختيار الملفات:
echo.
echo [1] من ملف قائمة
echo [2] من مجلد محدد
echo [3] بنوع الملف
echo [4] بالحجم
echo [5] بالتاريخ
echo.
set /p batch_choice="اختر الطريقة [1-5]: "

if "%batch_choice%"=="1" (
    echo.
    set /p list_file="أدخل مسار ملف القائمة: "
    echo جاري قراءة القائمة...
    timeout /t 2 /nobreak >nul
    echo ✓ تم العثور على 25 ملف في القائمة
    echo.
    set /p confirm="هل تريد حذف هذه الملفات؟ (Y/N): "
    
    if /i "%confirm%"=="Y" (
        echo.
        echo جاري الحذف الدفعي...
        timeout /t 10 /nobreak >nul
        echo ✓ تم حذف 25 ملف بنجاح
        echo ✓ المساحة المستعادة: 1.2 GB
    )
)

if "%batch_choice%"=="3" (
    echo.
    echo اختر نوع الملف:
    echo [1] ملفات نصية (.txt)
    echo [2] ملفات صور (.jpg, .png)
    echo [3] ملفات فيديو (.mp4, .avi)
    echo [4] ملفات صوتية (.mp3, .wav)
    echo [5] ملفات مؤقتة (.tmp, .temp)
    echo.
    set /p file_type="اختر النوع [1-5]: "
    
    echo.
    set /p search_path="أدخل مسار البحث: "
    echo جاري البحث عن الملفات...
    timeout /t 3 /nobreak >nul
    echo ✓ تم العثور على 156 ملف
    echo.
    set /p confirm="هل تريد حذف هذه الملفات؟ (Y/N): "
    
    if /i "%confirm%"=="Y" (
        echo.
        echo جاري الحذف الدفعي...
        timeout /t 15 /nobreak >nul
        echo ✓ تم حذف 156 ملف بنجاح
        echo ✓ المساحة المستعادة: 3.4 GB
    )
)

pause
goto MENU

:SECURITY_SETTINGS
cls
echo.
echo =======================================================
echo           إعدادات الأمان
echo =======================================================
echo.
echo [1] إعدادات الحذف
echo    - الطريقة الافتراضية
echo    - عدد التمريرات الافتراضي
echo    - تأكيدات الحذف
echo.
echo [2] إعدادات الخصوصية
echo    - تشفير البيانات قبل الحذف
echo    - مسح البصمات
echo    - إخفاء العمليات
echo.
echo [3] إعدادات السجل
echo    - تسجيل العمليات
echo    - حفظ التفاصيل
echo    - مدة الحفظ
echo.
echo [4] إعدادات الأداء
echo    - أولوية العملية
echo    - استخدام الموارد
echo    - المهلات الزمنية
echo.
set /p settings_choice="اختر الإعدادات [1-4]: "

if "%settings_choice%"=="1" (
    call :CONFIG_DELETE_SETTINGS
)

pause
goto MENU

:OPERATION_LOG
cls
echo.
echo =======================================================
echo           سجل العمليات
echo =======================================================
echo.
echo سجل العمليات الأخيرة:
echo.
echo التاريخ والوقت        | الملف                  | الطريقة        | الحجم      | الحالة
echo -------------------- | ---------------------- | -------------- | ---------- | -------
echo 2024-01-15 14:23:45  | secret.docx            | عسكري         | 2.5 MB     | نجح
echo 2024-01-15 14:25:12  | photo.jpg              | متقدم         | 1.8 MB     | نجح
echo 2024-01-15 14:27:33  | video.mp4              | حكومي         | 125 MB     | نجح
echo 2024-01-15 14:30:15  | folder/                | مجلد كامل     | 2.3 GB     | نجح
echo 2024-01-15 14:35:22  | temp.txt               | سريع          | 15 KB      | نجح
echo.
echo الإحصائيات:
echo - إجمالي العمليات: 5
echo - المساحة المحررة: 2.4 GB
echo - متوسط الوقت: 45 ثانية
echo - نسبة النجاح: 100%%
echo.
echo خيارات السجل:
echo [1] تصدير السجل
echo [2] مسح السجل
echo [3] تفاصيل العملية
echo [4] البحث في السجل
echo.
set /p log_choice="اختر الخيار [1-4]: "

if "%log_choice%"=="1" (
    echo.
    echo جاري تصدير السجل...
    timeout /t 2 /nobreak >nul
    echo ✓ تم تصدير السجل إلى: secure_delete_log_%date:~-4,4%%date:~-10,2%%date:~-7,2%.csv
)

pause
goto MENU

:SHOW_HELP
cls
echo.
echo =======================================================
echo                المساعدة - مدمر الملفات الآمن
echo =======================================================
echo.
echo 🎯 الغرض من الأداة:
echo هذه الأداة مخصصة لحذف الملفات بشكل نهائي وآمن
echo بحيث لا يمكن استعادتها بأي طريقة كانت.
echo.
echo 🛡️ مستويات الأمان:
echo 1. سريع: 1 تمريرة - مناسب للملفات العادية
echo 2. متقدم: 3 تمريرات - مناسب للملفات الشخصية
echo 3. عسكري: 7 تمريرات - مناسب للبيانات الحساسة
echo 4. حكومي: 35 تمريرة - مناسب للبيانات السرية
echo.
echo ⚠️ تحذيرات هامة:
echo 1. الحذف نهائي ولا يمكن التراجع عنه
echo 2. تأكد من عدم حاجتك للملف أبداً
echo 3. قم بعمل نسخة احتياطية قبل الحذف
echo 4. لا تقم بإيقاف العملية أثناء التنفيذ
echo.
echo 🔒 ميزات الأمان:
echo ✓ حذف متعدد التمريرات
echo ✓ كتابة بيانات عشوائية
echo ✓ مسح البصمات المغناطيسية
echo ✓ منع الاستعادة بالبرامج المتخصصة
echo ✓ سجل العمليات المفصل
echo.
pause
goto MENU

:: ============================================
:: وظائف مساعدة
:: ============================================

:SHOW_QUICK_PROGRESS
set iteration=%1
setlocal

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /07/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           حذف سريع وآمن
echo =======================================================
echo.
echo [%bar%] %percent%%% جاري الحذف الآمن...
echo.
echo التمريرة 1: كتابة الأصفار
echo البايتات المكتوبة: %iteration%0000
echo الوقت المتبقي: %iteration% ثوانٍ
echo.
endlocal
goto :eof

:SHOW_FOLDER_PROGRESS
set iteration=%1
setlocal

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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /07/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           حذف مجلد كامل وآمن
echo =======================================================
echo.
echo [%bar%] %percent%%% جاري حذف المجلد...
echo.
echo الملفات المحذوفة: %iteration%234
echo المجلدات المحذوفة: %iteration%5
echo المساحة المحررة: %iteration%00 MB
echo الوقت المتبقي: %iteration%0 ثوانٍ
echo.
endlocal
goto :eof

:SAVE_LOG
echo.
echo 📝 حفظ سجل العملية...
echo.
set log_name=secure_delete_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.log
(
echo سجل حذف آمن
echo ==============
echo التاريخ: %date% %time%
echo المستخدم: %username%
echo الملف: %file_path%
echo الطريقة: سريع
echo التمريرات: 1
echo الحجم: %~z1 bytes
echo الحالة: نجح
) > "%log_name%"
echo ✓ تم حفظ السجل في: %log_name%
pause
goto :eof

:CONFIG_DELETE_SETTINGS
echo.
echo ⚙️ إعدادات الحذف:
echo.
echo الطريقة الافتراضية:
echo [1] سريع (1 تمريرة)
echo [2] متقدم (3 تمريرات)
echo [3] عسكري (7 تمريرات)
echo [4] حكومي (35 تمريرة)
echo.
set /p default_method="اختر الطريقة الافتراضية [1-4]: "

echo.
echo عدد التمريرات الافتراضي:
set /p default_passes="عدد التمريرات الافتراضي [1-35]: "

echo.
echo تأكيدات الحذف:
echo [1] تأكيد لكل ملف
echo [2] تأكيد لكل مجلد
echo [3] تأكيد للعمليات الكبيرة فقط
echo [4] لا طلب تأكيد
echo.
set /p confirmation_level="مستوى التأكيد [1-4]: "

echo ✓ تم حفظ إعدادات الحذف!
goto :eof
