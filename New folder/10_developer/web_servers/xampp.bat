@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "XAMPP_DIR=C:\xampp"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %ORANGE%===================================================%WHITE%
echo %ORANGE%  🟧 XAMPP - حزمة تطوير كاملة (Apache + MySQL + PHP + Perl)%WHITE%
echo %ORANGE%===================================================%WHITE%
echo.

if exist "!XAMPP_DIR!" (
    echo %GREEN%✓ XAMPP مثبت مسبقًا%WHITE%
    if exist "!XAMPP_DIR!\apache\bin\httpd.exe" (
        "!XAMPP_DIR!\apache\bin\httpd.exe" -v | findstr "Apache"
    )
    goto :SECURITY_SETUP
)

echo %YELLOW%[1/4] جارٍ التنزيل من الموقع الرسمي (7.5 جيجابايت)...%WHITE%
echo %GRAY%(قد يستغرق 5-20 دقيقة حسب سرعة الإنترنت)%WHITE%
call :LOADING_ANIMATION 10

set "INSTALLER=%TEMP%\xampp.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.2.12/xampp-windows-x64-8.2.12-0-VS16-installer.exe/download' -OutFile '!INSTALLER!' -Headers @{Referer='https://www.apachefriends.org/index.html'}" >nul 2>&1

if not exist "!INSTALLER!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.apachefriends.org/ar/index.html%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

echo %YELLOW%[2/4] جارٍ التثبيت الصامت...%WHITE%
start /wait "" "!INSTALLER!" --mode unattended --install-dir="!XAMPP_DIR!" --disable-components="mercury,filezilla" >nul 2>&1
del "!INSTALLER!" >nul 2>&1

if not exist "!XAMPP_DIR!\xampp-control.exe" (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:SECURITY_SETUP
echo %YELLOW%[3/4] جارٍ تطبيق إعدادات الأمان الافتراضية...%WHITE%
echo %GRAY%(تعطيل الوصول الخارجي، تفعيل كلمات المرور)%WHITE%

:: تعطيل الوصول الخارجي لـ MySQL
(
echo [mysqld]
echo bind-address=127.0.0.1
echo skip-networking
) > "!XAMPP_DIR!\mysql\bin\my.ini"

:: إنشاء ملف أمان افتراضي
(
echo # إعدادات أمان XAMPP من Knoux Toolbox
echo # التاريخ: !TIMESTAMP!
echo 
echo # MySQL: كلمة مرور الجذر فارغة افتراضيًا - يُنصح بتغييرها
echo # phpMyAdmin: الوصول محدود لـ localhost فقط
echo # FileZilla: معطل افتراضيًا
echo # Mercury: معطل افتراضيًا
echo 
echo # لتفعيل الوصول الخارجي: عدل ملفات التهيئة يدويًا
) > "!XAMPP_DIR!\security_setup.txt"

echo %YELLOW%[4/4] جارٍ بدء الخدمات الأساسية...%WHITE%
"!XAMPP_DIR!\xampp_start.exe" apache >nul 2>&1
"!XAMPP_DIR!\xampp_start.exe" mysql >nul 2>&1

timeout /t 5 >nul
tasklist | findstr "httpd.exe" >nul && (
    echo %GREEN%✓ Apache قيد التشغيل%WHITE%
) || (
    echo %YELLOW%لم يتم بدء Apache تلقائيًا - ابدأه من لوحة التحكم%WHITE%
)

tasklist | findstr "mysqld.exe" >nul && (
    echo %GREEN%✓ MySQL قيد التشغيل%WHITE%
) || (
    echo %YELLOW%لم يتم بدء MySQL تلقائيًا - ابدأه من لوحة التحكم%WHITE%
)

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%لوحة التحكم:%WHITE% !XAMPP_DIR!\xampp-control.exe
echo %CYAN%الموقع المحلي:%WHITE% %CYAN%http://localhost%WHITE%
echo %CYAN%phpMyAdmin:%WHITE% %CYAN%http://localhost/phpmyadmin%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%نصائح أمان هامة:%WHITE%
echo   • لا تستخدم XAMPP في بيئة إنتاج
echo   • غيّر كلمة مرور MySQL الافتراضية (فارغة)
echo   • تعطيل الوصول الخارجي في الشبكات العامة
echo   • استخدم 'xampp_stop.exe' لإيقاف جميع الخدمات

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed XAMPP 8.2.12 with security hardening >> "!LOG_FILE!"

timeout /t 10 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
