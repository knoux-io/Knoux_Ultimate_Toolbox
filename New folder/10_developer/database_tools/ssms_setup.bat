@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  📋 SQL Server Management Studio (SSMS)%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

where ssms.exe >nul 2>&1 && (
    echo %GREEN%✓ SSMS مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
echo %GRAY%(الحجم: ~1.2 جيجابايت - قد يستغرق 5-15 دقيقة)%WHITE%

winget install -e --id Microsoft.SQLServerManagementStudio --silent --accept-source-agreements >nul 2>&1

where ssms.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://aka.ms/ssmsfullsetup%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%المزايا الرئيسية:%WHITE%
echo   ✓ واجهة رسومية كاملة لإدارة قواعد بيانات SQL Server
echo   ✓ محرر استعلامات متقدم مع إكمال تلقائي
echo   ✓ تصميم وتوليد التقارير (Report Builder)
echo   ✓ مراقبة الأداء والمؤشرات الحيوية
echo   ✓ تصدير/استيراد البيانات بتنسيقات متعددة
echo   ✓ دعم التحكم بالإصدار (Git integration)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed SQL Server Management Studio >> "!LOG_FILE!"

timeout /t 5 >nul
