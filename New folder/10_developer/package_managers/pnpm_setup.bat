@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  ⚡ PNPM - أسرع مدير حزم (Ecosystem-friendly)%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

pnpm -v >nul 2>&1 && (
    echo %GREEN%✓ PNPM مثبت مسبقًا%WHITE%
    pnpm -v
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
powershell -Command "iwr https://get.pnpm.io/install.ps1  -useb | iex" >nul 2>&1

pnpm -v >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%البديل: npm install -g pnpm%WHITE%
    npm install -g pnpm >nul 2>&1 || exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
pnpm -v

echo.
echo %CYAN%لماذا PNPM؟%WHITE%
echo   ✓ أسرع بـ 2-3x من NPM/Yarn
echo   ✓ يوفر 70% من مساحة التخزين (Hard Links)
echo   ✓ متوافق تمامًا مع package.json
echo.
echo %CYAN%البدء:%WHITE% pnpm install في مجلد مشروعك

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed PNPM (ultra-fast package manager) >> "!LOG_FILE!"

timeout /t 5 >nul
