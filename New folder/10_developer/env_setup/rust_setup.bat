@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GRAY%===================================================%WHITE%
echo %GRAY%  🦀 Rust Programming Language Setup%WHITE%
echo %GRAY%===================================================%WHITE%
echo.

rustc --version >nul 2>&1 && (
    echo %GREEN%✓ Rust مثبت مسبقًا%WHITE%
    rustc --version
    cargo --version
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ تنزيل وتشغيل المثبت الرسمي...%WHITE%
echo %GRAY%(سيتم التثبيت في %USERPROFILE%\.cargo)%WHITE%
timeout /t 3 >nul

:: تنزيل وتثبيت عبر powershell
powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; `iwr -useb https://rustwasm.github.io/rust-installer/init.sh -OutFile %TEMP%\rust-install.ps1; powershell -File %TEMP%\rust-install.ps1 --profile default --default-toolchain stable" >nul 2>&1

:: البديل: استخدام winget
if errorlevel 1 (
    echo %YELLOW%جارٍ المحاولة عبر Winget...%WHITE%
    winget install -e --id Rustlang.Rustup --silent >nul 2>&1
)

rustc --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://rustup.rs%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح!%WHITE%
rustc --version
cargo --version

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Rust with Cargo >> "!LOG_FILE!"

timeout /t 4 >nul
