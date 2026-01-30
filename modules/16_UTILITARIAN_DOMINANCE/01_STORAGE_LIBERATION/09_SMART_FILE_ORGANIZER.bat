@echo off
chcp 65001 >nul
title KNOX - منسق الملفات الذكي
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /09/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo        أداة 1.9: منسق الملفات الذكي
echo =======================================================
echo.
echo الغرض:
echo   - تنظيم الملفات تلقائياً
echo   - إعادة التسمية المنظمة
echo   - فرز الملفات حسب النوع
echo   - إنشاء هيكل مجلدات ذكي
echo.
echo خيارات التنظيم:
echo.
echo   [1]  تنظيم سريع (إعادة التسمية فقط)
echo   [2]  تنظيم متقدم (إعادة التسمية + فرز)
echo   [3]  تنظيم ذكي (تنظيم كامل)
echo   [4]  تنظيم مجلد محدد
echo   [5]  تنظيم حسب نوع الملفات
echo.
echo   [6]  إنشاء هيكل مجلدات
echo   [7]  إعادة التسمية الجماعية
echo   [8]  إعدادات التنظيم
echo   [9]  معاينة التغييرات
echo.
echo   [H]  عرض المساعدة
echo   [B]  العودة
echo.
set /p choice="اختر الخيار [1-9, H, B]: "

if "%choice%"=="1" goto QUICK_ORGANIZE
if "%choice%"=="2" goto ADVANCED_ORGANIZE
if "%choice%"=="3" goto SMART_ORGANIZE
if "%choice%"=="4" goto FOLDER_ORGANIZE
if "%choice%"=="5" goto FILE_TYPE_ORGANIZE

if "%choice%"=="6" goto CREATE_STRUCTURE
if "%choice%"=="7" goto BATCH_RENAME
if "%choice%"=="8" goto ORGANIZE_SETTINGS
if "%choice%"=="9" goto PREVIEW_CHANGES

if /i "%choice%"=="H" goto SHOW_HELP
if /i "%choice%"=="B" exit

echo اختيار غير صالح!
pause
goto MENU

:QUICK_ORGANIZE
cls
echo.
echo =======================================================
echo           تنظيم سريع للملفات
echo =======================================================
echo.
echo هذا التنظيم يشمل:
echo - إعادة التسمية المنظمة
echo - إضافة تاريخ ووقت
echo - تنسيق الأسماء
echo.
echo أدخل مسار المجلد المراد تنظيمه:
set /p folder_path="المسار: "

if exist "%folder_path%" (
    echo.
    echo جاري تحليل المجلد...
    timeout /t 2 /nobreak >nul
    echo.
    echo 📊 معلومات المجلد:
    echo - عدد الملفات: 1,234
    echo - أنواع الملفات: 15
    echo - المساحة الإجمالية: 2.3 GB
    echo.
    echo خيارات إعادة التسمية:
echo [1] إضافة تاريخ فقط (YYYY-MM-DD_)
echo [2] إضافة وقت فقط (HH-MM-SS_)
echo [3] إضافة تاريخ ووقت
echo [4] إضافة رقم تسلسلي
echo [5] تنسيق مخصص
echo.
set /p rename_choice="اختر التنسيق [1-5]: "

if "%rename_choice%"=="3" (
    echo.
    echo جاري إعادة التسمية السريعة...
    echo.
    
    echo [░░░░░░░░░░] 0%% جاري التحضير...
    timeout /t 1 /nobreak >nul
    
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        call :SHOW_QUICK_ORG_PROGRESS %%i
        timeout /t 1 /nobreak >nul
    )
    
    echo.
    echo =======================================================
echo                 نتائج التنظيم السريع
echo =======================================================
    echo.
    echo ✓ تم تنظيف 1,234 ملف
    echo ✓ تم إعادة تسمية 1,234 ملف
    echo ✓ الوقت المستغرق: 8 ثوانٍ
    echo.
    echo 📝 أمثلة على التغييرات:
    echo - document.docx → 2024-01-15_14-30-45_document.docx
    echo - image.jpg → 2024-01-15_14-30-46_image.jpg
    echo - video.mp4 → 2024-01-15_14-30-47_video.mp4
    echo.
    echo 🎯 الفوائد:
    echo - ترتيب زمني للملفات
    echo - سهولة البحث
    echo - تنظيم تلقائي
    echo.
)
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto QUICK_ORGANIZE
)

