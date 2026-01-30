@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🔄 تحديث جميع حزم NPM العالمية%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

npm -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    exit /b 1
)

echo %YELLOW%جارٍ فحص الحزم القديمة...%WHITE%
npm outdated -g --depth=0

echo.
set /p "CONFIRM=هل تريد التحديث الآن؟ (y/n): "
if /i "!CONFIRM!" neq "y" exit /b 0

echo %YELLOW%جارٍ التحديث...%WHITE%
for /f "skip=1 tokens=1" %%a in ('npm outdated -g --depth=0 2^>nul') do (
    echo تحديث %%a...
    npm update -g %%a >nul 2>&1
)

echo %GREEN%✓ اكتمل التحديث%WHITE%
npm list -g --depth=0

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Updated all global NPM packages >> "!LOG_FILE!"

timeout /t 4 >nul
