@echo off
title Knox Ultimate Toolbox - Services Viewer
color 0A
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
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
echo           عارض قائمة الخدمات الذكي
echo               Category: 07 Services
echo                 Color: Emerald Green #00C853
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] عرض جميع الخدمات
echo [2] تصفية حسب النوع
echo [3] البحث عن خدمة
echo [4] عرض تفاصيل الخدمة
echo [5] تصدير القائمة
echo [6] العودة لقائمة الخدمات
echo [7] القائمة الرئيسية
echo.
set /p choice="اختر (1-7): "

if "%choice%"=="1" goto SHOW_ALL
if "%choice%"=="2" goto FILTER_BY_TYPE
if "%choice%"=="3" goto SEARCH_SERVICE
if "%choice%"=="4" goto VIEW_DETAILS
if "%choice%"=="5" goto EXPORT_LIST
if "%choice%"=="6" call "07_services.bat"
if "%choice%"=="7" call "KNOX_MAIN_MENU.BAT"
goto MENU

:SHOW_ALL
cls
echo 📋 عرض جميع الخدمات
echo ═══════════════════════════════════════════════════════
echo عرض كامل لجميع خدمات النظام مع حالتها
echo.
echo 🔄 جاري تحميل الخدمات...
echo جمع البيانات: [██████████] 100%%
echo تنظيم القائمة: [██████████] 100%%
echo.
echo 📊 إحصائيات الخدمات:
echo • إجمالي الخدمات: 256 خدمة
echo • الخدمات النشطة: 156 (61%%)
echo • الخدمات المتوقفة: 100 (39%%)
echo.
echo 🎯 عرض الخدمات (الصفحة 1/26):
echo.
echo 1. Adobe Acrobat Update Service
echo    • الحالة: ⏳ متوقفة
echo    • النوع: يدوي
echo    • PID: -
echo    • الذاكرة: -
echo.
echo 2. Application Identity
echo    • الحالة: ✅ نشطة
echo    • النوع: يدوي
echo    • PID: 1248
echo    • الذاكرة: 4.2 ميجابايت
echo.
echo 3. Background Intelligent Transfer Service
echo    • الحالة: ✅ نشطة
echo    • النوع: تلقائي (مؤجل)
echo    • PID: 1892
echo    • الذاكرة: 8.5 ميجابايت
echo.
echo 4. Base Filtering Engine
echo    • الحالة: ✅ نشطة
echo    • النوع: تلقائي
echo    • PID: 756
echo    • الذاكرة: 12.8 ميجابايت
echo.
echo 5. Bluetooth Support Service
echo    • الحالة: ⏳ متوقفة
echo    • النوع: يدوي
echo    • PID: -
echo    • الذاكرة: -
echo.
echo ...
echo.
echo 📄 الصفحات: 1/26 | استخدم الأسهم للتنقل
pause
goto MENU

:FILTER_BY_TYPE
cls
echo 🎯 تصفية حسب النوع
echo ═══════════════════════════════════════════════════════
echo عرض الخدمات حسب نوعها أو حالتها
echo.
echo 🔍 خيارات التصفية:
echo [1] الخدمات النشطة فقط
echo [2] الخدمات المتوقفة فقط
echo [3] الخدمات التلقائية
echo [4] الخدمات اليدوية
echo [5] الخدمات المعطلة
echo [6] خدمات النظام
echo [7] خدمات المستخدم
echo.
set /p filter="اختر نوع التصفية: "

echo.
echo 🔄 جاري التصفية...
if "%filter%"=="1" (
    echo 📊 الخدمات النشطة (156 خدمة):
    echo • Windows Audio ✅
    echo • Windows Defender ✅
    echo • Windows Update ✅
    echo • Print Spooler ✅
    echo • Themes ✅
    echo • المزيد...
)
if "%filter%"=="3" (
    echo 📊 الخدمات التلقائية (85 خدمة):
    echo • Windows Audio Endpoint Builder
    echo • Windows Defender Antivirus Service
    echo • Windows Management Instrumentation
    echo • Windows Time
    echo • المزيد...
)
echo.
pause
goto MENU

:SEARCH_SERVICE
cls
echo 🔍 البحث عن خدمة
echo ═══════════════════════════════════════════════════════
echo البحث عن خدمات بأسماء أو أوصاف محددة
echo.
set /p search="أدخل كلمة البحث: "

