@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "EXPORT_DIR=%~dp0..\..\..\exports\env_settings"
set "TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
set "TIMESTAMP=!TIMESTAMP: =0!"
set "TIMESTAMP=!TIMESTAMP::=!"

if not exist "!EXPORT_DIR!" mkdir "!EXPORT_DIR!"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  💾 تصدير إعدادات بيئة التطوير%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

echo %YELLOW%جارٍ جمع المعلومات...%WHITE%

:: 1. إصدارات اللغات
(
    echo === إصدارات اللغات ===
    node -v 2>nul || echo Node.js: غير مثبت
    npm -v 2>nul || echo 
    python --version 2>nul || echo Python: غير مثبت
    java -version 2>&1 | findstr "version" || echo Java: غير مثبت
    dotnet --version 2>nul || echo .NET: غير مثبت
    go version 2>nul || echo Go: غير مثبت
    rustc --version 2>nul || echo Rust: غير مثبت
    ruby --version 2>nul || echo Ruby: غير مثبت
    php -v 2>nul || echo PHP: غير مثبت
    perl -v 2>nul | findstr "This is perl" || echo Perl: غير مثبت
) > "!EXPORT_DIR!\versions_!TIMESTAMP!.txt"

:: 2. متغيرات البيئة المهمة
(
    echo === متغيرات البيئة ===
    echo PATH=!PATH!
    echo JAVA_HOME=!JAVA_HOME!
    echo PYTHONPATH=!PYTHONPATH!
    echo GOPATH=!GOPATH!
    echo RUSTUP_HOME=!RUSTUP_HOME!
) > "!EXPORT_DIR!\env_vars_!TIMESTAMP!.txt"

:: 3. الحزم المثبتة (npm و pip)
if exist "%USERPROFILE%\AppData\Roaming\npm" (
    npm list -g --depth=0 > "!EXPORT_DIR!\npm_packages_!TIMESTAMP!.txt" 2>nul
)
if exist "%USERPROFILE%\AppData\Local\Programs\Python" (
    pip list > "!EXPORT_DIR!\pip_packages_!TIMESTAMP!.txt" 2>nul
)

:: 4. تقرير ملخص
(
    echo تقرير تصدير بيئة التطوير
    echo التاريخ: %DATE% %TIME%
    echo النظام: %OS% %PROCESSOR_ARCHITECTURE%
    echo.
    echo الملفات المصدرة:
    dir /b "!EXPORT_DIR!\*_!TIMESTAMP!.*"
) > "!EXPORT_DIR!\SUMMARY_!TIMESTAMP!.txt"

echo %GREEN%✓ تم التصدير بنجاح!%WHITE%
echo المجلد: !EXPORT_DIR!
echo.
dir "!EXPORT_DIR!\*_!TIMESTAMP!.*" /b

timeout /t 5 >nul
