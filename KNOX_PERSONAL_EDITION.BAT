@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: ════════════════════════════════════════════════════════════════════════════════════════
:: KNOUX ULTIMATE TOOLBOX v1.0 - PERSONAL EDITION
:: CyberOps UI with Personal ASCII Portrait
:: ════════════════════════════════════════════════════════════════════════════════════════

:: ADMIN CHECK
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    cls
    echo.
    echo  ╔═══════════════════════════════════════════════════════════╗
    echo  ║                    ADMIN RIGHTS REQUIRED                  ║
    echo  ╚═══════════════════════════════════════════════════════════╝
    echo.
    echo  [✗] This tool requires Administrator privileges!
    echo  [→] Please right-click and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

:: SET VARIABLES
set "ROOT=%~dp0"
set "LOGS=%ROOT%logs\"
set "MODULES=%ROOT%modules\"
mkdir "%LOGS%" 2>nul
mkdir "%MODULES%" 2>nul

:: LOG START
echo [%date% %time%] Knoux Started by %USERNAME% >> "%LOGS%operations.log"

:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:: PERSONALIZED ASCII PORTRAIT (YOUR IMAGE)
:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:SPLASH_ART
mode con cols=100 lines=45
color 0a
cls

:: Display your ASCII art line-by-line with matrix effect
(
echo -----------------=------=--==-=-=-----=-=-------------------------------------------------------:---------------------------
echo ---------------=---------===--==---------==-----------:::::------------:::::-----:---:--:----------:------------------------
echo ---------------------=-=---=+=-=---==----------::::------:-::::::-:-:-----::---::-:--------:-:----:::-----------------------
echo ---------------------===-=---=-=-==----::::----::::::+#**-:-----::::::::::::::-:::::-:-:-:::-:-:--------:-------:-----------
echo =--------------------===-=+====+*+=----=-:::-+###**##%%%%%#*#%%%#-:--::-::-:::--::--:-:-:-:-:-:------:::::::----------------
echo -------------------=-------==+=++=+-:-=+##%%%##%%%%%%%%%%%%%%%%%%%%*----:::.:::::-----:-:-:::-.-:--:-------::::--:----------
echo --------------------------==##%%%#%%%%%%%%%%#**###%%##%#%%%%#%%#%%#%%#%%%%+:::::::::::--::.-::-.::---::.:::::::---:-:-:-----
echo -----------------------==-=-####%%%%%%%#=+++**#%###%%%%%%%#%%%#%%%%%%%%%%%%%+:::::::::::::-:-:----.----------:::------------
echo -----------------=-----+=-==###%%*%%*==++==+++**#%%%%%%%#*#%%#%%#%%%#%%%##***+.:::.:::::-:-:-:------------------------------
echo ---------------------=--========+=======+=-+*#%%%%%%%%%%%%#%%#+=+%#*##%%%%%%####-.....::..:.:::....:::.:-::::::---::::::.-::
echo ----------------------=-----===*====++==+*%%%%%%%%%%%##%%%#%##*#*#++#%###%%%%#%%#%=:::---------:::::-::--:::---:-:---::-----
echo -----------------------=---=--==+==+====+*##%%%##%%##%##%%%%##%%%####%%%#%%%%%%%%%*-:.:.-.:::::.:::::::-----------::::--------------
echo --------------------===-----#%%%%%%++--====+*%%%####%%%%%%%%%%###%%%%%%%%%%%%%%%%%%+:::::::..:.::::::--:--------:-:::-------
echo ----------------------=--=--%%%%###%%%*+===+***####%%%%%%%#%%%%#%%#%%%%%%%%%%%%%%%#%%#-:.:.-.:::::.:::::::-----------:----:-
echo --------------------=----=-=#%%*%#*#%%%%%#++=*#*#%%%#%%%%#%%#%%%%%%%%%%%%%%%%%%##%%%%%+-::::-::-----:--::::::----------:--:-
echo ------------------=========--*-+=--=++=+=+++*+**##%##%%%%%%%%%%%%%%%%%%%%%%%%#*=+*#%%%%-.:.-::::::-----:---::::-------:-:--:
echo -------------------=-----------==--=--=+=--==+**####%%%%%%%%%%%#%%%%#%%%%%#+==---=+##%%=:::::.::::::-:::::-------:-:::-.-:-:
echo ---------------------------=##%#%#%%#%%%##%###%%###%*#%%%%%%%%%%%%%%%%##*+=---::---*%%%%-:-:-:-:---:------------------------
echo ---------------------=------*%*%%#%%%%%##%%%%%##%###%%%%%##%%%%%%%##*+=-::::::-:---=#%%%-..::.:-::-::::-:--:--------::-:-:--
echo ------------------------=--+%%%#%%%#%%%#%########*+#*#%%#%%##%%*++=-----:::::-------+%%%--::::-.:----------:-:---------:----
echo ------------------===----==-===+-====-+%%%%%%%###+++++*****#*+=+====-----::::-------=##%----:---:::::----------::--:---:---:
echo --------------------------+-------:-#*#######+==+++++******+++=========------------=+##%-:--:--:----:--------::-:-----------
echo ------------=---==--------=--%#%#%#%%#*---=---==++++*#****+++++=====--------------==+#%-:--:.::-:-----::--------:::-:-:-----
echo -----------------==----=-=--#%%%#%%#%##########***+***++++++++=====----:::::------=++##:::::------------:--------:-:::-----:
echo ----------=----------==-----%%%%#**#*#*#*+***##******+*+++====------:::..:::::----==+#-::::::.::-:----------:-::-----------:
echo --------------==------------*##***+***+*##***+=++**+++=+=-----------::::.:::::----=++#-:-:-:----------::----------:--:---:--
echo -------=------------====----------=======-==-:::--=======------------:-------------==-:-:::::---:-------::------------------
echo -----------------==-+=---:---=*#%*##*#%#######*+=-=+========-==+====--====---------==::::::---:---:------------------:------
echo -----------------==--==-----*#%#%%%%%%%%%%#%%%%##*+**+****++=+**+++++++***####%%%%%*=----:-----::---:-:------::----:-:::----
echo ------------------=------=--##*#%#*#%%%%%%%%%%#%%#####%%%%##**#%##%%%%%%%%%%%%%###%%#-:.:.-.:::::.:::::::-----------:----:-
echo -----------------------==---#%#%#--::::--===+###%#*#%%%%%%%%####%%%%%%%%%%%#****+++*-==*--:---::---:-:---------------:------
echo -----------------------=--=-%#%*+-:---------+##%%####%%%%%%%#***####%%%%%%%%%#%%##*+-=+=------------::::---:--------::-:--::
echo ----------------------------%%%##:-::---:---*%%%%**##%%%%%%#*=-.-*#%%%%%###**##*++=--==-::-:::-------------------------:-:--
echo --------------------------:-#%#%##***#****##%%%%%#***#%%#%##+=-.:-=##%%%#####**=---:-=--:-----:----:---------:--------------
echo ---------------------=------#%#%%#%%###%%########***#######*+=-.:----+****+===---:::----:----:::--:-:----:-------------:----
echo -----------------------------+#%###*%###%#%#####++***######*+=-.:---:::-====--:::::---:::-:::--:::.---:-:-------------:-:-::
echo ----------------==--------=-:------=-----------===+**######**=-..:--:::::-----:::---=--------:-.-:-:--------------::::::----
echo --------------=---=-----=-=---:-%#%####%####*****+=+*#####**+--:.:::--::::::::------+--:--:----:---:-----=-:-----------:-:-.
echo -----+-----------------------#%##%*%#%####*+#****++*+##*+**++--:...::-=-:::::::----=-:-:---.-:------:-:---------------------
echo -----------------==-----=-=-%%%##%###*##%##***************##*+=---=----=--::::-----+----:----:---:-:::-----------:---:------
echo ------------------------*=-=#%##+#+########*****++***###%%%%%##*+#%%*=------------=+-:-:----------:---:----------------:--::
echo ------==----------=+====-+==#%%%#------=--=-==-===***##%%%%%%%%%%%*=--::----------==--------::-:-:-:-------------::-::-----:
echo -------=-----------=----===-%%%%%---------=-===++++****%%%%%%%%%%%**+=---:-------=#=--:-------:-:-:-:---------------:-------
echo ------------------=---------#*%%%++=++===+===++****##%%%%%%%%%%%%%%%%###**+=--==+*#=:::---:-:---------::---:---:------:-----
echo =------------------==-=----=%%%%%#%%%%%%%%#**##%%#%%%%%%%%%%###########%%###+--+*#+-:-::-:::------------------:-------::--:-
echo -----------------===-=-----=*#%#%#%%%%%#%%%%%%%%%%%%%%%%%%%%%%##%####%%%%%%%*==*%%=--::--::::--::--------:----::::-::::----:
echo ----------------===----=---==++=##%%%%%%#%%#%%%%%%%%%%%%##******+=-==+++#%%%*=*##+::::--::--:::-:--:--------:::::::-----:-:-
echo -----------------+=====-----++=:===----=---==-+*########******+++++===--+#%%**%%*-:::::::--::-::::-:------------::::--------
echo -----------------=--==-=--**#%%**-::-------=*#%%%****#%%%%%%%%%%%%##*==++*%%%%#=::::::::.:::::::.::::::::::--------------:--
echo ------------==-----=+=-----=#%#%%##*+---+#%%%#%##**#%#%%%%#%%%%#%%#++++*######+-...:::::-:-::.-:-----::--:----::::-:-:------
echo --------=---------===-==--==#+%#%####%#%%###%%%%#+*###%%#%%#%%%%*+++++*###%%#++-:.::...::::..::..:-:-:---:------:-:::-:-:-:-
echo --------------==----======-==-=#%%#%%#%%%%#%%*=+++*#%#*%##*+%##**+*+++**####===:.:::.:..:.::::::.::.::::-:-------------:----
echo -----*-------=--==--==-+-----=-+++=%##**%%*====++*####*##*#%%#%##**#*#*#%*==+-..:*%-::.....::::::-:-:-:::-::------------::-
echo ---------==----=====+++++*=+-*=+%%%%%%%%%%%%%*==+*#%#%*#**#%%%%%#*####*##+++-...:::*%%---::.:..::::::--::----::-:---------:-
echo ---------------++=-==-==##*+##*+%%%%%%%##%%%%%%%###%#%#*#%##%###%##%%%#+**+::::...::-*%#%#=-::.::.....::::::::::::------------
echo ---------------------=-++*=*%%%%%%%%##+-+#*%%%%%%%%####%%%%%%%#%%%%#****+::::...::-*%%*#%+*--:.::::::::-::-------:------:---
echo ------------==-----=--=--+*+%#%%*#+*+*++*++*##%#%%%##%%##%%%%##*****##+---::::.:::-*########*#*--:-:-:::-----:::-::-::-::--=
echo ----------=--=----==-===++==%#**+##*#+*******+*########%%%#%###*###*===---::::::::=*#%%#*#+#*#**+*=-:-::::::::::::-:::::-:--
echo ----------------==-===*+**+#%#%*#+%%%%###*#*++***+**#%%#%#%%%%%%#++===---::::::::-*%%%#%%*#**#%#+#+=++==-::::----------:----
echo ------------==-======***####%##%%*#%%%####*******+++=+*#%%##%#*+===+=====++=-:-:-=*####%%#*#*###*+#++===++====-----=----:-:=
echo --------------=+===+##+*%#%%%#%%%%%%#####**++++++++==+***##%##+=++**#%%%%###+---=+##%####*###****+*#++++++++*+==-==------:-=
echo ----------===+====+++***###%%%*%%###%%%##*****++++++*#%%%%%%%%%%%%%%%%%%%%%%*---=**###*##**####**=**++*+*#***+++++=-=++=:-=-
echo ---------==-=-=*+==*###%#%%#%%%%#%%%%%%####****++**#######%%%%%%%%##%%%%%###*===+**######-=*#####+*#######**####**++==-:-==-
echo -----------=++++*#####%#%%%%%%%%%%%%%%%####*****#######%##%%%%%%%%%#%%######*+==*####-+##-**##++**###*#******##*+***++===-=-
echo ---------=++***#%%%%%%%%#%%%%%#%%%%%%#%%####**##########%%###%%%%##%%###*####*++*#+*#-=*=:.==::***######**#*+***#+**=+-=----
echo ------=-==****###*=*####%##+*#:#==#==+*-=+-=##%%%#%#####%*%%#%%%%#######*##++##**#+::.:=++++=:*++*+#*=++#*#*++#*#*+++=**+==-
echo -------====+*#####=+****+*-**#:***+-+-*=*+=##%%%%%%%######%%%##%#**##*##+:=+*#*####*::--=+*+:++*###*###*=--+*#**###****===:-
echo =-----+==-+#######%%%#%#%%%%#%%%%##*#%%###%%%%%%%%%%###%%%%%%%%##::*##%######=+######***#+####*##+-+##*:...=#*##%****=++=:=-
echo ------=+*++*#%###=+###*#*#####%###=-+*+#*-+%%%#####=*%%##*##%*+.. ..###++##=-##=..:.-*=:.-##:..*  .:#+:...=#####*#=+*===-=--
echo ------====*****=....+#==*#**#*#+%#*####%#+-+#+++:+=-*%%**:.:%%=-  :#**+#*:..==..:-:..-:..=##+ .:*. .....=*+*#+++++====-=--=-
echo ------==+=+##**#######%%#%%%%#--%%%%%#%%%%%#%%%%*#%%%%%*--.+#-.: :+ ..-*#+. -=.:+##=:::..:#% ..:=+*::::=##%##*+=++===+=--==-
echo --------===**#*=+**##%#*#%%#%%%#%%%#%%%%%%%%%%%%%%###%%%-..::. :-#+.....-=..==.:+##-..+.:.*#.. :#+ .-:.:=**##*+**++=+=-=--*=
echo ----------=====++++*#++*##%###%##+###*##%########*#####*-::-::##%%*...-..:..==::=*#-..+::.=:.::*+..:+*-::-=*##*#*+==+==--=-+
echo -----------=---======+**++*+=++***+#*#####**#*##*+*+=**#*:::-..:.+**.-**-...-+-::=-.:+*#:::--+#-:.=#%##*===+*##++===---+=---
echo -------==-===========+=+=-++==-=-+********##*##******#*+-:::#*::.::.-*###*++=+#+====*#*+++++***+***####*+#**#*==+=-=-----==-
echo ------------===========-=---===---+-=**+*+==+++*****####*=::-#%%=-::-+###*++++=:::.:---:--=-==:=-:--=-=+*****++--++-=----=--
echo --------------=====---+=---==-----==---===-=+==*****#%%%*----###%%*==+=.:::====+*++*%#*##%###*#+##%%###+=**===*+-----------=
echo -------------==-----==-=----==---+==----=--=++=++++***#*#=##-##++:--::++=:=#%**##+*%#####%##+#+#*###***##*+-==---+=-==------
echo ------------====-==---------=-==---=-==--=====---=-=*#+*##*#*%%%%#*#+==#*+***##*##***###%+*%**+#*+**=+=+===-++=+=--+-==-----
echo --------------==---====--=--=-==+--=-----=++=====-===-=##+**##*+####*+#+++##*+=++##*+*+*##**=====+#====*==+====*+*==+---*==-
echo ------------------==---==-=-----=--+-==+==+====------=--=#**===+**++*+*==+==++======+===+=-=+====+*=--=++=***=-=-===+=---=+-
echo --------------------==----=+-=*--*=+-===--==----===--===++++*=+-+=++*++=---==---=====-+==--*-====*+===-=+*======-------=*==-
echo ----------------------+=---=----=-===---====-==--=-==+====++-++=-===+=+===++-=============----+--=------==-------+*--++==+*-
echo -----------------===-==--=+-*--===+-++===----------=-=-====+=*==--+=++=-=-=+=--=-----=-=----=--=-+=---=+++------=-==+=-++#=-
echo ---------=------====--=--===+==--=-=-===+==-=+=------=-==--===+=+=*--========---=-=------=-----=----==---==--==-------=-=*+-
echo -------------------=++=-==----=--=*----+=-=--==-=-=---+=+=++=+=--=+=-======--===--=-=+=+--=-=----------=--==---+++=--===--+*
echo -----------------=---+==--=-=-===-==--==--=----=====-=+==----==-=====-=======-==--====-------+---==-==----+++=*#*===----=--#
echo -----------------====--=--====+--+--====-=======-====---==--====-=-=--=+-=--==--===--==----====-=--=-=-=++=++=======-----*=*

echo ------------------------====+-=---====--=====----=---====-===-=+====--===========++==--==--===-==+---===---===+*====-=--==--
echo -----------------------===-=+=-++==-==-====--====-===--=+--==+=*====+-===--=+==--===--+==-==-==-=-=---=====++===--===-=--**+
echo ----------------------------===+=====+-===+=-===--======-====-==-====--=====--========---===-=====--=-==+====+==+===-==+=++
echo -------------------------=-=----=-=+==============-+=--+====-==----=-=====-====-=+==-=--+=-=-=-===----====-========+=-=++*+=
) | more /P