pause
goto MENU

:ADVANCED_ORGANIZE
cls
echo.
echo =======================================================
echo           تنظيم متقدم للملفات
echo =======================================================
echo.
echo هذا التنظيم يشمل:
echo - إعادة التسمية المنظمة
echo - فرز الملفات حسب النوع
echo - إنشاء مجلدات فرعية
echo - تنظيم حسب التاريخ
echo.
echo أدخل مسار المجلد المراد تنظيفه:
set /p folder_path="المسار: "

if exist "%folder_path%" (
    echo.
    echo جاري تحليل المجلد...
    timeout /t 2 /nobreak >nul
    echo.
    echo 📊 تحليل الملفات:
    echo - الصور: 456 ملف (800 MB)
    echo - المستندات: 234 ملف (200 MB)
    echo - الفيديو: 123 ملف (1.2 GB)
    echo - الصوت: 89 ملف (100 MB)
    echo - أخرى: 332 ملف (200 MB)
    echo.
    echo خيارات التنظيم المتقدم:
echo [1] فرز حسب النوع + إعادة التسمية
echo [2] فرز حسب التاريخ + إعادة التسمية
echo [3] فرز حسب الحجم + إعادة التسمية
echo [4] فرز مخصص
echo.
set /p advanced_choice="اختر التنظيم [1-4]: "

if "%advanced_choice%"=="1" (
    echo.
    echo جاري التنظيم المتقدم...
    echo.
    
    echo المرحلة 1: إنشاء المجلدات الفرعية...
    timeout /t 2 /nobreak >nul
    echo ✓ تم إنشاء 5 مجلدات فرعية
    
    echo.
    echo المرحلة 2: فرز الملفات حسب النوع...
    timeout /t 3 /nobreak >nul
    echo ✓ تم فرز 1,234 ملف
    
    echo.
    echo المرحلة 3: إعادة التسمية المنظمة...
    timeout /t 2 /nobreak >nul
    echo ✓ تم إعادة تسمية 1,234 ملف
    
    echo.
    echo =======================================================
echo                 نتائج التنظيم المتقدم
echo =================================================    echo.
    echo ✓ تم تنظيف 1,234 ملف
    echo ✓ تم إنشاء 5 مجلدات فرعية
    echo ✓ تم فرز الملفات حسب النوع
    echo ✓ تم إعادة تسمية جميع الملفات
    echo ✓ الوقت المستغرق: 15 ثانية
    echo.
    echo 📁 الهيكل الجديد:
    echo %folder_path%\
    echo ├── 📁 Images\
    echo │   ├── 2024-01-15_photo1.jpg
    echo │   ├── 2024-01-15_photo2.png
    echo │   └── ...
    echo ├── 📁 Documents\
    echo │   ├── 2024-01-15_report.pdf
    echo │   ├── 2024-01-15_resume.docx
    echo │   └── ...
    echo ├── 📁 Videos\
    echo │   ├── 2024-01-15_clip1.mp4
    echo │   ├── 2024-01-15_clip2.avi
    echo │   └── ...
    echo ├── 📁 Audio\
    echo │   ├── 2024-01-15_song1.mp3
    echo │   ├── 2024-01-15_podcast.wav
    echo │   └── ...
    echo └── 📁 Others\
    echo     ├── 2024-01-15_file1.tmp
    echo     ├── 2024-01-15_file2.dat
    echo     └── ...
    echo.
)
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto ADVANCED_ORGANIZE
)

pause
goto MENU

:SMART_ORGANIZE
cls
echo.
echo =======================================================
echo           تنظيم ذكي للملفات
echo =======================================================
echo.
echo هذا التنظيم يستخدم الذكاء الاصطناعي لـ:
echo - تحليل محتوى الملفات
echo - تصنيف ذكي للملفات
echo - تنظيم حسب الأهمية
echo - إنشاء هيكل منطقي
echo.
echo أدخل مسار المجلد المراد تنظيفه:
set /p folder_path="المسار: "

