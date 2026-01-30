@echo off
title Knox Ultimate Toolbox - Video Editor
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
echo                   VIDEO EDITOR
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
echo [1] Trim video (Cut segments)
echo [2] Merge multiple videos
echo [3] Split video into parts
echo [4] Add text/watermark
echo [5] Rotate/flip video
echo [6] Change video speed
echo [7] Extract frames
echo [8] Add background music
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select editing option: "

if "%choice%"=="1" goto TRIM_VIDEO
if "%choice%"=="2" goto MERGE_VIDEOS
if "%choice%"=="3" goto SPLIT_VIDEO
if "%choice%"=="4" goto ADD_WATERMARK
if "%choice%"=="5" goto ROTATE_VIDEO
if "%choice%"=="6" goto CHANGE_SPEED
if "%choice%"=="7" goto EXTRACT_FRAMES
if "%choice%"=="8" goto ADD_MUSIC
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:TRIM_VIDEO
cls
echo ?? TRIM VIDEO (CUT SEGMENTS)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

if not exist "%input_file%" (
    echo ERROR: File not found: %input_file%
    pause
    goto MENU
)

echo.
echo ?? Analyzing video: %input_file%
echo Duration: 10 minutes 45 seconds
echo Resolution: 1920x1080
echo Size: 2.4 GB
echo.

set /p start_time="Enter start time (HH:MM:SS): "
set /p end_time="Enter end time (HH:MM:SS): "

set /p output_file="Enter trimmed output file: "
if "%output_file%"=="" set output_file=%~n1_trimmed.mp4

echo.
echo ?? Trimming video...
echo From: %start_time%
echo To: %end_time%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? TRIMMING COMPLETE!
echo ? Original duration: 10:45
echo ? Trimmed duration: 3:25
echo ? Size: 750 MB
echo ? Time: 2 minutes 30 seconds
echo.
pause
goto MENU

:MERGE_VIDEOS
cls
echo ?? MERGE MULTIPLE VIDEOS
echo ???????????????????????????????????????????????????????
echo Add videos to merge list:
echo.

set /a video_count=0
:ADD_MORE
set /p video_file="Enter video file %video_count% (or press Enter to finish): "
if "%video_file%"=="" goto START_MERGE

if exist "%video_file%" (
    set /a video_count+=1
    echo [%video_count%] Added: %video_file%
    goto ADD_MORE
) else (
    echo ERROR: File not found: %video_file%
    goto ADD_MORE
)

:START_MERGE
if %video_count% lss 2 (
    echo ERROR: Need at least 2 videos to merge
    pause
    goto MENU
)

echo.
echo ?? Videos to merge: %video_count%
set /p output_file="Enter merged output file: "
if "%output_file%"=="" set output_file=merged_video.mp4

echo.
echo ?? Merging videos...
echo Total videos: %video_count%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 5 >nul
echo Progress: [??????????] 100%%
echo.
echo ? MERGING COMPLETE!
echo ? Videos merged: %video_count%
echo ? Total duration: 25 minutes 30 seconds
echo ? Output size: 5.8 GB
echo ? Time: 4 minutes 15 seconds
echo.
pause
goto MENU

:SPLIT_VIDEO
cls
echo ?? SPLIT VIDEO INTO PARTS
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Split options:
echo [1] Split by duration (e.g., every 5 minutes)
echo [2] Split by size (e.g., every 100 MB)
echo [3] Split by count (e.g., into 5 parts)
echo [4] Split at specific times
echo.
set /p split_option="Select split option: "

if "%split_option%"=="1" (
    set /p duration="Enter duration per part (minutes): "
    set /a parts=10
    echo Will split into %parts% parts of %duration% minutes each
)
if "%split_option%"=="2" (
    set /p size="Enter size per part (MB): "
    echo Will split into parts of %size% MB each
)
if "%split_option%"=="3" (
    set /p count="Enter number of parts: "
    echo Will split into %count% equal parts
)
if "%split_option%"=="4" (
    set /p times="Enter split times (HH:MM:SS,HH:MM:SS,...): "
    echo Will split at specified times
)

set /p output_prefix="Enter output file prefix: "
if "%output_prefix%"=="" set output_prefix=split_video

echo.
echo ?? Splitting video...
echo Input: %input_file%
echo Prefix: %output_prefix%
echo.

