@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🪶 WinGet - مدير الحزم الرسمي من مايكروسوفت%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:: فحص التثبيت (مدمج في Windows 10 1809+ و Windows 11)
winget --info >nul 2>&1 || (
    echo %YELLOW%WinGet غير مثبت أو يحتاج تحديث%WHITE%
    echo %YELLOW%الحل التلقائي:%WHITE%
    
    :: محاولة التثبيت عبر App Installer من المتجر
    start ms-appinstaller:?source=https://apps.microsoft.com/detail/9nblggh4nns1 
    echo %CYAN%تم فتح متجر مايكروسوفت لتثبيت App Installer...%WHITE%
    echo %GRAY%(أغلق هذه النافذة بعد التثبيت وأعد التشغيل)%WHITE%
    timeout /t 10 >nul
    exit /b 0
)

:: عرض المعلومات
for /f "tokens=2*" %%a in ('winget --info ^| findstr "Version"') do set "VER=%%b"
echo %GREEN%✓ WinGet جاهز للعمل%WHITE%
echo الإصدار: %CYAN%!VER!%WHITE%

:: تحسين الإعدادات
echo.
echo %YELLOW%جارٍ تحسين الإعدادات...%WHITE%
winget settings >nul 2>&1

:: إنشاء ملف إعدادات مخصص
set "SETTINGS_PATH=%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
if exist "!SETTINGS_PATH!" (
    powershell -Command "(Get-Content '!SETTINGS_PATH!' -Raw) -replace '\"source\": \[\]', '\"source\": [{\"name\": \"winget\", \"type\": \"Microsoft.Winget.Source_8wekyb3d8bbwe\"}]' | Set-Content '!SETTINGS_PATH!'" >nul 2>&1
)

echo %GREEN%✓ تم التحسين:%WHITE%
echo   - تفعيل المصادر الرسمية
echo   - تحسين سرعة البحث

echo.
echo %CYAN%أوامر أساسية:%WHITE%
echo   winget install AppName          ← تثبيت تطبيق
echo   winget search keyword           ← البحث
echo   winget upgrade --all            ← تحديث الكل
echo   winget export -o apps.json      ← تصدير قائمة التطبيقات
echo   winget import -i apps.json      ← استيراد واستعادة

:: تسجيل العملية
echo [!TIMESTAMP!] INFO: WinGet configured and optimized (v!VER!) >> "!LOG_FILE!"

timeout /t 6 >nul
