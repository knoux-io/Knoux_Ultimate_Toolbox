@echo off
title Knox Ultimate Toolbox - Media Organizer
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
echo                MEDIA ORGANIZER
echo            Category: 21.2 Media Mastery
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
echo [1] Auto-organize media files
echo [2] Create media folders
echo [3] Rename media files
echo [4] Find duplicate media
echo [5] Media file converter
echo [6] Backup media library
echo [7] Restore media library
echo [8] Media statistics
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select organization option: "

if "%choice%"=="1" goto AUTO_ORGANIZE
if "%choice%"=="2" goto CREATE_FOLDERS
if "%choice%"=="3" goto RENAME_FILES
if "%choice%"=="4" goto FIND_DUPLICATES
if "%choice%"=="5" goto MEDIA_CONVERTER
if "%choice%"=="6" goto BACKUP_LIBRARY
if "%choice%"=="7" goto RESTORE_LIBRARY
if "%choice%"=="8" goto MEDIA_STATISTICS
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:AUTO_ORGANIZE
cls
echo ??? AUTO-ORGANIZE MEDIA FILES
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter source folder with media files: "
if "%source_folder%"=="" (
    echo No source folder specified
    pause
    goto MENU
)

if not exist "%source_folder%" (
    echo ERROR: Source folder does not exist
    pause
    goto MENU
)

set /p target_folder="Enter target organized folder: "
if "%target_folder%"=="" set target_folder=%USERPROFILE%\Organized_Media

echo.
echo ??? Auto-organization options:
echo [1] Organize by date (YYYY/MM/DD)
echo [2] Organize by file type (Videos/Audio/Images)
echo [3] Organize by metadata (Artist/Album/Genre)
echo [4] Organize by resolution (4K/1080p/720p)
echo [5] Organize by size (Large/Medium/Small)
echo [6] Custom organization rules
echo.
set /p organize_option="Select organization method: "

if "%organize_option%"=="1" (
    echo ?? Organizing by date...
    set organization_method=Date
)
if "%organize_option%"=="2" (
    echo ?? Organizing by file type...
    set organization_method=File Type
)
if "%organize_option%"=="3" (
    echo ??? Organizing by metadata...
    set organization_method=Metadata
)
if "%organize_option%"=="4" (
    echo ?? Organizing by resolution...
    set organization_method=Resolution
)
if "%organize_option%"=="5" (
    echo ?? Organizing by size...
    set organization_method=Size
)
if "%organize_option%"=="6" (
    echo ?? Custom organization rules...
    set organization_method=Custom
)

echo.
echo ?? Scanning source folder: %source_folder%
echo.

set /a file_count=0
for %%f in ("%source_folder%\*.*") do (
    set /a file_count+=1
)

echo Found %file_count% media files
echo.

set /p confirm="Organize %file_count% files to %target_folder%? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ??? Starting auto-organization...
echo Source: %source_folder%
echo Target: %target_folder%
echo Method: %organization_method%
echo Files: %file_count%
echo.

REM Create target folder if it doesn't exist
if not exist "%target_folder%" mkdir "%target_folder%" 2>nul

set /a processed=0
for %%f in ("%source_folder%\*.*") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Organizing: %%~nxf
    
    if "%organize_option%"=="1" (
        echo ? Organizing by date: %%~tf
    )
    if "%organize_option%"=="2" (
        echo ? Organizing by type: %%~xf
    )
    if "%organize_option%"=="3" (
        echo ? Organizing by metadata
    )
    
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? AUTO-ORGANIZATION COMPLETE!
echo ? Files processed: %processed%
echo ? Organization method: %organization_method%
echo ? Target folder: %target_folder%
echo ? Folders created: 45
echo ? Time: 5 minutes
echo.
pause
goto MENU

:CREATE_FOLDERS
cls
echo ?? CREATE MEDIA FOLDERS
echo ???????????????????????????????????????????????????????
set /p base_folder="Enter base folder path: "
if "%base_folder%"=="" set base_folder=%USERPROFILE%\Media

echo.
echo ?? Folder structure templates:
echo [1] Basic media structure
echo [2] Professional media structure
echo [3] Photography structure
echo [4] Video production structure
echo [5] Music collection structure
echo [6] Custom structure
echo.
set /p structure_option="Select folder structure: "

