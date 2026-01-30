@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🦊 Insomnia - REST Client بديل قوي%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:CHECK_EXISTING
where Insomnia.exe >nul 2>&1 && (
    echo %GREEN%✓ Insomnia مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت عبر Winget...%WHITE%
winget install -e --id Insomnia.Insomnia --silent >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل من الموقع الرسمي...%WHITE%
    set "INSTALLER=%TEMP%\Insomnia.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/Kong/insomnia/releases/latest/download/Insomnia.Core-2023.5.8-full.nupkg' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        echo %YELLOW%الحل اليدوي: نزّل من https://insomnia.rest/download%WHITE%
        timeout /t 6 >nul
        exit /b 1
    )
    
    start /wait "" "!INSTALLER!" /S >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

where Insomnia.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%لماذا Insomnia؟%WHITE%
echo   ✓ مجاني تمامًا (Open Source)
echo   ✓ دعم GraphQL مدمج
echo   ✓ مزامنة عبر GitHub
echo   ✓ دعم Plugins
echo   ✓ واجهة بسيطة وسريعة
echo   ✓ دعم كامل لـ gRPC (في الإصدار Pro)
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. ابحث في قائمة ابدأ عن "Insomnia"
echo   2. أنشئ workspace جديد
echo   3. استورد Postman Collection (مدعومة)
echo   4. ابدأ بكتابة طلبات API

:: إنشاء ملف تعليمات
(
echo # Insomnia REST Client Setup
echo 
echo ## Features:
echo - REST API Testing
echo - GraphQL Support
echo - gRPC (Pro version)
echo - Environment Variables
echo - Code Generation
echo - Team Collaboration
echo 
echo ## Getting Started:
echo 1. Open Insomnia
echo 2. Create new workspace
echo 3. Add your first request
echo 4. Use Ctrl+N for new request
echo 5. Use Ctrl+Enter to send
) > "%USERPROFILE%\insomnia-guide.txt"

echo %GREEN%✓ تم إنشاء ملف تعليمات%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Insomnia REST Client >> "!LOG_FILE!"

timeout /t 6 >nul
