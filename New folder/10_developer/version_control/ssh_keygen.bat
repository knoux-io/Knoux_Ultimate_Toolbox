@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🔑 مولد مفاتيح SSH الآمنة%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:: التحقق من وجود OpenSSH
where ssh-keygen >nul 2>&1 || (
    echo %RED%✗ OpenSSH غير مثبت%WHITE%
    echo %YELLOW%الحل: تفعيل مكون OpenSSH Client من "لوحة التحكم ← البرامج والميزات"%WHITE%
    echo أو شغّل: %CYAN%Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

:CHECK_EXISTING
if exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    echo %GREEN%✓ مفتاح SSH موجود مسبقًا%WHITE%
    type "%USERPROFILE%\.ssh\id_ed25519.pub"
    echo.
    set /p "NEW_KEY=هل تريد إنشاء مفتاح جديد؟ (قد يعطل الاتصالات الحالية) (y/n): "
    if /i "!NEW_KEY!" neq "y" exit /b 0
)

:KEY_TYPE
echo %CYAN%اختر نوع المفتاح (الأمان مقابل التوافق):%WHITE%
echo   [1] ed25519   ← الأحدث والأكثر أمانًا (موصى به)
echo   [2] rsa 4096  ← متوافق مع جميع الخوادم القديمة
echo   [3] ecdsa     ← توازن بين الأمان والحجم
echo.
set /p "KEY_TYPE=اختر: "

if "!KEY_TYPE!"=="1" set "ALGO=ed25519" & set "BITS="
if "!KEY_TYPE!"=="2" set "ALGO=rsa" & set "BITS=-b 4096"
if "!KEY_TYPE!"=="3" set "ALGO=ecdsa" & set "BITS=-b 521"

:EMAIL_PROMPT
set /p "EMAIL=أدخل بريدك الإلكتروني (للتعرف على المفتاح): "

:GENERATE
echo %YELLOW%جارٍ إنشاء المفتاح...%WHITE%
echo %GRAY%(اضغط Enter للمسار الافتراضي، ثم اترك كلمة المرور فارغة للوصول التلقائي أو أدخل كلمة مرور للأمان)%WHITE%

if not exist "%USERPROFILE%\.ssh" mkdir "%USERPROFILE%\.ssh" >nul
attrib +h "%USERPROFILE%\.ssh" >nul 2>&1

ssh-keygen -t !ALGO! !BITS! -C "!EMAIL!" -f "%USERPROFILE%\.ssh\id_!ALGO!" -N "" >nul 2>&1

if not exist "%USERPROFILE%\.ssh\id_!ALGO!.pub" (
    echo %RED%✗ فشل إنشاء المفتاح%WHITE%
    exit /b 1
)

:SET_PERMISSIONS
echo %YELLOW%جارٍ ضبط أذونات الملفات الآمنة...%WHITE%
icacls "%USERPROFILE%\.ssh\id_!ALGO!" /inheritance:r /grant:r "%USERNAME%:(R)" >nul 2>&1
icacls "%USERPROFILE%\.ssh\id_!ALGO!.pub" /inheritance:r /grant:r "%USERNAME%:(R)" >nul 2>&1

:DISPLAY_KEY
echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم إنشاء مفتاح SSH بنجاح!%WHITE%
echo %CYAN%نوع المفتاح:%WHITE% !ALGO!
echo %CYAN%البريد المرتبط:%WHITE% !EMAIL!
echo %CYAN%مسار المفتاح الخاص:%WHITE% %GRAY%%USERPROFILE%\.ssh\id_!ALGO!%WHITE%
echo %CYAN%مسار المفتاح العام:%WHITE% %GRAY%%USERPROFILE%\.ssh\id_!ALGO!.pub%WHITE%
echo.
echo %YELLOW%مفتاحك العام (انسخه بالكامل):%WHITE%
type "%USERPROFILE%\.ssh\id_!ALGO!.pub"
echo.
echo %CYAN%الخطوات التالية:%WHITE%
echo   1. GitHub: Settings ← SSH and GPG keys ← New SSH key
echo   2. GitLab: Preferences ← SSH Keys
echo   3. Bitbucket: Personal settings ← SSH keys
echo.
echo %YELLOW%اختبار الاتصال:%WHITE% ssh -T git@github.com

:: حفظ نسخة احتياطية مشفرة
set "BACKUP_DIR=%~dp0..\..\..\backups\ssh_keys"
if not exist "!BACKUP_DIR!" mkdir "!BACKUP_DIR!" >nul

copy "%USERPROFILE%\.ssh\id_!ALGO!.pub" "!BACKUP_DIR!\id_!ALGO!_pub_!DATE:~10,4!!DATE:~4,2!!DATE:~7,2!.txt" >nul 2>&1
echo %YELLOW%✓ تم حفظ نسخة احتياطية من المفتاح العام في: !BACKUP_DIR!%WHITE%
echo %RED%⚠️  المفتاح الخاص (السري) لم يتم نسخه - احفظه يدويًا في مكان آمن%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Generated SSH key (!ALGO!) for !EMAIL! >> "!LOG_FILE!"

timeout /t 12 >nul
