@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  📥 مستنسخ المستودعات المتقدم%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

git --version >nul 2>&1 || (
    echo %RED%✗ Git غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] استنساخ مستودع عادي
echo   [2] استنساخ مع جميع الفروع والعلامات
echo   [3] استنساخ سطحي (Shallow - للسرعة)
echo   [4] استنساخ مع الـ Submodules
echo   [5] استنساخ من قوالب شائعة (Knoux Templates)
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :CLONE_NORMAL
if "!CHOICE!"=="2" goto :CLONE_ALL
if "!CHOICE!"=="3" goto :CLONE_SHALLOW
if "!CHOICE!"=="4" goto :CLONE_SUBMODULES
if "!CHOICE!"=="5" goto :CLONE_TEMPLATE
goto :MENU

:CLONE_NORMAL
set /p "REPO_URL=رابط المستودع (HTTPS أو SSH): "
set /p "DEST_DIR=مسار الوجهة (اترك فارغًا للمجلد الحالي): "
if "!DEST_DIR!"=="" set "DEST_DIR=%CD%"

echo %YELLOW%جارٍ الاستنساخ...%WHITE%
git clone "!REPO_URL!" "!DEST_DIR!" && (
    echo %GREEN%✓ تم الاستنساخ بنجاح%WHITE%
    cd /d "!DEST_DIR!" && git log --oneline -5
) || (
    echo %RED%✗ فشل الاستنساخ%WHITE%
)
goto :MENU

:CLONE_ALL
set /p "REPO_URL=رابط المستودع: "
set /p "DEST_DIR=مسار الوجهة: "
if "!DEST_DIR!"=="" set "DEST_DIR=%CD%\repo"

echo %YELLOW%جارٍ الاستنساخ مع جميع الفروع...%WHITE%
git clone --mirror "!REPO_URL!" "!DEST_DIR!.git" && (
    cd /d "!DEST_DIR!.git"
    git config --bool core.bare false
    git checkout -f
    echo %GREEN%✓ تم الاستنساخ الكامل (branches + tags)%WHITE%
) || (
    echo %RED%✗ فشل الاستنساخ%WHITE%
)
goto :MENU

:CLONE_SHALLOW
set /p "REPO_URL=رابط المستودع: "
set /p "DEST_DIR=مسار الوجهة: "
if "!DEST_DIR!"=="" set "DEST_DIR=%CD%\repo"

echo %YELLOW%جارٍ الاستنساخ السطحي (أسرع، بدون سجل كامل)...%WHITE%
git clone --depth 1 "!REPO_URL!" "!DEST_DIR!" && (
    echo %GREEN%✓ تم الاستنساخ السطحي بنجاح%WHITE%
    echo %GRAY%(ملاحظة: لن تتمكن من الوصول للتاريخ الكامل)%WHITE%
) || (
    echo %RED%✗ فشل الاستنساخ%WHITE%
)
goto :MENU

:CLONE_SUBMODULES
set /p "REPO_URL=رابط المستودع (يحتوي على Submodules): "
set /p "DEST_DIR=مسار الوجهة: "
if "!DEST_DIR!"=="" set "DEST_DIR=%CD%\repo"

echo %YELLOW%جارٍ الاستنساخ مع الـ Submodules...%WHITE%
git clone --recurse-submodules "!REPO_URL!" "!DEST_DIR!" && (
    echo %GREEN%✓ تم الاستنساخ مع جميع الـ Submodules%WHITE%
) || (
    echo %RED%✗ فشل الاستنساخ%WHITE%
)
goto :MENU

:CLONE_TEMPLATE
echo %CYAN%قوالب شائعة جاهزة للاستخدام:%WHITE%
echo   [1] React + TypeScript Starter
echo   [2] Node.js API Boilerplate
echo   [3] Python Flask Microservice
echo   [4] Django Project Template
echo   [5] Vue 3 + Vite Starter
set /p "TEMPLATE=اختر قالب: "

if "!TEMPLATE!"=="1" set "URL=https://github.com/knoux/react-ts-starter.git"
if "!TEMPLATE!"=="2" set "URL=https://github.com/knoux/node-api-boilerplate.git"
if "!TEMPLATE!"=="3" set "URL=https://github.com/knoux/flask-microservice.git"
if "!TEMPLATE!"=="4" set "URL=https://github.com/knoux/django-project-template.git"
if "!TEMPLATE!"=="5" set "URL=https://github.com/knoux/vue3-vite-starter.git"

set /p "DEST_DIR=مسار المشروع الجديد: "
git clone "!URL!" "!DEST_DIR!" && (
    echo %GREEN%✓ تم استنساخ القالب بنجاح%WHITE%
    echo %YELLOW%الخطوات التالية:%WHITE%
    cd /d "!DEST_DIR!"
    if exist "package.json" (
        echo   npm install
        echo   npm run dev
    ) else if exist "requirements.txt" (
        echo   pip install -r requirements.txt
        echo   python app.py
    )
) || (
    echo %RED%✗ فشل الاستنساخ%WHITE%
)
goto :MENU

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Cloned repository: !REPO_URL! to !DEST_DIR! >> "!LOG_FILE!"

timeout /t 4 >nul
exit /b
