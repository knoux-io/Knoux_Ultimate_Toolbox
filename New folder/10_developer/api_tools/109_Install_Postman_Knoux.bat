@echo off
:: =================================================================
:: KNOUX POSTMAN INSTALLER
:: تثبيت Postman
:: =================================================================
title Knoux - Postman Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX POSTMAN + COLLECTION MANAGER
echo   تثبيت Postman مع مدير المجموعات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Postman...
winget install Postman.Postman --silent --accept-package-agreements

echo [✓] تم تثبيت Postman!
echo [→] افتح Postman لبدء الاستخدام
pause
