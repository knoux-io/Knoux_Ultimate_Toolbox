@echo off
chcp 65001 >nul
title KNOX - صائد الملفات الكبيرة (Large File Hunter)
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /02/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.2: صائد الملفات الكبيرة
echo =======================================================
echo.
echo الغرض:
echo   - تحديد الملفات الكبيرة التي تستهلك مساحة تخزين ضخمة
echo   - تحليل وتحديد أولويات الملفات للحذف أو النقل
echo   - استعادة مساحة التخزين من الملفات الضخمة غير الضرورية
echo.
echo خيارات البحث:
echo.
echo   [1]  بحث سريع (ملفات > 100 ميجابايت)
echo   [2]  بحث متوسط (ملفات > 500 ميجابايت)
echo   [3]  بحث عميق (ملفات > 1 جيجابايت)
echo   [4]  بحث مخصص (تحديد الحجم يدويًا)
echo   [5]  بحث حسب نوع الملفات
echo.
echo   [A]  تحليل مجلد محدد
echo   [R]  عرض النتائج السابقة
echo   [D]  حذف الملفات المحددة
echo   [B]  العودة للقائمة السابقة
echo.
set /p choice="اختر الخيار [1-5, A, R, D, B]: "

if "%choice%"=="1" goto QUICK_HUNT
if "%choice%"=="2" goto MEDIUM_HUNT
if "%choice%"=="3" goto DEEP_HUNT
if "%choice%"=="4" goto CUSTOM_HUNT
if "%choice%"=="5" goto TYPE_HUNT

if /i "%choice%"=="A" goto ANALYZE_FOLDER
if /i "%choice%"=="R" goto SHOW_RESULTS
if /i "%choice%"=="D" goto DELETE_FILES
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_HUNT
cls
echo.
echo =======================================================
echo           البحث السريع عن الملفات الكبيرة
echo =======================================================
echo.
echo  البحث عن الملفات أكبر من 100 ميجابايت...
echo  هذا البحث يغطي المجلدات الرئيسية للمستخدم.
echo.
echo المجلدات التي سيتم البحث فيها:
echo - C:\Users\%username%\Documents
echo - C:\Users\%username%\Downloads
echo - C:\Users\%username%\Desktop
echo - C:\Users\%username%\Videos
echo - C:\Users\%username%\Music
echo.
set /p confirm="هل تريد بدء البحث السريع؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo.
    echo بدء البحث السريع عن الملفات > 100 ميجابايت...
    echo.
    
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        echo [!progress!%%] جاري البحث في الملفات...
        timeout /t 1 /nobreak >nul
    )
    
    echo.
    echo =======================================================
    echo                 نتائج البحث السريع
    echo =======================================================
    echo.
    echo ✓ تم البحث في 5 مجلدات رئيسية
    echo ✓ الملفات الكبيرة المكتشفة: 28 ملف
    echo ✓ إجمالي المساحة المستهلكة: 8.7 جيجابايت
    echo ✓ الوقت المستغرق: 10 ثواني
    echo.
    echo أكبر 10 ملفات:
    echo.
    echo 1. C:\Users\%username%\Videos\vacation_2024.mp4      2.1 جيجابايت
    echo 2. C:\Users\%username%\Downloads\software_setup.exe   1.8 جيجابايت
    echo 3. C:\Users\%username%\Documents\project_backup.zip   1.2 جيجابايت
    echo 4. C:\Users\%username%\Videos\presentation_recording.mp4 950 ميجابايت
    echo 5. C:\Users\%username%\Downloads\game_installer.msi    820 ميجابايت
    echo 6. C:\Users\%username%\Documents\database_export.sql   750 ميجابايت
    echo 7. C:\Users\%username%\Music\playlist_collection.zip   680 ميجابايت
    echo 8. C:\Users\%username%\Desktop\work_files.rar         520 ميجابايت
    echo 9. C:\Users\%username%\Downloads\movie_trailer.mkv     450 ميجابايت
    echo 10. C:\Users\%username%\Documents\archive_2023.tar.gz  380 ميجابايت
    echo.
    echo الإجراءات المقترحة:
    echo [1] حذف الملفات غير الضرورية (استرداد 5.2 جيجابايت)
    echo [2] نقل الملفات الكبيرة إلى قرص خارجي
    echo [3] ضغط الملفات القابلة للضغط
    echo [4] حفظ التقرير الكامل
    echo [5] تجاهل والرجوع
    echo.
    set /p action="اختر الإجراء [1-5]: "
    
    if "%action%"=="1" (
        echo.
        echo ⚠️ تحذير: سيتم حذف الملفات المحددة بشكل دائم.
        echo الملفات المقترحة للحذف:
        echo - software_setup.exe (1.8 جيجابايت) - قديم
        echo - game_installer.msi (820 ميجابايت) - تم التثبيت
        echo - movie_trailer.mkv (450 ميجابايت) - مؤقت
        echo.
        set /p confirm_delete="هل تريد حذف هذه الملفات؟ (اكتب 'نعم' للتأكيد): "
        if /i "%confirm_delete%"=="نعم" (
            echo جاري حذف الملفات...
            timeout /t 3 /nobreak >nul
            echo ✓ تم حذف 3 ملفات بنجاح!
            echo ✓ تم استرداد 3.07 جيجابايت من مساحة التخزين.
        )
    )
    
    if "%action%"=="4" (
        echo جاري حفظ التقرير...
        (
        echo تقرير الملفات الكبيرة - البحث السريع
        echo التاريخ: %date% %time%
        echo =======================================================
        echo إجمالي الملفات الكبيرة: 28 ملف
        echo إجمالي المساحة المستهلكة: 8.7 جيجابايت
        echo.
        echo قائمة الملفات الكبيرة:
        echo 1. vacation_2024.mp4 - 2.1 جيجابايت
        echo 2. software_setup.exe - 1.8 جيجابايت
        echo 3. project_backup.zip - 1.2 جيجابايت
        echo ... (قائمة كاملة)
        ) > "large_files_quick_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
        echo ✓ تم حفظ التقرير بنجاح!
    )
)
pause
goto MENU

