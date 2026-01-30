@echo off
title Knox Ultimate Toolbox - Developer Tools
color 0B
cls

setlocal
set "SCRIPT_DIR=%~dp0"

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           أدوات المطورين الأسطورية
echo               Category: 10 Developer
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] إعداد بيئة التطوير
echo [2] مديرو الحزم
echo [3] المحررات وبيئات التطوير
echo [4] أدوات قواعد البيانات
echo [5] التحكم بالإصدار
echo [6] الحاويات والافتراضية
echo [7] خوادم الويب
echo [8] تطوير الواجهات الأمامية
echo [9] تطوير الموبايل
echo [10] تطوير API
echo [11] أدوات الاختبار
echo [12] أدوات الأمان
echo [13] DevOps و CI/CD
echo [14] أدوات البناء
echo [15] التوثيق
echo [16] الإنتاجية
echo [17] أدوات السحابة
echo [18] تحليل الكود
echo [19] أطر العمل
echo [20] العودة للقائمة الرئيسية
echo.
set /p choice="اختر الفئة (1-20): "

if "%choice%"=="1" call "%SCRIPT_DIR%env_setup\01_nodejs_lts.bat"
if "%choice%"=="2" call "%SCRIPT_DIR%package_managers\01_chocolatey_setup.bat"
if "%choice%"=="3" call "%SCRIPT_DIR%editors_ides\01_vscode_setup.bat"
if "%choice%"=="4" call "%SCRIPT_DIR%database_tools\01_mysql_server.bat"
if "%choice%"=="5" call "%SCRIPT_DIR%version_control\01_git_scm.bat"
if "%choice%"=="6" call "%SCRIPT_DIR%containers\01_docker_desktop.bat"
if "%choice%"=="7" call "%SCRIPT_DIR%web_servers\01_apache.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%frontend\01_react_dev_tools.bat"
if "%choice%"=="9" call "%SCRIPT_DIR%mobile_dev\01_android_studio.bat"
if "%choice%"=="10" call "%SCRIPT_DIR%api_tools\01_postman.bat"
if "%choice%"=="11" call "%SCRIPT_DIR%testing_tools\01_selenium.bat"
if "%choice%"=="12" call "%SCRIPT_DIR%security_tools\01_openssl.bat"
if "%choice%"=="13" call "%SCRIPT_DIR%devops\01_jenkins.bat"
if "%choice%"=="14" call "%SCRIPT_DIR%build_tools\01_webpack.bat"
if "%choice%"=="15" call "%SCRIPT_DIR%documentation\01_mkdocs.bat"
if "%choice%"=="16" call "%SCRIPT_DIR%productivity\01_windows_terminal.bat"
if "%choice%"=="17" call "%SCRIPT_DIR%cloud_tools\01_aws_cli.bat"
if "%choice%"=="18" call "%SCRIPT_DIR%code_analysis\01_eslint.bat"
if "%choice%"=="19" call "%SCRIPT_DIR%frameworks\01_django_project.bat"
if "%choice%"=="20" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"

goto MENU
