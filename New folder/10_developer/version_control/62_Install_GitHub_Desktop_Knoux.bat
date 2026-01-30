@echo off
:: =================================================================
:: KNOUX GITHUB DESKTOP INSTALLER
:: تثبيت GitHub Desktop مع مدير المستودعات
:: =================================================================
title Knoux - GitHub Desktop Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX GITHUB DESKTOP + REPOSITORY MANAGER
echo   تثبيت GitHub Desktop مع مدير المستودعات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت GitHub Desktop...
winget install GitHub.GitHubDesktop --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://central.github.com/deployments/desktop/desktop/latest/win32' -OutFile '$env:TEMP\github-desktop.exe'"
    start /wait "" "$env:TEMP\github-desktop.exe" /S
)

echo [✓] تم تثبيت GitHub Desktop!

:: Create repository manager
echo [→] جاري إنشاء مدير المستودعات...
(
    echo @echo off
    echo title Knoux GitHub Repository Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX GITHUB REPOSITORY MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] إنشاء مستودع جديد
    echo echo [2] استنساخ مستودع
    echo echo [3] فتح مستودع محلي
    echo echo [4] عرض المستودعات الحالية
    echo echo [5] مزامنة المستودعات
    echo echo [6] إنشاء فرع جديد
    echo echo [7] دمج الفروع
    echo echo [8] عرض التغييرات
    echo echo [9] نشر التغييرات
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" goto :CREATE_REPO
    echo if "%%choice%%"=="2" goto :CLONE_REPO
    echo if "%%choice%%"=="3" goto :OPEN_REPO
    echo if "%%choice%%"=="4" goto :LIST_REPOS
    echo if "%%choice%%"=="5" goto :SYNC_REPOS
    echo if "%%choice%%"=="6" goto :CREATE_BRANCH
    echo if "%%choice%%"=="7" goto :MERGE_BRANCH
    echo if "%%choice%%"=="8" goto :VIEW_CHANGES
    echo if "%%choice%%"=="9" goto :PUSH_CHANGES
    echo if "%%choice%%"=="0" exit /b
    echo pause
    echo goto MENU
    echo.
    echo :CREATE_REPO
    echo set /p repo_name=اسم المستودع: 
    echo set /p repo_path=مسار المستودع: 
    echo mkdir "%%repo_path%%\%%repo_name%%"
    echo cd "%%repo_path%%\%%repo_name%%"
    echo git init
    echo echo # %%repo_name%% ^> README.md
    echo git add README.md
    echo git commit -m "Initial commit"
    echo echo [✓] تم إنشاء المستودع: %%repo_name%%
    echo pause
    echo goto MENU
    echo.
    echo :CLONE_REPO
    echo set /p repo_url=رابط المستودع: 
    echo set /p clone_path=مسار الاستنساخ: 
    echo git clone %%repo_url%% "%%clone_path%%"
    echo echo [✓] تم استنساخ المستودع!
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_github_manager.bat"

echo [✓] تم إنشاء مدير المستودعات!
echo [→] المسار: %USERPROFILE%\knoux_github_manager.bat

:: Create desktop shortcut
echo [→] جاري إنشاء اختصار سطح المكتب...
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\GitHub Desktop.lnk'); $Shortcut.TargetPath = 'C:\Users\%USERNAME%\AppData\Local\GitHubDesktop\GitHubDesktop.exe'; $Shortcut.Save()"

echo [✓] تم إنشاء اختصار سطح المكتب!
echo [✓] GitHub Desktop جاهز للاستخدام!
pause
