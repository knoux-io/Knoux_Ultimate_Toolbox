@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "APACHE_DIR=C:\Apache24"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %ORANGE%===================================================%WHITE%
echo %ORANGE%  🐆 Apache HTTP Server 2.4 - خادم الويب الكلاسيكي%WHITE%
echo %ORANGE%===================================================%WHITE%
echo.

:CHECK_EXISTING
sc query Apache2.4 >nul 2>&1 && (
    echo %GREEN%✓ Apache قيد التشغيل%WHITE%
    "%APACHE_DIR%\bin\httpd.exe" -v
    goto :CONFIGURE
)

echo %YELLOW%[1/4] جارٍ التنزيل من الموقع الرسمي...%WHITE%
call :LOADING_ANIMATION 6

set "ZIP=%TEMP%\httpd.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://archive.apache.org/dist/httpd/binaries/win64/httpd-2.4.58-win64-VS16.zip' -OutFile '!ZIP!'" >nul 2>&1

if not exist "!ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://httpd.apache.org/download.cgi%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

echo %YELLOW%[2/4] جارٍ الاستخراج...%WHITE%
powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath 'C:\' -Force" >nul 2>&1
del "!ZIP!" >nul 2>&1

if not exist "!APACHE_DIR!" (
    echo %RED%✗ فشل الاستخراج%WHITE%
    exit /b 1
)

:CONFIGURE
echo %YELLOW%[3/4] جارٍ التهيئة للغة العربية...%WHITE%

:: تعديل ملف httpd.conf
set "CONF=!APACHE_DIR!\conf\httpd.conf"

:: تعيين مسار الخادم
powershell -Command "(Get-Content '!CONF!' -Raw) -replace 'Define SRVROOT.*', 'Define SRVROOT \"C:/Apache24\"' | Set-Content '!CONF!'" >nul 2>&1

:: تفعيل الوحدات المهمة
powershell -Command "(Get-Content '!CONF!' -Raw) -replace '#LoadModule rewrite_module', 'LoadModule rewrite_module' | Set-Content '!CONF!'" >nul 2>&1
powershell -Command "(Get-Content '!CONF!' -Raw) -replace '#LoadModule deflate_module', 'LoadModule deflate_module' | Set-Content '!CONF!'" >nul 2>&1
powershell -Command "(Get-Content '!CONF!' -Raw) -replace '#LoadModule headers_module', 'LoadModule headers_module' | Set-Content '!CONF!'" >nul 2>&1

:: تعيين ترميز يونيكود للعربية
(
echo.
echo # === إعدادات اللغة العربية ===
echo AddDefaultCharset UTF-8
echo IndexOptions +Charset=UTF-8
echo AddCharset UTF-8 .html .htm .css .js .json .xml
) >> "!CONF!"

echo %YELLOW%[4/4] جارٍ تثبيت الخدمة...%WHITE%
"!APACHE_DIR!\bin\httpd.exe" -k install >nul 2>&1
net start Apache2.4 >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل بدء الخدمة - تحقق من تعارض المنافذ%WHITE%
    echo %YELLOW%الحل: تأكد من إيقاف IIS أو أي خادم ويب آخر على المنفذ 80%WHITE%
    exit /b 1
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت والتهيئة الكاملة!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المسار: %GRAY%!APACHE_DIR!%WHITE%
echo   المنفذ: %GRAY%80%WHITE%
echo   المستندات: %GRAY%!APACHE_DIR!\htdocs%WHITE%
echo   السجلات: %GRAY%!APACHE_DIR!\logs%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الاختبار:%WHITE% افتح المتصفح واذهب إلى: %CYAN%http://localhost%WHITE%
echo.
echo %YELLOW%أوامر مفيدة:%WHITE%
echo   net stop Apache2.4    ← إيقاف الخادم
echo   net start Apache2.4   ← تشغيل الخادم
echo   httpd -t              ← فحص صحة التهيئة

:: إنشاء صفحة اختبار بالعربية
(
echo ^<!DOCTYPE html^>
echo ^<html dir="rtl" lang="ar"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<title^>مرحباً بك في خادم Apache^</title^>
echo     ^<style^>
echo         body { font-family: 'Segoe UI', Tahoma, sans-serif; text-align: center; padding: 50px; background: #f5f5f5; }
echo         .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); max-width: 600px; margin: 0 auto; }
echo         h1 { color: #d32323; }
echo         .icon { font-size: 48px; margin-bottom: 20px; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="container"^>
echo         ^<div class="icon"^>🐆^</div^>
echo         ^<h1^>خادم Apache يعمل بنجاح!^</h1^>
echo         ^<p^>تم التثبيت بواسطة Knoux Ultimate Toolbox^</p^>
echo         ^<p^>الوقت الحالي: ^<span id="time"^>^</span^>^</p^>
echo     ^</div^>
echo     ^<script^>document.getElementById('time').textContent = new Date().toLocaleString('ar-EG');^</script^>
echo ^</body^>
echo ^</html^>
) > "!APACHE_DIR!\htdocs\index.html"

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Apache HTTP Server 2.4 with Arabic support >> "!LOG_FILE!"

timeout /t 8 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