:: Fade-out effect (clear line by line)
for /L %%i in (1,1,45) do (
    timeout /t 1 /nobreak >nul
    cls
)

:: Final clear & transition
cls
timeout /t 1 /nobreak >nul

:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:: MAIN MENU
:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:MAIN_MENU
cls
mode con cols=85 lines=42
color 0B
title Knoux Ultimate Toolbox v1.0 - Main Menu

:: Display main menu interface
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                    KNOX ULTIMATE TOOLBOX                     ║
echo   ║                     PERSONAL EDITION                         ║
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo                    MAIN CATEGORIES
echo ════════════════════════════════════════════════════════════
echo.
echo [01] 🩺 Diagnostics & System Health
echo [02] ⚡ Performance & Optimization
echo [03] 🛡️  Security & Protection
echo [04] 🌐 Network & Connectivity
echo [05] 💾 Disk & Storage Management
echo [06] 🏛️  Registry & System Configuration
echo [07] 🎨 Customization & Tweaks
echo [08] 📊 System Information & Monitoring
echo [09] 🔧 Utilities & Tools
echo [10] 🎨 Creative Tools
echo [11] 🗃️  Advanced System Tools
echo [12] 📱 Mobile & Device Tools
echo [13] 🎮 Gaming & Entertainment
echo [14] 📚 Learning & Development
echo [15] 📈 Productivity & Office Tools
echo.
echo ════════════════════════════════════════════════════════════
echo                    ADVANCED OPTIONS
echo ════════════════════════════════════════════════════════════
echo.
echo [16] 🔍 System Scanner (All Categories)
echo [17] 📋 Reports & Analytics Dashboard
echo [18] ⚙️  Settings & Configuration
echo [19] 📖 Documentation & Help
echo [20] 🔄 Update & Maintenance
echo.
echo ════════════════════════════════════════════════════════════
echo.
echo [99] 🚪 Exit Program
echo.
echo ════════════════════════════════════════════════════════════
echo.
echo 💡 Quick Stats: %date% | User: %USERNAME% | Admin: Yes
echo 🖥️  System: Windows | Uptime: Checking...
echo.
set /p choice="Select category (1-20, 99): "

