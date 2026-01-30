@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %YELLOW%===================================================%WHITE%
echo %YELLOW%  🔷 VirtualBox 7.0 - افتراضية مفتوحة المصدر%WHITE%
echo %YELLOW%===================================================%WHITE%
echo.

:: تحذير مهم: تعارض مع Hyper-V
bcdedit /enum firmware | findstr "hypervisorlaunchtype" | findstr "Auto" >nul && (
    echo %RED%⚠️  تحذير أمان هام:%WHITE%
    echo VirtualBox لا يعمل مع Hyper-V مفعل في نفس الوقت!
    echo.
    echo %CYAN%الخيارات:%WHITE%
    echo   [1] تعطيل Hyper-V مؤقتًا (موصى لاستخدام VirtualBox)
    echo   [2] استخدام WSL2 بدلاً من VirtualBox (لا يتطلب تعطيل Hyper-V)
    echo   [3] المتابعة مع المخاطرة (قد لا تعمل الأجهزة الافتراضية)
    echo.
    set /p "ACTION=اختر: "
    
    if "!ACTION!"=="1" (
        echo %YELLOW%جارٍ تعطيل Hyper-V...%WHITE%
        bcdedit /set hypervisorlaunchtype off >nul 2>&1
        echo %RED%⚠️  مطلوب إعادة تشغيل لإكمال التعطيل%WHITE%
        timeout /t 3 >nul
        shutdown /r /t 15 /c "إعادة التشغيل لتعطيل Hyper-V - Knoux Toolbox"
        exit /b 0
    )
    if "!ACTION!"=="2" (
        echo %GREEN%✓ التوجيه إلى WSL2 كبديل آمن%WHITE%
        call "%~dp0wsl2_setup.bat"
        exit /b 0
    )
)

:CHECK_EXISTING
where VirtualBox.exe >nul 2>&1 && (
    echo %GREEN%✓ VirtualBox مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/3] جارٍ التنزيل من الموقع الرسمي...%WHITE%
call :LOADING_ANIMATION 6

set "INSTALLER=%TEMP%\VirtualBox.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://download.virtualbox.org/virtualbox/7.0.14/VirtualBox-7.0.14-161095-Win.exe' -OutFile '!INSTALLER!'" >nul 2>&1

if not exist "!INSTALLER!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.virtualbox.org/wiki/Downloads%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

echo %YELLOW%[2/3] جارٍ التثبيت الصامت...%WHITE%
start /wait "" "!INSTALLER!" --silent --ignore-reboot >nul 2>&1
del "!INSTALLER!" >nul 2>&1

echo %YELLOW%[3/3] جارٍ تثبيت امتداد الحزمة الإضافية (Extension Pack)...%WHITE%
set "EXT_PACK=%TEMP%\Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack"
powershell -Command "Invoke-WebRequest -Uri 'https://download.virtualbox.org/virtualbox/7.0.14/Oracle_VM_VirtualBox_Extension_Pack-7.0.14.vbox-extpack' -OutFile '!EXT_PACK!'" >nul 2>&1

if exist "!EXT_PACK!" (
    "%PROGRAMFILES%\Oracle\VirtualBox\VBoxManage.exe" extpack install "!EXT_PACK!" --replace >nul 2>&1
    del "!EXT_PACK!" >nul 2>&1
)

echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%للاستخدام:%WHITE% ابحث في قائمة ابدأ عن "Oracle VM VirtualBox"
echo.
echo %YELLOW%ملاحظات هامة:%WHITE%
echo   • لتشغيل الأجهزة الافتراضية: تأكد من تعطيل Hyper-V
echo   • لتفعيل مشاركة المجلدات: تثبيت "Guest Additions" داخل الجهاز الافتراضي
echo   • لتحسين الأداء: خصص ذاكرة الوصول العشوائي (RAM) ووحدات المعالجة المركزية (CPU) لكل جهاز

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed VirtualBox 7.0 with Extension Pack >> "!LOG_FILE!"

timeout /t 6 >nul
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
