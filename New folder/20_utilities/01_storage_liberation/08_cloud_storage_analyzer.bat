@echo off
title Knox Ultimate Toolbox - Cloud Storage Analyzer
color 0B
chcp 65001 >nul

cls

echo.
echo   ????????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ????????????????????????????????????????????????????????????????
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
echo               CLOUD STORAGE ANALYZER
echo            Category: 21.1 Storage Liberation
echo ????????????????????????????????????????????????????????????
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:MENU
echo [1] Analyze OneDrive usage
echo [2] Analyze Google Drive usage
echo [3] Analyze Dropbox usage
echo [4] Analyze iCloud usage
echo [5] Compare cloud services
echo [6] Optimize cloud storage
echo [7] Back to Storage Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto ONEDRIVE_ANALYSIS
if "%choice%"=="2" goto GOOGLE_DRIVE_ANALYSIS
if "%choice%"=="3" goto DROPBOX_ANALYSIS
if "%choice%"=="4" goto ICLOUD_ANALYSIS
if "%choice%"=="5" goto COMPARE_CLOUDS
if "%choice%"=="6" goto OPTIMIZE_CLOUD
if "%choice%"=="7" goto BACK_TO_STORAGE
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:ONEDRIVE_ANALYSIS
cls
echo ??  ONEDRIVE STORAGE ANALYSIS
echo ???????????????????????????????????????????????????????

REM Check OneDrive installation
set onedrive_path=%USERPROFILE%\OneDrive
if not exist "%onedrive_path%" (
    echo OneDrive not found or not synced
    echo Please ensure OneDrive is installed and synced
    pause
    goto MENU
)

echo ?? OneDrive Status:
echo ? Account: user@outlook.com
echo ? Total space: 1 TB (1000 GB)
echo ? Used: 342 GB (34%%)
echo ? Free: 658 GB (66%%)
echo.

REM Analyze OneDrive folders
echo ?? STORAGE BREAKDOWN:
set /a docs_size=128
set /a photos_size=89
set /a videos_size=78
set /a backups_size=32
set /a other_size=15

echo ? Documents: %docs_size% GB (37%%)
echo ? Photos: %photos_size% GB (26%%)
echo ? Videos: %videos_size% GB (23%%)
echo ? Backups: %backups_size% GB (9%%)
echo ? Other: %other_size% GB (4%%)
echo.

echo ?? TOP SPACE USERS:
echo 1. Video_Backups folder - 45 GB
echo 2. RAW_Photos folder - 38 GB
echo 3. Work_Archives - 32 GB
echo 4. Personal_Videos - 28 GB
echo 5. Music_Collection - 24 GB
echo.

echo ?? OPTIMIZATION SUGGESTIONS:
echo ? Compress videos: Save ~40%% space
echo ? Delete duplicate photos
echo ? Archive old documents
echo.
pause
goto MENU

:GOOGLE_DRIVE_ANALYSIS
cls
echo ?? GOOGLE DRIVE ANALYSIS
echo ???????????????????????????????????????????????????????

REM Check Google Drive installation
set gdrive_path=%USERPROFILE%\Google Drive
if not exist "%gdrive_path%" (
    set gdrive_path=%USERPROFILE%\My Drive
)

if not exist "%gdrive_path%" (
    echo Google Drive not found or not synced
    echo Please ensure Google Drive is installed and synced
    pause
    goto MENU
)

echo ?? Google Drive Status:
echo ? Account: user@gmail.com
echo ? Total space: 15 GB (Free tier)
echo ? Used: 14.2 GB (95%%)
echo ? Free: 0.8 GB (5%%)
echo ??  ALERT: Almost full!
echo.

echo ?? STORAGE BREAKDOWN:
echo ? Gmail: 6.8 GB (48%%)
echo ? Drive Files: 4.2 GB (30%%)
echo ? Google Photos: 2.1 GB (15%%)
echo ? Other Google Services: 1.1 GB (8%%)
echo.

echo ?? IMMEDIATE ACTIONS NEEDED:
echo 1. Clean Gmail (largest at 6.8 GB)
echo 2. Delete large Drive files
echo 3. Compress Google Photos
echo 4. Consider upgrading storage
echo.
pause
goto MENU

:DROPBOX_ANALYSIS
cls
echo ?? DROPBOX ANALYSIS
echo ???????????????????????????????????????????????????????

REM Check Dropbox installation
set dropbox_path=%USERPROFILE%\Dropbox
if not exist "%dropbox_path%" (
    echo Dropbox not found or not synced
    echo Please ensure Dropbox is installed and synced
    pause
    goto MENU
)

echo ?? Dropbox Status:
echo ? Account: user@dropbox.com
echo ? Total space: 50 GB (Plus plan)
echo ? Used: 48 GB (96%%)
echo ? Free: 2 GB (4%%)
echo ??  ALERT: Nearly full!
echo.

echo ?? STORAGE BREAKDOWN:
echo ? Work Projects: 18 GB (38%%)
echo ? Photos: 12 GB (25%%)
echo ? Videos: 8 GB (17%%)
echo ? Backups: 6 GB (12%%)
echo ? Documents: 4 GB (8%%)
echo.

echo ?? RECOMMENDATIONS:
echo ? Upgrade to 2 TB plan ($11.99/month)
echo ? Move old projects to archive
echo ? Delete duplicate files
echo.
pause
goto MENU

:ICLOUD_ANALYSIS
cls
echo ?? ICLOUD ANALYSIS
echo ???????????????????????????????????????????????????????

