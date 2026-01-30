@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  👤 مدير إعدادات Git المتقدم%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

git --version >nul 2>&1 || (
    echo %RED%✗ Git غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً version_control\git_scm.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] عرض جميع الإعدادات الحالية
echo   [2] تغيير اسم المستخدم
echo   [3] تغيير البريد الإلكتروني
echo   [4] تغيير المحرر الافتراضي
echo   [5] تفعيل/تعطيل إعادة تعيين السطر التلقائي (autocrlf)
echo   [6] إعدادات الألوان والواجهة
echo   [7] إنشاء اختصارات مخصصة (Aliases)
echo   [8] تصدير الإعدادات إلى ملف
echo   [9] استيراد الإعدادات من ملف
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :SHOW_CONFIG
if "!CHOICE!"=="2" goto :SET_NAME
if "!CHOICE!"=="3" goto :SET_EMAIL
if "!CHOICE!"=="4" goto :SET_EDITOR
if "!CHOICE!"=="5" goto :SET_CRLF
if "!CHOICE!"=="6" goto :SET_COLORS
if "!CHOICE!"=="7" goto :SET_ALIASES
if "!CHOICE!"=="8" goto :EXPORT_CONFIG
if "!CHOICE!"=="9" goto :IMPORT_CONFIG
goto :MENU

:SHOW_CONFIG
echo.
echo %CYAN%الإعدادات العامة (--global):%WHITE%
git config --global --list
echo.
echo %CYAN%الإعدادات المحلية للمستودع الحالي:%WHITE%
git config --local --list 2>nul || echo %GRAY%(لم يتم اكتشاف مستودع محلي)%WHITE%
pause
goto :MENU

:SET_NAME
set /p "NAME=أدخل اسمك الكامل: "
git config --global user.name "!NAME!"
echo %GREEN%✓ تم التحديث%WHITE%
goto :MENU

:SET_EMAIL
set /p "EMAIL=أدخل بريدك الإلكتروني: "
git config --global user.email "!EMAIL!"
echo %GREEN%✓ تم التحديث%WHITE%
goto :MENU

:SET_EDITOR
echo %CYAN%اختر المحرر:%WHITE%
echo   [1] VS Code (code --wait)
echo   [2] Notepad++
echo   [3] Vim
echo   [4] مخصص
set /p "EDITOR_CHOICE=اختر: "

if "!EDITOR_CHOICE!"=="1" set "EDITOR=code --wait"
if "!EDITOR_CHOICE!"=="2" set "EDITOR=notepad++ -multiInst -nosession"
if "!EDITOR_CHOICE!"=="3" set "EDITOR=vim"
if "!EDITOR_CHOICE!"=="4" set /p "EDITOR=أدخل الأمر: "

git config --global core.editor "!EDITOR!"
echo %GREEN%✓ تم تعيين المحرر: !EDITOR!%WHITE%
goto :MENU

:SET_CRLF
echo %CYAN%وضعية إعادة تعيين السطر (autocrlf):%WHITE%
echo   [1] input  ← Windows → Unix (موصى به للمطورين)
echo   [2] true   ← Windows فقط
echo   [3] false  ← بدون تحويل (للمشاريع المختلطة)
set /p "CRLF_CHOICE=اختر: "

if "!CRLF_CHOICE!"=="1" git config --global core.autocrlf input
if "!CRLF_CHOICE!"=="2" git config --global core.autocrlf true
if "!CRLF_CHOICE!"=="3" git config --global core.autocrlf false

echo %GREEN%✓ تم التحديث%WHITE%
goto :MENU

:SET_COLORS
git config --global color.ui auto
git config --global color.diff.meta "yellow bold"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.status.added "green"
git config --global color.status.changed "yellow"
git config --global color.status.untracked "red"
echo %GREEN%✓ تم تفعيل ألوان متقدمة للواجهة%WHITE%
goto :MENU

:SET_ALIASES
echo %YELLOW%جارٍ إنشاء اختصارات شائعة...%WHITE%
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
echo %GREEN%✓ تم إنشاء الاختصارات:%WHITE%
echo   git co    = git checkout
echo   git br    = git branch
echo   git ci    = git commit
echo   git st    = git status
echo   git lg    = سجل مرئي متقدم
goto :MENU

:EXPORT_CONFIG
set "EXPORT_FILE=%USERPROFILE%\git-config-backup_!DATE:~10,4!!DATE:~4,2!!DATE:~7,2!.txt"
git config --global --list > "!EXPORT_FILE!"
echo %GREEN%✓ تم التصدير إلى: !EXPORT_FILE!%WHITE%
goto :MENU

:IMPORT_CONFIG
set /p "IMPORT_FILE=مسار ملف الإعدادات: "
if not exist "!IMPORT_FILE!" (
    echo %RED%✗ الملف غير موجود%WHITE%
    goto :MENU
)
echo %YELLOW%جارٍ الاستيراد...%WHITE%
for /f "tokens=1,* delims==" %%a in (!IMPORT_FILE!) do (
    git config --global "%%a" "%%b" >nul 2>&1
)
echo %GREEN%✓ تم الاستيراد%WHITE%
goto :MENU
