@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:HEADER
cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🐙 Git SCM - نظام التحكم بالإصدار الأساسي%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:CHECK_EXISTING
git --version >nul 2>&1 && (
    for /f "tokens=*" %%a in ('git --version') do set "VER=%%a"
    echo %GREEN%✓ Git مثبت مسبقًا%WHITE%
    echo !VER!
    goto :CONFIGURE_GIT
)

echo %YELLOW%[1/4] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 4

:: الطريقة 1: عبر Winget (موصى بها)
winget install -e --id Git.Git --silent --accept-source-agreements >nul 2>&1

:: الطريقة 2: عبر Chocolatey (بديل)
if errorlevel 1 (
    choco install git -y --params "'/GitAndUnixToolsOnPath /WindowsTerminal'" >nul 2>&1
)

:: التحقق
git --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://git-scm.com/download/win%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

:CONFIGURE_GIT
echo %YELLOW%[2/4] جارٍ تهيئة إعدادات المطور...%WHITE%

:: جمع معلومات المستخدم
set "GIT_NAME="
set "GIT_EMAIL="

if exist "%~dp0..\..\..\config\user_preferences.cfg" (
    for /f "tokens=2 delims==" %%a in ('findstr /i "git_name" "%~dp0..\..\..\config\user_preferences.cfg"') do set "GIT_NAME=%%a"
    for /f "tokens=2 delims==" %%a in ('findstr /i "git_email" "%~dp0..\..\..\config\user_preferences.cfg"') do set "GIT_EMAIL=%%a"
)

if "!GIT_NAME!"=="" (
    set /p "GIT_NAME=اسمك الكامل (سيظهر في عمليات الـ Commit): "
)
if "!GIT_EMAIL!"=="" (
    set /p "GIT_EMAIL=بريدك الإلكتروني (لـ GitHub/GitLab): "
)

:: تطبيق الإعدادات
git config --global user.name "!GIT_NAME!" >nul 2>&1
git config --global user.email "!GIT_EMAIL!" >nul 2>&1
git config --global init.defaultBranch main >nul 2>&1
git config --global core.editor "code --wait" >nul 2>&1
git config --global pull.rebase false >nul 2>&1
git config --global credential.helper manager-core >nul 2>&1
git config --global core.autocrlf input >nul 2>&1
git config --global core.quotepath false >nul 2>&1
git config --global color.ui auto >nul 2>&1
git config --global alias.co checkout >nul 2>&1
git config --global alias.br branch >nul 2>&1
git config --global alias.ci commit >nul 2>&1
git config --global alias.st status >nul 2>&1
git config --global alias.unstage "reset HEAD --" >nul 2>&1
git config --global alias.last "log -1 HEAD" >nul 2>&1

echo %GREEN%✓ تم تهيئة الإعدادات الأساسية%WHITE%

:ENABLE_UTF8
echo %YELLOW%[3/4] جارٍ تفعيل دعم يونيكود للعربية...%WHITE%
git config --global core.quotepath false >nul 2>&1
git config --global gui.encoding utf-8 >nul 2>&1
git config --global i18n.commitencoding utf-8 >nul 2>&1
git config --global i18n.logoutputencoding utf-8 >nul 2>&1

:: اختبار دعم العربية
echo اختبار ملف عربي > "%TEMP%\test_arabic.txt"
git -C "%TEMP%" init >nul 2>&1
git -C "%TEMP%" add test_arabic.txt >nul 2>&1
git -C "%TEMP%" commit -m "اختبار" >nul 2>&1
git -C "%TEMP%" log --oneline >nul 2>&1 && (
    echo %GREEN%✓ تم تفعيل دعم كامل للعربية والأحرف غير اللاتينية%WHITE%
) || (
    echo %YELLOW%ملاحظة: قد تحتاج ضبط إعدادات الطرفية يدويًا%WHITE%
)
rmdir /s /q "%TEMP%\.git" >nul 2>&1
del "%TEMP%\test_arabic.txt" >nul 2>&1

:INSTALL_GIT_BASH
echo %YELLOW%[4/4] جارٍ إعداد بيئة Git Bash...%WHITE%
if exist "%PROGRAMFILES%\Git\git-bash.exe" (
    echo %GREEN%✓ Git Bash جاهز للاستخدام%WHITE%
    echo %CYAN%للاستخدام:%WHITE% ابحث في قائمة ابدأ عن "Git Bash"
) else (
    echo %YELLOW%Git Bash سيتم تثبيته مع الحزمة الكاملة%WHITE%
)

echo.
echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت والتهيئة الكاملة!%WHITE%
echo %CYAN%معلوماتك:%WHITE%
echo   الاسم: %CYAN%!GIT_NAME!%WHITE%
echo   البريد: %CYAN%!GIT_EMAIL!%WHITE%
echo   الفرع الافتراضي: %CYAN%main%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الأوامر الأساسية:%WHITE%
echo   git init                ← إنشاء مستودع جديد
echo   git clone [url]         ← استنساخ مستودع موجود
echo   git add .               ← إضافة التغييرات للـ Staging
echo   git commit -m "رسالة"   ← حفظ التغييرات
echo   git push                ← رفع التغييرات للخادم
echo   git pull                ← جلب التحديثات
echo   git status              ← عرض حالة المستودع
echo.
echo %YELLOW%نصيحة:%WHITE% استخدم اختصارات مثل: %CYAN%git co%WHITE% بدلاً من %GRAY%git checkout%WHITE%

:: حفظ الإعدادات في ملف التفضيلات
(
echo git_name=!GIT_NAME!
echo git_email=!GIT_EMAIL!
) >> "%~dp0..\..\..\config\user_preferences.cfg" 2>nul

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Git !VER! with Arabic support and aliases >> "!LOG_FILE!"

timeout /t 8 >nul
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
