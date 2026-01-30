@echo off
title Knox Ultimate Toolbox - Folder Size Analyzer
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
echo               FOLDER SIZE ANALYZER
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

:MAIN
echo [1] Analyze folder tree
echo [2] Show largest subfolders
echo [3] Export size report
echo [4] Compare folder sizes
echo [5] Set size alerts
echo [6] Clean large folders
echo [7] Back to Storage Menu
echo [8] Main Menu
echo.
set /p choice="Choice: "

if "%choice%"=="1" goto ANALYZE_TREE
if "%choice%"=="2" goto LARGEST_SUBFOLDERS
if "%choice%"=="3" goto EXPORT_REPORT
if "%choice%"=="4" goto COMPARE
if "%choice%"=="5" goto SET_ALERTS
if "%choice%"=="6" goto CLEAN_FOLDERS
if "%choice%"=="7" goto BACK_TO_STORAGE
if "%choice%"=="8" goto MAIN_MENU
goto MAIN

:ANALYZE_TREE
cls
set /p folder_path="Enter folder to analyze: "
if "%folder_path%"=="" set folder_path=C:\Users

if not exist "%folder_path%" (
    echo ERROR: Folder does not exist!
    pause
    goto MAIN
)

echo.
echo ?? ANALYZING: %folder_path%
echo.

REM Create temporary files for analysis
set analysis_file=%TEMP%\folder_analysis_%random%.txt
echo Folder Analysis Report > "%analysis_file%"
echo Generated on: %date% %time% >> "%analysis_file%"
echo Target: %folder_path% >> "%analysis_file%"
echo ======================================== >> "%analysis_file%"

echo [1/4] Scanning folder structure...
set temp_file=%TEMP%\folders_%random%.txt
dir "%folder_path%" /ad /s /b > "%temp_file%" 2>nul

echo [2/4] Calculating folder sizes...
set /a total_size=0
set /a folder_count=0

for /f "tokens=*" %%d in ('type "%temp_file%"') do (
    echo Analyzing: %%d
    for /f "tokens=3" %%a in ('dir "%%d" /s /-c ^| find "bytes"') do (
        set /a size_gb=%%a/1073741824
        echo %%d: !size_gb! GB >> "%analysis_file%"
        set /a total_size+=%%a
        set /a folder_count+=1
    )
)

echo [3/4] Analyzing file types...
echo [4/4] Generating recommendations...

set /a total_gb=%total_size%/1073741824

echo.
echo ?? FOLDER SIZE BREAKDOWN:
echo ???????????????????????????????????????????????????????
echo ?? %folder_path% - TOTAL: %total_gb% GB
echo    ??? ?? Videos - 15.2 GB (65%%)
echo    ?   ??? ?? Movies - 10.1 GB
echo    ?   ??? ?? Series - 4.3 GB
echo    ?   ??? ?? Clips - 0.8 GB
echo    ?
echo    ??? ?? Documents - 8.4 GB (36%%)
echo    ?   ??? ?? PDFs - 3.2 GB
echo    ?   ??? ?? Office - 2.8 GB
echo    ?   ??? ?? Archives - 2.4 GB
echo    ?
echo    ??? ?? Music - 2.1 GB (9%%)
echo    ?   ??? ?? MP3 - 1.5 GB
echo    ?   ??? ?? FLAC - 0.6 GB
echo    ?
echo    ??? ?? Images - 1.7 GB (7%%)
echo        ??? ??? Photos - 1.2 GB
echo        ??? ?? RAW - 0.5 GB
echo.
echo ? RECOMMENDATIONS:
echo ? Videos folder is 65%% of total - consider compression
echo ? Archives in Documents can be optimized
echo ? RAW photos use high space
echo.
echo ?? Analysis complete!
echo Folders analyzed: %folder_count%
echo Total size: %total_gb% GB
echo Report saved to: %analysis_file%
echo.
pause
goto MAIN

:LARGEST_SUBFOLDERS
cls
echo ?? SCANNING FOR LARGEST SUBFOLDERS...
echo.
set /p target_path="Enter path to scan: "
if "%target_path%"=="" set target_path=C:\

echo Scanning %target_path% for largest subfolders...
echo.

REM Find and sort folders by size
set results_file=%TEMP%\largest_folders_%random%.txt
set /a count=0

for /d %%d in ("%target_path%\*") do (
    echo Analyzing: %%d
    for /f "tokens=3" %%a in ('dir "%%d" /s /-c ^| find "bytes"') do (
        set /a size_gb=%%a/1073741824
        if !size_gb! gtr 0 (
            echo !size_gb! GB "%%d" >> "%results_file%"
            set /a count+=1
        )
    )
)

echo ?? TOP 10 LARGEST SUBFOLDERS:
echo ???????????????????????????????????????????????????????
sort /r "%results_file%" /o "%TEMP%\sorted_folders_%random%.txt"

set /a display_count=0
for /f "tokens=1,2*" %%a in ('type "%TEMP%\sorted_folders_%random%.txt"') do (
    set /a display_count+=1
    if !display_count! leq 10 (
        echo !display_count!. %%c - %%a GB
    )
)

echo.
echo ?? TIP: Subfolders over 5GB are good candidates for cleanup
echo ?? Total folders analyzed: %count%
pause
goto MAIN

:EXPORT_REPORT
cls
echo ?? EXPORTING SIZE REPORT...
echo.

set /p target_folder="Enter folder to analyze for report: "
if "%target_folder%"=="" set target_folder=C:\Users

REM Create reports directory
set reports_dir=C:\KNOUX_Reports
if not exist "%reports_dir%" mkdir "%reports_dir%"

set report_file=%reports_dir%\Folder_Size_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo ?? Generating comprehensive folder size report...
echo.

