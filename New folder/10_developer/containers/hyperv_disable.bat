@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
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
echo %RED%===================================================%WHITE%
echo %RED%  💠 تعطيل Hyper-V - للتوافق مع VirtualBox/VMware%WHITE%
echo %RED%===================================================%WHITE%
echo.

bcdedit /enum firmware | findstr "hypervisorlaunchtype" | findstr "Off" >nul && (
    echo %GREEN%✓ Hyper-V معطل مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ تعطيل Hyper-V...%WHITE%
bcdedit /set hypervisorlaunchtype off >nul 2>&1

echo %GREEN%✓ تم تعطيل Hyper-V بنجاح%WHITE%
echo %RED%⚠️  مطلوب إعادة تشغيل النظام لتفعيل التغييرات%WHITE%
echo.
echo %CYAN%ملاحظة هامة:%WHITE%
echo   • بعد إعادة التشغيل، ستعمل VirtualBox و VMware بشكل طبيعي
echo   • لاستخدام Docker Desktop، ستحتاج إلى إعادة تفعيل Hyper-V أو استخدام WSL2 backend
echo   • يمكن التبديل ذهابًا وإيابًا بين الوضعين حسب الحاجة

set /p "REBOOT=هل تريد إعادة التشغيل الآن؟ (y/n): "
if /i "!REBOOT!"=="y" (
    shutdown /r /t 15 /c "إعادة التشغيل لتعطيل Hyper-V - Knoux Toolbox"
)

:: تسجيل العملية
echo [!TIMESTAMP!] WARNING: Disabled Hyper-V for VirtualBox/VMware compatibility >> "!LOG_FILE!"

timeout /t 5 >nul
