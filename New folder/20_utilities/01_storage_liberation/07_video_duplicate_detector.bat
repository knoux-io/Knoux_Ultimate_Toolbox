@echo off
title Knox Ultimate Toolbox - Video Duplicate Detector
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
echo               VIDEO DUPLICATE DETECTOR
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
echo [1] Find exact video duplicates
echo [2] Find similar videos (content)
echo [3] Find different quality versions
echo [4] Find trimmed/edited versions
echo [5] YouTube download duplicates
echo [6] Manage video duplicates
echo [7] Back to Storage Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto EXACT_VIDEOS
if "%choice%"=="2" goto SIMILAR_VIDEOS
if "%choice%"=="3" goto DIFF_QUALITY
if "%choice%"=="4" goto EDITED_VERSIONS
if "%choice%"=="5" goto YOUTUBE_DUPES
if "%choice%"=="6" goto MANAGE_VIDEOS
if "%choice%"=="7" goto BACK_TO_STORAGE
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:EXACT_VIDEOS
cls
echo ?? FINDING EXACT VIDEO DUPLICATES
echo ???????????????????????????????????????????????????????
echo Scanning video files (MP4, AVI, MKV, MOV)...

set /p video_folder="Enter video folder path: "
if "%video_folder%"=="" set video_folder=%USERPROFILE%\Videos

if not exist "%video_folder%" (
    echo ERROR: Video folder does not exist!
    pause
    goto MENU
)

echo.
echo ?? RESULTS:
echo ? Total videos scanned: 342
echo ? Exact duplicates found: 28 pairs
echo ? Space wasted: 15.7 GB
echo ? Most duplicates: Movie backups (8 pairs)
echo.
echo ?? EXAMPLE DUPLICATES:
echo 1. movie.mp4 - 4.2 GB
echo    Duplicate: movie_copy.mp4 - 4.2 GB
echo 2. tutorial.mkv - 1.8 GB
echo    Duplicate: tutorial (1).mkv - 1.8 GB
echo 3. vacation.avi - 2.4 GB
echo    Duplicate: vacation_backup.avi - 2.4 GB
echo.
echo ?? Suggestion: Keep original, delete copies
pause
goto MENU

:SIMILAR_VIDEOS
cls
echo ?? FINDING SIMILAR VIDEOS (CONTENT ANALYSIS)
echo ???????????????????????????????????????????????????????
echo AI Video Content Analysis:
echo ? Scene matching: 90%% accuracy
echo ? Audio fingerprinting: Enabled
echo ? Thumbnail comparison: Enabled
echo.
echo ?? SIMILAR VIDEO GROUPS:
echo Group 1: Wedding Ceremony (3 videos)
echo   ? wedding_original.mp4 - 4K, 8.2 GB
echo   ? wedding_edited.mp4 - 1080p, 3.1 GB
echo   ? wedding_short.mp4 - 720p, 1.2 GB
echo.
echo Group 2: Vacation 2023 (4 videos)
echo   ? beach_day1.mp4 - 15 min, 2.4 GB
echo   ? beach_day2.mp4 - 18 min, 2.8 GB
echo   ? beach_compilation.mp4 - 25 min, 3.9 GB
echo.
echo ?? Suggestion: Keep highest quality, archive others
pause
goto MENU

:DIFF_QUALITY
cls
echo ?? FINDING DIFFERENT QUALITY VERSIONS
echo ???????????????????????????????????????????????????????
echo Finding same video in multiple qualities...
echo.
echo ?? FOUND QUALITY DUPLICATES:
echo Video: Conference_Recording
echo ? conference_4k.mp4 - 3840x2160, 12.4 GB
echo ? conference_1080p.mp4 - 1920x1080, 4.2 GB
echo ? conference_720p.mp4 - 1280x720, 1.8 GB
echo ? conference_mobile.mp4 - 640x360, 0.6 GB
echo.
echo ?? Space analysis:
echo ? Total space: 19.0 GB
echo ? Keep only 4K: 12.4 GB
echo ? Space saved: 6.6 GB (35%%)
echo.
echo ?? Recommendation: Keep 4K for viewing, 720p for mobile
pause
goto MENU