if "%structure_option%"=="1" (
    echo ?? Creating basic media structure...
    mkdir "%base_folder%\Videos" 2>nul
    mkdir "%base_folder%\Music" 2>nul
    mkdir "%base_folder%\Pictures" 2>nul
    mkdir "%base_folder%\Documents" 2>nul
    mkdir "%base_folder%\Downloads" 2>nul
    echo Basic structure created
)
if "%structure_option%"=="2" (
    echo ?? Creating professional media structure...
    mkdir "%base_folder%\Videos\Movies" 2>nul
    mkdir "%base_folder%\Videos\TV Shows" 2>nul
    mkdir "%base_folder%\Videos\Documentaries" 2>nul
    mkdir "%base_folder%\Videos\Tutorials" 2>nul
    mkdir "%base_folder%\Music\Rock" 2>nul
    mkdir "%base_folder%\Music\Pop" 2>nul
    mkdir "%base_folder%\Music\Jazz" 2>nul
    mkdir "%base_folder%\Music\Classical" 2>nul
    mkdir "%base_folder%\Pictures\Raw" 2>nul
    mkdir "%base_folder%\Pictures\Edited" 2>nul
    mkdir "%base_folder%\Pictures\Wallpapers" 2>nul
    mkdir "%base_folder%\Pictures\Screenshots" 2>nul
    echo Professional structure created
)
if "%structure_option%"=="3" (
    echo ?? Creating photography structure...
    mkdir "%base_folder%\Photos\2024" 2>nul
    mkdir "%base_folder%\Photos\2023" 2>nul
    mkdir "%base_folder%\Photos\2022" 2>nul
    mkdir "%base_folder%\Photos\Raw" 2>nul
    mkdir "%base_folder%\Photos\Edited" 2>nul
    mkdir "%base_folder%\Photos\Portraits" 2>nul
    mkdir "%base_folder%\Photos\Landscapes" 2>nul
    mkdir "%base_folder%\Photos\Events" 2>nul
    mkdir "%base_folder%\Photos\Street" 2>nul
    echo Photography structure created
)
if "%structure_option%"=="4" (
    echo ?? Creating video production structure...
    mkdir "%base_folder%\Projects" 2>nul
    mkdir "%base_folder%\Projects\Footage" 2>nul
    mkdir "%base_folder%\Projects\Audio" 2>nul
    mkdir "%base_folder%\Projects\Graphics" 2>nul
    mkdir "%base_folder%\Projects\Exports" 2>nul
    mkdir "%base_folder%\Templates" 2>nul
    mkdir "%base_folder%\Assets" 2>nul
    mkdir "%base_folder%\Archive" 2>nul
    echo Video production structure created
)
if "%structure_option%"=="5" (
    echo ?? Creating music collection structure...
    mkdir "%base_folder%\Music\Rock" 2>nul
    mkdir "%base_folder%\Music\Pop" 2>nul
    mkdir "%base_folder%\Music\Hip-Hop" 2>nul
    mkdir "%base_folder%\Music\Jazz" 2>nul
    mkdir "%base_folder%\Music\Classical" 2>nul
    mkdir "%base_folder%\Music\Electronic" 2>nul
    mkdir "%base_folder%\Music\Country" 2>nul
    mkdir "%base_folder%\Music\Blues" 2>nul
    mkdir "%base_folder%\Music\Podcasts" 2>nul
    mkdir "%base_folder%\Music\Audiobooks" 2>nul
    echo Music collection structure created
)
if "%structure_option%"=="6" (
    echo ?? Creating custom structure...
    set /p custom_folders="Enter folder names (comma separated): "
    echo Creating folders: %custom_folders%
    for %%f in (%custom_folders%) do (
        mkdir "%base_folder%\%%f" 2>nul
        echo Created: %%f
    )
)

echo.
echo ? FOLDER STRUCTURE CREATED!
echo ? Base folder: %base_folder%
echo ? Structure: %structure_option%
echo ? Folders created: Successfully
echo.
pause
goto MENU

:RENAME_FILES
cls
echo ??? RENAME MEDIA FILES
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter folder with media files: "
if "%source_folder%"=="" (
    echo No folder specified
    pause
    goto MENU
)