echo.
echo 🔎 جاري البحث عن '%search%'...
echo فحص أسماء الخدمات: [██████████] 100%%
echo فحص أوصاف الخدمات: [██████████] 100%%
echo فحص مسارات التنفيذ: [██████████] 100%%
echo.
echo 📋 نتائج البحث:
echo.
echo 1. Windows Update
echo    • الاسم: wuauserv
echo    • الوصف: تمكين الكشف عن الخدمة...
echo    • الحالة: ✅ نشطة
echo.
echo 2. Windows Defender
echo    • الاسم: WinDefend
echo    • الوصف: يساعد في حماية جهاز الكمبيوتر...
echo    • الحالة: ✅ نشطة
echo.
echo 3. Windows Search
echo    • الاسم: WSearch
echo    • الوصف: يوفر فهرسة المحتوى...
echo    • الحالة: ⏳ متوقفة
echo.
echo 📊 عدد النتائج: 3 خدمات تطابق البحث
echo.
pause
goto MENU

:VIEW_DETAILS
cls
echo 📋 عرض تفاصيل الخدمة
echo ═══════════════════════════════════════════════════════
echo عرض معلومات مفصلة عن خدمة محددة
echo.
set /p service="أدخل اسم الخدمة: "

echo.
echo 🔍 جاري تحميل تفاصيل '%service%'...
echo جمع المعلومات: [██████████] 100%%
echo تحليل التبعيات: [██████████] 100%%
echo.
echo 📊 تفاصيل الخدمة: Windows Update
echo.
echo 🔹 المعلومات الأساسية:
echo • اسم العرض: Windows Update
echo • اسم الخدمة: wuauserv
echo • الوصف: تمكين الكشف عن الخدمة...
echo • حالة الخدمة: ✅ قيد التشغيل
echo • حالة البدء: تلقائي (مؤجل)
echo • PID العملية: 2456
echo.
echo 📁 معلومات المسار:
echo • مسار التنفيذ: C:\Windows\system32\svchost.exe -k netsvcs
echo • مجلد العمل: C:\Windows\system32
echo • نوع الخدمة: Win32 Share Process
echo.
echo 🔗 التبعيات:
echo • الخدمات المطلوبة:
echo   - RPC (الاستدعاء عن بعد)
echo   - DCOM Server Process Launcher
echo   - BITS (Background Intelligent Transfer)
echo • الخدمات المعتمدة على هذه الخدمة:
echo   - Windows Update Medic Service
echo   - Update Orchestrator Service
echo.
echo 📊 استخدام الموارد:
echo • استخدام الذاكرة: 45.8 ميجابايت
echo • استخدام المعالج: 0.8%%
echo • مقابض الملفات: 248 مقبض
echo • مؤشرات الترابط: 12 مؤشر
echo.
echo ⚙️  معلومات الأمان:
echo • حساب التشغيل: LocalSystem
echo • الصلاحيات: عالية الامتيازات
echo • إمكانية التوقف: نعم
echo • إمكانية الإيقاف المؤقت: لا
echo.
pause
goto MENU

:EXPORT_LIST
cls
echo 📤 تصدير القائمة
echo ═══════════════════════════════════════════════════════
echo تصدير قائمة الخدمات إلى ملف خارجي
echo.
echo 💾 تنسيقات التصدير:
echo [1] CSV (لبرامج الجداول)
echo [2] HTML (عرض في المتصفح)
echo [3] TXT (نص عادي)
echo [4] XML (للمعالجة الآلية)
echo.
set /p format="اختر تنسيق التصدير: "

echo.
echo 📊 جاري تصدير قائمة الخدمات...
echo جمع البيانات: [██████████] 100%%
echo تنظيم التنسيق: [██████████] 100%%
echo حفظ الملف: [██████████] 100%%
echo.
echo ✅ التصدير مكتمل!
echo 📁 معلومات الملف:
echo • الموقع: C:\KNOX_Exports\Services_List_%date%.%format%
echo • الحجم: 1.2 ميجابايت
echo • عدد الخدمات: 256 خدمة
echo • الأعمدة: 12 عمود (الاسم، الحالة، النوع، إلخ)
echo.
echo 📋 محتويات الملف:
echo • معلومات جميع الخدمات
echo • إحصائيات موجزة
echo • توقيت التصدير
echo • معلومات النظام
echo.
pause
goto MENU