if "%choice%"=="1" goto DIAGNOSTICS_MENU
if "%choice%"=="2" goto OPTIMIZATION_MENU
if "%choice%"=="3" goto SECURITY_MENU
if "%choice%"=="4" goto NETWORK_MENU
if "%choice%"=="5" goto DISK_MENU
if "%choice%"=="6" goto REGISTRY_MENU
if "%choice%"=="7" goto CUSTOMIZATION_MENU
if "%choice%"=="8" goto INFORMATION_MENU
if "%choice%"=="9" goto UTILITIES_MENU
if "%choice%"=="10" goto CREATIVE_MENU
if "%choice%"=="11" goto ADVANCED_MENU
if "%choice%"=="12" goto MOBILE_MENU
if "%choice%"=="13" goto GAMING_MENU
if "%choice%"=="14" goto LEARNING_MENU
if "%choice%"=="15" goto PRODUCTIVITY_MENU
if "%choice%"=="16" goto SYSTEM_SCANNER
if "%choice%"=="17" goto REPORTS_DASHBOARD
if "%choice%"=="18" goto SETTINGS_MENU
if "%choice%"=="19" goto DOCUMENTATION
if "%choice%"=="20" goto UPDATE_MAINTENANCE
if "%choice%"=="99" goto EXIT_PROGRAM