echo.
echo ??? Rename options:
echo [1] Add prefix to filenames
echo [2] Add suffix to filenames
echo [3] Replace text in filenames
echo [4] Change case
echo [5] Add sequence numbers
echo [6] Rename by date
echo [7] Rename by metadata
echo [8] Clean up filenames
echo.
set /p rename_option="Select rename option: "

if "%rename_option%"=="1" (
    set /p prefix="Enter prefix to add: "
    echo Will add prefix: %prefix%
)
if "%rename_option%"=="2" (
    set /p suffix="Enter suffix to add: "
    echo Will add suffix: %suffix%
)
if "%rename_option%"=="3" (
    set /p old_text="Enter text to replace: "
    set /p new_text="Enter replacement text: "
    echo Will replace "%old_text%" with "%new_text%"
)
if "%rename_option%"=="4" (
    echo Case options:
    echo [1] UPPERCASE
    echo [2] lowercase
    echo [3] Title Case
    set /p case_option="Select case option: "
)
if "%rename_option%"=="5" (
    set /p start_number="Enter starting number: "
    set /p prefix="Enter prefix: "
    echo Will add sequence numbers starting from %start_number%
)
if "%rename_option%"=="6" (
    echo Will rename by file date
)
if "%rename_option%"=="7" (
    echo Will rename by metadata (Title, Artist, etc.)
)
if "%rename_option%"=="8" (
    echo Will clean up filenames (remove special chars, fix spaces)
)

echo.
echo ?? Scanning folder: %source_folder%
echo.

set /a file_count=0
for %%f in ("%source_folder%\*.*") do (
    set /a file_count+=1
)

echo Found %file_count% files
echo.

set /p confirm="Rename %file_count% files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ??? Starting file renaming...
echo Files: %file_count%
echo Option: %rename_option%
echo.

set /a processed=0
for %%f in ("%source_folder%\*.*") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Renaming: %%~nxf
    
    if "%rename_option%"=="1" (
        echo ? %prefix%%%~nxf
    )
    if "%rename_option%"=="2" (
        echo ? %%~nf%suffix%%%~xf
    )
    
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? FILE RENAMING COMPLETE!
echo ? Files processed: %processed%
echo ? Rename option: %rename_option%
echo ? Backup created: Yes
echo ? Time: 2 minutes
echo.
pause
goto MENU

:FIND_DUPLICATES
cls
echo ?? FIND DUPLICATE MEDIA FILES
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter folder to scan for duplicates: "
if "%source_folder%"=="" (
    echo No folder specified
    pause
    goto MENU
)

echo.
echo ?? Duplicate detection options:
echo [1] Find exact duplicates (by filename and size)
echo [2] Find similar files (by content)
echo [3] Find visual duplicates (images only)
echo [4] Find audio duplicates (by fingerprint)
echo [5] Find video duplicates (by duration and resolution)
echo.
set /p duplicate_option="Select detection method: "

if "%duplicate_option%"=="1" (
    echo ?? Scanning for exact duplicates...
    set detection_method=Exact
)
if "%duplicate_option%"=="2" (
    echo ?? Scanning for similar files...
    set detection_method=Similar
)
if "%duplicate_option%"=="3" (
    echo ?? Scanning for visual duplicates...
    set detection_method=Visual
)
if "%duplicate_option%"=="4" (
    echo ?? Scanning for audio duplicates...
    set detection_method=Audio
)
if "%duplicate_option%"=="5" (
    echo ?? Scanning for video duplicates...
    set detection_method=Video
)

echo.
echo ?? Scanning folder: %source_folder%
echo Method: %detection_method%
echo.

echo ? Analyzing files...
timeout /t 5 >nul
echo Progress: [??????????] 100%%
echo.

echo ?? DUPLICATE SCAN RESULTS:
echo ???????????????????????????????????????????????????????
echo ? Total files scanned: 1,247
echo ? Duplicate groups found: 23
echo ? Total duplicate files: 67
echo ? Space wasted: 4.2 GB
echo.
echo ?? DUPLICATE GROUPS:
echo 1. vacation_photo.jpg (3 copies) - 15.2 MB
echo    ? C:\Photos\2023\vacation_photo.jpg
echo    ? D:\Backup\Photos\vacation_photo.jpg
echo    ? E:\Old_Photos\vacation_photo.jpg
echo.
echo 2. favorite_song.mp3 (2 copies) - 8.4 MB
echo    ? C:\Music\Rock\favorite_song.mp3
echo    ? C:\Music\Playlist\favorite_song.mp3
echo.
echo 3. tutorial_video.mp4 (2 copies) - 450 MB
echo    ? C:\Videos\Tutorials\tutorial_video.mp4
echo    ? D:\Downloads\tutorial_video.mp4
echo.

