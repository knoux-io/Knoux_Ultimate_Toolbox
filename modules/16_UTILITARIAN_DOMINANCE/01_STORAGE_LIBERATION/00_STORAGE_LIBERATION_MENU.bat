@echo off
chcp 65001 >nul
title KNOX - تحرير مساحة التخزين (أزرق كهربائي #00D4FF)
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
echo        الفئة 1: تحرير مساحة التخزين (أزرق كهربائي)
echo            "كل بايت له قيمة - وكل بايت تم توفيره هو انتصار"
echo =======================================================
echo.
echo الأدوات المتاحة:
echo.
echo   [1]  مدمر الملفات المكررة - Duplicate File Destroyer
echo   [2]  صائد الملفات الكبيرة - Large File Hunter
echo   [3]  محلل حجم المجلدات - Folder Size Analyzer
echo   [4]  مزيل المجلدات الفارغة - Empty Folder Remover
echo   [5]  منظف الملفات المؤقتة - Temporary File Cleanser
echo.
echo   [6]  مكتشف الصور المكررة المتخصص - Duplicate Photo Finder
echo   [7]  كاشف الفيديو المكرر - Video Duplicate Detector
echo   [8]  محلل مزامنة تخزين السحابة - Cloud Storage Sync Analyzer
echo   [9]  محسن الأرشيف - Archive Optimizer
echo   [10] متوقع التخزين - Storage Forecaster
echo.
echo   [B]  العودة للقائمة الرئيسية
echo   [X]  الخروج
echo.
set /p choice="اختر الأداة [1-10, B, X]: "

if "%choice%"=="1" call "01_DUPLICATE_FILE_DESTROYER.bat"
if "%choice%"=="2" call "02_LARGE_FILE_HUNTER.bat"
if "%choice%"=="3" call "03_FOLDER_SIZE_ANALYZER.bat"
if "%choice%"=="4" call "04_EMPTY_FOLDER_REMOVER.bat"
if "%choice%"=="5" call "05_TEMPORARY_FILE_CLEANSER.bat"
if "%choice%"=="6" call "06_DUPLICATE_PHOTO_FINDER.bat"
if "%choice%"=="7" call "07_VIDEO_DUPLICATE_DETECTOR.bat"
if "%choice%"=="8" call "08_CLOUD_STORAGE_SYNC_ANALYZER.bat"
if "%choice%"=="9" call "09_ARCHIVE_OPTIMIZER.bat"
if "%choice%"=="10" call "10_STORAGE_FORECASTER.bat"

if /i "%choice%"=="B" exit
if /i "%choice%"=="X" exit

echo اختيار غير صالح! اضغط أي مفتاح للمحاولة مرة أخرى...
pause >nul
goto MENU