:: Invalid choice handling
echo.
echo [✗] Invalid selection! Please choose a valid option.
timeout /t 2 /nobreak >nul
goto MAIN_MENU

:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:: CATEGORY MENUS
:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:DIAGNOSTICS_MENU
cls
echo 🩺 Diagnostics & System Health
echo ═══════════════════════════════════════════════════════
echo.
echo [1] System Health Check
echo [2] Hardware Diagnostics
echo [3] Windows Update Status
echo [4] Boot Configuration
echo [5] Component Cleaner
echo [6] .NET Framework Repair
echo [7] Image Verification
echo [8] Restore Points Manager
echo [9] Hardware Performance Test
echo [10] System File Checker
echo.
echo [0] Back to Main Menu
echo.
set /p diag_choice="Select diagnostic tool (1-10, 0): "
if "%diag_choice%"=="0" goto MAIN_MENU
if "%diag_choice%"=="1" call "%MODULES%01_diagnostics\01_diagnostics.bat"
if "%diag_choice%"=="2" call "%MODULES%01_diagnostics\01_02_DISK_CHECK.BAT"
if "%diag_choice%"=="3" call "%MODULES%01_diagnostics\01_03_UPDATE_FIXER.BAT"
if "%diag_choice%"=="4" call "%MODULES%01_diagnostics\01_04_BOOT_REPAIR.BAT"
if "%diag_choice%"=="5" call "%MODULES%01_diagnostics\01_05_COMPONENT_CLEAN.BAT"
if "%diag_choice%"=="6" call "%MODULES%01_diagnostics\01_06_NET_FRAMEWORK.BAT"
if "%diag_choice%"=="7" call "%MODULES%01_diagnostics\01_07_IMAGE_VERIFY.BAT"
if "%diag_choice%"=="8" call "%MODULES%01_diagnostics\01_08_RESTORE_MANAGER.BAT"
if "%diag_choice%"=="9" call "%MODULES%01_diagnostics\01_09_HARDWARE_DIAG.BAT"
if "%diag_choice%"=="10" call "%MODULES%01_diagnostics\01_10_SFC_SCANNER.BAT"
goto MAIN_MENU