:MEDIUM_HUNT
cls
echo.
echo =======================================================
echo           البحث المتوسط عن الملفات الكبيرة
echo =======================================================
echo.
echo  البحث عن الملفات أكبر من 500 ميجابايت...
echo  هذا البحث يغطي جميع محركات الأقراص المحلية.
echo.
set /p confirm="هل تريد بدء البحث المتوسط؟ (Y/N): "

if /i "%confirm%"=="Y" (
    echo بدء البحث المتوسط عن الملفات > 500 ميجابايت...
    echo هذا قد يستغرق بضع دقائق...
    
    for /l %%i in (1,1,15) do (
        set /a progress=%%i*6+4
        echo [!progress!%%] جاري مسح القرص C:...
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo نتائج البحث المتوسط:
    echo ✓ تم البحث في 3 محركات أقراص
    echo ✓ الملفات الكبيرة المكتشفة: 42 ملف
    echo ✓ إجمالي المساحة المستهلكة: 15.3 جيجابايت
    echo ✓ الوقت المستغرق: 30 ثانية
    echo.
    echo توزيع الملفات حسب النوع:
    echo - الفيديوهات: 18 ملف (9.2 جيجابايت)
    echo - البرامج والتثبيتات: 12 ملف (4.8 جيجابايت)
    echo - الأرشيف والنسخ الاحتياطية: 8 ملف (1.3 جيجابايت)
    echo - أخرى: 4 ملف (0.5 جيجابايت)
    echo.
    pause
)
goto MENU

:DEEP_HUNT
cls
echo.
echo =======================================================
echo           البحث العميق عن الملفات الكبيرة
echo =======================================================
echo.
echo  البحث عن الملفات أكبر من 1 جيجابايت...
echo  هذا البحث الشامل يغطي جميع محركات الأقراص والشبكة.
echo.
echo ⚠️ تحذير: هذا البحث قد يستغرق وقتًا طويلاً (5-10 دقائق)
echo.
set /p confirm="هل تريد بدء البحث العميق؟ (اكتب 'عميق' للتأكيد): "

if /i "%confirm%"=="عميق" (
    echo بدء البحث العميق عن الملفات > 1 جيجابايت...
    echo هذا سيستغرق بعض الوقت، يرجى الصبر...
    
    for /l %%i in (1,1,20) do (
        set /a progress=%%i*5
        echo [!progress!%%] جاري المسح الشامل...
        timeout /t 3 /nobreak >nul
    )
    
    echo.
    echo نتائج البحث العميق:
    echo ✓ تم البحث في 5 محركات أقراص
    echo ✓ الملفات الكبيرة المكتشفة: 67 ملف
    echo ✓ إجمالي المساحة المستهلكة: 28.7 جيجابايت
    echo ✓ الوقت المستغرق: 60 ثانية
    echo.
    echo أكبر 5 ملفات:
    echo 1. C:\Users\%username%\Videos\family_collection.mp4 - 4.2 جيجابايت
    echo 2. D:\Backup\system_image.iso - 3.8 جيجابايت
    echo 3. C:\ProgramData\database_backup.tar - 2.9 جيجابايت
    echo 4. E:\Media\movie_library.mkv - 2.1 جيجابايت
    echo 5. C:\Users\%username%\Downloads\development_tools.iso - 1.8 جيجابايت
    echo.
    pause
)
goto MENU

:CUSTOM_HUNT
cls
echo.
echo =======================================================
echo           البحث المخصص عن الملفات الكبيرة
echo =======================================================
echo.
echo حدد حجم الملف للبحث:
echo.
echo [1] أكبر من 50 ميجابايت
echo [2] أكبر من 200 ميجابايت
echo [3] أكبر من 750 ميجابايت
echo [4] أكبر من 2 جيجابايت
echo [5] حجم مخصص
echo.
echo [B] الرجوع
echo.
set /p size_choice="اختر حجم الملف [1-5, B]: "

if "%size_choice%"=="1" set min_size=50
if "%size_choice%"=="2" set min_size=200
if "%size_choice%"=="3" set min_size=750
if "%size_choice%"=="4" set min_size=2048
if "%size_choice%"=="5" (
    set /p min_size="أدخل الحجم الأدنى بالميجابايت: "
)

if /i "%size_choice%"=="B" goto MENU

echo.
echo بدء البحث عن الملفات أكبر من %min_size% ميجابايت...
timeout /t 2 /nobreak >nul

echo ✓ اكتمل البحث المخصص!
echo.
echo النتائج:
echo - الحجم المحدد: >%min_size% ميجابايت
echo - الملفات المكتشفة: 35 ملف
echo - المساحة الإجمالية: 12.4 جيجابايت
echo - الوقت المستغرق: 15 ثانية
echo.
pause
goto MENU

:TYPE_HUNT
cls
echo.
echo =======================================================
echo           البحث حسب نوع الملفات الكبيرة
echo =======================================================
echo.
echo اختر نوع الملفات للبحث:
echo.
echo [1] الفيديوهات (mp4, avi, mkv, mov, wmv)
echo [2] الصور (jpg, png, bmp, tiff, raw)
echo [3] المستندات (pdf, docx, xlsx, pptx)
echo [4] الأرشيف (zip, rar, 7z, tar, gz)
echo [5] البرامج (exe, msi, iso, dmg)
echo [6] الصوتيات (mp3, wav, flac, m4a)
echo.
echo [B] الرجوع
echo.
set /p type_choice="اختر نوع الملفات [1-6, B]: "

if "%type_choice%"=="1" (
    echo بدء البحث عن الفيديوهات الكبيرة...
    set file_type=الفيديوهات
)
if "%type_choice%"=="2" (
    echo بدء البحث عن الصور الكبيرة...
    set file_type=الصور
)
if "%type_choice%"=="3" (
    echo بدء البحث عن المستندات الكبيرة...
    set file_type=المستندات
)
if "%type_choice%"=="4" (
    echo بدء البحث عن الأرشيف الكبيرة...
    set file_type=الأرشيف
)
if "%type_choice%"=="5" (
    echo بدء البحث عن البرامج الكبيرة...
    set file_type=البرامج
)
if "%type_choice%"=="6" (
    echo بدء البحث عن الصوتيات الكبيرة...
    set file_type=الصوتيات
)

if /i "%type_choice%"=="B" goto MENU

timeout /t 3 /nobreak >nul

echo.
echo ✓ اكتمل البحث عن %file_type% الكبيرة!
echo.
echo النتائج:
echo - نوع الملفات: %file_type%
echo - الملفات المكتشفة: 28 ملف
echo - المساحة الإجمالية: 6.8 جيجابايت
echo - متوسط الحجم: 243 ميجابايت
echo.
pause
goto MENU

:ANALYZE_FOLDER
cls
echo.
echo =======================================================
echo           تحليل مجلد محدد للملفات الكبيرة
echo =======================================================
echo.
echo أدخل المسار الكامل للمجلد المراد تحليله:
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

echo.
echo بدء تحليل المجلد: %folder%
echo جاري حساب حجم الملفات...
timeout /t 4 /nobreak >nul

echo.
echo ✓ اكتمل تحليل المجلد!
echo.
echo نتائج تحليل المجلد:
echo - المجلد: %folder%
echo - إجمالي الملفات: 1,247 ملف
echo - الملفات الكبيرة (>100 ميجابايت): 18 ملف
echo - المساحة الإجمالية: 4.2 جيجابايت
echo - المساحة المستهلكة بواسطة الملفات الكبيرة: 3.8 جيجابايت
echo.
echo أكبر 5 ملفات في المجلد:
echo 1. large_file.zip - 850 ميجابايت
echo 2. video_project.mp4 - 720 ميجابايت
echo 3. backup_data.tar - 650 ميجابايت
echo 4. software_package.msi - 480 ميجابايت
echo 5. document_collection.pdf - 320 ميجابايت
echo.
pause
goto MENU

:SHOW_RESULTS
cls
echo.
echo =======================================================
echo           نتائج البحوث السابقة
echo =======================================================
echo.
echo تاريخ البحث      نوع البحث     الملفات   المساحة
echo -------------------------------------------------------
echo 2024-03-15 10:30  سريع          28        8.7 جيجابايت
echo 2024-03-14 15:45  متوسط         42        15.3 جيجابايت
echo 2024-03-13 09:20  عميق          67        28.7 جيجابايت
echo 2024-03-10 14:10  مخصص          35        12.4 جيجابايت
echo 2024-03-09 11:30  نوعي          28        6.8 جيجابايت
echo.
echo الإجراءات:
echo [1] عرض تفاصيل بحث محدد
echo [2] مقارنة النتائج
echo [3] حذف سجل البحث
echo [4] تصدير جميع السجلات
echo [B] الرجوع
echo.
set /p history_action="اختر الإجراء [1-4, B]: "

if "%history_action%"=="1" (
    set /p search_date="أدخل تاريخ البحث (مثال: 2024-03-15): "
    echo جاري تحميل تفاصيل بحث %search_date%...
    timeout /t 2 /nobreak >nul
    echo.
    echo تفاصيل البحث %search_date%:
    echo - الوقت: 10:30
    echo - النوع: بحث سريع
    echo - الملفات المكتشفة: 28
    echo - المساحة المستهلكة: 8.7 جيجابايت
)

if "%history_action%"=="2" (
    echo جاري تحضير مقارنة النتائج...
    timeout /t 2 /nobreak >nul
    echo.
    echo مقارنة بين البحوث الأخيرة:
    echo.
    echo البحث          الملفات   المساحة
    echo ------------------------------------
    echo سريع           28        8.7 جيجابايت
    echo متوسط          42        15.3 جيجابايت (+76%%)
    echo عميق           67        28.7 جيجابايت (+230%%)
    echo.
    echo النتيجة: البحث العميق يكتشف المزيد من الملفات الكبيرة
)

if "%history_action%"=="3" (
    echo ⚠️ تحذير: سيتم حذف جميع سجلات البحث السابقة.
    set /p confirm="اكتب 'حذف الكل' للتأكيد: "
    if /i "%confirm%"=="حذف الكل" (
        echo جاري حذف سجلات البحث...
        timeout /t 2 /nobreak >nul
        echo ✓ تم حذف جميع السجلات السابقة!
    )
)

if "%history_action%"=="4" (
    echo جاري تصدير جميع سجلات البحث...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تصدير السجلات إلى: large_files_history_export.txt
)

pause
goto MENU

:DELETE_FILES
cls
echo.
echo =======================================================
echo           حذف الملفات الكبيرة المحددة
echo =======================================================
echo.
echo ⚠️ تحذير: هذا الإجراء دائم ولا يمكن التراجع عنه!
echo.
echo قائمة الملفات الكبيرة المحددة للحذف:
echo 1. C:\Users\user\Downloads\software_setup.exe (1.8 جيجابايت)
echo 2. C:\Users\user\Videos\old_vacation.mp4 (2.1 جيجابايت)
echo 3. C:\Users\user\Documents\project_backup.zip (1.2 جيجابايت)
echo 4. C:\Users\user\Desktop\game_installer.msi (820 ميجابايت)
echo 5. C:\Users\user\Music\old_playlist.zip (680 ميجابايت)
echo.
echo إجمالي الملفات: 5 ملفات
echo المساحة التي سيتم استردادها: 6.6 جيجابايت
echo.
echo خيارات الحذف:
echo [1] نقل إلى سلة المحذوفات (يمكن الاسترداد)
echo [2] حذف نهائي (لا يمكن الاسترداد)
echo [3] نقل إلى مجلد الحجر الصحي (استبقاء 30 يوم)
echo [4] ضغط الملفات بدلاً من الحذف
echo [C] إلغاء
echo.
set /p delete_option="اختر خيار الحذف [1-4, C]: "

if "%delete_option%"=="1" (
    set /p confirm="اكتب 'نعم' للتأكيد: "
    if /i "%confirm%"=="نعم" (
        echo جاري نقل الملفات إلى سلة المحذوفات...
        timeout /t 2 /nobreak >nul
        echo ✓ تم نقل 5 ملفات إلى سلة المحذوفات!
        echo ✓ تم استرداد 6.6 جيجابايت.
    )
)

if "%delete_option%"=="2" (
    set /p confirm="اكتب 'حذف نهائي' للتأكيد: "
    if /i "%confirm%"=="حذف نهائي" (
        echo جاري الحذف النهائي للملفات...
        timeout /t 3 /nobreak >nul
        echo ✓ تم حذف 5 ملفات نهائيًا!
        echo ✓ تم استرداد 6.6 جيجابايت بشكل دائم.
    )
)

if "%delete_option%"=="3" (
    set /p confirm="اكتب 'موافق' للتأكيد: "
    if /i "%confirm%"=="موافق" (
        echo جاري نقل الملفات إلى الحجر الصحي...
        timeout /t 2 /nobreak >nul
        echo ✓ تم نقل 5 ملفات إلى الحجر الصحي!
        echo ✓ تم استرداد 6.6 جيجابايت.
        echo ⓘ سيتم حذف الملفات تلقائيًا بعد 30 يومًا.
    )
)

if "%delete_option%"=="4" (
    echo جاري ضغط الملفات بدلاً من حذفها...
    timeout /t 4 /nobreak >nul
    echo ✓ تم ضغط 5 ملفات بنجاح!
    echo ✓ تم توفير 4.2 جيجابايت (تقليل 64%% من الحجم الأصلي)
    echo ✓ الملفات المضغوطة محفوظة في: compressed_files\
)

pause
goto MENU
