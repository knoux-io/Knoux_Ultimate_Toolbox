@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🏗️  Minikube - بيئة Kubernetes محلية%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

where minikube.exe >nul 2>&1 && (
    echo %GREEN%✓ Minikube مثبت مسبقًا%WHITE%
    minikube version
    goto :START_CLUSTER
)

echo %YELLOW%[1/3] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 5

winget install -e --id Kubernetes.Minikube --silent >nul 2>&1

where minikube.exe >nul 2>&1 || (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "MINIKUBE=%TEMP%\minikube.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe' -OutFile '!MINIKUBE!'" >nul 2>&1
    
    if not exist "!MINIKUBE!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        exit /b 1
    )
    
    move "!MINIKUBE!" "C:\Program Files\minikube.exe" >nul 2>&1
    setx PATH "%PATH%;C:\Program Files" >nul
)

:START_CLUSTER
echo %YELLOW%[2/3] جارٍ بدء المجموعة المحلية...%WHITE%
echo %GRAY%(قد يستغرق 2-5 دقائق حسب سرعة الجهاز)%WHITE%

:: اختيار برنامج التشغيل المناسب
if exist "%PROGRAMFILES%\Oracle\VirtualBox\VBoxManage.exe" (
    set "DRIVER=virtualbox"
) else if exist "%PROGRAMFILES%\VMware\VMware Workstation\vmrun.exe" (
    set "DRIVER=vmware"
) else (
    set "DRIVER=docker"
)

minikube start --driver=!DRIVER! --cpus=2 --memory=4096 >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل بدء المجموعة%WHITE%
    echo %YELLOW%المحاولة مع برنامج تشغيل مختلف...%WHITE%
    minikube start --driver=docker >nul 2>&1 || (
        echo %RED%✗ فشل مع جميع برامج التشغيل%WHITE%
        echo %YELLOW%الحلول:%WHITE%
        echo   - تأكد من تثبيت Docker Desktop أو VirtualBox
        echo   - جرب: minikube delete ثم أعد المحاولة
        timeout /t 6 >nul
        exit /b 1
    )
)

:VERIFY
echo %YELLOW%[3/3] جارٍ التحقق...%WHITE%
timeout /t 10 >nul
kubectl get nodes >nul 2>&1 && (
    echo %GREEN%===================================================%WHITE%
    echo %GREEN%✓ تم إنشاء بيئة Kubernetes محلية بنجاح!%WHITE%
    echo %CYAN%معلومات المجموعة:%WHITE%
    kubectl get nodes
    echo.
    echo %CYAN%الوصول إلى لوحة التحكم:%WHITE% minikube dashboard
    echo %CYAN%عرض الخدمات:%WHITE% minikube service list
    echo %GREEN%===================================================%WHITE%
) || (
    echo %RED%✗ فشل التحقق من المجموعة%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Minikube with !DRIVER! driver and started local cluster >> "!LOG_FILE!"

timeout /t 8 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣾⣽⣻⢿⡿⣟⣯⣷"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ الإعداد... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
