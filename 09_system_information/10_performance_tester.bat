@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - System Performance Tester
color 0C
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo               ____====-_  _-====____
echo          _--^^^#####//      \\#####^^^--_
echo       _-^##########// (    ) \\##########^-_
echo      -############//  |\^^/|  \\############-
echo    _/############//   (@::@)   \\############\_
echo   /#############((     \\//     ))#############\
echo  -###############\\    (oo)    //###############-
echo -#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /09/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo       SYSTEM PERFORMANCE TESTER - Tool 09.10
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Quick benchmark (simulated)
echo [2] CPU performance test (simulated)
echo [3] Disk performance test (simulated)
echo [4] Gaming/graphics profile (simulated)
echo [5] Export performance summary (TXT)
echo [6] Back to Information Menu
echo [7] Main Menu
echo.
set /p choice="Select (1-7): "

if "%choice%"=="1" goto QUICK
if "%choice%"=="2" goto CPU
if "%choice%"=="3" goto DISK
if "%choice%"=="4" goto GPU
if "%choice%"=="5" goto EXPORT
if "%choice%"=="6" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:QUICK
cls
echo ⚡ QUICK BENCHMARK (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Running CPU micro-test: [██████████] 100%%
echo Running memory test: [██████████] 100%%
echo Running storage test: [██████████] 100%%
echo Running GPU test: [██████████] 100%%
echo.
echo 📊 Score Summary:
echo • CPU: 9.6/10
echo • RAM: 9.2/10
echo • Disk: 9.7/10
echo • GPU: 10/10
echo.
echo ⭐ Overall: 9.6/10 (Excellent)
echo.
pause
goto MENU

:CPU
cls
echo 🚀 CPU PERFORMANCE (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Single-core test: [██████████] 100%%
echo Multi-core test: [██████████] 100%%
echo.
echo Results:
echo • Single-core: 2,150 pts
echo • Multi-core: 40,700 pts
echo • Stability: ✅ Stable
echo.
pause
goto MENU

:DISK
cls
echo 💿 DISK PERFORMANCE (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Sequential read: [██████████] 100%%
echo Sequential write: [██████████] 100%%
echo Random 4K: [██████████] 100%%
echo.
echo NVMe (System):
echo • Read: 7450 MB/s
echo • Write: 6900 MB/s
echo.
pause
goto MENU

:GPU
cls
echo 🎮 GAMING/GRAPHICS PROFILE (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Rendering test: [██████████] 100%%
echo Ray tracing test: [██████████] 100%%
echo.
echo Results:
echo • 1080p: 400+ FPS
echo • 1440p: 250+ FPS
echo • 4K: 120+ FPS
echo • Verdict: ✅ High-end gaming ready
echo.
pause
goto MENU

:EXPORT
cls
echo 💾 EXPORT PERFORMANCE SUMMARY
echo ═══════════════════════════════════════════════════════
echo.
set "OUT_DIR=C:\KNOX_Reports"
set "OUT_FILE=%OUT_DIR%\Performance_%date:~-4%%date:~4,2%%date:~7,2%.txt"
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%" >nul 2>&1

echo Writing report: [██████████] 100%%
(
  echo KNOX Performance Summary
  echo Date: %date% %time%
  echo CPU Score: 9.6/10
  echo RAM Score: 9.2/10
  echo Disk Score: 9.7/10
  echo GPU Score: 10/10
  echo Overall: 9.6/10
) > "%OUT_FILE%"

echo.
echo ✅ Report saved:
echo • %OUT_FILE%
echo.
pause
goto MENU
