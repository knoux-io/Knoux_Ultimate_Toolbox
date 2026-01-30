@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Developer Tools Menu
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /10/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           💻 DEVELOPER TOOLS
echo               Category: 10 Developer Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Environment Setup
echo [2] Code Editors & IDEs
echo [3] Version Control
echo [4] Build Tools
echo [5] Package Managers
echo [6] Testing Tools
echo [7] Documentation Tools
echo [8] API Tools
echo [9] Database Tools
echo [10] DevOps Tools
echo [11] Container Tools
echo [12] Cloud Tools
echo [13] Security Tools
echo [14] Productivity Tools
echo [15] Frameworks
echo [16] Frontend Development
echo [17] Mobile Development
echo [18] Web Servers
echo [19] Code Analysis
echo [20] Back to Main Menu
echo.
set /p choice="Select option (1-20): "

if "%choice%"=="1" call "%SCRIPT_DIR%env_setup\01_env_setup_manager.bat"
if "%choice%"=="2" call "%SCRIPT_DIR%editors_ides\02_editors_manager.bat"
if "%choice%"=="3" call "%SCRIPT_DIR%version_control\03_git_manager.bat"
if "%choice%"=="4" call "%SCRIPT_DIR%build_tools\04_build_manager.bat"
if "%choice%"=="5" call "%SCRIPT_DIR%package_managers\05_package_manager.bat"
if "%choice%"=="6" call "%SCRIPT_DIR%testing_tools\06_testing_manager.bat"
if "%choice%"=="7" call "%SCRIPT_DIR%documentation\07_doc_manager.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%api_tools\08_api_manager.bat"
if "%choice%"=="9" call "%SCRIPT_DIR%database_tools\09_db_manager.bat"
if "%choice%"=="10" call "%SCRIPT_DIR%devops\10_devops_manager.bat"
if "%choice%"=="11" call "%SCRIPT_DIR%containers\11_container_manager.bat"
if "%choice%"=="12" call "%SCRIPT_DIR%cloud_tools\12_cloud_manager.bat"
if "%choice%"=="13" call "%SCRIPT_DIR%security_tools\13_security_manager.bat"
if "%choice%"=="14" call "%SCRIPT_DIR%productivity\14_productivity_manager.bat"
if "%choice%"=="15" call "%SCRIPT_DIR%frameworks\15_framework_manager.bat"
if "%choice%"=="16" call "%SCRIPT_DIR%frontend\16_frontend_manager.bat"
if "%choice%"=="17" call "%SCRIPT_DIR%mobile_dev\17_mobile_manager.bat"
if "%choice%"=="18" call "%SCRIPT_DIR%web_servers\18_webserver_manager.bat"
if "%choice%"=="19" call "%SCRIPT_DIR%code_analysis\19_analysis_manager.bat"
if "%choice%"=="20" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU
