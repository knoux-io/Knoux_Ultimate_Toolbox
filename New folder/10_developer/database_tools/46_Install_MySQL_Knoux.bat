@echo off
:: =================================================================
:: KNOUX MYSQL SERVER INSTALLER
:: تثبيت MySQL مع مدير النسخ الاحتياطي
:: =================================================================
title Knoux - MySQL Server Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX MYSQL SERVER + BACKUP MANAGER
echo   تثبيت MySQL مع مدير النسخ الاحتياطي
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت MySQL Server...
winget install Oracle.MySQL --silent --accept-package-agreements

echo [✓] تم تثبيت MySQL!
echo [→] لبدء الخدمة: net start MySQL80
echo [→] لإيقاف الخدمة: net stop MySQL80

:: Create backup script
echo [→] جاري إنشاء سكريبت النسخ الاحتياطي...
(
    echo @echo off
    echo title Knoux MySQL Backup Manager
    echo.
    echo echo [→] جاري إنشاء نسخة احتياطية...
    echo set backup_file=mysql_backup_%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%.sql
    echo mysqldump -u root -p --all-databases > "%backup_file%"
    echo.
    echo echo [✓] تم إنشاء النسخة الاحتياطية: %backup_file%
    echo pause
) > "%USERPROFILE%\mysql_backup.bat"

echo [✓] تم إنشاء مدير النسخ الاحتياطي!
pause