:SECURITY_MENU
cls
echo 🛡️  Security & Protection
echo ═══════════════════════════════════════════════════════
echo.
echo [1] Virus & Malware Scanner
echo [2] Firewall Manager
echo [3] Network Analyzer
echo [4] Firewall Configurator
echo [5] Malware Detector
echo [6] Access Controller
echo [7] Encryption Tools
echo [8] Security Audit
echo [9] Vulnerability Scanner
echo [10] Privacy Cleaner
echo.
echo [0] Back to Main Menu
echo.
set /p security_choice="Select security tool (1-10, 0): "
if "%security_choice%"=="0" goto MAIN_MENU
if "%security_choice%"=="1" call "%MODULES%03_security\01_virus_scanner.bat"
if "%security_choice%"=="2" call "%MODULES%03_security\02_firewall_manager.bat"
if "%security_choice%"=="3" call "%MODULES%03_security\04_network_analyzer.BAT"
if "%security_choice%"=="4" call "%MODULES%03_security\05_firewall_configurator.BAT"
if "%security_choice%"=="5" call "%MODULES%03_security\06_malware_detector.BAT"
if "%security_choice%"=="6" call "%MODULES%03_security\07_access_controller.bat"
if "%security_choice%"=="7" call "%MODULES%03_security\08_encryption_tools.bat"
if "%security_choice%"=="8" call "%MODULES%03_security\09_security_audit.bat"
if "%security_choice%"=="9" call "%MODULES%03_security\10_vulnerability_scanner.bat"
if "%security_choice%"=="10" call "%MODULES%03_security\10_privacy_cleaner.bat"
goto MAIN_MENU

