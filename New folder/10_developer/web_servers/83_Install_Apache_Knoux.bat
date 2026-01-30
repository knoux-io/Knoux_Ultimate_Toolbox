@echo off
:: =================================================================
:: KNOUX APACHE SERVER INSTALLER
:: تثبيت Apache مع مدير Virtual Hosts
:: =================================================================
title Knoux - Apache Server Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX APACHE + VIRTUAL HOST MANAGER
echo   تثبيت Apache مع مدير Virtual Hosts
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Apache HTTP Server...
choco install apache-httpd -y

echo [✓] تم تثبيت Apache!
echo [→] لبدء الخدمة: httpd -k start
echo [→] لإيقاف الخدمة: httpd -k stop
pause
