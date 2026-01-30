@echo off
:: =================================================================
:: KNOUX NGINX INSTALLER
:: تثبيت Nginx مع مدير التكوين
:: =================================================================
title Knoux - Nginx Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX NGINX + CONFIGURATION MANAGER
echo   تثبيت Nginx مع مدير التكوين
echo ═══════════════════════════════════════════════════════════
echo.

:: Check Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [✗] يلزم صلاحيات المسؤول!
    echo [→] يرجى تشغيل كمسؤول
    pause
    exit /b 1
)

echo [→] جاري تثبيت Nginx...
winget install nginx.nginx --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://nginx.org/download/nginx-1.25.3.zip' -OutFile '$env:TEMP\nginx.zip'"
    powershell -Command "Expand-Archive -Path '$env:TEMP\nginx.zip' -DestinationPath 'C:\nginx' -Force"
)

echo [✓] تم تثبيت Nginx!

:: Create configuration manager
echo [→] جاري إنشاء مدير التكوين...
set "NGINX_CONF_DIR=C:\nginx\conf"
set "NGINX_HTML_DIR=C:\nginx\html"

:: Create basic configuration
(
    echo worker_processes 1;
    echo events {
    echo     worker_connections 1024;
    echo }
    echo http {
    echo     include       mime.types;
    echo     default_type  application/octet-stream;
    echo     sendfile        on;
    echo     keepalive_timeout  65;
    echo     
    echo     server {
    echo         listen       80;
    echo         server_name  localhost;
    echo         
    echo         location / {
    echo             root   html;
    echo             index  index.html index.htm;
    echo         }
    echo         
    echo         error_page   500 502 503 504  /50x.html;
    echo         location = /50x.html {
    echo             root   html;
    echo         }
    echo     }
    echo }
) > "%NGINX_CONF_DIR%\nginx.conf"

:: Create virtual host template
(
    echo server {
    echo     listen 80;
    echo     server_name example.com www.example.com;
    echo     
    echo     root "C:/nginx/html/example";
    echo     index index.html index.php;
    echo     
    echo     location / {
    echo         try_files $uri $uri/ =404;
    echo     }
    echo     
    echo     location ~ \.php$ {
    echo         fastcgi_pass 127.0.0.1:9000;
    echo         fastcgi_index index.php;
    echo         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    echo         include fastcgi_params;
    echo     }
    echo }
) > "%NGINX_CONF_DIR%\vhost_template.conf"

:: Create HTML page
(
    echo ^<!DOCTYPE html^>
    echo ^<html^>
    echo ^<head^>
    echo     ^<title^>Knoux Nginx Server^</title^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<h1^>🚀 Knoux Nginx Server^</h1^>
    echo     ^<p^>Server is running successfully!^</p^>
    echo     ^<p^>Time: %date% %time%^</p^>
    echo ^</body^>
    echo ^</html^>
) > "%NGINX_HTML_DIR%\index.html"

echo [✓] تم إنشاء التكوين الأساسي!

:: Create Nginx manager
(
    echo @echo off
    echo title Knoux Nginx Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX NGINX MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] بدء Nginx
    echo echo [2] إيقاف Nginx
    echo echo [3] إعادة تشغيل Nginx
    echo echo [4] اختبار التكوين
    echo echo [5] عرض الحالة
    echo echo [6] إضافة Virtual Host
    echo echo [7] عرض السجلات
    echo echo [8] تنظيف السجلات
    echo echo [9] فتح في المتصفح
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" cd /d C:\nginx ^&^& nginx.exe
    echo if "%%choice%%"=="2" cd /d C:\nginx ^&^& nginx.exe -s stop
    echo if "%%choice%%"=="3" cd /d C:\nginx ^&^& nginx.exe -s reload
    echo if "%%choice%%"=="4" cd /d C:\nginx ^&^& nginx.exe -t
    echo if "%%choice%%"=="5" tasklist /fi "imagename eq nginx.exe"
    echo if "%%choice%%"=="6" goto :ADD_VHOST
    echo if "%%choice%%"=="7" type C:\nginx\logs\access.log
    echo if "%%choice%%"=="8" del C:\nginx\logs\*.log
    echo if "%%choice%%"=="9" start http://localhost
    echo if "%%choice%%"=="0" exit /b
    echo pause
    echo goto MENU
    echo.
    echo :ADD_VHOST
    echo set /p domain=اسم النطاق: 
    echo set /p path=مسار المجلد: 
    echo echo server {
    echo     listen 80;
    echo     server_name %%domain%%;
    echo     root "%%path%%";
    echo     index index.html;
    echo } ^>^> C:\nginx\conf\nginx.conf
    echo echo [✓] تم إضافة Virtual Host!
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_nginx_manager.bat"

echo [✓] تم إنشاء مدير Nginx!
echo [→] المسار: %USERPROFILE%\knoux_nginx_manager.bat

:: Create desktop shortcut
echo [→] جاري إنشاء اختصار سطح المكتب...
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Nginx Manager.lnk'); $Shortcut.TargetPath = '%USERPROFILE%\knoux_nginx_manager.bat'; $Shortcut.Save()"

echo [✓] تم إنشاء اختصار سطح المكتب!
echo [✓] Nginx جاهز للاستخدام!
echo [→] لتشغيل: C:\nginx\nginx.exe
echo [→] للإدارة: %USERPROFILE%\knoux_nginx_manager.bat
pause