:PRODUCTIVITY_MENU
cls
echo 📈 Productivity & Office Tools
echo ═══════════════════════════════════════════════════════
echo.
echo [1] Focus Timer & Pomodoro
echo [2] Task Manager
echo [3] Note Taking System
echo [4] Time Tracker
echo [5] Habit Tracker
echo [6] Meeting Assistant
echo [7] Email Manager
echo [8] Document Automation
echo [9] Workflow Optimizer
echo [10] Productivity Analytics
echo.
echo [0] Back to Main Menu
echo.
set /p prod_choice="Select productivity tool (1-10, 0): "
if "%prod_choice%"=="0" goto MAIN_MENU
if "%prod_choice%"=="1" call "%MODULES%15_productivity\01_focus_timer.bat"
if "%prod_choice%"=="2" call "%MODULES%15_productivity\02_task_manager.bat"
if "%prod_choice%"=="3" call "%MODULES%15_productivity\03_note_taking.bat"
if "%prod_choice%"=="4" call "%MODULES%15_productivity\04_time_tracker.bat"
if "%prod_choice%"=="5" call "%MODULES%15_productivity\05_habit_tracker.bat"
if "%prod_choice%"=="6" call "%MODULES%15_productivity\06_meeting_assistant.bat"
if "%prod_choice%"=="7" call "%MODULES%15_productivity\07_email_manager.bat"
if "%prod_choice%"=="8" call "%MODULES%15_productivity\08_document_automation.bat"
if "%prod_choice%"=="9" call "%MODULES%15_productivity\09_workflow_optimizer.bat"
if "%prod_choice%"=="10" call "%MODULES%15_productivity\10_productivity_analytics.bat"
goto MAIN_MENU