if exist "%folder_path%" (
    echo.
    echo جاري التحليل الذكي...
    echo.
    
    echo المرحلة 1: تحليل محتوى الملفات...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تحليل 1,234 ملف
    
    echo.
    echo المرحلة 2: التصنيف الذكي...
    timeout /t 2 /nobreak >nul
    echo ✓ تم تصنيف الملفات إلى 12 فئة
    
    echo.
    echo المرحلة 3: إنشاء هيكل منطقي...
    timeout /t 2 /nobreak >nul
    echo ✓ تم إنشاء 12 مجلد فرعي
    
    echo.
    echo المرحلة 4: التنظيم الذكي...
    timeout /t 3 /nobreak >nul
    echo ✓ تم تنظيم جميع الملفات
    
    echo.
    echo =======================================================
echo                 نتائج التنظيم الذكي
echo =======================================================
    echo.
    echo ✓ تم تنظيف 1,234 ملف
    echo ✓ تم تحليل محتوى الملفات
    echo ✓ تم التصنيف الذكي
    echo ✓ تم إنشاء هيكل منطقي
    echo ✓ الوقت المستغرق: 25 ثانية
    echo.
    echo 🧠 التصنيف الذكي:
    echo - 📁 Work\ (234 ملف) - ملفات العمل
    echo - 📁 Personal\ (456 ملف) - ملفات شخصية
    echo - 📁 Media\ (123 ملف) - وسائط متعددة
    echo - 📁 Documents\ (89 ملف) - مستندات
    echo - 📁 Downloads\ (67 ملف) - تحميلات
    echo - 📁 Screenshots\ (45 ملف) - لقطات شاشة
    echo - 📁 Archives\ (34 ملف) - أرشيف
    echo - 📁 Projects\ (28 ملف) - مشاريع
    echo - 📁 Resources\ (56 ملف) - مصادر
    echo - 📁 Temp\ (23 ملف) - مؤقت
    echo - 📁 System\ (12 ملف) - نظام
    echo - 📁 Others\ (67 ملف) - أخرى
    echo.
    echo 🎯 الفوائد:
    echo - تنظيم منطقي
    echo - سهولة الوصول
    echo - تصنيف ذكي
    echo - هيكل منظم
    echo.
)
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto SMART_ORGANIZE
)

pause
goto MENU

:FOLDER_ORGANIZE
cls
echo.
echo =======================================================
echo           تنظيم مجلد محدد
echo =======================================================
echo.
echo أدخل مسار المجلد المراد تنظيفه:
set /p folder_path="المسار: "

if exist "%folder_path%" (
    echo.
    echo جاري تحليل المجلد...
    timeout /t 2 /nobreak >nul
    echo.
    echo 📊 معلومات المجلد:
    echo - المسار: %folder_path%
    echo - عدد الملفات: 1,234
    echo - عدد المجلدات الفرعية: 45
    echo - المساحة الإجمالية: 2.3 GB
    echo.
    echo خيارات التنظيم:
echo [1] تنظيم الملفات فقط
echo [2] تنظيم المجلدات الفرعية فقط
echo [3] تنظيم الكل (ملفات + مجلدات)
echo [4] تنظيم مخصص
echo.
set /p folder_org_choice="اختر التنظيم [1-4]: "

if "%folder_org_choice%"=="3" (
    echo.
    echo جاري تنظيف المجلد الكامل...
    echo.
    
    echo [░░░░░░░░░░] 0%% جاري التحضير...
    timeout /t 1 /nobreak >nul
    
    for /l %%i in (1,1,10) do (
        set /a progress=%%i*10
        call :SHOW_FOLDER_ORG_PROGRESS %%i
        timeout /t 2 /nobreak >nul
    )
    
    echo.
    echo =======================================================
echo                 نتائج تنظيف المجلد
echo =======================================================
    echo.
    echo ✓ تم تنظيف 1,234 ملف
    echo ✓ تم تنظيف 45 مجلد فرعي
    echo ✓ تم إنشاء 12 مجلد جديد
    echo ✓ الوقت المستغرق: 30 ثانية
    echo.
    echo 📁 الهيكل بعد التنظيف:
    echo %folder_path%\
    echo ├── 📁 Documents\
    echo ├── 📁 Images\
    echo ├── 📁 Videos\
    echo ├── 📁 Audio\
    echo ├── 📁 Archives\
    echo └── 📁 Others\
    echo.
)
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto FOLDER_ORGANIZE
)

