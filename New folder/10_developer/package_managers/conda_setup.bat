@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🐍 Anaconda/Miniconda - لعلوم البيانات والذكاء الاصطناعي%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

conda --version >nul 2>&1 && (
    echo %GREEN%✓ Conda مثبت مسبقًا%WHITE%
    conda --version
    goto :ENV_MANAGER
)

echo %CYAN%اختر النوع:%WHITE%
echo   [1] Miniconda (خفيف - ~50MB) - موصى به للمطورين
echo   [2] Anaconda (كامل - ~3GB) - يحتوي على 150+ حزمة مسبقة
echo.
set /p "CHOICE=اختر (1/2): "

if "!CHOICE!"=="1" (
    set "INSTALLER_URL=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe "
    set "INSTALLER_NAME=miniconda.exe"
) else (
    set "INSTALLER_URL=https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Windows-x86_64.exe "
    set "INSTALLER_NAME=anaconda.exe"
)

echo %YELLOW%جارٍ التنزيل...%WHITE%
powershell -Command "Invoke-WebRequest -Uri '!INSTALLER_URL!' -OutFile '%TEMP%\!INSTALLER_NAME!'" >nul 2>&1

if not exist "%TEMP%\!INSTALLER_NAME!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    exit /b 1
)

echo %YELLOW%جارٍ التثبيت الصامت...%WHITE%
start /wait "" "%TEMP%\!INSTALLER_NAME!" /InstallationType=JustMe /RegisterPython=1 /S /D=!USERPROFILE!\conda >nul 2>&1
del "%TEMP%\!INSTALLER_NAME!" >nul 2>&1

:: تحديث PATH
setx PATH "!USERPROFILE!\conda\Scripts;!USERPROFILE!\conda;%PATH%" >nul

timeout /t 5 >nul
conda --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: أعد تشغيل الجهاز ثم جرب مجددًا%WHITE%
    exit /b 1
)

:ENV_MANAGER
echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
conda --version

echo.
echo %CYAN%إدارة البيئات:%WHITE%
echo   conda create -n myenv python=3.11   ← بيئة جديدة
echo   conda activate myenv               ← تفعيل البيئة
echo   conda install numpy pandas         ← تثبيت حزم
echo   conda env list                     ← عرض البيئات
echo   conda deactivate                   ← إلغاء التفعيل

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Conda (!CHOICE! - Miniconda/Anaconda) >> "!LOG_FILE!"

timeout /t 6 >nul
