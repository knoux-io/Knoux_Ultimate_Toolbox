@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "NGINX_DIR=C:\nginx"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🚀 Nginx - خادم الويب عالي الأداء%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

if exist "!NGINX_DIR!" (
    echo %GREEN%✓ Nginx مثبت مسبقًا%WHITE%
    "!NGINX_DIR!\nginx.exe" -v
    goto :START_SERVER
)

echo %YELLOW%جارٍ التنزيل من الموقع الرسمي...%WHITE%
set "ZIP=%TEMP%\nginx.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://nginx.org/download/nginx-1.25.3.zip' -OutFile '!ZIP!'" >nul 2>&1

if not exist "!ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    exit /b 1
)

echo %YELLOW%جارٍ الاستخراج...%WHITE%
powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath 'C:\' -Force" >nul 2>&1
del "!ZIP!" >nul 2>&1

if not exist "!NGINX_DIR!" (
    echo %RED%✗ فشل الاستخراج%WHITE%
    exit /b 1
)

:START_SERVER
echo %YELLOW%جارٍ بدء الخادم...%WHITE%
taskkill /f /im nginx.exe >nul 2>&1
start "" "!NGINX_DIR!\nginx.exe"

timeout /t 2 >nul
tasklist | findstr "nginx.exe" >nul && (
    echo %GREEN%✓ تم التشغيل بنجاح%WHITE%
) || (
    echo %RED%✗ فشل التشغيل - تحقق من تعارض المنافذ%WHITE%
    exit /b 1
)

:: تهيئة ملف التكوين للعربية والأداء
set "CONF=!NGINX_DIR!\conf\nginx.conf"
(
echo worker_processes  auto;
echo events {
echo     worker_connections  1024;
echo }
echo http {
echo     include       mime.types;
echo     default_type  application/octet-stream;
echo     sendfile        on;
echo     tcp_nopush      on;
echo     tcp_nodelay     on;
echo     keepalive_timeout  65;
echo     gzip  on;
echo     gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
echo     charset utf-8;
echo     server {
echo         listen       8080;
echo         server_name  localhost;
echo         location / {
echo             root   html;
echo             index  index.html index.htm;
echo             charset utf-8;
echo         }
echo         error_page   500 502 503 504  /50x.html;
echo         location = /50x.html {
echo             root   html;
echo         }
echo     }
echo }
) > "!CONF!"

:: إنشاء صفحة اختبار
(
echo ^<!DOCTYPE html^>
echo ^<html dir="rtl" lang="ar"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<title^>مرحباً بك في Nginx^</title^>
echo     ^<style^>
echo         body { font-family: 'Segoe UI', Tahoma; text-align: center; padding: 50px; background: #2c3e50; color: white; }
echo         .container { background: #34495e; padding: 40px; border-radius: 10px; max-width: 600px; margin: 0 auto; }
echo         h1 { color: #3498db; font-size: 2.5em; }
echo         .rocket { font-size: 64px; margin: 20px 0; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="container"^>
echo         ^<div class="rocket"^>🚀^</div^>
echo         ^<h1^>Nginx يعمل بسرعة فائقة!^</h1^>
echo         ^<p^>خادم الويب المفضل للمواقع عالية الحركة^</p^>
echo         ^<p^>تم التثبيت بواسطة Knoux Toolbox^</p^>
echo     ^</div^>
echo ^</body^>
echo ^</html^>
) > "!NGINX_DIR!\html\index.html"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المسار: %GRAY%!NGINX_DIR!%WHITE%
echo   المنفذ: %GRAY%8080%WHITE% (لتلافي التعارض مع Apache/IIS)
echo   التحكم: %GRAY%!NGINX_DIR!\nginx.exe%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%أوامر التحكم:%WHITE%
echo   nginx -s stop     ← إيقاف الخادم
echo   nginx -s reload   ← إعادة تحميل التهيئة بدون إيقاف
echo   nginx -s reopen   ← إعادة فتح ملفات السجل
echo.
echo %YELLOW%الاختبار:%WHITE% افتح: %CYAN%http://localhost:8080%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Nginx 1.25.3 with performance optimizations >> "!LOG_FILE!"

timeout /t 6 >nul