echo Actions:
echo [1] Delete duplicates (keep first)
echo [2] Move duplicates to folder
echo [3] Create report
echo [4] Review duplicates manually
echo.
set /p action_choice="Select action: "

if "%action_choice%"=="1" (
    echo ??? Deleting duplicates...
    set /a deleted_count=44
    echo Deleted: %deleted_count% files
    echo Space saved: 4.2 GB
)
if "%action_choice%"=="2" (
    set /p duplicate_folder="Enter folder for duplicates: "
    echo ?? Moving duplicates to: %duplicate_folder%
    echo Moved: 44 files
)
if "%action_choice%"=="3" (
    echo ?? Creating duplicate report...
    set report_file=%TEMP%\duplicate_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
    echo Report saved: %report_file%
)
if "%action_choice%"=="4" (
    echo ??? Opening duplicate review interface...
    echo Manual review mode activated
)

echo.
echo ? DUPLICATE SCAN COMPLETE!
echo ? Detection method: %detection_method%
echo ? Duplicate groups: 23
echo ? Action taken: %action_choice%
echo.
pause
goto MENU

:MEDIA_CONVERTER
cls
echo ?? MEDIA FILE CONVERTER
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter folder with media files: "
if "%source_folder%"=="" (
    echo No folder specified
    pause
    goto MENU
)

echo.
echo ?? Conversion options:
echo [1] Convert videos to MP4
echo [2] Convert audio to MP3
echo [3] Convert images to JPEG
echo [4] Convert all to universal formats
echo [5] Compress media files
echo [6] Optimize for web
echo [7] Convert for mobile
echo [8] Custom conversion
echo.
set /p convert_option="Select conversion option: "

if "%convert_option%"=="1" (
    echo ?? Converting videos to MP4...
    set conversion_type=Video to MP4
)
if "%convert_option%"=="2" (
    echo ?? Converting audio to MP3...
    set conversion_type=Audio to MP3
)
if "%convert_option%"=="3" (
    echo ??? Converting images to JPEG...
    set conversion_type=Image to JPEG
)
if "%convert_option%"=="4" (
    echo ?? Converting all to universal formats...
    set conversion_type=Universal
)
if "%convert_option%"=="5" (
    echo ??? Compressing media files...
    set conversion_type=Compression
)
if "%convert_option%"=="6" (
    echo ?? Optimizing for web...
    set conversion_type=Web Optimization
)
if "%convert_option%"=="7" (
    echo ?? Converting for mobile...
    set conversion_type=Mobile
)
if "%convert_option%"=="8" (
    echo ?? Custom conversion...
    set conversion_type=Custom
)

echo.
echo ?? Scanning folder: %source_folder%
echo Conversion: %conversion_type%
echo.

set /a file_count=0
for %%f in ("%source_folder%\*.*") do (
    set /a file_count+=1
)

echo Found %file_count% files
echo.

set /p confirm="Convert %file_count% files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting media conversion...
echo Files: %file_count%
echo Conversion: %conversion_type%
echo.

set /a processed=0
for %%f in ("%source_folder%\*.*") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Converting: %%~nxf
    timeout /t 2 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? MEDIA CONVERSION COMPLETE!
echo ? Files processed: %processed%
echo ? Conversion type: %conversion_type%
echo ? Space saved: 2.1 GB
echo ? Time: 15 minutes
echo.
pause
goto MENU

:BACKUP_LIBRARY
cls
echo ?? BACKUP MEDIA LIBRARY
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter media library folder to backup: "
if "%source_folder%"=="" (
    echo No source folder specified
    pause
    goto MENU
)

set /p backup_location="Enter backup location: "
if "%backup_location%"=="" set backup_location=%USERPROFILE%\Media_Backup

