@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  ☸️  kubectl - أداة سطر أوامر Kubernetes%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

where kubectl.exe >nul 2>&1 && (
    for /f "tokens=*" %%a in ('kubectl version --client --short 2^>nul') do set "VER=%%a"
    echo %GREEN%✓ kubectl مثبت مسبقًا%WHITE%
    echo !VER!
    goto :CONFIGURE
)

echo %YELLOW%جارٍ التثبيت عبر Winget...%WHITE%
winget install -e --id Kubernetes.kubectl --silent >nul 2>&1

where kubectl.exe >nul 2>&1 || (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "KUBECTL=%TEMP%\kubectl.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://dl.k8s.io/release/v1.29.0/bin/windows/amd64/kubectl.exe' -OutFile '!KUBECTL!'" >nul 2>&1
    
    if not exist "!KUBECTL!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        exit /b 1
    )
    
    move "!KUBECTL!" "C:\Program Files\kubectl.exe" >nul 2>&1
    setx PATH "%PATH%;C:\Program Files" >nul
)

:CONFIGURE
echo %YELLOW%جارٍ إنشاء ملف التهيئة الافتراضي...%WHITE%
set "KUBE_DIR=%USERPROFILE%\.kube"
if not exist "!KUBE_DIR!" mkdir "!KUBE_DIR!" >nul

(
echo apiVersion: v1
echo clusters: []
echo contexts: []
echo current-context: ""
echo kind: Config
echo preferences: {}
echo users: []
) > "!KUBE_DIR!\config"

echo %GREEN%✓ تم الإعداد الأساسي%WHITE%

echo.
echo %CYAN%الأوامر الأساسية:%WHITE%
echo   kubectl get pods          ← عرض الحاويات قيد التشغيل
echo   kubectl get services      ← عرض الخدمات
echo   kubectl apply -f file.yaml ← تطبيق تكوين
echo   kubectl describe pod name ← عرض تفاصيل الحاوية
echo.
echo %YELLOW%للاستخدام مع بيئة محلية:%WHITE%
echo   1. شغّل minikube start لتثبيت بيئة محلية
echo   2. أو اتصل ببيئة سحابية (AWS EKS, Azure AKS, GCP GKE)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed kubectl for Kubernetes management >> "!LOG_FILE!"

timeout /t 6 >nul
