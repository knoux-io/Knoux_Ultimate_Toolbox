@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  ✅ Commit سريع مع قوالب رسائل احترافية%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:: التحقق من وجود مستودع محلي
git rev-parse --git-dir >nul 2>&1 || (
    echo %RED%✗ لم يتم اكتشاف مستودع Git في هذا المجلد%WHITE%
    echo %YELLOW%الحل: اذهب إلى مجلد المشروع أو شغّل "git init"%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:: عرض التغييرات
echo %CYAN%التغييرات الحالية:%WHITE%
git status --short

echo.
echo %CYAN%اختر قالب رسالة Commit:%WHITE%
echo   [1] feat:    ← ميزة جديدة
echo   [2] fix:     ← إصلاح خطأ
echo   [3] docs:    ← تحديث الوثائق
echo   [4] style:   ← تنسيق الكود (بدون تغيير في السلوك)
echo   [5] refactor:← إعادة هيكلة الكود
echo   [6] test:    ← إضافة/تحديث الاختبارات
echo   [7] chore:   ← مهام صيانة (تحديث الحزم، إلخ)
echo   [8] custom:  ← رسالة مخصصة
echo.
set /p "TEMPLATE=اختر: "

if "!TEMPLATE!"=="1" set "PREFIX=feat:"
if "!TEMPLATE!"=="2" set "PREFIX=fix:"
if "!TEMPLATE!"=="3" set "PREFIX=docs:"
if "!TEMPLATE!"=="4" set "PREFIX=style:"
if "!TEMPLATE!"=="5" set "PREFIX=refactor:"
if "!TEMPLATE!"=="6" set "PREFIX=test:"
if "!TEMPLATE!"=="7" set "PREFIX=chore:"
if "!TEMPLATE!"=="8" set /p "PREFIX=البادئة (اترك فارغًا): "

set /p "MESSAGE=رسالة التغيير (باختصار): "

:: إضافة جميع التغييرات
git add . >nul 2>&1

:: Commit
if "!PREFIX!"=="" (
    git commit -m "!MESSAGE!" >nul 2>&1
) else (
    git commit -m "!PREFIX! !MESSAGE!" >nul 2>&1
)

if !errorlevel! equ 0 (
    echo %GREEN%✓ تم Commit التغييرات بنجاح%WHITE%
    git log --oneline -1
) else (
    echo %RED%✗ فشل Commit - قد لا توجد تغييرات%WHITE%
)

:: دفع تلقائي (اختياري)
set /p "PUSH=هل تريد الدفع للفرع البعيد؟ (y/n): "
if /i "!PUSH!"=="y" (
    git push origin HEAD >nul 2>&1 && (
        echo %GREEN%✓ تم الدفع بنجاح%WHITE%
    ) || (
        echo %YELLOW%فشل الدفع - قد تحتاج إعداد الـ remote أولاً%WHITE%
    )
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Quick commit with message: !PREFIX! !MESSAGE! >> "!LOG_FILE!"

timeout /t 4 >nul
exit /b
