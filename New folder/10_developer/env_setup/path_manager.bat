@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %YELLOW%===================================================%WHITE%
echo %YELLOW%  ➕ مدير مسار النظام (PATH) المتقدم%WHITE%
echo %YELLOW%===================================================%WHITE%
echo.

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] عرض محتويات PATH الحالية
echo   [2] إضافة مسار جديد
echo   [3] إزالة مسار
echo   [4] تنظيف المسارات المكررة
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :VIEW_PATH
if "!CHOICE!"=="2" goto :ADD_PATH
if "!CHOICE!"=="3" goto :REMOVE_PATH
if "!CHOICE!"=="4" goto :CLEAN_PATH
goto :MENU

:VIEW_PATH
echo.
echo %CYAN%مسارات النظام الحالية:%WHITE%
echo %PATH% | findstr /n "^" | findstr /r "[0-9]*:" 
echo.
echo %GRAY%(المسارات مفصولة بـ ;)%WHITE%
pause
goto :MENU

:ADD_PATH
set /p "NEW_PATH=أدخل المسار لإضافته: "
if not exist "!NEW_PATH!" (
    echo %RED%⚠️  المسار غير موجود%WHITE%
    set /p "FORCE=هل تريد الإضافة رغم ذلك؟ (y/n): "
    if /i "!FORCE!" neq "y" goto :MENU
)

:: التحقق من عدم التكرار
echo "!PATH!" | findstr /i /c:"!NEW_PATH!" >nul && (
    echo %YELLOW%⚠️  المسار موجود مسبقًا%WHITE%
    goto :MENU
)

set "NEW_PATH=!NEW_PATH:\=\\!"
reg add "HKCU\Environment" /v Path /t REG_EXPAND_SZ /d "!PATH!;!NEW_PATH!" /f >nul 2>&1 && (
    echo %GREEN%✓ تم الإضافة%WHITE%
    echo %YELLOW%ملاحظة: أعد فتح موجه الأوامر لتفعيل التغيير%WHITE%
) || (
    echo %RED%✗ فشل الإضافة%WHITE%
)
goto :MENU

:REMOVE_PATH
set /p "REMOVE_PATH=أدخل المسار للإزالة: "
set "NEW_PATH="
for %%a in ("!PATH:;=";"!") do (
    if /i not "%%~a"=="!REMOVE_PATH!" (
        if defined NEW_PATH (set "NEW_PATH=!NEW_PATH!;%%~a") else (set "NEW_PATH=%%~a")
    )
)
reg add "HKCU\Environment" /v Path /t REG_EXPAND_SZ /d "!NEW_PATH!" /f >nul 2>&1 && (
    echo %GREEN%✓ تم الإزالة%WHITE%
) || (
    echo %RED%✗ فشل الإزالة%WHITE%
)
goto :MENU

:CLEAN_PATH
:: إزالة المكررات والمسارات الفارغة
set "CLEANED="
for %%a in ("!PATH:;=";"!") do (
    if not "%%~a"=="" (
        echo "!CLEANED!" | findstr /i /c:"%%~a" >nul || (
            if defined CLEANED (set "CLEANED=!CLEANED!;%%~a") else (set "CLEANED=%%~a")
        )
    )
)
reg add "HKCU\Environment" /v Path /t REG_EXPAND_SZ /d "!CLEANED!" /f >nul 2>&1 && (
    echo %GREEN%✓ تم التنظيف (تمت إزالة !COUNT! مسار مكرر)%WHITE%
) || (
    echo %RED%✗ فشل التنظيف%WHITE%
)
goto :MENU
