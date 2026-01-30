@echo off
chcp 65001 >nul
title KNOX UTILITARIAN DOMINANCE CENTER - القسم 16
color 0A
mode con: cols=130 lines=50

:MAIN
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /16/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo =======================================================
echo     KNOX UTILITARIAN DOMINANCE CENTER - القسم 16
echo        "حيث تنحني الأدوات المتميزة للقوة المتاحة"
echo =======================================================
echo.
echo الفئات الرئيسية:
echo.
echo   [1]  تحرير مساحة التخزين      (أزرق كهربائي #00D4FF)
echo   [2]  إتقان الوسائط           (أرجواني نابض #9C27B0)
echo   [3]  ذكاء الملفات            (أخضر زمردي #00E676)
echo   [4]  امتياز الصور            (برتقالي غروب الشمس #FF6F00)
echo   [5]  قوة المستندات           (بنفسجي ملكي #6A1B9A)
echo.
echo   [6]  تحسين النظام            (أحمر قرمزي #C62828)
echo   [7]  استعادة البيانات        (فيروزي محيطي #00ACC1)
echo   [8]  منظف الخصوصية           (رمادي فولاذي #546E7A)
echo   [9]  أدوات الشبكة            (أخضر نيون #00FF00)
echo   [10] أدوات إبداعية           (أصفر ذهبي #FFD700)
echo.
echo   [P]  عرض الفلسفة والأساس
echo   [X]  العودة إلى القائمة الرئيسية
echo.
set /p choice="اختر الفئة [1-10, P, X]: "

if "%choice%"=="1" call "01_STORAGE_LIBERATION\00_STORAGE_LIBERATION_MENU.bat"
if "%choice%"=="2" call "02_MEDIA_MASTERY\00_MEDIA_MASTERY_MENU.bat"
if "%choice%"=="3" call "03_FILE_INTELLIGENCE\00_FILE_INTELLIGENCE_MENU.bat"
if "%choice%"=="4" call "04_IMAGE_EXCELLENCE\00_IMAGE_EXCELLENCE_MENU.bat"
if "%choice%"=="5" call "05_DOCUMENT_POWER\00_DOCUMENT_POWER_MENU.bat"

if "%choice%"=="6" call "06_SYSTEM_OPTIMIZATION\00_SYSTEM_OPTIMIZATION_MENU.bat"
if "%choice%"=="7" call "07_DATA_RECOVERY\00_DATA_RECOVERY_MENU.bat"
if "%choice%"=="8" call "08_PRIVACY_CLEANER\00_PRIVACY_CLEANER_MENU.bat"
if "%choice%"=="9" call "09_NETWORK_UTILITIES\00_NETWORK_UTILITIES_MENU.bat"
if "%choice%"=="10" call "10_CREATIVE_TOOLS\00_CREATIVE_TOOLS_MENU.bat"

if /i "%choice%"=="P" goto PHILOSOPHY
if /i "%choice%"=="X" exit

echo اختيار غير صالح! اضغط أي مفتاح للمحاولة مرة أخرى...
pause >nul
goto MAIN

:PHILOSOPHY
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /16/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ============================================================
echo              الفلسفة الأساسية - رسالة العلامة التجارية
echo ============================================================
echo.
echo "لطالما احتجزت صناعة البرمجيات الأدوات الأساسية خلف أسعار
echo متميزة لفترة طويلة جدًا. أدوات اكتشاف الملفات المكررة؟
echo 50 دولارًا. أدوات تحليل جودة الصور؟ 40 دولارًا.
echo أدوات تحسين الفيديو؟ 60 دولارًا.
echo.
echo نرفض هذا الندرة الاصطناعية.
echo KNOUX موجود هنا - وكل الأداة التي تحتاجها تأتي مع الحماية
echo التي تستحقها. لا مبيعات إضافية. لا اشتراكات. لا تنازلات."
echo.
echo ------------------------------------------------------------
echo        "كسر قيود الأدوات باهظة الثمن"
echo ------------------------------------------------------------
echo.
echo اضغط أي مفتاح للعودة...
pause >nul
goto MAIN