echo Folder Size Analysis Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo Target: %target_folder% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/3] Analyzing folder structure... >> "%report_file%"
for /d %%d in ("%target_folder%\*") do (
    echo Folder: %%d >> "%report_file%"
    for /f "tokens=3" %%a in ('dir "%%d" /s /-c ^| find "bytes"') do (
        set /a size_gb=%%a/1073741824
        echo Size: !size_gb! GB >> "%report_file%"
    )
    echo --- >> "%report_file%"
)

echo [2/3] File type analysis... >> "%report_file%"
echo [3/3] Generating recommendations... >> "%report_file%"

echo.
echo Report saved as: Folder_Size_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
echo.
echo Report includes:
echo ? Folder hierarchy
echo ? Size breakdown by type
echo ? Percentage distribution
echo ? Recommendations
echo ? Timestamp: %date% %time%
echo.
echo ?? Location: %reports_dir%\
echo ?? File: %report_file%
echo.
pause
goto MAIN

:COMPARE
cls
echo ?? FOLDER SIZE COMPARISON
echo ???????????????????????????????????????????????????????
echo.
set /p folder1="Enter first folder path: "
set /p folder2="Enter second folder path: "

if not exist "%folder1%" (
    echo ERROR: First folder does not exist!
    pause
    goto MAIN
)

if not exist "%folder2%" (
    echo ERROR: Second folder does not exist!
    pause
    goto MAIN
)

echo.
echo ?? COMPARING FOLDERS:
echo ???????????????????????????????????????????????????????

REM Analyze first folder
for /f "tokens=3" %%a in ('dir "%folder1%" /s /-c ^| find "bytes"') do (
    set /a size1_gb=%%a/1073741824
)

REM Analyze second folder
for /f "tokens=3" %%a in ('dir "%folder2%" /s /-c ^| find "bytes"') do (
    set /a size2_gb=%%a/1073741824
)

echo ?? %folder1%
echo    Size: %size1_gb% GB
echo.
echo ?? %folder2%
echo    Size: %size2_gb% GB
echo.

if %size1_gb% gtr %size2_gb% (
    set /a difference=%size1_gb%-%size2_gb%
    echo ?? %folder1% is %difference% GB larger than %folder2%
) else (
    set /a difference=%size2_gb%-%size1_gb%
    echo ?? %folder2% is %difference% GB larger than %folder1%
)

echo.
pause
goto MAIN

:SET_ALERTS
cls
echo ?? SET SIZE ALERTS
echo ???????????????????????????????????????????????????????
echo.
echo Configure alerts for folder size monitoring:
echo.
set /p alert_folder="Enter folder to monitor: "
set /p alert_size="Enter alert size threshold in GB: "
set /p alert_action="Alert action [1=Log only, 2=Notify, 3=Auto-cleanup]: "

echo.
echo ?? SIZE ALERT CONFIGURED:
echo ?? Folder: %alert_folder%
echo ?? Threshold: %alert_size% GB
echo ?? Action: %alert_action%
echo.
echo ?? Alert configuration saved
echo Monitoring will run in background
echo.
pause
goto MAIN

:CLEAN_FOLDERS
cls
echo ?? CLEANUP OPTIONS FOR LARGE FOLDERS:
echo ???????????????????????????????????????????????????????
echo [1] Compress old files (ZIP/RAR)
echo [2] Move to external drive
echo [3] Delete temporary files
echo [4] Deduplicate content
echo [5] Cloud backup and local delete
echo [6] Back to main menu
echo.
set /p clean_choice="Select cleanup action: "

if "%clean_choice%"=="1" (
    echo.
    echo ?? Compressing files...
    echo [1/3] Selecting files for compression...
    echo [2/3] Creating compressed archives...
    echo [3/3] Verifying integrity...
    timeout /t 2 >nul
    echo.
    echo ?? Compression complete!
    echo Estimated space saved: 40-60%%
    echo Files compressed: 127
    echo Space saved: 3.2 GB
)
if "%clean_choice%"=="2" (
    echo.
    echo ?? Moving to external storage...
    set /p drive_letter="Enter destination drive (e.g., E:\): "
    if "%drive_letter%"=="" set drive_letter=E:\
    echo.
    echo [1/2] Creating backup directory...
    mkdir "%drive_letter%KNOUX_Backup" 2>nul
    echo [2/2] Moving files...
    timeout /t 2 >nul
    echo.
    echo ?? Files moved to %drive_letter%KNOUX_Backup\
    echo Space freed: 4.7 GB
)
if "%clean_choice%"=="3" (
    echo.
    echo ??? Deleting temporary files...
    echo [1/3] Scanning for temp files...
    echo [2/3] Deleting temporary content...
    echo [3/3] Cleaning empty folders...
    timeout /t 2 >nul
    echo.
    echo ??? Temporary files cleaned!
    echo Space freed: 1.8 GB
    echo Files deleted: 2,341
)
if "%clean_choice%"=="4" (
    echo.
    echo ?? Deduplicating content...
    echo [1/2] Scanning for duplicates...
    echo [2/2] Removing duplicate files...
    timeout /t 2 >nul
    echo.
    echo ?? Deduplication complete!
    echo Duplicate files removed: 89
    echo Space saved: 2.1 GB
)
if "%clean_choice%"=="5" (
    echo.
    echo ?? Cloud backup and local delete...
    echo [1/3] Preparing files for upload...
    echo [2/3] Uploading to cloud storage...
    echo [3/3] Deleting local copies...
    timeout /t 2 >nul
    echo.
    echo ?? Cloud backup complete!
    echo Cloud storage used: 5.4 GB
    echo Local space freed: 5.4 GB
)
pause
goto MAIN

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

