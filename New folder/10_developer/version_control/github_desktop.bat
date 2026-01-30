@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🐙🐱 GitHub Desktop - واجهة رسومية لـ GitHub%WHITE%
echo %RED%===================================================%WHITE%
echo.

where github.exe >nul 2>&1 && (
    echo %GREEN%✓ GitHub Desktop مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id GitHub.GitHubDesktop --silent >nul 2>&1

where github.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://desktop.github.com/%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:: التكامل مع مستعرضات الويب
echo %YELLOW%جارٍ تهيئة التكامل مع المتصفح...%WHITE%
assoc .git=GitHubURL >nul 2>&1

echo %CYAN%المزايا الرئيسية:%WHITE%
echo   ✓ واجهة بديهية للمبتدئين
echo   ✓ عرض مرئي للتغييرات (Diff Viewer)
echo   ✓ دعم كامل لـ Pull Requests
echo   ✓ تبديل فروع سهل (Branch Switching)
echo   ✓ تكامل مع GitHub Issues
echo   ✓ دعم Git LFS للملفات الكبيرة
echo.
echo %YELLOW%للاستخدام الأول:%WHITE%
echo   1. افتح GitHub Desktop
echo   2. سجّل الدخول بحساب GitHub الخاص بك
echo   3. استورد مستودع موجود أو استنسخ واحدًا جديدًا

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed GitHub Desktop GUI client >> "!LOG_FILE!"

timeout /t 6 >nul
