@echo off
:: =================================================================
:: KNOUX POSTGRESQL INSTALLER
:: تثبيت PostgreSQL مع مدير قواعد البيانات
:: =================================================================
title Knoux - PostgreSQL Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX POSTGRESQL + DATABASE MANAGER
echo   تثبيت PostgreSQL مع مدير قواعد البيانات
echo ═══════════════════════════════════════════════════════════
echo.

:: Check Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [✗] يلزم صلاحيات المسؤول!
    echo [→] يرجى تشغيل كمسؤول
    pause
    exit /b 1
)

echo [→] جاري تثبيت PostgreSQL...
winget install PostgreSQL.PostgreSQL --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://get.enterprisedb.com/postgresql/postgresql-16.2-1-windows-x64.exe' -OutFile '$env:TEMP\postgresql.exe'"
    start /wait "" "$env:TEMP\postgresql.exe" --mode unattended --unattendedmodeui none --superpassword "knoux123"
)

echo [✓] تم تثبيت PostgreSQL!

:: Create database manager
echo [→] جاري إنشاء مدير قواعد البيانات...
(
    echo @echo off
    echo title Knoux PostgreSQL Database Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX POSTGRESQL DATABASE MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] بدء خدمة PostgreSQL
    echo echo [2] إيقاف خدمة PostgreSQL
    echo echo [3] إنشاء قاعدة بيانات جديدة
    echo echo [4] حذف قاعدة بيانات
    echo echo [5] عرض قواعد البيانات
    echo echo [6] نسخ احتياطي لقاعدة بيانات
    echo echo [7] استعادة قاعدة بيانات
    echo echo [8] الاتصال بقاعدة البيانات
    echo echo [9] فحص حالة الخدمة
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" net start postgresql-x64-16
    echo if "%%choice%%"=="2" net stop postgresql-x64-16
    echo if "%%choice%%"=="3" goto :CREATE_DB
    echo if "%%choice%%"=="4" goto :DROP_DB
    echo if "%%choice%%"=="5" psql -U postgres -l
    echo if "%%choice%%"=="6" goto :BACKUP_DB
    echo if "%%choice%%"=="7" goto :RESTORE_DB
    echo if "%%choice%%"=="8" psql -U postgres
    echo if "%%choice%%"=="9" sc query postgresql-x64-16
    echo if "%%choice%%"=="0" exit /b
    echo pause
    echo goto MENU
    echo.
    echo :CREATE_DB
    echo set /p db_name=اسم قاعدة البيانات: 
    echo createdb -U postgres %%db_name%%
    echo echo [✓] تم إنشاء قاعدة البيانات: %%db_name%%
    echo pause
    echo goto MENU
    echo.
    echo :BACKUP_DB
    echo set /p db_name=اسم قاعدة البيانات: 
    echo set /p backup_file=ملف النسخ الاحتياطي: 
    echo pg_dump -U postgres %%db_name%% ^> %%backup_file%%
    echo echo [✓] تم إنشاء النسخ الاحتياطي: %%backup_file%%
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_postgresql_manager.bat"

echo [✓] تم إنشاء مدير قواعد البيانات!
echo [→] المسار: %USERPROFILE%\knoux_postgresql_manager.bat

:: Set environment variables
echo [→] جاري ضبط متغيرات البيئة...
setx PGDATA "C:\Program Files\PostgreSQL\16\data" /M
setx PATH "%PATH%;C:\Program Files\PostgreSQL\16\bin" /M

echo [✓] تم ضبط متغيرات البيئة!
echo [→] PGDATA: C:\Program Files\PostgreSQL\16\data
echo [→] PATH: C:\Program Files\PostgreSQL\16\bin

echo [✓] PostgreSQL جاهز للاستخدام!
echo [→] كلمة المرور الافتراضية: knoux123
echo [→] المستخدم: postgres
pause
