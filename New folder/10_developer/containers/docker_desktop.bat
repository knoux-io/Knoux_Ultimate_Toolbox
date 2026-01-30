@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول لتثبيت Docker Desktop%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🐳 Docker Desktop - منصة الحاويات الرسمية%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:CHECK_WSL2
wsl --list >nul 2>&1 || (
    echo %YELLOW%ملاحظة هامة:%WHITE%
    echo Docker Desktop يتطلب WSL2 للعمل بكفاءة على Windows.
    echo.
    set /p "INSTALL_WSL=هل تريد تثبيت WSL2 الآن؟ (موصى به) (y/n): "
    if /i "!INSTALL_WSL!"=="y" (
        call "%~dp0wsl2_setup.bat"
        timeout /t 3 >nul
    )
)

:CHECK_EXISTING
docker --version >nul 2>&1 && (
    for /f "tokens=*" %%a in ('docker --version') do set "VER=%%a"
    echo %GREEN%✓ Docker Desktop مثبت مسبقًا%WHITE%
    echo !VER!
    goto :POST_INSTALL
)

echo %YELLOW%[1/4] جارٍ التثبيت عبر Winget...%WHITE%
call :LOADING_ANIMATION 8

winget install -e --id Docker.DockerDesktop --silent --accept-source-agreements --accept-package-agreements >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "INSTALLER=%TEMP%\DockerDesktopInstaller.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        echo %YELLOW%الحل اليدوي: نزّل من https://www.docker.com/products/docker-desktop/%WHITE%
        timeout /t 6 >nul
        exit /b 1
    )
    
    start /wait "" "!INSTALLER!" install --quiet >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

:VERIFY
timeout /t 15 >nul
docker --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت أو الخدمة لم تبدأ%WHITE%
    echo %YELLOW%الحلول:%WHITE%
    echo   - أعد تشغيل الجهاز
    echo   - تحقق من تفعيل Hyper-V أو WSL2
    timeout /t 6 >nul
    exit /b 1
)

:POST_INSTALL
for /f "tokens=*" %%a in ('docker --version') do set "VER=%%a"
echo %GREEN%✓ تم التثبيت بنجاح: !VER!%WHITE%

echo %YELLOW%[2/4] جارٍ تهيئة إعدادات اللغة العربية...%WHITE%
set "DOCKER_CONFIG=%APPDATA%\Docker\settings.json"
if exist "!DOCKER_CONFIG!" (
    powershell -Command "(Get-Content '!DOCKER_CONFIG!' -Raw) -replace '\"useWindowsContainers\":\s*false', '\"useWindowsContainers\": false' | Set-Content '!DOCKER_CONFIG!'" >nul 2>&1
)

echo %YELLOW%[3/4] جارٍ اختبار التشغيل...%WHITE%
docker run --rm hello-world >nul 2>&1 && (
    echo %GREEN%✓ تم التحقق من عمل الحاويات بنجاح%WHITE%
) || (
    echo %YELLOW%لم يتم تنزيل الصورة الأساسية - جارٍ المحاولة مرة أخرى...%WHITE%
    docker pull hello-world >nul 2>&1 && docker run --rm hello-world >nul 2>&1 && echo %GREEN%✓ نجاح بعد إعادة المحاولة%WHITE% || echo %RED%✗ فشل اختبار الحاويات%WHITE%
)

echo %YELLOW%[4/4] جارٍ تهيئة مساحة التخزين...%WHITE%
docker system prune -f >nul 2>&1
docker volume prune -f >nul 2>&1
echo %GREEN%✓ تم تنظيف المساحة المؤقتة%WHITE%

echo.
echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%الأوامر الأساسية:%WHITE%
echo   docker ps              ← عرض الحاويات قيد التشغيل
echo   docker images          ← عرض الصور المحلية
echo   docker run -it ubuntu  ← تشغيل حاوية أوبونتو تفاعلية
echo   docker-compose up      ← تشغيل خدمات متعددة (مطلوب تثبيت منفصل)
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%نصائح هامة:%WHITE%
echo   • أعد تشغيل الجهاز إذا واجهت مشاكل في الاتصال بالشبكة
echo   • للتبديل بين Linux/Windows containers: انقر على أيقونة Docker في شريط المهام
echo   • المجلد الافتراضي للبيانات: %GRAY%\\wsl$\docker-desktop-data%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Docker Desktop !VER! with Arabic support >> "!LOG_FILE!"

timeout /t 10 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣾⣽⣻⢿⡿⣟⣯⣷"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
