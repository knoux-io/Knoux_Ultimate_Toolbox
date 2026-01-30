@echo off
chcp 65001 >nul
title Visual Effects Optimizer - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Visual Effects Optimizer                      ║
echo ║              Knoux Ultimate Toolbox                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Visual Effects Optimizer                      ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Best Performance (Disable all effects)
echo [2] Best Appearance (Enable all effects)
echo [3] Custom Settings
echo [4] Current Settings
echo [5] Gaming Optimized
echo [0] Exit
echo.
set /p choice="Select an option [0-5]: "

if "%choice%"=="1" goto best_performance
if "%choice%"=="2" goto best_appearance
if "%choice%"=="3" goto custom_settings
if "%choice%"=="4" goto current_settings
if "%choice%"=="5" goto gaming_optimized
if "%choice%"=="0" goto exit
goto menu

:best_performance
echo.
echo [INFO] Setting visual effects for best performance...
echo.

:: Disable all visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

:: Disable individual effects
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ComboBoxAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v CursorShadow /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FadeMenus /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SmoothScroll /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TooltipAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UIAnimation /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Visual effects set for best performance
pause
goto menu

:best_appearance
echo.
echo [INFO] Setting visual effects for best appearance...
echo.

:: Enable all visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul

:: Enable individual effects
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 400 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 0 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ComboBoxAnimation /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v CursorShadow /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FadeMenus /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SmoothScroll /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TooltipAnimation /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UIAnimation /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Visual effects set for best appearance
pause
goto menu

:custom_settings
echo.
echo [INFO] Custom visual effects settings:
echo.
echo [1] Enable/Disable Window Animations
echo [2] Enable/Disable Menu Animations
echo [3] Enable/Disable Taskbar Animations
echo [4] Enable/Disable Fade Effects
echo [5] Enable/Disable Smooth Scrolling
echo [0] Back to main menu
echo.
set /p custom="Select an option [0-5]: "

if "%custom%"=="1" goto window_animations
if "%custom%"=="2" goto menu_animations
if "%custom%"=="3" goto taskbar_animations
if "%custom%"=="4" goto fade_effects
if "%custom%"=="5" goto smooth_scrolling
if "%custom%"=="0" goto menu
goto custom_settings

:window_animations
echo.
set /p toggle="Enable window animations? [Y/N]: "
if /i "%toggle%"=="Y" (
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul
    echo [SUCCESS] Window animations enabled
) else (
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
    echo [SUCCESS] Window animations disabled
)
pause
goto custom_settings

:menu_animations
echo.
set /p toggle="Enable menu animations? [Y/N]: "
if /i "%toggle%"=="Y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FadeMenus /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Menu animations enabled
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FadeMenus /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Menu animations disabled
)
pause
goto custom_settings

:taskbar_animations
echo.
set /p toggle="Enable taskbar animations? [Y/N]: "
if /i "%toggle%"=="Y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Taskbar animations enabled
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Taskbar animations disabled
)
pause
goto custom_settings

:fade_effects
echo.
set /p toggle="Enable fade effects? [Y/N]: "
if /i "%toggle%"=="Y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ComboBoxAnimation /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Fade effects enabled
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ComboBoxAnimation /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Fade effects disabled
)
pause
goto custom_settings

:smooth_scrolling
echo.
set /p toggle="Enable smooth scrolling? [Y/N]: "
if /i "%toggle%"=="Y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SmoothScroll /t REG_DWORD /d 1 /f >nul
    echo [SUCCESS] Smooth scrolling enabled
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SmoothScroll /t REG_DWORD /d 0 /f >nul
    echo [SUCCESS] Smooth scrolling disabled
)
pause
goto custom_settings

:current_settings
echo.
echo [INFO] Current visual effects settings:
echo.
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting 2>nul
echo.
echo Individual effects:
reg query "HKCU\Control Panel\Desktop" /v DragFullWindows 2>nul
reg query "HKCU\Control Panel\Desktop" /v MenuShowDelay 2>nul
reg query "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate 2>nul
echo.
pause
goto menu

:gaming_optimized
echo.
echo [INFO] Applying gaming-optimized visual settings...
echo.

:: Gaming-optimized settings (balance between performance and appearance)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

:: Keep essential effects, disable heavy ones
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ComboBoxAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v CursorShadow /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FadeMenus /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SmoothScroll /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TooltipAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UIAnimation /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Gaming-optimized visual settings applied
pause
goto menu

:exit
echo.
echo [INFO] Visual Effects Optimizer closed
exit /b 0