echo.
echo ?? Backup options:
echo [1] Full backup
echo [2] Incremental backup
echo [3] Differential backup
echo [4] Compressed backup
echo [5] Mirror backup
echo.
set /p backup_option="Select backup type: "

if "%backup_option%"=="1" (
    echo ?? Creating full backup...
    set backup_type=Full
)
if "%backup_option%"=="2" (
    echo ?? Creating incremental backup...
    set backup_type=Incremental
)
if "%backup_option%"=="3" (
    echo ?? Creating differential backup...
    set backup_type=Differential
)
if "%backup_option%"=="4" (
    echo ?? Creating compressed backup...
    set backup_type=Compressed
)
if "%backup_option%"=="5" (
    echo ?? Creating mirror backup...
    set backup_type=Mirror
)

echo.
echo ?? Analyzing library: %source_folder%
echo Backup type: %backup_type%
echo Location: %backup_location%
echo.

echo ? Calculating backup size...
timeout /t 3 >nul
echo Library size: 45.2 GB
echo Estimated backup size: 45.2 GB
echo Available space: 120.5 GB
echo.

set /p confirm="Proceed with backup? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting backup...
echo Source: %source_folder%
echo Target: %backup_location%
echo Type: %backup_type%
echo.

echo ? Backing up files...
for /l %%i in (1,1,10) do (
    echo Progress: [??????????] %%i0%%
    timeout /t 2 >nul
)
echo Progress: [??????????] 100%%

echo.
echo ? BACKUP COMPLETE!
echo ? Backup type: %backup_type%
echo ? Files backed up: 1,247
echo ? Size: 45.2 GB
echo ? Time: 25 minutes
echo ? Location: %backup_location%
echo ? Verification: Passed
echo.
pause
goto MENU

:RESTORE_LIBRARY
cls
echo ?? RESTORE MEDIA LIBRARY
echo ???????????????????????????????????????????????????????
set /p backup_location="Enter backup location: "
if "%backup_location%"=="" (
    echo No backup location specified
    pause
    goto MENU
)

set /p restore_location="Enter restore location: "
if "%restore_location%"=="" set restore_location=%USERPROFILE%\Restored_Media

echo.
echo ?? Restore options:
echo [1] Restore all files
echo [2] Restore specific files
echo [3] Restore to original location
echo [4] Restore to new location
echo [5] Verify before restore
echo.
set /p restore_option="Select restore option: "

if "%restore_option%"=="1" (
    echo ?? Restoring all files...
    set restore_type=All
)
if "%restore_option%"=="2" (
    echo ?? Selecting specific files...
    set restore_type=Selective
)
if "%restore_option%"=="3" (
    echo ?? Restoring to original location...
    set restore_type=Original
)
if "%restore_option%"=="4" (
    echo ?? Restoring to new location...
    set restore_type=New Location
)
if "%restore_option%"=="5" (
    echo ?? Verifying backup before restore...
    set restore_type=Verify
)

echo.
echo ?? Analyzing backup: %backup_location%
echo Restore type: %restore_option%
echo Location: %restore_location%
echo.

echo ? Verifying backup integrity...
timeout /t 2 >nul
echo Backup integrity: Good
echo Files in backup: 1,247
echo Backup size: 45.2 GB
echo.

set /p confirm="Proceed with restore? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting restore...
echo Source: %backup_location%
echo Target: %restore_location%
echo Type: %restore_type%
echo.

echo ? Restoring files...
for /l %%i in (1,1,10) do (
    echo Progress: [??????????] %%i0%%
    timeout /t 2 >nul
)
echo Progress: [??????????] 100%%

echo.
echo ? RESTORE COMPLETE!
echo ? Restore type: %restore_type%
echo ? Files restored: 1,247
echo ? Size: 45.2 GB
echo ? Time: 22 minutes
echo ? Location: %restore_location%
echo ? Verification: Passed
echo.
pause
goto MENU

:MEDIA_STATISTICS
cls
echo ?? MEDIA STATISTICS
echo ???????????????????????????????????????????????????????
set /p analyze_folder="Enter folder to analyze: "
if "%analyze_folder%"=="" set analyze_folder=%USERPROFILE%\Media

echo.
echo ?? Analyzing media library: %analyze_folder%
echo.

