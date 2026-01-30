@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🐳🐳 Docker Compose - إدارة خدمات متعددة%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

docker compose version >nul 2>&1 && (
    echo %GREEN%✓ Docker Compose مدمج مع Docker Desktop%WHITE%
    docker compose version
    timeout /t 3 >nul
    exit /b 0
)

where docker-compose >nul 2>&1 && (
    echo %GREEN%✓ Docker Compose مثبت مسبقًا%WHITE%
    docker-compose --version
    goto :MENU
)

:INSTALL
echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id Docker.DockerCompose --silent >nul 2>&1

where docker-compose >nul 2>&1 || (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "COMPOSE_URL=https://github.com/docker/compose/releases/latest/download/docker-compose-windows-x86_64.exe"
    powershell -Command "Invoke-WebRequest -Uri '!COMPOSE_URL!' -OutFile 'C:\Program Files\Docker\docker-compose.exe'" >nul 2>&1
)

:MENU
echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
echo.
echo %CYAN%الخيارات المتقدمة:%WHITE%
echo   [1] عرض النسخة الحالية
echo   [2] تحديث إلى أحدث إصدار
echo   [3] تثبيت إصدار محدد (للتوافق مع المشاريع القديمة)
echo   [4] إنشاء ملف docker-compose.yml نموذجي
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" docker-compose --version & pause & goto :MENU
if "!CHOICE!"=="2" goto :UPDATE
if "!CHOICE!"=="3" goto :SPECIFIC_VERSION
if "!CHOICE!"=="4" goto :CREATE_TEMPLATE
goto :MENU

:UPDATE
echo %YELLOW%جارٍ التحديث...%WHITE%
winget upgrade -e --id Docker.DockerCompose --silent >nul 2>&1
docker-compose --version
goto :MENU

:SPECIFIC_VERSION
set /p "VERSION=أدخل رقم الإصدار (مثل: 2.20.0): "
echo %YELLOW%جارٍ التثبيت...%WHITE%
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/docker/compose/releases/download/v!VERSION!/docker-compose-windows-x86_64.exe' -OutFile 'C:\Program Files\Docker\docker-compose.exe'" >nul 2>&1
docker-compose --version
goto :MENU

:CREATE_TEMPLATE
set "TEMPLATE=docker-compose.yml"
(
echo version: '3.8'
echo services:
echo   web:
echo     image: nginx:alpine
echo     ports:
echo       - "8080:80"
echo     volumes:
echo       - ./html:/usr/share/nginx/html:ro
echo   db:
echo     image: mysql:8.0
echo     environment:
echo       MYSQL_ROOT_PASSWORD: example
echo       MYSQL_DATABASE: app_db
echo     volumes:
echo       - db_data:/var/lib/mysql
echo volumes:
echo   db_data:
) > "!TEMPLATE!"

echo %GREEN%✓ تم إنشاء ملف نموذجي: !TEMPLATE!%WHITE%
echo %YELLOW%للاستخدام:%WHITE% docker-compose up -d
goto :MENU

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Docker Compose >> "!LOG_FILE!"
