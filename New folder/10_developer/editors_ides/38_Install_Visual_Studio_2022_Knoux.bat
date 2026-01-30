@echo off
:: =================================================================
:: KNOUX VISUAL STUDIO 2022 INSTALLER
:: تثبيت Visual Studio 2022 مع مدير المكونات
:: =================================================================
title Knoux - Visual Studio 2022 Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX VISUAL STUDIO 2022 + COMPONENT MANAGER
echo   تثبيت Visual Studio 2022 مع مدير المكونات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Visual Studio 2022...
echo [→] هذا قد يستغرق وقتاً طويلاً...

:: Install Visual Studio 2022 Community
winget install Microsoft.VisualStudio.2022.Community --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vs_community.exe' -OutFile '$env:TEMP\vs2022.exe'"
    start /wait "" "$env:TEMP\vs2022.exe" --quiet --wait
)

echo [✓] تم تثبيت Visual Studio 2022!

:: Create component manager
echo [→] جاري إنشاء مدير المكونات...
(
    echo @echo off
    echo title Knoux VS2022 Component Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX VS2022 COMPONENT MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] تثبيت مكونات تطوير الويب
    echo echo [2] تثبيت مكونات تطوير سطح المكتب
    echo echo [3] تثبيت مكونات تطوير الموبايل
    echo echo [4] تثبيت مكونات تطوير الألعاب
    echo echo [5] تثبيت مكونات Python
    echo echo [6] تثبيت مكونات Node.js
    echo echo [7] تثبيت مكونات Azure
    echo echo [8] عرض المكونات المثبتة
    echo echo [9] تحديث Visual Studio
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" goto :WEB_DEV
    echo if "%%choice%%"=="2" goto :DESKTOP_DEV
    echo if "%%choice%%"=="3" goto :MOBILE_DEV
    echo if "%%choice%%"=="4" goto :GAME_DEV
    echo if "%%choice%%"=="5" goto :PYTHON_DEV
    echo if "%%choice%%"=="6" goto :NODE_DEV
    echo if "%%choice%%"=="7" goto :AZURE_DEV
    echo if "%%choice%%"=="8" goto :LIST_COMPONENTS
    echo if "%%choice%%"=="9" goto :UPDATE_VS
    echo if "%%choice%%"=="0" exit /b
    echo.
    echo pause
    echo goto MENU
    echo.
    echo :WEB_DEV
    echo echo [→] تثبيت مكونات تطوير الويب...
    echo "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VSInstaller.exe" modify --installPath "C:\Program Files\Microsoft Visual Studio\2022\Community" --add Microsoft.VisualStudio.Workload.NetWeb --includeRecommended --quiet
    echo echo [✓] تم تثبيت مكونات الويب!
    echo pause
    echo goto MENU
    echo.
    echo :DESKTOP_DEV
    echo echo [→] تثبيت مكونات تطوير سطح المكتب...
    echo "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VSInstaller.exe" modify --installPath "C:\Program Files\Microsoft Visual Studio\2022\Community" --add Microsoft.VisualStudio.Workload.ManagedDesktop --includeRecommended --quiet
    echo echo [✓] تم تثبيت مكونات سطح المكتب!
    echo pause
    echo goto MENU
    echo.
    echo :PYTHON_DEV
    echo echo [→] تثبيت مكونات Python...
    echo "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VSInstaller.exe" modify --installPath "C:\Program Files\Microsoft Visual Studio\2022\Community" --add Microsoft.VisualStudio.Workload.Python --includeRecommended --quiet
    echo echo [✓] تم تثبيت مكونات Python!
    echo pause
    echo goto MENU
    echo.
    echo :NODE_DEV
    echo echo [→] تثبيت مكونات Node.js...
    echo "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\VSInstaller.exe" modify --installPath "C:\Program Files\Microsoft Visual Studio\2022\Community" --add Microsoft.VisualStudio.Workload.Node --includeRecommended --quiet
    echo echo [✓] تم تثبيت مكونات Node.js!
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_vs2022_manager.bat"

echo [✓] تم إنشاء مدير المكونات!
echo [→] المسار: %USERPROFILE%\knoux_vs2022_manager.bat

:: Create desktop shortcut
echo [→] جاري إنشاء اختصار سطح المكتب...
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Visual Studio 2022.lnk'); $Shortcut.TargetPath = 'C:\Program Files\Microsoft Visual Studio\2022\Common7\IDE\devenv.exe'; $Shortcut.Save()"

echo [✓] تم إنشاء اختصار سطح المكتب!
echo [✓] Visual Studio 2022 جاهز للاستخدام!
pause
