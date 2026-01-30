@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

net session >nul 2>&1 || (
    echo %RED%⚠️  صلاحيات مسؤول مطلوبة%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

cls
echo %RED%===================================================%WHITE%
echo %RED%  ☕ Java JDK 21 (LTS) - OpenJDK الرسمي%WHITE%
echo %RED%===================================================%WHITE%
echo.

:: فحص التثبيت الحالي
java -version 2>&1 | findstr "21" >nul && (
    echo %GREEN%✓ Java 21 مثبت مسبقًا%WHITE%
    java -version 2>&1 | findstr "version"
    goto :POST_INSTALL
)

echo %YELLOW%جارٍ التثبيت عبر Microsoft Build of OpenJDK...%WHITE%
call :LOADING_ANIMATION 5

:: التثبيت عبر winget
winget install -e --id Microsoft.OpenJDK.21 --silent --accept-source-agreements >nul 2>&1

:: التحقق
java -version 2>&1 | findstr "21" >nul || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%البديل: التحميل اليدوي من https://learn.microsoft.com/java%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:POST_INSTALL
:: إعداد متغيرات البيئة
set "JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.2+13"
if exist "!JAVA_HOME!" (
    setx JAVA_HOME "!JAVA_HOME!" >nul
    setx PATH "%%JAVA_HOME%%\bin;%%PATH%%" >nul
    echo %GREEN%✓ تم تعيين JAVA_HOME%WHITE%
)

echo %GREEN%✓ تم التثبيت بنجاح!%WHITE%
java -version 2>&1 | findstr "version"

echo.
echo %CYAN%المتغيرات المطلوبة:%WHITE%
echo   JAVA_HOME = %GRAY%!JAVA_HOME!%WHITE%
echo   PATH يحتوي على = %GRAY%!JAVA_HOME!\bin%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Java JDK 21 >> "!LOG_FILE!"

timeout /t 4 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=|/-\"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 4"
    <nul set /p "=جارٍ التثبيت... !SPINNER:~!POS!,1!   " <nul
    timeout /t 1 >nul
    echo !BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!    <nul
)
echo.
exit /b