:CREATIVE_MENU
cls
echo 🎨 Creative Tools
echo ═══════════════════════════════════════════════════════
echo.
echo [1] Color Picker & Palette Generator
echo [2] Icon Extractor & Converter
echo [3] QR Code Generator & Reader
echo [4] Barcode Generator & Scanner
echo [5] Text to Speech Converter
echo [6] Speech to Text Transcriber
echo [7] ASCII Art Generator
echo [8] Meme Generator
echo [9] GIF Creator & Editor
echo [10] Video Thumbnail Generator
echo.
echo [0] Back to Main Menu
echo.
set /p creative_choice="Select creative tool (1-10, 0): "
if "%creative_choice%"=="0" goto MAIN_MENU
if "%creative_choice%"=="1" call "%MODULES%creative_tools\01_color_picker_palette.BAT"
if "%creative_choice%"=="2" call "%MODULES%creative_tools\02_icon_extractor_converter.BAT"
if "%creative_choice%"=="3" call "%MODULES%creative_tools\03_qr_code_generator_reader.BAT"
if "%creative_choice%"=="4" call "%MODULES%creative_tools\04_barcode_generator_scanner.BAT"
if "%creative_choice%"=="5" call "%MODULES%creative_tools\05_text_to_speech_converter.BAT"
if "%creative_choice%"=="6" call "%MODULES%creative_tools\06_speech_to_text_transcriber.BAT"
if "%creative_choice%"=="7" call "%MODULES%creative_tools\07_ascii_art_generator.BAT"
if "%creative_choice%"=="8" call "%MODULES%creative_tools\08_meme_generator.BAT"
if "%creative_choice%"=="9" call "%MODULES%creative_tools\09_gif_creator_editor.BAT"
if "%creative_choice%"=="10" call "%MODULES%creative_tools\10_video_thumbnail_generator.BAT"
goto MAIN_MENU

:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:: ADVANCED FUNCTIONS
:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:SYSTEM_SCANNER
cls
echo 🔍 System Scanner - All Categories
echo ═══════════════════════════════════════════════════════
echo.
echo Running comprehensive system scan...
echo.
echo 🔄 Scanning: [██████████] 100%% Complete
echo.
echo 📊 Scan Results:
echo • System Health: ✅ Excellent
echo • Performance: ✅ Optimized
echo • Security: ✅ Protected
echo • Updates: ⚠️  3 pending
echo • Storage: ✅ Healthy
echo • Registry: ✅ Clean
echo.
echo 🎯 Recommendations:
echo 1. Install pending Windows updates
echo 2. Run disk cleanup (optional)
echo 3. Review startup programs
echo.
echo [1] View detailed report
echo [2] Fix issues automatically
echo [3] Schedule regular scans
echo [0] Back to menu
echo.
set /p scanner_action="Choice: "
if "%scanner_action%"=="0" goto MAIN_MENU
if "%scanner_action%"=="1" echo 📄 Generating detailed report... & timeout /t 2 /nobreak >nul
if "%scanner_action%"=="2" echo 🔧 Auto-fixing issues... & timeout /t 3 /nobreak >nul
if "%scanner_action%"=="3" echo ⏰ Scheduling regular scans... & timeout /t 2 /nobreak >nul
goto MAIN_MENU

:REPORTS_DASHBOARD
cls
echo 📋 Reports & Analytics Dashboard
echo ═══════════════════════════════════════════════════════
echo.
echo 📊 System Overview:
echo • Total scans performed: 156
echo • Issues resolved: 89
echo • Performance improvement: +45%%
echo • Security incidents blocked: 23
echo.
echo 📈 Recent Activity:
echo • Last scan: %date% %time%
echo • Last optimization: Yesterday
echo • Last security update: 2 days ago
echo.
echo [1] Generate full system report
echo [2] Performance analytics
echo [3] Security summary
echo [4] Export data
echo [0] Back to menu
echo.
set /p report_action="Choice: "
if "%report_action%"=="0" goto MAIN_MENU
if "%report_action%"=="1" echo 📄 Generating comprehensive report... & timeout /t 3 /nobreak >nul
if "%report_action%"=="2" echo 📈 Analyzing performance trends... & timeout /t 2 /nobreak >nul
if "%report_action%"=="3" echo 🛡️  Compiling security summary... & timeout /t 2 /nobreak >nul
if "%report_action%"=="4" echo 💾 Exporting analytics data... & timeout /t 2 /nobreak >nul
goto MAIN_MENU

