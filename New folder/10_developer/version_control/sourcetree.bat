@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🦎 Sourcetree - عميل Git من Atlassian%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

where sourcetree.exe >nul 2>&1 && (
    echo %GREEN%✓ Sourcetree مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id Atlassian.SourceTree --silent >nul 2>&1

where sourcetree.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.sourcetreeapp.com/%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%المزايا:%WHITE%
echo   ✓ مجاني تمامًا (بدون قيود)
echo   ✓ دعم كامل لـ Git و Mercurial
echo   ✓ تكامل مع Bitbucket و Jira
echo   ✓ واجهة بسيطة للمبتدئين
echo   ✓ عرض مرئي للـ Stash و Shelving
echo   ✓ دعم كامل لـ Submodules

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Sourcetree Git client >> "!LOG_FILE!"

timeout /t 5 >nul
