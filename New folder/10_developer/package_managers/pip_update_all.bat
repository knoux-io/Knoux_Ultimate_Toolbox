@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🔄 تحديث جميع حزم Python (PIP)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

python -c "import sys" >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    exit /b 1
)

echo %YELLOW%جارٍ جمع قائمة الحزم...%WHITE%
pip list --outdated --format=freeze > "%TEMP%\outdated.txt" 2>nul

if %errorlevel% neq 0 (
    echo %GREEN%✓ جميع الحزم محدثة%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%الحزم التي تحتاج تحديث:%WHITE%
type "%TEMP%\outdated.txt"

echo.
set /p "CONFIRM=هل تريد التحديث؟ (قد يستغرق عدة دقائق) (y/n): "
if /i "!CONFIRM!" neq "y" del "%TEMP%\outdated.txt" >nul & exit /b 0

echo %YELLOW%جارٍ التحديث...%WHITE%
for /f "tokens=1 delims==" %%a in (%TEMP%\outdated.txt) do (
    echo تحديث %%a...
    pip install --upgrade %%a >nul 2>&1
)

del "%TEMP%\outdated.txt" >nul

echo %GREEN%✓ اكتمل التحديث%WHITE%
pip list --outdated --format=columns | findstr /v "Package Version"

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Updated all outdated Python packages >> "!LOG_FILE!"

timeout /t 4 >nul