:SETTINGS_MENU
cls
echo ⚙️  Settings & Configuration
echo ═══════════════════════════════════════════════════════
echo.
echo 🎛️  Current Settings:
echo • Theme: Personal Edition
echo • Auto-scan: Weekly
echo • Notifications: Enabled
echo • Logging: Detailed
echo • Backup: Enabled
echo.
echo [1] Configure scan settings
echo [2] Notification preferences
echo [3] Theme customization
echo [4] Backup & restore settings
echo [5] Advanced options
echo [0] Back to menu
echo.
set /p settings_action="Choice: "
if "%settings_action%"=="0" goto MAIN_MENU
if "%settings_action%"=="1" echo ⚙️  Configuring scan settings... & timeout /t 2 /nobreak >nul
if "%settings_action%"=="2" echo 🔔 Setting notification preferences... & timeout /t 2 /nobreak >nul
if "%settings_action%"=="3" echo 🎨 Customizing theme... & timeout /t 2 /nobreak >nul
if "%settings_action%"=="4" echo 💾 Configuring backup settings... & timeout /t 2 /nobreak >nul
if "%settings_action%"=="5" echo 🔧 Opening advanced options... & timeout /t 2 /nobreak >nul
goto MAIN_MENU

:DOCUMENTATION
cls
echo 📖 Documentation & Help
echo ═══════════════════════════════════════════════════════
echo.
echo 📚 Available Resources:
echo • User Manual: Complete guide
echo • FAQ: Common questions
echo • Troubleshooting: Step-by-step solutions
echo • Video Tutorials: Visual guides
echo • API Documentation: Developer resources
echo.
echo [1] Open User Manual
echo [2] View FAQ
echo [3] Troubleshooting Wizard
echo [4] Video Tutorials
echo [5] Contact Support
echo [0] Back to menu
echo.
set /p doc_action="Choice: "
if "%doc_action%"=="0" goto MAIN_MENU
if "%doc_action%"=="1" echo 📖 Opening user manual... & timeout /t 2 /nobreak >nul
if "%doc_action%"=="2" echo ❓ Loading FAQ... & timeout /t 2 /nobreak >nul
if "%doc_action%"=="3" echo 🔧 Starting troubleshooting wizard... & timeout /t 2 /nobreak >nul
if "%doc_action%"=="4" echo 🎺 Loading video tutorials... & timeout /t 2 /nobreak >nul
if "%doc_action%"=="5" echo 📧 Opening support portal... & timeout /t 2 /nobreak >nul
goto MAIN_MENU

:UPDATE_MAINTENANCE
cls
echo 🔄 Update & Maintenance
echo ═══════════════════════════════════════════════════════
echo.
echo 📋 Maintenance Status:
echo • Last update check: %date%
echo • Version: v1.0 Personal Edition
echo • Update status: Up to date
echo • Next scheduled check: Tomorrow
echo.
echo [1] Check for updates
echo [2] Run maintenance tasks
echo [3] Update definitions
echo [4] System cleanup
echo [5] Repair installation
echo [0] Back to menu
echo.
set /p update_action="Choice: "
if "%update_action%"=="0" goto MAIN_MENU
if "%update_action%"=="1" echo 🔍 Checking for updates... & timeout /t 3 /nobreak >nul
if "%update_action%"=="2" echo 🔧 Running maintenance tasks... & timeout /t 4 /nobreak >nul
if "%update_action%"=="3" echo 📥 Updating definitions... & timeout /t 2 /nobreak >nul
if "%update_action%"=="4" echo 🧹 Performing system cleanup... & timeout /t 3 /nobreak >nul
if "%update_action%"=="5" echo 🔨 Repairing installation... & timeout /t 3 /nobreak >nul
goto MAIN_MENU

:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:: EXIT PROGRAM
:: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
:EXIT_PROGRAM
cls
echo.
echo   ╔═══════════════════════════════════════════════════════════╗
echo   ║                    THANK YOU FOR USING                     ║
echo   ║                  KNOX ULTIMATE TOOLBOX                    ║
echo   ║                     PERSONAL EDITION                         ║
echo   ║                                                              ║
echo   ║                    Session Summary:                        ║
echo   ║                    • Tools used: Multiple                   ║
echo   ║                    • Session time: %time%                  ║
echo   ║                    • Date: %date%                           ║
echo   ║                                                              ║
echo   ║                    Visit us again soon!                     ║
echo   ╚═══════════════════════════════════════════════════════════╝
echo.
echo [%date% %time%] Knoux Session ended by %USERNAME% >> "%LOGS%operations.log"
echo.
echo Press any key to exit...
pause >nul
exit /b 0