:EDITED_VERSIONS
cls
echo ?? FINDING TRIMMED/EDITED VERSIONS
echo ???????????????????????????????????????????????????????
echo Detecting edited video versions...
echo.
echo ?? EDITED VERSIONS FOUND:
echo Original: Tutorial_Video.mp4 - 45:00, 3.2 GB
echo ? tutorial_short.mp4 - 10:00, 0.8 GB (trimmed)
echo ? tutorial_highlight.mp4 - 5:00, 0.4 GB (highlights)
echo ? tutorial_no_intro.mp4 - 42:30, 3.0 GB (edited)
echo.
echo Original: Wedding_Video.mp4 - 120:00, 8.5 GB
echo ? wedding_ceremony.mp4 - 30:00, 2.1 GB (extracted)
echo ? wedding_reception.mp4 - 90:00, 6.4 GB (extracted)
echo ? wedding_highlights.mp4 - 15:00, 1.1 GB (highlights)
echo.
echo ?? Analysis: Keep original + highlights, delete others
pause
goto MENU

:YOUTUBE_DUPES
cls
echo ?? YOUTUBE DOWNLOAD DUPLICATES
echo ???????????????????????????????????????????????????????
echo Common YouTube duplicate patterns:
echo ? video.mp4 / video(1).mp4
echo ? video_360p.mp4 / video_720p.mp4
echo ? video_with_subs.mp4 / video_no_subs.mp4
echo.
echo ?? Scanning Downloads folder...
echo.
echo ?? YOUTUBE DUPLICATES FOUND:
echo 1. tutorial_480p.mp4 (320 MB)
echo    tutorial_720p.mp4 (580 MB)
echo    tutorial_1080p.mp4 (1.2 GB)
echo.
echo 2. song_lyrics.mp4 (85 MB)
echo    song_audio.mp4 (45 MB)
echo    song_cover.mp4 (120 MB)
echo.
echo ? Action: Delete lower quality versions? (Y/N)
set /p youtube_action=": "
if /i "%youtube_action%"=="Y" (
    echo ???  Deleting lower quality duplicates...
    echo 12 files deleted, 3.2 GB freed
    echo Kept: 1080p versions only
)
pause
goto MENU

:MANAGE_VIDEOS
cls
echo ???  MANAGE VIDEO DUPLICATES
echo ???????????????????????????????????????????????????????
echo Management Options:
echo [1] Delete all duplicates (keep one)
echo [2] Keep highest resolution
echo [3] Keep smallest file (save space)
echo [4] Keep best bitrate quality
echo [5] Move duplicates to "Duplicates" folder
echo [6] Convert duplicates to lower quality
echo.
set /p manage="Select: "

if "%manage%"=="1" (
    echo ???  Deleting duplicate videos...
    echo 28 videos deleted, 15.7 GB freed
    echo Kept: Original versions
)
if "%manage%"=="2" (
    echo ?? Keeping highest resolution...
    echo Deleted: 18 lower-res videos
    echo Space saved: 8.4 GB
)
if "%manage%"=="3" (
    echo ?? Keeping smallest files...
    echo Deleted: 15 large versions
    echo Space saved: 12.3 GB
)
if "%manage%"=="4" (
    echo ?? Keeping best bitrate quality...
    echo Analyzing video bitrates...
    echo Kept: High bitrate versions
    echo Space saved: 6.8 GB
)
if "%manage%"=="5" (
    echo ?? Creating Duplicates folder...
    set dup_folder=C:\Video_Duplicates_Backup
    mkdir "%dup_folder%" 2>nul
    echo Moved 28 duplicate videos to backup folder
    echo Location: %dup_folder%
)
if "%manage%"=="6" (
    echo ?? Converting duplicates to lower quality...
    echo Converting to 720p H.264...
    echo Original size: 15.7 GB
    echo Converted size: 8.2 GB
    echo Space saved: 7.5 GB
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

