@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🧶 Yarn Package Manager - أسرع من NPM%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

yarn --version >nul 2>&1 && (
    echo %GREEN%✓ Yarn مثبت مسبقًا%WHITE%
    yarn --version
    goto :OPTIMIZE
)

:: الخيار 1: التثبيت عبر Corepack (موصى به - مدمج مع Node.js 16.10+)
echo %YELLOW%جارٍ التثبيت عبر Corepack (الطريقة الرسمية)...%WHITE%
corepack enable >nul 2>&1 && corepack prepare yarn@stable --activate >nul 2>&1

if errorlevel 1 (
    :: الخيار 2: التثبيت عبر npm
    echo %YELLOW%المحاولة عبر npm...%WHITE%
    npm install -g yarn >nul 2>&1
)

yarn --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:OPTIMIZE
echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
yarn --version

:: تحسين الأداء
echo %YELLOW%جارٍ تحسين أداء Yarn...%WHITE%
yarn config set cache-folder "%TEMP%\yarn-cache" >nul 2>&1
yarn config set network-timeout 600000 >nul 2>&1

echo %GREEN%✓ تم التحسين:%WHITE%
echo   - مجلد تخزين مؤقت في %TEMP%
echo   - مهلة شبكة ممتدة (10 دقائق)

echo.
echo %CYAN%أوامر سريعة:%WHITE%
echo   yarn install        ← تثبيت التبعيات
echo   yarn add package    ← إضافة حزمة
echo   yarn global add pkg ← تثبيت عالمي
echo   yarn upgrade-interactive ← تحديث تفاعلي

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Yarn !VER! with performance optimizations >> "!LOG_FILE!"

timeout /t 5 >nul
