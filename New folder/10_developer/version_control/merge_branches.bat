@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🔀 دمج الفروع المتقدم مع حل التعارضات%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

git rev-parse --git-dir >nul 2>&1 || (
    echo %RED%✗ لم يتم اكتشاف مستودع Git%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:: عرض الفرع الحالي
for /f "tokens=*" %%a in ('git branch --show-current') do set "CURRENT=%%a"
echo %CYAN%الفرع الحالي:%WHITE% %GREEN%!CURRENT!%WHITE%
echo.

:: عرض الفروع المتاحة للدمج
echo %CYAN%الفروع المتاحة للدمج:%WHITE%
git branch --no-merged "!CURRENT!" 2>nul | findstr /v "*"
echo.

set /p "BRANCH=اختر الفرع للدمج: "

:: التحقق من وجود تعارضات محتملة
echo %YELLOW%جارٍ فحص التعارضات المحتملة...%WHITE%
git merge --no-commit --no-ff "!BRANCH!" >nul 2>&1

if !errorlevel! equ 0 (
    :: لا توجد تعارضات - إكمال الدمج
    git commit -m "merge: دمج !BRANCH! في !CURRENT!" >nul 2>&1
    echo %GREEN%✓ تم الدمج بنجاح بدون تعارضات%WHITE%
    git log --oneline -3
    goto :END
) else (
    echo %RED%⚠️  تم اكتشاف تعارضات في الدمج%WHITE%
    echo.
    git status --short | findstr "^UU"
    
    echo.
    echo %CYAN%خيارات حل التعارضات:%WHITE%
    echo   [1] استخدام أداتنا التفاعلية لحل التعارضات
    echo   [2] استخدام أداة خارجية (VS Code, Meld)
    echo   [3] إلغاء الدمج (--abort)
    echo   [4] قبول جميع التغييرات من الفرع الحالي (الاحتفاظ بـ ours)
    echo   [5] قبول جميع التغييرات من الفرع المدمج (الاحتفاظ بـ theirs)
    echo.
    set /p "RESOLVE=اختر: "
    
    if "!RESOLVE!"=="1" goto :INTERACTIVE_RESOLVE
    if "!RESOLVE!"=="2" goto :EXTERNAL_TOOL
    if "!RESOLVE!"=="3" git merge --abort && echo %YELLOW%✓ تم إلغاء الدمج%WHITE% && goto :END
    if "!RESOLVE!"=="4" git checkout --ours . && git add . && git commit -m "merge: حل التعارضات بالاحتفاظ بـ ours" && echo %GREEN%✓ تم الحل بالاحتفاظ بالتغييرات الحالية%WHITE% && goto :END
    if "!RESOLVE!"=="5" git checkout --theirs . && git add . && git commit -m "merge: حل التعارضات بالاحتفاظ بـ theirs" && echo %GREEN%✓ تم الحل بالاحتفاظ بتغييرات الفرع المدمج%WHITE% && goto :END
)

:INTERACTIVE_RESOLVE
echo %YELLOW%جارٍ عرض الملفات المتضاربة...%WHITE%
for /f "tokens=2*" %%a in ('git status --short ^| findstr "^UU"') do (
    echo %CYAN%ملف متضارب:%WHITE% %%b
    set /p "KEEP=الاحتفاظ بـ [1] الحالي / [2] الجديد / [3] كلاهما: "
    if "!KEEP!"=="1" git checkout --ours "%%b" && git add "%%b"
    if "!KEEP!"=="2" git checkout --theirs "%%b" && git add "%%b"
    if "!KEEP!"=="3" (
        echo %YELLOW%تم فتح الملف للمراجعة اليدوية - بعد الحفظ أضفه بـ git add "%%b"%WHITE%
        start notepad "%%b"
        pause
    )
)

git commit -m "merge: دمج !BRANCH! مع حل التعارضات" >nul 2>&1 && (
    echo %GREEN%✓ تم إكمال الدمج بعد حل التعارضات%WHITE%
) || (
    echo %RED%✗ لم تتم إضافة جميع الملفات - أكمل يدويًا%WHITE%
)
goto :END

:EXTERNAL_TOOL
echo %CYAN%الأدوات المتاحة:%WHITE%
echo   [1] VS Code (git mergetool --tool=vscode)
echo   [2] Meld (يجب التثبيت مسبقًا)
echo   [3] Vimdiff
set /p "TOOL=اختر: "

if "!TOOL!"=="1" (
    git config --global merge.tool vscode
    git config --global mergetool.vscode.cmd "code --wait $MERGED"
    git mergetool
)
if "!TOOL!"=="2" git mergetool --tool=meld
if "!TOOL!"=="3" git mergetool --tool=vimdiff

git commit -m "merge: دمج !BRANCH! بعد الحل الخارجي" >nul 2>&1
echo %GREEN%✓ تم إكمال الدمج%WHITE%
goto :END

:END
:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Merged branch !BRANCH! into !CURRENT! >> "!LOG_FILE!"

timeout /t 5 >nul
exit /b
