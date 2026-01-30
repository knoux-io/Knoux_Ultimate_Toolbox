@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  🛣️  مدير متغيرات البيئة المتقدم%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] عرض جميع المتغيرات
echo   [2] إضافة متغير جديد
echo   [3] تعديل متغير موجود
echo   [4] حذف متغير
echo   [5] تصدير المتغيرات الحالية
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :VIEW_VARS
if "!CHOICE!"=="2" goto :ADD_VAR
if "!CHOICE!"=="3" goto :EDIT_VAR
if "!CHOICE!"=="4" goto :DELETE_VAR
if "!CHOICE!"=="5" goto :EXPORT_VARS
goto :MENU

:VIEW_VARS
echo.
echo %CYAN%المتغيرات الشائعة:%WHITE%
echo   PATH       = %GRAY%!PATH:~0,80!...%WHITE%
echo   JAVA_HOME  = %GRAY%!JAVA_HOME!%WHITE%
echo   PYTHONPATH = %GRAY%!PYTHONPATH!%WHITE%
echo   GOPATH     = %GRAY%!GOPATH!%WHITE%
echo.
set /p "=اضغط أي مفتاح لعرض الكل..." <nul & pause >nul
set
pause
goto :MENU

:ADD_VAR
set /p "VAR_NAME=اسم المتغير: "
set /p "VAR_VALUE=القيمة: "
setx "!VAR_NAME!" "!VAR_VALUE!" >nul 2>&1 && (
    echo %GREEN%✓ تم الإضافة%WHITE%
) || (
    echo %RED%✗ فشل الإضافة (قد تحتاج صلاحيات مسؤول)%WHITE%
)
goto :MENU

:EDIT_VAR
set /p "VAR_NAME=اسم المتغير للتعديل: "
set /p "VAR_VALUE=القيمة الجديدة: "
setx "!VAR_NAME!" "!VAR_VALUE!" >nul 2>&1 && (
    echo %GREEN%✓ تم التعديل%WHITE%
) || (
    echo %RED%✗ فشل التعديل%WHITE%
)
goto :MENU

:DELETE_VAR
set /p "VAR_NAME=اسم المتغير للحذف: "
reg delete "HKCU\Environment" /v "!VAR_NAME!" /f >nul 2>&1 && (
    echo %GREEN%✓ تم الحذف (سيتطلب إعادة تشغيل)%WHITE%
) || (
    echo %RED%✗ فشل الحذف%WHITE%
)
goto :MENU

:EXPORT_VARS
set > "%~dp0..\..\..\exports\env_backup_!DATE:~10,4!!DATE:~4,2!!DATE:~7,2!.txt"
echo %GREEN%✓ تم التصدير إلى exports\%WHITE%
goto :MENU
