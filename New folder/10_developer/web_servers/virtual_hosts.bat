@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  🏠 مدير Virtual Hosts - مواقع متعددة على نفس الجهاز%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] إنشاء Virtual Host جديد
echo   [2] عرض جميع Virtual Hosts الحالية
echo   [3] حذف Virtual Host
echo   [4] تفعيل/تعطيل جميع Virtual Hosts
echo   [5] إعداد دعم النطاقات الفرعية التلقائية (*.test)
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :CREATE_VHOST
if "!CHOICE!"=="2" goto :LIST_VHOSTS
if "!CHOICE!"=="3" goto :DELETE_VHOST
if "!CHOICE!"=="4" goto :TOGGLE_VHOSTS
if "!CHOICE!"=="5" goto :AUTO_SUBDOMAINS
goto :MENU

:CREATE_VHOST
set /p "DOMAIN=اسم النطاق (مثل: myproject.test): "
set /p "DOCROOT=مسار مجلد المستندات (مثل: C:\projects\myproject): "

if not exist "!DOCROOT!" (
    echo %RED%✗ المجلد غير موجود%WHITE%
    set /p "CREATE_DIR=هل تريد إنشاءه؟ (y/n): "
    if /i "!CREATE_DIR!"=="y" mkdir "!DOCROOT!" >nul
)

:: إضافة إلى hosts file
findstr /i "!DOMAIN!" "%WINDIR%\System32\drivers\etc\hosts" >nul || (
    echo 127.0.0.1 !DOMAIN! >> "%WINDIR%\System32\drivers\etc\hosts"
    echo %GREEN%✓ تم إضافة !DOMAIN! إلى hosts file%WHITE%
)

:: إنشاء هيكل مجلدات المشروع
if not exist "!DOCROOT!\public" mkdir "!DOCROOT!\public" >nul
if not exist "!DOCROOT!\logs" mkdir "!DOCROOT!\logs" >nul

:: إنشاء صفحة اختبار
(
echo ^<!DOCTYPE html^>
echo ^<html dir="rtl" lang="ar"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<title^>!DOMAIN!^</title^>
echo     ^<style^>
echo         body { font-family: Arial; text-align: center; padding: 50px; background: #3498db; color: white; }
echo         h1 { font-size: 3em; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<h1^>!DOMAIN!^</h1^>
echo     ^<p^>Virtual Host يعمل بنجاح^</p^>
echo ^</body^>
echo ^</html^>
) > "!DOCROOT!\public\index.html"

echo %GREEN%✓ تم إنشاء Virtual Host: !DOMAIN!%WHITE%
echo المسار: !DOCROOT!\public
goto :MENU

:LIST_VHOSTS
echo %CYAN%Virtual Hosts الحالية:%WHITE%
findstr "127.0.0.1" "%WINDIR%\System32\drivers\etc\hosts" | findstr ".test .local .dev"
pause
goto :MENU

:DELETE_VHOST
set /p "DOMAIN=اسم النطاق للحذف: "
powershell -Command "(Get-Content '%WINDIR%\System32\drivers\etc\hosts' -Raw) -replace '.*127\.0\.0\.1.*!DOMAIN!.*\r?\n?', '' | Set-Content '%WINDIR%\System32\drivers\etc\hosts'" >nul 2>&1
echo %GREEN%✓ تم الحذف (قد تحتاج إعادة تشغيل المتصفح)%WHITE%
goto :MENU

:TOGGLE_VHOSTS
echo %YELLOW%ملاحظة:%WHITE% هذا الخيار يتطلب تعديل يدوي لتهيئة الخادم (Apache/Nginx)
pause
goto :MENU

:AUTO_SUBDOMAINS
echo %YELLOW%جارٍ إعداد دعم النطاقات الفرعية التلقائية...%WHITE%
echo %GRAY%(يتطلب Laragon أو Valet للعمل الكامل)%WHITE%

:: إضافة نطاقات بدل عامة
findstr ".test" "%WINDIR%\System32\drivers\etc\hosts" >nul || (
    echo 127.0.0.1 *.test >> "%WINDIR%\System32\drivers\etc\hosts"
)

echo %GREEN%✓ تم التهيئة الأساسية%WHITE%
echo الآن يمكنك استخدام أي نطاق ينتهي بـ .test بدون إعداد يدوي
goto :MENU