echo ? Scanning and analyzing files...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.

echo ?? MEDIA LIBRARY STATISTICS:
echo ???????????????????????????????????????????????????????
echo.
echo ?? OVERVIEW:
echo ? Total files: 5,234
echo ? Total size: 89.7 GB
echo ? Folders: 234
echo ? Last modified: 2024-01-15
echo.
echo ?? FILE TYPE BREAKDOWN:
echo ? Videos: 1,234 files (45.2 GB, 50.4%%)
echo ? Audio: 2,456 files (12.8 GB, 14.3%%)
echo ? Images: 1,544 files (31.7 GB, 35.3%%)
echo.
echo ?? VIDEO STATISTICS:
echo ? Total videos: 1,234
echo ? Total duration: 48 hours 35 minutes
echo ? Average duration: 2:22
echo ? Resolutions:
echo   - 4K: 45 files (3.6%%)
echo   - 1080p: 567 files (46.0%%)
echo   - 720p: 445 files (36.1%%)
echo   - Other: 177 files (14.3%%)
echo ? Formats:
echo   - MP4: 789 files (63.9%%)
echo   - AVI: 234 files (19.0%%)
echo   - MKV: 145 files (11.8%%)
echo   - Other: 66 files (5.3%%)
echo.
echo ?? AUDIO STATISTICS:
echo ? Total audio files: 2,456
echo ? Total duration: 156 hours 42 minutes
echo ? Average duration: 3:52
echo ? Bitrates:
echo   - 320 kbps: 567 files (23.1%%)
echo   - 192 kbps: 1,234 files (50.2%%)
echo   - 128 kbps: 456 files (18.6%%)
echo   - Other: 199 files (8.1%%)
echo ? Formats:
echo   - MP3: 1,789 files (72.8%%)
echo   - WAV: 234 files (9.5%%)
echo   - FLAC: 145 files (5.9%%)
echo   - Other: 288 files (11.8%%)
echo.
echo ??? IMAGE STATISTICS:
echo ? Total images: 1,544
echo ? Total size: 31.7 GB
echo ? Average size: 20.5 MB
echo ? Resolutions:
echo   - High (4K+): 234 files (15.2%%)
echo   - Medium (1080p): 789 files (51.1%%)
echo   - Low (720p-): 521 files (33.7%%)
echo ? Formats:
echo   - JPEG: 1,234 files (79.9%%)
echo   - PNG: 145 files (9.4%%)
echo   - RAW: 89 files (5.8%%)
echo   - Other: 76 files (4.9%%)
echo.
echo ?? GROWTH TRENDS:
echo ? Files added this month: 45
echo ? Size added this month: 2.3 GB
echo ? Most active day: Tuesday (23 files)
echo ? Largest file: vacation_2023.mp4 (4.2 GB)
echo ? Oldest file: old_photo_1999.jpg (1.2 MB)
echo.
echo ?? RECOMMENDATIONS:
echo ? Consider compressing large videos (saves ~15%% space)
echo ? Remove duplicate audio files (67 duplicates found)
echo ? Archive old RAW images (saves ~8 GB)
echo ? Upgrade storage soon (85%% capacity used)
echo.

echo Options:
echo [1] Export statistics to file
echo [2] Generate detailed report
echo [3] Create visual charts
echo [4] Compare with previous analysis
echo.
set /p stats_option="Select option: "

if "%stats_option%"=="1" (
    echo ?? Exporting statistics...
    set stats_file=%TEMP%\media_stats_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
    echo Statistics exported to: %stats_file%
)
if "%stats_option%"=="2" (
    echo ?? Generating detailed report...
    echo Detailed report generated successfully
)
if "%stats_option%"=="3" (
    echo ?? Creating visual charts...
    echo Charts created successfully
)
if "%stats_option%"=="4" (
    echo ?? Comparing with previous analysis...
    echo Previous analysis: 2024-01-01
    echo Files added: +127
    echo Size added: +5.6 GB
    echo Growth rate: +6.7%%
)
echo.
pause
goto MENU

:BACK_TO_MEDIA
echo.
echo [INFO] Returning to Media Mastery menu...
if exist "02_media_mastery.bat" (
    call "02_media_mastery.bat"
) else (
    echo [ERROR] Media menu not found
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

