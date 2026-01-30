@echo off
:: =================================================================
:: KNOUX DOCKER COMPOSE INSTALLER
:: تثبيت Docker Compose مع مكتبة القوالب
:: =================================================================
title Knoux - Docker Compose Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX DOCKER COMPOSE + TEMPLATE LIBRARY
echo   تثبيت Docker Compose مع مكتبة القوالب
echo ═══════════════════════════════════════════════════════════
echo.

:: Check if Docker is installed
echo [Knoux] جاري فحص Docker...
where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo [✗] Docker غير مثبت!
    echo [→] يرجى تثبيت Docker Desktop أولاً
    pause
    exit /b 1
)

echo [→] جاري تثبيت Docker Compose...
winget install Docker.DockerCompose --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/docker/compose/releases/latest/download/docker-compose-Windows-x86_64.exe' -OutFile '$env:TEMP\docker-compose.exe'"
    move "$env:TEMP\docker-compose.exe" "C:\Program Files\Docker\docker-compose.exe"
)

echo [✓] تم تثبيت Docker Compose!
docker-compose --version

:: Create template library
echo [→] جاري إنشاء مكتبة القوالب...
set "TEMPLATES_DIR=%USERPROFILE%\Knoux_Docker_Templates"
if not exist "%TEMPLATES_DIR%" mkdir "%TEMPLATES_DIR%"

:: Create Node.js template
(
    echo version: '3.8'
    echo services:
    echo   app:
    echo     build: .
    echo     ports:
    echo       - "3000:3000"
    echo     volumes:
    echo       - .:/app
    echo       - /app/node_modules
    echo     environment:
    echo       - NODE_ENV=development
    echo     command: npm run dev
) > "%TEMPLATES_DIR%\docker-compose.node.yml"

:: Create Python template
(
    echo version: '3.8'
    echo services:
    echo   app:
    echo     build: .
    echo     ports:
    echo       - "8000:8000"
    echo     volumes:
    echo       - .:/app
    echo     environment:
    echo       - PYTHONPATH=/app
    echo     command: python manage.py runserver 0.0.0.0:8000
) > "%TEMPLATES_DIR%\docker-compose.python.yml"

:: Create WordPress template
(
    echo version: '3.8'
    echo services:
    echo   db:
    echo     image: mysql:5.7
    echo     volumes:
    echo       - db_data:/var/lib/mysql
    echo     restart: always
    echo     environment:
    echo       MYSQL_ROOT_PASSWORD: knoux123
    echo       MYSQL_DATABASE: wordpress
    echo       MYSQL_USER: wordpress
    echo       MYSQL_PASSWORD: knoux123
    echo   wordpress:
    echo     depends_on:
    echo       - db
    echo     image: wordpress:latest
    echo     ports:
    echo       - "8000:80"
    echo     restart: always
    echo     environment:
    echo       WORDPRESS_DB_HOST: db:3306
    echo       WORDPRESS_DB_USER: wordpress
    echo       WORDPRESS_DB_PASSWORD: knoux123
    echo       WORDPRESS_DB_NAME: wordpress
    echo volumes:
    echo       - ./wp-content:/var/www/html/wp-content
    echo volumes:
    echo   db_data: {}
) > "%TEMPLATES_DIR%\docker-compose.wordpress.yml"

echo [✓] تم إنشاء مكتبة القوالب!
echo [→] المسار: %TEMPLATES_DIR%

:: Create Compose manager
echo [→] جاري إنشاء مدير Docker Compose...
(
    echo @echo off
    echo title Knoux Docker Compose Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX DOCKER COMPOSE MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] إنشاء مشروع جديد
    echo echo [2] استخدام قالب Node.js
    echo echo [3] استخدام قالب Python
    echo echo [4] استخدام قالب WordPress
    echo echo [5] بدء الحاويات
    echo echo [6] إيقاف الحاويات
    echo echo [7] إعادة بناء الحاويات
    echo echo [8] عرض سجلات الحاويات
    echo echo [9] تنظيف الحاويات
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" goto :NEW_PROJECT
    echo if "%%choice%%"=="2" goto :NODE_TEMPLATE
    echo if "%%choice%%"=="3" goto :PYTHON_TEMPLATE
    echo if "%%choice%%"=="4" goto :WORDPRESS_TEMPLATE
    echo if "%%choice%%"=="5" docker-compose up -d
    echo if "%%choice%%"=="6" docker-compose down
    echo if "%%choice%%"=="7" docker-compose up --build -d
    echo if "%%choice%%"=="8" docker-compose logs -f
    echo if "%%choice%%"=="9" docker-compose down -v --remove-orphans
    echo if "%%choice%%"=="0" exit /b
    echo pause
    echo goto MENU
    echo.
    echo :NODE_TEMPLATE
    echo copy "%USERPROFILE%\Knoux_Docker_Templates\docker-compose.node.yml" docker-compose.yml
    echo echo [✓] تم نسخ قالب Node.js!
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_docker_compose_manager.bat"

echo [✓] تم إنشاء مدير Docker Compose!
echo [→] المسار: %USERPROFILE%\knoux_docker_compose_manager.bat

echo [✓] Docker Compose جاهز للاستخدام!
echo [→] القوالب المتاحة: Node.js, Python, WordPress
pause