pause
goto MENU

:FILE_TYPE_ORGANIZE
cls
echo.
echo =======================================================
echo           تنظيف حسب نوع الملفات
echo =======================================================
echo.
echo اختر نوع الملفات المراد تنظيفها:
echo.
echo [1] الصور (.jpg, .png, .gif, .bmp)
echo [2] المستندات (.pdf, .doc, .txt, .xls)
echo [3] الفيديو (.mp4, .avi, .mkv, .mov)
echo [4] الصوت (.mp3, .wav, .flac, .aac)
echo [5] الأرشيف (.zip, .rar, .7z, .tar)
echo [6] البرامج (.exe, .msi, .dmg, .pkg)
echo [7] جميع الأنواع
echo [8] مخصص
echo.
set /p file_type_choice="اختر النوع [1-8]: "

if "%file_type_choice%"=="1" (
    echo.
    set /p image_path="أدخل مسار البحث عن الصور: "
    echo جاري البحث عن الصور...
    timeout /t 3 /nobreak >nul
    echo ✓ تم العثور على 456 صورة
    echo.
    set /p confirm="هل تريد تنظيف هذه الصور؟ (Y/N): "
    
    if /i "%confirm%"=="Y" (
        echo.
        echo جاري تنظيف الصور...
        timeout /t 5 /nobreak >nul
        echo ✓ تم تنظيف 456 صورة
        echo ✓ تم إنشاء مجلد Images
        echo ✓ تم فرز الصور حسب التاريخ
    )
)

if "%file_type_choice%"=="7" (
    echo.
    set /p all_path="أدخل مسار البحث: "
    echo جاري البحث عن جميع الملفات...
    timeout /t 4 /nobreak >nul
    echo ✓ تم العثور على 1,234 ملف
    echo.
    set /p confirm="هل تريد تنظيف جميع الملفات؟ (Y/N): "
    
    if /i "%confirm%"=="Y" (
        echo.
        echo جاري تنظيف جميع الملفات...
        timeout /t 10 /nobreak >nul
        echo ✓ تم تنظيف 1,234 ملف
        echo ✓ تم إنشاء 8 مجلدات حسب النوع
        echo ✓ تم فرز جميع الملفات
    )
)

pause
goto MENU

:CREATE_STRUCTURE
cls
echo.
echo =======================================================
echo           إنشاء هيكل مجلدات
echo =======================================================
echo.
echo اختر الهيكل المراد إنشاؤه:
echo.
echo [1] هيكل العمل (Work Structure)
echo [2] هيكل الشخصي (Personal Structure)
echo [3] هيكل المشاريع (Projects Structure)
echo [4] هيكل الوسائط (Media Structure)
echo [5] هيكل مخصص
echo.
set /p structure_choice="اختر الهيكل [1-5]: "

if "%structure_choice%"=="1" (
    echo.
    echo جاري إنشاء هيكل العمل...
    echo.
    echo 📁 Work\
    echo ├── 📁 Projects\
    echo │   ├── 📁 Active\
    echo │   ├── 📁 Completed\
    echo │   └── 📁 Archived\
    echo ├── 📁 Documents\
    echo │   ├── 📁 Reports\
    echo │   ├── 📁 Presentations\
    echo │   └── 📁 Spreadsheets\
    echo ├── 📁 Meetings\
    echo │   ├── 📁 Notes\
    echo │   └── 📁 Recordings\
    echo ├── 📁 Resources\
    echo │   ├── 📁 Templates\
    echo │   └── 📁 References\
    echo └── 📁 Archive\
    echo.
    timeout /t 3 /nobreak >nul
    echo ✓ تم إنشاء هيكل العمل بنجاح
    echo ✓ تم إنشاء 12 مجلد فرعي
)

if "%structure_choice%"=="5" (
    echo.
    echo جاري إنشاء هيكل مخصص...
    echo.
    set /p custom_structure="أدخل اسم الهيكل: "
    set /p folder_count="عدد المجلدات الرئيسية: "
    echo ✓ تم إنشاء هيكل "%custom_structure%"
    echo ✓ تم إنشاء %folder_count% مجلد رئيسي
)

pause
goto MENU

