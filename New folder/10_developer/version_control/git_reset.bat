@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "BACKUP_DIR=%~dp0..\..\..\backups\git_resets"

cls
echo %RED%===================================================%WHITE%
echo %RED%  ⚠️  إعادة تعيين Git المتقدمة (بحذر)%WHITE%
echo %RED%===================================================%WHITE%
echo.

git rev-parse --git-dir >nul 2>&1 || (
    echo %RED%✗ لم يتم اكتشاف مستودع Git%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:: إنشاء مجلد النسخ الاحتياطي إذا لم يكن موجودًا
if not exist "!BACKUP_DIR!" mkdir "!BACKUP_DIR!" >nul

:: عرض الحالة الحالية
echo %CYAN%الحالة الحالية:%WHITE%
git log --oneline -5
echo.

echo %YELLOW%تنبيه أمان هام:%WHITE%
echo عمليات إعادة التعيين قد تؤدي إلى فقدان التغييرات الدائمة!
echo سيتم إنشاء نقطة استعادة تلقائية قبل أي عملية.
echo.
echo %CYAN%أنواع إعادة التعيين:%WHITE%
echo   [1] --soft  ← الاحتفاظ بالتغييرات في Staging
echo   [2] --mixed ← الاحتفاظ بالتغييرات كـ Unstaged (الافتراضي)
echo   [3] --hard  ← فقدان جميع التغييرات (خطير!)
echo   [4] إعادة تعيين ملف واحد فقط
echo   [5] التراجع عن آخر Commit مع الاحتفاظ بالتغييرات
echo   [0] الإلغاء
echo.
set /p "TYPE=اختر النوع: "

if "!TYPE!"=="0" exit /b 0

:: تحديد نوع العملية
if "!TYPE!"=="1" set "FLAG=--soft"
if "!TYPE!"=="2" set "FLAG=--mixed"
if "!TYPE!"=="3" set "FLAG=--hard"
if "!TYPE!"=="4" goto :RESET_FILE
if "!TYPE!"=="5" goto :UNDO_COMMIT

:: تحديد الهدف
set /p "TARGET=الهدف (HEAD~1 للرجوع خطوة واحدة، أو hash محدد): "
if "!TARGET!"=="" set "TARGET=HEAD~1"

:: إنشاء نقطة استعادة
set "BACKUP_NAME=reset_backup_!DATE:~10,4!!DATE:~4,2!!DATE:~7,2!_!TIME:~0,2!!TIME:~3,2!!TIME:~6,2!"
set "BACKUP_NAME=!BACKUP_NAME: =0!"
set "BACKUP_NAME=!BACKUP_NAME::=!"

git stash save "Knoux Auto-Backup before reset" >nul 2>&1
git branch "!BACKUP_NAME!" >nul 2>&1 && (
    echo %GREEN%✓ تم إنشاء نقطة استعادة: !BACKUP_NAME!%WHITE%
    echo %YELLOW%للاستعادة لاحقًا: git checkout !BACKUP_NAME!%WHITE%
) || (
    echo %RED%✗ فشل إنشاء نقطة الاستعادة%WHITE%
    set /p "FORCE=هل تريد المتابعة بدون استعادة؟ (غير موصى) (y/n): "
    if /i "!FORCE!" neq "y" exit /b 1
)

:: تنفيذ إعادة التعيين
echo %YELLOW%جارٍ تنفيذ إعادة التعيين (!FLAG!)...%WHITE%
git reset !FLAG! !TARGET! && (
    echo %GREEN%✓ تم إعادة التعيين بنجاح%WHITE%
    git status
) || (
    echo %RED%✗ فشل إعادة التعيين%WHITE%
)

goto :END

:RESET_FILE
set /p "FILE_PATH=مسار الملف النسبي (مثل: src/app.js): "
set /p "COMMIT_HASH=الـ Commit المستهدف (اترك فارغًا لـ HEAD): "
if "!COMMIT_HASH!"=="" set "COMMIT_HASH=HEAD"

git checkout "!COMMIT_HASH!" -- "!FILE_PATH!" && (
    echo %GREEN%✓ تم استعادة الملف: !FILE_PATH!%WHITE%
) || (
    echo %RED%✗ فشل استعادة الملف%WHITE%
)
goto :END

:UNDO_COMMIT
echo %YELLOW%جارٍ التراجع عن آخر Commit مع الاحتفاظ بالتغييرات...%WHITE%
git reset --soft HEAD~1 && (
    echo %GREEN%✓ تم التراجع - التغييرات في Staging جاهزة لـ Commit جديد%WHITE%
    git status
) || (
    echo %RED%✗ فشل التراجع%WHITE%
)
goto :END

:END
:: تسجيل العملية
echo [!TIMESTAMP!] WARNING: Git reset performed (!FLAG! !TARGET!) - Backup: !BACKUP_NAME! >> "!LOG_FILE!"

timeout /t 6 >nul
exit /b