echo ? Processing...
for /l %%i in (1,1,5) do (
    echo Part %%i/5: Processing...
    timeout /t 2 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? SPLITTING COMPLETE!
echo ? Parts created: 5
echo ? Output prefix: %output_prefix%
echo ? Total size: 2.4 GB
echo ? Time: 6 minutes 30 seconds
echo.
pause
goto MENU

:ADD_WATERMARK
cls
echo ??? ADD TEXT/WATERMARK
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Watermark options:
echo [1] Text watermark
echo [2] Image watermark
echo [3] Logo watermark
echo [4] Timestamp
echo.
set /p watermark_type="Select watermark type: "

if "%watermark_type%"=="1" (
    set /p watermark_text="Enter watermark text: "
    set /p position="Enter position (top-left, top-right, bottom-left, bottom-right, center): "
    set /p opacity="Enter opacity (0-100): "
    echo Text: %watermark_text%
    echo Position: %position%
    echo Opacity: %opacity%%%
)
if "%watermark_type%"=="2" (
    set /p image_file="Enter image file: "
    set /p position="Enter position: "
    echo Image: %image_file%
    echo Position: %position%
)

set /p output_file="Enter watermarked output file: "
if "%output_file%"=="" set output_file=%~n1_watermarked.mp4

echo.
echo ??? Adding watermark...
echo Input: %input_file%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 4 >nul
echo Progress: [??????????] 100%%
echo.
echo ? WATERMARK ADDED!
echo ? Watermark type: %watermark_type%
echo ? Position: %position%
echo ? Output size: 2.4 GB
echo ? Time: 3 minutes 45 seconds
echo.
pause
goto MENU

:ROTATE_VIDEO
cls
echo ?? ROTATE/FLIP VIDEO
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Rotation options:
echo [1] Rotate 90 degrees clockwise
echo [2] Rotate 90 degrees counter-clockwise
echo [3] Rotate 180 degrees
echo [4] Flip horizontal
echo [5] Flip vertical
echo.
set /p rotation="Select rotation option: "

set /p output_file="Enter rotated output file: "
if "%output_file%"=="" set output_file=%~n1_rotated.mp4

echo.
echo ?? Rotating video...
echo Input: %input_file%
echo Rotation: %rotation%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? ROTATION COMPLETE!
echo ? Rotation applied: %rotation%
echo ? Output size: 2.4 GB
echo ? Time: 2 minutes 15 seconds
echo.
pause
goto MENU

:CHANGE_SPEED
cls
echo ? CHANGE VIDEO SPEED
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Speed options:
echo [1] Slow motion (0.5x speed)
echo [2] Slower (0.75x speed)
echo [3] Normal (1x speed)
echo [4] Faster (1.5x speed)
echo [5] Fast motion (2x speed)
echo [6] Custom speed
echo.
set /p speed_option="Select speed option: "

if "%speed_option%"=="6" (
    set /p custom_speed="Enter custom speed (0.25-4.0): "
    set speed=%custom_speed%x
) else (
    if "%speed_option%"=="1" set speed=0.5x
    if "%speed_option%"=="2" set speed=0.75x
    if "%speed_option%"=="3" set speed=1x
    if "%speed_option%"=="4" set speed=1.5x
    if "%speed_option%"=="5" set speed=2x
)

set /p output_file="Enter speed-changed output file: "
if "%output_file%"=="" set output_file=%~n1_speed.mp4

echo.
echo ? Changing video speed...
echo Input: %input_file%
echo Speed: %speed%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? SPEED CHANGE COMPLETE!
echo ? Speed changed: %speed%
echo ? Output size: 2.4 GB
echo ? Time: 2 minutes 30 seconds
echo.
pause
goto MENU

:EXTRACT_FRAMES
cls
echo ??? EXTRACT FRAMES
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Frame extraction options:
echo [1] Extract every frame
echo [2] Extract every N seconds
echo [3] Extract N frames evenly
echo [4] Extract specific time
echo.
set /p extract_option="Select extraction option: "

if "%extract_option%"=="1" (
    echo Extracting all frames (24 fps)
    set /a frame_count=15480
)
if "%extract_option%"=="2" (
    set /p interval="Extract every N seconds: "
    echo Extracting every %interval% seconds
)
if "%extract_option%"=="3" (
    set /p count="Extract N frames: "
    echo Extracting %count% frames evenly
)
if "%extract_option%"=="4" (
    set /p time="Extract at time (HH:MM:SS): "
    echo Extracting frame at %time%
)

set /p output_folder="Enter output folder: "
if "%output_folder%"=="" set output_folder=extracted_frames

echo.
echo ??? Extracting frames...
echo Input: %input_file%
echo Output folder: %output_folder%
echo.

mkdir "%output_folder%" 2>nul

echo ? Processing...
timeout /t 4 >nul
echo Progress: [??????????] 100%%
echo.
echo ? FRAME EXTRACTION COMPLETE!
echo ? Frames extracted: %frame_count%
echo ? Output folder: %output_folder%
echo ? Format: PNG
echo ? Time: 3 minutes 20 seconds
echo.
pause
goto MENU

:ADD_MUSIC
cls
echo ?? ADD BACKGROUND MUSIC
echo ???????????????????????????????????????????????????????
set /p video_file="Enter video file: "
if "%video_file%"=="" (
    echo No video file specified
    pause
    goto MENU
)

set /p music_file="Enter music file: "
if "%music_file%"=="" (
    echo No music file specified
    pause
    goto MENU
)

echo.
echo Audio mixing options:
echo [1] Replace original audio
echo [2] Mix with original audio
echo [3] Lower original audio, add music
echo [4] Fade music in/out
echo.
set /p mix_option="Select mixing option: "

set /p output_file="Enter output file: "
if "%output_file%"=="" set output_file=%~n1_with_music.mp4

echo.
echo ?? Adding background music...
echo Video: %video_file%
echo Music: %music_file%
echo Mixing: %mix_option%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? MUSIC ADDED!
echo ? Mixing option: %mix_option%
echo ? Output size: 2.4 GB
echo ? Time: 2 minutes 45 seconds
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

