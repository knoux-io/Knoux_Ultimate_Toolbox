@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  🌿 مدير الفروع المتقدم%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

git rev-parse --git-dir >nul 2>&1 || (
    echo %RED%✗ لم يتم اكتشاف مستودع Git%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] إنشاء فرع جديد من الفرع الحالي
echo   [2] إنشاء فرع من فرع بعيد (remote)
echo   [3] سحب جميع الفروع البعيدة
echo   [4] دمج فرع في الفرع الحالي
echo   [5] حذف فرع محلي/بعيد
echo   [6] عرض جميع الفروع (محلي + بعيد)
echo   [7] تبديل الفرع الحالي
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :CREATE_LOCAL
if "!CHOICE!"=="2" goto :CREATE_FROM_REMOTE
if "!CHOICE!"=="3" goto :FETCH_ALL
if "!CHOICE!"=="4" goto :MERGE_BRANCH
if "!CHOICE!"=="5" goto :DELETE_BRANCH
if "!CHOICE!"=="6" goto :LIST_BRANCHES
if "!CHOICE!"=="7" goto :SWITCH_BRANCH
goto :MENU

:CREATE_LOCAL
set /p "BRANCH_NAME=اسم الفرع الجديد (استخدم - للفصل: feature/login): "
git checkout -b "!BRANCH_NAME!" && (
    echo %GREEN%✓ تم إنشاء وتبديل إلى الفرع: !BRANCH_NAME!%WHITE%
    git branch --show-current
) || (
    echo %RED%✗ فشل الإنشاء - قد يكون الفرع موجودًا%WHITE%
)
goto :MENU

:CREATE_FROM_REMOTE
git branch -r
set /p "REMOTE_BRANCH=اختر فرعًا بعيدًا (مثل: origin/develop): "
set "LOCAL_NAME=!REMOTE_BRANCH:origin/=!"
git checkout -b "!LOCAL_NAME!" "!REMOTE_BRANCH!" && (
    echo %GREEN%✓ تم إنشاء الفرع المحلي من البعيد%WHITE%
) || (
    echo %RED%✗ فشل الإنشاء%WHITE%
)
goto :MENU

:FETCH_ALL
echo %YELLOW%جارٍ جلب جميع الفروع البعيدة...%WHITE%
git fetch --all --prune
echo %GREEN%✓ تم التحديث%WHITE%
goto :MENU

:MERGE_BRANCH
git branch
set /p "BRANCH_TO_MERGE=اسم الفرع للدمج: "
git merge "!BRANCH_TO_MERGE!" --no-ff -m "merge: دمج !BRANCH_TO_MERGE! في !BRANCH_CURRENT!" && (
    echo %GREEN%✓ تم الدمج بنجاح%WHITE%
) || (
    echo %RED%✗ تعارض في الدمج - يجب حله يدويًا%WHITE%
    git status
)
goto :MENU

:DELETE_BRANCH
set /p "BRANCH_NAME=اسم الفرع للحذف: "
set /p "REMOTE_DELETE=هل تريد حذف الفرع البعيد أيضًا؟ (y/n): "

git branch -d "!BRANCH_NAME!" && (
    echo %GREEN%✓ تم حذف الفرع المحلي%WHITE%
    if /i "!REMOTE_DELETE!"=="y" (
        git push origin --delete "!BRANCH_NAME!" && (
            echo %GREEN%✓ تم حذف الفرع البعيد%WHITE%
        ) || (
            echo %RED%✗ فشل حذف الفرع البعيد%WHITE%
        )
    )
) || (
    echo %YELLOW%الفرع يحتوي على تغييرات غير مدمجة - استخدام -D للقوة؟%WHITE%
    set /p "FORCE= (y/n): "
    if /i "!FORCE!"=="y" git branch -D "!BRANCH_NAME!" && echo %GREEN%✓ تم الحذف القسري%WHITE%
)
goto :MENU

:LIST_BRANCHES
echo %CYAN%الفروع المحلية:%WHITE%
git branch -v
echo.
echo %CYAN%الفروع البعيدة:%WHITE%
git branch -r
pause
goto :MENU

:SWITCH_BRANCH
git branch
set /p "BRANCH_NAME=اسم الفرع للتبديل: "
git checkout "!BRANCH_NAME!" && (
    echo %GREEN%✓ تم التبديل إلى: !BRANCH_NAME!%WHITE%
) || (
    echo %RED%✗ فشل التبديل - قد تكون هناك تغييرات غير محفوظة%WHITE%
)
goto :MENU

:END
:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Merged branch !BRANCH! into !CURRENT! >> "!LOG_FILE!"

timeout /t 5 >nul
exit /b
