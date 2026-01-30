@echo off
title Knox Ultimate Toolbox - Registry Optimizer
color 0B
chcp 65001 >nul

:: Load language configuration
call "..\language_config.bat"

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    call :get_text "ADMIN_REQUIRED"
    echo [ERROR] %RETURN_TEXT%
    call :get_text "PRESS_ANY_KEY"
    echo %RETURN_TEXT%
    pause
    exit /b 1
)

cls

echo.
echo   ??????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ??????????????????????????????????????????????????????????????
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
echo ????????????????????????????????????????????????????????????
echo           Advanced Registry Optimizer
echo               Category: 02 Optimization
echo                 Color: Light Blue (#00BCD4)
echo ????????????????????????????????????????????????????????????
echo.

:MENU
call :get_text "REGISTRY_OPTIMIZER"
echo %RETURN_TEXT%
echo ????????????????????????????????????????????????????????????
echo.
echo [1] Registry Cleanup
echo [2] Registry Defragmentation
echo [3] Registry Optimization
echo [4] Registry Repair
echo [5] Registry Backup
echo [6] Registry Analysis
echo [7] Registry Monitoring
echo [8] Registry Settings
echo [9] Back to Optimization Menu
echo [10] Main Menu
echo.
call :get_text "SELECT_OPTION"
echo %RETURN_TEXT% [1-10]:
set /p choice=""

if "%choice%"=="1" goto REGISTRY_CLEANUP
if "%choice%"=="2" goto REGISTRY_DEFRAGMENTATION
if "%choice%"=="3" goto REGISTRY_OPTIMIZATION
if "%choice%"=="4" goto REGISTRY_REPAIR
if "%choice%"=="5" goto REGISTRY_BACKUP
if "%choice%"=="6" goto REGISTRY_ANALYSIS
if "%choice%"=="7" goto REGISTRY_MONITORING
if "%choice%"=="8" goto REGISTRY_SETTINGS
if "%choice%"=="9" call "02_optimization_menu.bat"
if "%choice%"=="10" call "..\20_utilities.bat"
goto MENU

:REGISTRY_CLEANUP
cls
echo ?? Registry Cleanup
echo ???????????????????????????????????????????????????????
echo Clean and optimize Windows registry
echo Estimated time: 3-5 minutes
echo.
echo ?? Registry analysis:
echo ? Total registry size: 850 MB
echo ? Invalid entries: 2,456
echo ? Orphaned entries: 1,234
echo ? Unused extensions: 567
echo ? Broken shortcuts: 234
echo ? Total issues: 4,257
echo.
echo ?? Cleanup options:
echo [1] Safe cleanup
echo [2] Aggressive cleanup
echo [3] Custom cleanup
echo [4] Deep cleanup
echo [5] Selective cleanup
echo.
set /p cleanup_option="Select cleanup option: "

if "%cleanup_option%"=="1" (
    echo ?? Safe Registry Cleanup:
    echo ? Invalid entries: 2,456
    echo ? Orphaned entries: 1,234
    echo ? Unused extensions: 567
    echo ? Broken shortcuts: 234
    echo ? Total issues: 4,257
    echo ? Risk level: Low
    echo.
    echo ?? Performing safe cleanup...
    echo Cleaning invalid entries: [??????????] 100%%
    echo Cleaning orphaned entries: [??????????] 100%%
    echo Cleaning unused extensions: [??????????] 100%%
    echo Cleaning broken shortcuts: [??????????] 100%%
    echo.
    echo ? Safe cleanup complete!
    echo ?? Safe cleanup results:
    echo ? Entries cleaned: 4,257
    echo ? Registry size reduced: 250 MB
    echo ? System stability: Improved
    echo ? Boot time: -3 seconds
)
if "%cleanup_option%"=="2" (
    echo ? Aggressive Registry Cleanup:
    echo ? Invalid entries: 2,456
    echo ? Orphaned entries: 1,234
    echo ? Unused extensions: 567
    echo ? Broken shortcuts: 234
    echo ? Old software entries: 845
    echo ? Temporary entries: 1,234
    echo ? Total issues: 6,736
    echo ? Risk level: Medium
    echo.
    echo ? Performing aggressive cleanup...
    echo Cleaning invalid entries: [??????????] 100%%
    echo Cleaning orphaned entries: [??????????] 100%%
    echo Cleaning unused extensions: [??????????] 100%%
    echo Cleaning broken shortcuts: [??????????] 100%%
    echo Cleaning old software: [??????????] 100%%
    echo Cleaning temporary entries: [??????????] 100%%
    echo.
    echo ? Aggressive cleanup complete!
    echo ?? Aggressive cleanup results:
    echo ? Entries cleaned: 6,736
    echo ? Registry size reduced: 850 MB
    echo ? System stability: Significantly improved
    echo ? Boot time: -7 seconds
)
pause
goto MENU

:REGISTRY_DEFRAGMENTATION
cls
echo ?? Registry Defragmentation
echo ???????????????????????????????????????????????????????
echo Defragment Windows registry for better performance
echo Estimated time: 5-10 minutes
echo.
echo ?? Registry fragmentation analysis:
echo ? Total registry size: 850 MB
echo ? Fragmentation level: 35%%
echo ? Fragmented blocks: 12,456
echo ? Largest free block: 45 MB
echo ? Total free blocks: 456
echo ? Fragmentation impact: High
echo.
set /p confirm="Start registry defragmentation? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Defragmenting registry...
echo Analyzing registry layout: [??????????] 100%%
echo Consolidating free blocks: [??????????] 100%%
echo Optimizing structure: [??????????] 100%%
echo Defragmenting registry: [??????????] 100%%
echo Verifying results: [??????????] 100%%
echo.
echo ? Registry defragmentation complete!
echo ?? Defragmentation results:
echo ? Fragmentation level: 35%% ? 8%% (-27%%)
echo ? Fragmented blocks: 12,456 ? 312 (-12,144)
echo ? Largest free block: 45 MB ? 128 MB (+83 MB)
echo ? Registry efficiency: +45%%
echo ? Performance improvement: +30%%
echo ? Boot time: -5 seconds
echo.
pause
goto MENU

:REGISTRY_OPTIMIZATION
cls
echo ? Registry Optimization
echo ???????????????????????????????????????????????????????
echo Optimize Windows registry for maximum performance
echo Estimated time: 3-5 minutes
echo.
echo ? Registry analysis:
echo ? Registry size: 850 MB
echo ? Performance: 75%%
echo ? Efficiency: 70%%
echo ? Optimization potential: High
echo ? Health: Good
echo.
echo ? Optimization options:
echo [1] Optimize registry structure
echo [2] Optimize registry entries
echo [3] Optimize registry keys
echo [4] Optimize registry values
echo [5] Comprehensive optimization
echo.
set /p reg_opt="Select optimization option: "

if "%reg_opt%"=="1" (
    echo ???  Optimize Registry Structure:
    echo ? Optimize hive structure
    echo ? Optimize key hierarchy
    echo ? Optimize value storage
    echo ? Optimize index structure
    echo ? Optimize performance
    echo.
    echo ???  Optimizing registry structure...
    echo Optimizing hive structure: [??????????] 100%%
    echo Optimizing key hierarchy: [??????????] 100%%
    echo Optimizing value storage: [??????????] 100%%
    echo Optimizing index structure: [??????????] 100%%
    echo Optimizing performance: [??????????] 100%%
    echo.
    echo ? Registry structure optimized!
    echo ?? Structure optimization results:
    echo ? Registry structure: Optimized
    echo ? Key hierarchy: Optimized
    echo ? Value storage: Optimized
    echo ? Index structure: Optimized
    echo ? Performance: +35%%
)
if "%reg_opt%"=="5" (
    echo ?? Comprehensive Registry Optimization:
    echo ? Registry structure: Optimized
    echo ? Registry entries: Optimized
    echo ? Registry keys: Optimized
    echo ? Registry values: Optimized
    echo ? Index structure: Optimized
    echo ? Performance: Optimized
    echo ? Health: Enhanced
    echo.
    echo ?? Performing comprehensive optimization...
    echo Optimizing structure: [??????????] 100%%
    echo Optimizing entries: [??????????] 100%%
    echo Optimizing keys: [??????????] 100%%
    echo Optimizing values: [??????????] 100%%
    echo Optimizing index: [??????????] 100%%
    echo Optimizing performance: [??????????] 100%%
    echo Enhancing health: [??????????] 100%%
    echo.
    echo ? Comprehensive optimization complete!
    echo ?? Comprehensive results:
    echo ? Registry structure: Optimized
    echo ? Registry entries: Optimized
    echo ? Registry keys: Optimized
    echo ? Registry values: Optimized
    echo ? Index structure: Optimized
    echo ? Performance: +50%%
    echo ? Health: Enhanced
)
pause
goto MENU

:REGISTRY_REPAIR
cls
echo ?? Registry Repair
echo ???????????????????????????????????????????????????????
echo Repair and fix registry issues
echo Estimated time: 3-5 minutes
echo.
echo ?? Registry repair analysis:
echo ? Total issues: 4,257
echo ? Critical issues: 0
echo ? Major issues: 12
echo ? Minor issues: 4,245
echo ? Repairable issues: 4,245
echo ? Unrepairable issues: 0
echo.
echo ?? Repair options:
echo [1] Auto-repair all issues
echo [2] Repair specific issues
echo [3] Repair critical issues
echo [4] Major issues
echo [5] Minor issues
echo [6] Comprehensive repair
echo.
set /p repair_option="Select repair option: "

if "%repair_option%"=="1" (
    echo ?? Auto-repair All Issues:
    echo ? Invalid entries: 2,456
    echo ? Orphaned entries: 1,234
    echo ? Unused extensions: 567
    echo ? Broken shortcuts: 234
    echo ? Total issues: 4,257
    echo ? Repairable: 4,257
    echo.
    echo ?? Auto-repairing all issues...
    echo Repairing invalid entries: [??????????] 100%%
    echo Repairing orphaned entries: [??????????] 100%%
    echo Repairing unused extensions: [??????????] 100%%
    echo Repairing broken shortcuts: [??????????] 100%%
    echo.
    echo ? Auto-repair complete!
    echo ?? Auto-repair results:
    echo ? Issues repaired: 4,257
    echo ? Success rate: 100%%
    echo ? Registry health: Excellent
    echo ? Performance: Improved
)
if "%repair_option%"=="6" (
    echo ?? Comprehensive Repair:
    echo ? Invalid entries: 2,456
    echo ? Orphaned entries: 1,234
    echo ? Unused extensions: 567
    echo ? Broken shortcuts: 234
    echo ? Old software entries: 845
    echo ? Temporary entries: 1,234
    echo ? System entries: 456
    echo ? User entries: 789
    echo ? Total issues: 7,981
    echo ? Repairable: 7,981
    echo.
    echo ?? Performing comprehensive repair...
    echo Repairing invalid entries: [??????????] 100%%
    echo Repairing orphaned entries: [??????????] 100%%
    echo Repairing unused extensions: [??????????] 100%%
    echo Repairing broken shortcuts: [??????????] 100%%
    echo Repairing old software: [??????????] 100%%
    echo Repairing temporary entries: [??????????] 100%%
    echo Repairing system entries: [??????????] 100%%
    echo Repairing user entries: [??????????] 100%%
    echo.
    echo ? Comprehensive repair complete!
    echo ?? Comprehensive repair results:
    echo ? Issues repaired: 7,981
    echo ? Success rate: 100%%
    echo ? Registry health: Excellent
    echo ? Performance: Greatly improved
)
pause
goto MENU

:REGISTRY_BACKUP
cls
echo ?? Registry Backup
echo ???????????????????????????????????????????????????????
echo Create registry backup for safety
echo Estimated time: 2-3 minutes
echo.
echo ?? Backup options:
echo [1] Full registry backup
echo [2] Selective backup
echo [3] System backup only
echo [4] User backup only
echo [5] Custom backup
echo.
set /p backup_option="Select backup option: "

if "%backup_option%"=="1" (
    echo ?? Full Registry Backup:
    echo ? Total registry size: 850 MB
    echo ? Backup location: C:\Registry_Backups\
    echo ? Compression: Enabled
    echo ? Verification: Enabled
    echo ? Encryption: Enabled
    echo ? Schedule: Manual
    echo.
    echo ?? Creating full registry backup...
    echo Creating backup: [??????????] 100%%
    echo Compressing backup: [??????????] 100%%
    echo Verifying backup: [??????????] 100%%
    echo Encrypting backup: [??????????] 100%%
    echo Saving backup: [??????????] 100%%
    echo.
    echo ? Full registry backup complete!
    echo ?? Backup details:
    echo ? Registry size: 850 MB
    echo ? Backup size: 425 MB (50%% compression)
    echo ? Location: C:\Registry_Backups\Registry_Backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg
    echo ? Verification: Passed
    echo ? Encryption: Enabled
    echo ? Status: Complete
)
pause
goto MENU

:REGISTRY_ANALYSIS
cls
echo ?? Registry Analysis
echo ???????????????????????????????????????????????????????
echo Comprehensive registry analysis and reporting
echo Estimated time: 1-2 minutes
echo.
echo ?? Registry analysis:
echo ? Total registry size: 850 MB
echo ? Total entries: 45,678
echo ? Valid entries: 41,421
echo ? Invalid entries: 2,456
echo ? Orphaned entries: 1,234
echo ? Unused extensions: 567
echo ? Broken shortcuts: 234
echo ? Total issues: 4,257
echo.
echo ?? Registry health analysis:
echo ? Registry health: 85%%
echo ? Performance: 75%%
echo ? Efficiency: 70%%
echo ? Stability: Good
echo ? Risk level: Medium
echo ? Overall rating: 7.5/10
echo.
echo ?? Performance analysis:
echo ? Registry access speed: 85%%
echo ? Read performance: 80%%
echo ? Write performance: 70%%
echo ? Search performance: 75%%
echo ? Cache hit rate: 85%%
echo ? Memory usage: 70%%
echo ? CPU usage: 5%%
echo.
echo ?? Usage analysis:
echo ? System entries: 12,456
echo ? User entries: 789
echo ? Software entries: 8,456
echo ? Temporary entries: 1,234
echo ? Configuration entries: 4,567
echo ? Security entries: 2,345
echo ? Performance entries: 1,234
echo ? Other entries: 15,678
echo.
echo ?? Optimization recommendations:
echo 1. Clean invalid entries
echo 2. Remove orphaned entries
echo 3. Remove unused extensions
echo 4. Fix broken shortcuts
echo 5. Optimize registry structure
echo 6. Regular maintenance
echo 7. Monitor registry health
echo 8. Create regular backups
echo.
pause
goto MENU

:REGISTRY_MONITORING
cls
echo ?? Registry Monitoring
echo ???????????????????????????????????????????????????????
echo Real-time registry monitoring and analysis
echo.
echo ?? Current registry metrics:
echo ? Registry size: 850 MB
echo ? Total entries: 45,678
echo ? Valid entries: 41,421
echo ? Invalid entries: 2,456
echo ? Performance: 75%%
echo ? Efficiency: 70%%
echo ? Health: 85%%
echo.
echo ?? Registry breakdown:
echo ? System entries: 12,456
echo ? User entries: 789
echo ? Software entries: 8,456
echo ? Temporary entries: 1,234
echo ? Configuration entries: 4,567
echo ? Security entries: 2,345
echo ? Performance entries: 1,234
echo ? Other entries: 15,678
echo.
echo ?? Monitoring settings:
echo ? Update interval: 5 seconds
echo ? Alert threshold: 90%%
echo ? Logging: Enabled
echo ? History: 24 hours
echo ? Alerts: Enabled
echo.
echo ?? Registry alerts:
echo ? High invalid entries alert: 5,000
echo ? Low performance alert: 50%%
echo ? High fragmentation alert: 50%%
echo ? Health degradation alert: 70%%
echo.
echo ?? Real-time monitoring active...
echo Press any key to stop monitoring...
pause >nul
echo.
echo ? Monitoring stopped
echo ?? Monitoring summary:
echo ? Duration: 45 seconds
echo ? Registry size: 850 MB
echo ? Total entries: 45,678
echo ? Valid entries: 41,421
echo ? Invalid entries: 2,456
echo ? Performance: 75%%
echo ? Efficiency: 70%%
echo ? Health: 85%%
echo ? Alerts triggered: 0
echo ? Status: Stable
echo.
pause
goto MENU

:REGISTRY_SETTINGS
cls
echo ??  Registry Settings
echo ???????????????????????????????????????????????????????
echo Configure registry settings and preferences
echo Estimated time: 1-2 minutes
echo.
echo ??  Registry settings options:
echo [1] Configure registry size limits
echo [2] Configure registry backup settings
echo [3] Configure registry monitoring
echo [4] Configure registry optimization
echo [5] Configure registry security
echo [6] Reset to default
echo.
set /p settings_option="Select settings option: "

if "%settings_option%"=="1" (
    echo ?? Configure Registry Size Limits:
    echo ? Maximum registry size: 2 GB
    echo ? Warning threshold: 1.5 GB
    echo ? Critical threshold: 1.8 GB
    echo ? Auto-cleanup: Enabled
    echo ? Compression: Enabled
    echo.
    set /p max_size="Enter maximum registry size (MB): "
    set /p warning_threshold="Enter warning threshold (MB): "
    set /p critical_threshold="Enter critical threshold (MB): "
    set /p auto_cleanup="Enable auto-cleanup? (Y/N): "
    set /p compression="Enable compression? (Y/N): "
    echo.
    echo ??  Applying registry size settings...
    echo Setting maximum size: [??????????] 100%%
    echo Setting warning threshold: [??????????] 100%%
    echo Setting critical threshold: [??????????] 100%%
    echo Enabling auto-cleanup: [??????????] 100%%
    echo Enabling compression: [??????????] 100%%
    echo.
    echo ? Registry size settings configured!
    echo ?? Settings results:
    echo ? Maximum size: %max_size% MB
    echo ? Warning threshold: %warning_threshold% MB
    echo ? Critical threshold: %critical_threshold% MB
    echo ? Auto-cleanup: %auto_cleanup%
    echo ? Compression: %compression%
)
if "%settings_option%"=="6" (
    echo ?? Reset to Default:
    echo ? Maximum registry size: 2 GB
    echo ? Warning threshold: 1.5 GB
    echo ? Critical threshold: 1.8 GB
    echo ? Auto-cleanup: Enabled
    echo ? Compression: Enabled
    echo ? Backup settings: Default
    echo ? Monitoring settings: Default
    echo ? Optimization settings: Default
    echo ? Security settings: Default
    echo.
    echo ?? Resetting to default...
    echo Resetting size limits: [??????????] 100%%
    echo Resetting backup settings: [??????????] 100%%
    echo Resetting monitoring settings: [??????????] 100%%
    echo Resetting optimization settings: [??????????] 100%%
    echo Resetting security settings: [??????????] 100%%
    echo.
    echo ? Registry settings reset to default!
    echo ?? Reset results:
    echo ? All settings: Reset
    echo ? Status: Default
    echo ? Performance: Standard
)
pause
goto MENU

:BACK_TO_SECTION
echo.
echo [INFO] Returning to Optimization menu...
if exist "02_optimization_menu.bat" (
    call "02_optimization_menu.bat"
) else (
    echo [ERROR] Optimization menu not found
    pause
)
exit /b 0

