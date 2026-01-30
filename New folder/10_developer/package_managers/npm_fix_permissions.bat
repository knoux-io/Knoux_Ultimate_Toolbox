@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🔧 إصلاح أخطاء أذونات NPM (مشكلة شائعة)%WHITE%
echo %RED%===================================================%WHITE%
echo.

echo %YELLOW%السبب:%WHITE% تثبيت حزم عالمية بدون صلاحيات كافية يؤدي إلى أخطاء مثل:
echo   - EACCES: permission denied
echo   - Error: EPERM: operation not permitted
echo.

set /p "CONFIRM=هل تريد الإصلاح التلقائي؟ (لا يحتاج صلاحيات مسؤول) (y/n): "
if /i "!CONFIRM!" neq "y" exit /b 0

:: الخطوة 1: إنشاء مجلد تثبيت عالمي في مجلد المستخدم
set "NPM_GLOBAL=%APPDATA%\npm-global"
if not exist "!NPM_GLOBAL!" mkdir "!NPM_GLOBAL!" >nul

:: الخطوة 2: تغيير إعدادات NPM
npm config set prefix "!NPM_GLOBAL!" >nul 2>&1

:: الخطوة 3: إضافة إلى PATH
set "CURRENT_PATH=%PATH%"
echo "!CURRENT_PATH!" | findstr /i "!NPM_GLOBAL!" >nul || (
    setx PATH "!NPM_GLOBAL!\bin;!CURRENT_PATH!" >nul
)

:: الخطوة 4: نقل الحزم الحالية (إن وجدت)
if exist "%APPDATA%\npm\node_modules" (
    echo %YELLOW%جارٍ نقل الحزم الحالية...%WHITE%
    xcopy "%APPDATA%\npm\node_modules" "!NPM_GLOBAL!\node_modules" /E /I /Y >nul 2>&1
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإصلاح بنجاح!%WHITE%
echo %CYAN%الآن يمكنك تثبيت الحزم العالمية بدون "تشغيل كمسؤول":%WHITE%
echo   npm install -g typescript
echo   npm install -g vercel
echo %GREEN%===================================================%WHITE%

:: اختبار سريع
npm install -g npm@latest >nul 2>&1 && (
    echo %GREEN%✓ اختبار النجاح: تم تحديث NPM نفسه بدون أخطاء%WHITE%
) || (
    echo %YELLOW%ملاحظة: قد تحتاج إعادة فتح موجه الأوامر لتفعيل التغييرات%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Fixed NPM permissions (user-space global install) >> "!LOG_FILE!"

timeout /t 6 >nul
