@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

net session >nul 2>&1 || (
    echo %RED%⚠️  صلاحيات مسؤول مطلوبة%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

cls
echo %RED%===================================================%WHITE%
echo %RED%  ☕ Java JDK 17 (LTS) - الأكثر استخدامًا%WHITE%
echo %RED%===================================================%WHITE%
echo.

java -version 2>&1 | findstr "17" >nul && (
    echo %GREEN%✓ Java 17 مثبت مسبقًا%WHITE%
    java -version 2>&1 | findstr "version"
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id EclipseAdoptium.Temurin.17.JDK --silent >nul 2>&1

java -version 2>&1 | findstr "17" >nul || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:: تثبيت Maven تلقائيًا
echo %YELLOW%تثبيت Apache Maven...%WHITE%
winget install -e --id Apache.Maven --silent >nul 2>&1

echo %GREEN%✓ تم التثبيت الكامل (JDK 17 + Maven)!%WHITE%
java -version 2>&1 | findstr "version"
mvn -v 2>&1 | findstr "Apache Maven"

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Java JDK 17 with Maven >> "!LOG_FILE!"

timeout /t 4 >nul
