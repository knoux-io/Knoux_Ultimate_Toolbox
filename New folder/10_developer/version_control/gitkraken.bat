@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  🐙🦑 GitKraken - واجهة احترافية للتحكم بالإصدار%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

where gitkraken.exe >nul 2>&1 && (
    echo %GREEN%✓ GitKraken مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id Axosoft.GitKraken --silent >nul 2>&1

where gitkraken.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.gitkraken.com/download%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%لماذا GitKraken؟%WHITE%
echo   ✓ واجهة رسومية جميلة مع دعم Dark Mode
echo   ✓ عرض شجري للـ Commit History (Graph)
echo   ✓ دعم كامل لـ GitHub, GitLab, Bitbucket
echo   ✓ مقارنة مرئية للتغييرات (Inline Diff)
echo   ✓ دمج تفاعلي (Interactive Rebase)
echo   ✓ دعم SSH Keys المدمج
echo   ✓ معاينة الصور في الـ Diff
echo.
echo %YELLOW%ملاحظة:%WHITE% النسخة المجانية كافية للاستخدام الشخصي
echo للفرق: هناك نسخة مدفوعة مع ميزات إضافية

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed GitKraken professional Git client >> "!LOG_FILE!"

timeout /t 6 >nul