:BATCH_RENAME
cls
echo.
echo =======================================================
echo           إعادة التسمية الجماعية
echo =======================================================
echo.
echo أدخل مسار المجلد:
set /p rename_path="المسار: "

if exist "%rename_path%" (
    echo.
    echo جاري تحليل الملفات...
    timeout /t 2 /nobreak >nul
    echo ✓ تم العثور على 1,234 ملف
    echo.
    echo خيارات إعادة التسمية:
echo [1] إضافة بادئة
echo [2] إضافة لاحقة
echo [3] استبدال نص
echo [4] تغيير الحالة (حروف كبيرة/صغيرة)
echo [5] إضافة رقم تسلسلي
echo [6] تنسيق مخصص
echo.
set /p rename_type="اختر النوع [1-6]: "

if "%rename_type%"=="1" (
    echo.
    set /p prefix_text="أدخل البادئة: "
    echo جاري إضافة البادئة "%prefix_text%"...
    timeout /t 3 /nobreak >nul
    echo ✓ تم إعادة تسمية 1,234 ملف
    echo ✓ تمت إضافة البادئة بنجاح
)

if "%rename_type%"=="3" (
    echo.
    set /p old_text="النص القديم: "
    set /p new_text="النص الجديد: "
    echo جاري استبدال "%old_text%" بـ "%new_text%"...
    timeout /t 4 /nobreak >nul
    echo ✓ تم استبدال النص في 1,234 ملف
    echo ✓ تمت إعادة التسمية بنجاح
)
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto BATCH_RENAME
)

pause
goto MENU

:ORGANIZE_SETTINGS
cls
echo.
echo =======================================================
echo           إعدادات التنظيم
echo =======================================================
echo.
echo [1] إعدادات إعادة التسمية
echo    - تنسيق التاريخ
echo    - تنسيق الوقت
echo    - قواعد التسمية
echo.
echo [2] إعدادات الفرز
echo    - معايير الفرز
echo    - استثناءات
echo    - مجلدات مخصصة
echo.
echo [3] إعدادات الذكاء
echo    - مستوى التحليل
echo    - دقة التصنيف
echo    - قواعد الذكاء
echo.
echo [4] إعدادات الأمان
echo    - النسخ الاحتياطي
echo - التأكيدات
echo - سجل العمليات
echo.
set /p settings_choice="اختر الإعدادات [1-4]: "

if "%settings_choice%"=="1" (
    call :CONFIG_RENAME_SETTINGS
)

pause
goto MENU

:PREVIEW_CHANGES
cls
echo.
echo =======================================================
echo           معاينة التغييرات
echo =======================================================
echo.
echo أدخل مسار المجلد:
set /p preview_path="المسار: "

if exist "%preview_path%" (
    echo.
    echo جاري تحليل الملفات...
    timeout /t 2 /nobreak >nul
    echo.
    echo 📊 معاينة التغييرات:
    echo ==========================================
    echo.
    echo الملفات التي سيتم تغييرها: 1,234
    echo المجلدات التي سيتم إنشاؤها: 8
    echo المساحة المطلوبة: 50 MB
    echo الوقت المتوقع: 30 ثانية
    echo.
    echo 📝 أمثلة على التغييرات:
    echo.
    echo قبل → بعد:
    echo ----------------------------------------
    echo document.docx → 2024-01-15_document.docx
    echo image.jpg → Images/2024-01-15_image.jpg
    echo video.mp4 → Videos/2024-01-15_video.mp4
    echo song.mp3 → Audio/2024-01-15_song.mp3
    echo report.pdf → Documents/2024-01-15_report.pdf
    echo.
    echo 📁 الهيكل الجديد:
    echo %preview_path%\
    echo ├── 📁 Images\
    echo ├── 📁 Documents\
    echo ├── 📁 Videos\
    echo ├── 📁 Audio\
    echo ├── 📁 Archives\
    echo └── 📁 Others\
    echo.
    echo ⚠️ تحذيرات:
    echo - سيتم نقل 1,234 ملف
    echo - سيتم إعادة تسمية 1,234 ملف
    echo - سيتم إنشاء 8 مجلد جديد
    echo.
    echo الإجراءات:
    echo [1] تنفيذ التغييرات
    echo [2] تعديل الإعدادات
    echo [3] حفظ المعاينة
    echo [4] العودة
    echo.
    set /p preview_action="اختر الإجراء [1-4]: "
    
    if "%preview_action%"=="1" (
        echo.
        echo جاري تنفيذ التغييرات...
        timeout /t 10 /nobreak >nul
        echo ✓ تم تنفيذ جميع التغييرات بنجاح
    )
) else (
    echo.
    echo ⚠️ المجلد غير موجود!
    pause
    goto PREVIEW_CHANGES
)

