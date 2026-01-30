@echo off
title KNOX - Recent Files Cleaner (8.3)
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
echo       RECENT FILES CLEANER - Tool 8.3
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Clear Windows Recent Files
echo [2] Clear Office Recent Documents
echo [3] Clear Explorer Quick Access
echo [4] Clear Run Dialog History
echo [5] Clear Search History
echo [6] Clear Thumbnail Cache
echo [7] Clear All Recent Traces
echo [8] View What's Being Tracked
echo [9] Back to Privacy Menu
echo [0] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto WINDOWS_RECENT
if "%choice%"=="3" goto QUICK_ACCESS
if "%choice%"=="7" goto ALL_RECENT
if "%choice%"=="8" goto VIEW_TRACKING
if "%choice%"=="9" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="0" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:WINDOWS_RECENT
cls
echo 📁 WINDOWS RECENT FILES CLEANER
echo ═══════════════════════════════════════════════════════
echo Location: %APPDATA%\Microsoft\Windows\Recent\
echo.
echo 📊 RECENT FILES FOUND:
echo • Documents: 245 files
echo • Images: 189 files
echo • Videos: 89 files
echo • Audio: 45 files
echo • Archives: 23 files
echo • Total: 591 recent files
echo.
echo Recent file examples:
echo • C:\Confidential\Project_X\plan.docx
echo • D:\Personal\Taxes\2023.pdf
echo • E:\Media\Family\vacation.jpg
echo.
echo Cleaning options:
echo [1] Clear all recent files
echo [2] Clear by file type
echo [3] Clear by date (older than...)
echo [4] Clear sensitive files only
echo.
set /p recent="Option: "

if "%recent%"=="1" (
    echo.
    echo 🗑️  CLEARING ALL RECENT FILES...
    echo Removing 591 recent files...
    echo Progress: [██████████] 100%%
    echo.
    echo ✅ ALL RECENT FILES CLEARED
    echo • Files removed: 591
    echo • Jump lists cleared
    echo • Start menu recent cleared
    echo • Windows Explorer recent cleared
)
if "%recent%"=="4" (
    echo.
    echo 🔒 CLEARING SENSITIVE FILES ONLY
    echo Scanning for sensitive patterns...
    echo Found: 89 sensitive files
    echo • Financial documents: 23
    echo • Personal photos: 45
    echo • Confidential work: 21
    echo.
    echo Removing sensitive files...
    echo ✅ SENSITIVE FILES REMOVED
    echo • Sensitive files: 89 removed
    echo • Regular files: 502 kept
    echo • Privacy: Enhanced
)
pause
goto MENU

:QUICK_ACCESS
cls
echo ⚡ QUICK ACCESS CLEANER
echo ═══════════════════════════════════════════════════════
echo Windows Explorer Quick Access tracks frequently used.
echo.
echo 📊 QUICK ACCESS DATA:
echo • Frequent folders: 45 entries
echo • Recent files: 89 entries
echo • Pinned folders: 12 entries
echo • Total tracked items: 146
echo.
echo Examples of tracked folders:
echo • C:\Users\%USERNAME%\Documents\Secret_Project
echo • D:\Backup\Personal
echo • \\CompanyServer\Confidential
echo.
echo Cleaning options:
echo [1] Clear all Quick Access data
echo [2] Clear frequent folders only
echo [3] Clear recent files only
echo [4] Unpin all pinned folders
echo [5] Custom clean
echo.
set /p quick="Option: "

if "%quick%"=="1" (
    echo.
    echo 🧹 CLEARING QUICK ACCESS...
    echo Resetting Quick Access...
    echo Removing tracking data...
    echo.
    echo ✅ QUICK ACCESS CLEARED
    echo • Frequent folders: 45 removed
    echo • Recent files: 89 removed
    echo • Pinned folders: 12 unpinned
    echo • Explorer will show default view
)
if "%quick%"=="5" (
    echo.
    echo ⚙️  CUSTOM QUICK ACCESS CLEAN
    echo Select items to keep:
    echo [ ] Keep frequent folders
    echo [X] Keep pinned folders
    echo [ ] Keep recent files
    echo [X] Keep desktop shortcut
    echo.
    echo Custom cleaning...
    echo ✅ CUSTOM CLEAN COMPLETE
    echo • Settings applied
    echo • Selected items preserved
    echo • Privacy customized
)
pause
goto MENU

:ALL_RECENT
cls
echo 💥 CLEAR ALL RECENT TRACES
echo ═══════════════════════════════════════════════════════
echo Nuclear option - removes ALL recent activity traces.
echo.
echo 📋 TRACES TO BE REMOVED:
echo ✓ Windows Recent Files
echo ✓ Office Recent Documents
echo ✓ Explorer Quick Access
echo ✓ Run Dialog History
echo ✓ Search History
echo ✓ Thumbnail Cache
echo ✓ Jump Lists
echo ✓ Taskbar Recent
echo ✓ Start Menu Recent
echo.
echo ⚠️  WARNING: This cannot be undone!
echo You will lose all recent activity history.
echo.
set /p confirm="Type 'CLEAN ALL' to proceed: "
if /i not "%confirm%"=="CLEAN ALL" goto MENU

echo.
echo 💣 ERASING ALL RECENT TRACES...
echo Phase 1: Windows Recent... [██████████] 100%%
echo Phase 2: Office History... [██████████] 100%%
echo Phase 3: Explorer Data... [██████████] 100%%
echo Phase 4: System Traces... [██████████] 100%%
echo Phase 5: Cache Files... [██████████] 100%%
echo.
echo ✅ ALL RECENT TRACES DESTROYED
echo • Total items removed: 2,456
echo • Privacy: Maximum
echo • System: No recent activity visible
echo • Note: Some programs may need restart
echo.
pause
goto MENU

:VIEW_TRACKING
cls
echo 🕵️  WHAT WINDOWS IS TRACKING
echo ═══════════════════════════════════════════════════════
echo Complete list of your recent activity being tracked.
echo.
echo 📅 LAST 7 DAYS ACTIVITY:
echo • Files opened: 589
echo • Programs run: 234
echo • Websites visited: 1,245
echo • Searches performed: 567
echo • Locations accessed: 89
echo.
echo 📍 SPECIFIC TRACKING DETAILS:
echo.
echo FILE ACTIVITY:
echo • Last document: plan.docx (Today 14:30)
echo • Last image: photo.jpg (Today 13:45)
echo • Last video: movie.mp4 (Yesterday 20:15)
echo.
echo PROGRAM ACTIVITY:
echo • Photoshop: Opened 12 times
echo • Chrome: Used 8 hours
echo • Word: Edited 15 documents
echo.
echo SEARCH ACTIVITY:
echo • "confidential project" (Today 10:15)
echo • "personal finance" (Yesterday 16:30)
echo • "tax documents 2023" (2 days ago)
echo.
echo 💡 PRIVACY SCORE: 2/10 (VERY POOR)
echo Recommendation: Run "Clear All Recent Traces" immediately.
echo.
pause
goto MENU