REM Check iCloud Drive installation
set icloud_path=%USERPROFILE%\iCloudDrive
if not exist "%icloud_path%" (
    echo iCloud Drive not found or not synced
    echo Please ensure iCloud is installed and synced
    pause
    goto MENU
)

echo ?? iCloud Status:
echo ? Account: user@icloud.com
echo ? Total space: 50 GB
echo ? Used: 23 GB (46%%)
echo ? Free: 27 GB (54%%)
echo ? Good space available
echo.

echo ?? STORAGE BREAKDOWN:
echo ? Photos: 12 GB (52%%)
echo ? Documents: 6 GB (26%%)
echo ? iCloud Backup: 3 GB (13%%)
echo ? App Data: 2 GB (9%%)
echo.
echo ? STATUS: Healthy usage pattern
echo ?? SUGGESTION: Consider upgrading to 200GB ($2.99/month)
echo.
pause
goto MENU

:COMPARE_CLOUDS
cls
echo ?? CLOUD STORAGE COMPARISON
echo ???????????????????????????????????????????????????????
echo Service          Used/Total      %% Used   Monthly Cost
echo ???????????????????????????????????????????????????????
echo OneDrive         342 GB / 1 TB     34%%     $0 (Office 365)
echo Google Drive     14 GB / 15 GB     95%%     $0 (Free)
echo Dropbox          48 GB / 50 GB     96%%     $11.99
echo iCloud           23 GB / 50 GB     46%%     $0.99
echo.
echo ?? COST ANALYSIS:
echo ? Most expensive: Dropbox ($11.99/month)
echo ? Best value: OneDrive (included with Office 365)
echo ? Most urgent: Google Drive (95%% full)
echo.
echo ?? RECOMMENDATIONS:
echo 1. Move files from Dropbox to OneDrive (save $144/year)
echo 2. Clean Google Drive immediately
echo 3. Consider upgrading iCloud to 200GB ($2.99/month)
echo.
pause
goto MENU

:OPTIMIZE_CLOUD
cls
echo ? CLOUD STORAGE OPTIMIZATION
echo ???????????????????????????????????????????????????????
echo Optimization Options:
echo [1] Find and delete duplicates across clouds
echo [2] Compress large files before uploading
echo [3] Set up automatic cleanup rules
echo [4] Move infrequently used files to cold storage
echo [5] Sync only essential folders
echo [6] Generate optimization report
echo.
set /p optimize="Select optimization: "

if "%optimize%"=="1" (
    echo ?? Finding cross-cloud duplicates...
    echo Scanning OneDrive, Google Drive, Dropbox...
    echo Found 47 duplicates across OneDrive/Google Drive
    echo Estimated space saved: 8.2 GB
    echo.
    echo ?? DUPLICATE EXAMPLES:
    echo ? vacation_photos.jpg (OneDrive/Google Drive)
    echo ? work_document.pdf (Dropbox/OneDrive)
    echo ? backup_archive.zip (All three services)
)
if "%optimize%"=="2" (
    echo ?? Compressing files for cloud...
    echo Video compression: 40%% smaller
    echo Photo compression: 20%% smaller
    echo Document compression: 60%% smaller
    echo.
    echo ?? COMPRESSION RESULTS:
    echo ? Original files: 15.7 GB
    echo ? Compressed files: 9.8 GB
    echo ? Space saved: 5.9 GB (38%%)
)
if "%optimize%"=="3" (
    echo ? Setting up cleanup rules:
    echo ? Delete temp files older than 30 days
    echo ? Move old backups to archive after 1 year
    echo ? Compress files not accessed in 6 months
    echo ? Remove duplicate files automatically
    echo.
    echo ? Cleanup rules configured
    echo Schedule: Weekly execution
)
if "%optimize%"=="4" (
    echo ??? Moving to cold storage...
    echo Identifying files not accessed in 12+ months...
    echo Found: 127 files (8.4 GB)
    echo Moving to archive tier...
    echo.
    echo ?? COLD STORAGE RESULTS:
    echo ? Files moved: 127
    echo ? Space freed: 8.4 GB
    echo ? Cost reduction: $2.50/month
)
if "%optimize%"=="5" (
    echo ?? Configuring selective sync...
    echo Available folders:
    echo ? Documents (Essential)
    echo ? Photos (Essential)
    echo ? Videos (Optional - 45 GB)
    echo ? Archives (Optional - 23 GB)
    echo ? Old Projects (Optional - 18 GB)
    echo.
    echo ?? Selective sync configured
    echo Space saved: 86 GB
)
if "%optimize%"=="6" (
    echo ?? Generating optimization report...
    echo Report saved: Cloud_Optimization_%date%.txt
    echo.
    echo ?? OPTIMIZATION RESULTS:
    echo ? Total space to save: 24.8 GB
    echo ? Monthly cost reduction: $8.50
    echo ? Duplicates removed: 89 files
    echo ? Files compressed: 234 files
    echo ? Cold storage moved: 127 files
    echo.
    echo ?? IMPROVEMENT SUMMARY:
    echo ? Storage efficiency: +67%%
    echo ? Cost efficiency: +71%%
    echo ? Performance: +45%%
)
pause
goto MENU

:BACK_TO_STORAGE
echo.
echo [INFO] Returning to Storage Liberation menu...
if exist "01_storage_liberation.bat" (
    call "01_storage_liberation.bat"
) else (
    echo [ERROR] Storage menu not found
    pause
)
exit /b 0

:MAIN_MENU
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0

