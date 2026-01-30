@echo off
:: =================================================================
:: KNOUX GIT INSTALLER
:: تثبيت Git مع مدير سير العمل
:: =================================================================
title Knoux - Git Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX GIT + WORKFLOW MANAGER
echo   تثبيت Git مع مدير سير العمل
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Git...
winget install Git.Git --silent --accept-package-agreements

echo [✓] تم تثبيت Git!
git --version

:: Configure Git
echo [→] جاري إعداد Git...
set /p git_name=اسمك: 
set /p git_email=بريدك الإلكتروني: 

git config --global user.name "%git_name%"
git config --global user.email "%git_email%"
git config --global init.defaultBranch main
git config --global pull.rebase true

echo [✓] تم إعداد Git!
pause
