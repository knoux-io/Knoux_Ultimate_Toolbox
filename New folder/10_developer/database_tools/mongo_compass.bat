@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🧭 MongoDB Compass - واجهة رسومية لـ MongoDB%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

where mongocompass.exe >nul 2>&1 && (
    echo %GREEN%✓ MongoDB Compass مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id MongoDB.Compass.Full --silent >nul 2>&1

where mongocompass.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%المزايا الرئيسية:%WHITE%
echo   ✓ واجهة بصرية لاستكشاف البيانات والمستندات
echo   ✓ مُنشئ استعلامات مرئي (بدون كتابة كود)
echo   ✓ تحليل أداء الاستعلامات (Explain Plan)
echo   ✓ تصور بيانات جغرافية (GeoJSON)
echo   ✓ دعم كامل لـ Aggregation Pipeline
echo   ✓ مراقبة الأداء في الوقت الفعلي

echo.
echo %YELLOW%للاستخدام:%WHITE%
echo   1. افتح MongoDB Compass
echo   2. أدخل سلسلة الاتصال: mongodb://localhost:27017
echo   3. أدخل بيانات المصادقة (إذا مكّنت الأمان)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed MongoDB Compass GUI >> "!LOG_FILE!"

timeout /t 5 >nul