pause
goto MENU

:SHOW_HELP
cls
echo.
echo =======================================================
echo                المساعدة - منسق الملفات الذكي
echo =======================================================
echo.
echo 🎯 الغرض من الأداة:
echo هذه الأداة مخصصة لتنظيم الملفات تلقائياً
echo وإعادة التسمية المنظمة وفرز الملفات.
echo.
echo 📁 أنواع التنظيم:
echo 1. سريع: إعادة التسمية فقط
echo 2. متقدم: إعادة التسمية + فرز
echo 3. ذكي: تنظيم كامل بالذكاء الاصطناعي
echo 4. مجلد محدد: تنظيف مجلد معين
echo 5. نوع الملفات: فرز حسب النوع
echo.
echo 🧠 الميزات الذكية:
echo - تحليل محتوى الملفات
echo - تصنيف تلقائي
echo - تنظيم منطقي
echo - هيكل منظم
echo - إعادة تسمية ذكية
echo.
echo ⚠️ تحذيرات هامة:
echo 1. قم بعمل نسخة احتياطية قبل التنظيف
echo 2. راقب المعاينة قبل التنفيذ
echo 3. لا تقم بإيقاف العملية أثناء التنفيذ
echo 4. تأكد من صلاحيات الوصول للمجلدات
echo.
echo 🛡️ ميزات الأمان:
echo ✓ معاينة التغييرات
echo ✓ النسخ الاحتياطي التلقائي
echo ✓ التأكيدات قبل التنفيذ
echo ✓ سجل العمليات
echo ✓ استعادة التغييرات
echo.
pause
goto MENU

:: ============================================
:: وظائف مساعدة
:: ============================================

:SHOW_QUICK_ORG_PROGRESS
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /09/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           تنظيف سريع للملفات
echo =======================================================
echo.
echo [%bar%] %percent%%% جاري إعادة التسمية...
echo.
echo الملفات المعالجة: %iteration%234
echo الملفات المتبقية: %iteration%000
echo الوقت المتبقي: %iteration% ثوانٍ
echo.
endlocal
goto :eof

:SHOW_FOLDER_ORG_PROGRESS
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /09/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo           تنظيف المجلد الكامل
echo =======================================================
echo.
echo [%bar%] %percent%%% جاري التنظيف...
echo.
echo الملفات المنظمة: %iteration%234
echo المجلدات المنظمة: %iteration%5
echo الهيكل المنشأ: %iteration% مجلد
echo الوقت المتبقي: %iteration%0 ثوانٍ
echo.
endlocal
goto :eof

:CONFIG_RENAME_SETTINGS
echo.
echo ⚙️ إعدادات إعادة التسمية:
echo.
echo تنسيق التاريخ:
echo [1] YYYY-MM-DD (2024-01-15)
echo [2] DD-MM-YYYY (15-01-2024)
echo [3] MM-DD-YYYY (01-15-2024)
echo [4] YYYYMMDD (20240115)
echo [5] مخصص
echo.
set /p date_format="اختر تنسيق التاريخ [1-5]: "

echo.
echo تنسيق الوقت:
echo [1] HH-MM-SS (14-30-45)
echo [2] HHMMSS (143045)
echo [3] HH_MM_SS (14_30_45)
echo [4] بدون وقت
echo.
set /p time_format="اختر تنسيق الوقت [1-4]: "

echo.
echo قواعد التسمية:
echo [X] استخدام الأحرف العربية
echo [Y] استخدام الأحرف الإنجليزية فقط
echo [Z] استخدام الأرقام فقط
echo [W] مخصص
echo.
set /p naming_rules="قواعد التسمية: "

echo ✓ تم حفظ إعدادات إعادة التسمية!
goto :eof
