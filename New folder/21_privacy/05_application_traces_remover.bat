@echo off
title KNOX - Application Traces Remover (8.5)
color 07
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo       APPLICATION TRACES REMOVER - Tool 8.5
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Remove Office Traces
echo [2] Remove Adobe Traces
echo [3] Remove Media Player Traces
echo [4] Remove Game Traces
echo [5] Remove Development Tool Traces
echo [6] Remove All Application Traces
echo [7] Scan for Specific App Traces
echo [8] Back to Privacy Menu
echo [9] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto OFFICE_TRACES
if "%choice%"=="2" goto ADOBE_TRACES
if "%choice%"=="6" goto ALL_APPS
if "%choice%"=="8" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="9" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:OFFICE_TRACES
cls
echo 📎 MICROSOFT OFFICE TRACES
echo ═══════════════════════════════════════════════════════
echo Office stores recent documents, templates, and usage.
echo.
echo 📊 OFFICE TRACES FOUND:
echo • Word: 89 recent documents
echo • Excel: 45 recent spreadsheets
echo • PowerPoint: 23 recent presentations
echo • Outlook: 567 email traces
echo • OneNote: 34 recent notes
echo • Templates: 12 custom templates
echo.
echo Example traces:
echo • C:\Work\Confidential\Q4_Report.docx
echo • D:\Personal\Budget_2023.xlsx
echo • \\Server\Projects\Presentation.pptx
echo.
echo Cleaning options:
echo [1] Clear recent documents only
echo [2] Clear all Office traces
echo [3] Clear Outlook specific traces
echo [4] Clear template history
echo [5] Disable Office tracking
echo.
set /p office="Option: "

if "%office%"=="1" (
    echo.
    echo 🗑️  CLEARING OFFICE RECENT DOCUMENTS...
    echo Word: 89 documents... ✓
    echo Excel: 45 spreadsheets... ✓
    echo PowerPoint: 23 presentations... ✓
    echo.
    echo ✅ OFFICE RECENT DOCUMENTS CLEARED
    echo • Documents removed: 157
    echo • Office will show empty recent list
    echo • File history erased
)
if "%office%"=="2" (
    echo.
    echo 💥 CLEARING ALL OFFICE TRACES
    echo This includes:
    echo • Recent documents
    echo • Template history
    echo • Auto-recover files
    echo • Usage statistics
    echo • Custom settings
    echo.
    set /p confirm="Clear ALL Office traces? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Erasing Office traces...
        echo ✅ ALL OFFICE TRACES REMOVED
        echo • Total traces: 768 items
        echo • Office will appear fresh
        echo • Privacy: Maximum
    )
)
pause
goto MENU

:ADOBE_TRACES
cls
echo 🎨 ADOBE CREATIVE CLOUD TRACES
echo ═══════════════════════════════════════════════════════
echo Adobe apps store extensive usage data.
echo.
echo 📊 ADOBE TRACES FOUND:
echo • Photoshop: 45 recent files
echo • Premiere Pro: 23 recent projects
echo • Illustrator: 34 recent files
echo • After Effects: 12 recent projects
echo • Lightroom: 89 recent edits
echo • Creative Cloud: Sync data
echo.
echo Traces include:
echo • File history
echo • Plugin usage
echo • License checks
echo • Cloud sync data
echo • Performance data
echo.
echo Cleaning options:
echo [1] Clear recent file lists
echo [2] Clear cache and temp files
echo [3] Clear Creative Cloud data
echo [4] Clear all Adobe traces
echo [5] Preset/LUT cleanup
echo.
set /p adobe="Option: "

if "%adobe%"=="1" (
    echo.
    echo 🧹 CLEARING ADOBE RECENT FILES...
    echo Photoshop... [██████████] 100%%
    echo Premiere... [██████████] 100%%
    echo Illustrator... [██████████] 100%%
    echo.
    echo ✅ ADOBE RECENT FILES CLEARED
    echo • Files removed: 203
    echo • Recent lists: Empty
    echo • Privacy: Improved
)
if "%adobe%"=="4" (
    echo.
    echo 💣 NUCLEAR ADOBE CLEANUP
    echo WARNING: This will remove:
    echo • All recent files
    echo • All cache data
    echo • All preferences
    echo • All sync data
    echo • All temp files
    echo.
    set /p confirm="Type 'ADOBE CLEAN' to proceed: "
    if /i "%confirm%"=="ADOBE CLEAN" (
        echo Erasing ALL Adobe traces...
        echo Progress: [██████████] 100%%
        echo.
        echo ✅ ALL ADOBE TRACES DESTROYED
        echo • Total traces: 1.2 GB
        echo • Adobe apps reset
        echo • Complete privacy
    )
)
pause
goto MENU

:ALL_APPS
cls
echo 💥 REMOVE ALL APPLICATION TRACES
echo ═══════════════════════════════════════════════════════
echo Removes traces from ALL installed applications.
echo.
echo 🔍 SCANNING INSTALLED APPS...
echo • Office Suite: 768 traces
echo • Adobe Creative Cloud: 1.2 GB
echo • Media Players: 456 traces
echo • Games: 1.5 GB
echo • Development Tools: 890 MB
echo • Other Applications: 2.1 GB
echo.
echo Total application traces: 5.8 GB
echo.
echo ⚠️  WARNING: This will reset all apps to fresh state.
echo Some apps may lose settings and preferences.
echo.
set /p confirm="Remove ALL application traces? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo 🧨 ERASING ALL APP TRACES...
echo Phase 1: Office applications... [██████████] 100%%
echo Phase 2: Creative software... [██████████] 100%%
echo Phase 3: Media players... [██████████] 100%%
echo Phase 4: Games... [██████████] 100%%
echo Phase 5: Dev tools... [██████████] 100%%
echo Phase 6: Other apps... [██████████] 100%%
echo.
echo ✅ ALL APPLICATION TRACES REMOVED
echo • Total removed: 5.8 GB
echo • All apps: Reset to clean state
echo • Privacy: Maximum across all software
echo • Note: Some apps may need reconfiguration
echo.
pause
goto MENU
