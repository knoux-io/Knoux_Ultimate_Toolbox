@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🟢 VMware Workstation Player - افتراضية احترافية%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

where vmplayer.exe >nul 2>&1 && (
    echo %GREEN%✓ VMware Workstation Player مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت عبر Winget...%WHITE%
winget install -e --id VMware.WorkstationPlayer --silent --accept-source-agreements >nul 2>&1

where vmplayer.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.vmware.com/products/workstation-player.html%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%المزايا مقارنة بـ VirtualBox:%WHITE%
echo   ✓ أداء أفضل في تشغيل أنظمة التشغيل الضيفية
echo   ✓ دعم أفضل لأجهزة Windows الحديثة
echo   ✓ واجهة مستخدم أكثر سلاسة
echo   ✓ دعم رسمي لأنظمة macOS كضيوف (مع قيود)
echo.
echo %YELLOW%ملاحظة:%WHITE% النسخة المجانية (Player) كافية للاستخدام الشخصي
echo للفرق: هناك نسخة مدفوعة (Pro) مع ميزات إضافية

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed VMware Workstation Player >> "!LOG_FILE!"

timeout /t 5 >nul
