@echo off
:: =================================================================
:: KNOUX VISUAL STUDIO CODE INSTALLER
:: تثبيت VS Code مع مدير الإضافات
:: =================================================================
title Knoux - VS Code Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX VS CODE + EXTENSION MANAGER
echo   تثبيت VS Code مع مدير الإضافات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Visual Studio Code...
winget install Microsoft.VisualStudioCode --silent --accept-package-agreements

echo [✓] تم تثبيت VS Code!
code --version

:: Install essential extensions
echo [→] جاري تثبيت الإضافات الأساسية...
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension ms-python.python
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension vscode-icons-team.vscode-icons

echo [✓] تم تثبيت الإضافات!
pause
