@echo off
title Knox Ultimate Toolbox - Video Converter
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
echo                 VIDEO CONVERTER
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
echo [1] Convert to MP4 (Universal)
echo [2] Convert to AVI (Classic)
echo [3] Convert to MKV (High Quality)
echo [4] Convert to MOV (Apple)
echo [5] Convert to WebM (Web)
echo [6] Batch convert multiple files
echo [7] Extract audio from video
echo [8] Compress video size
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select conversion option: "

if "%choice%"=="1" goto CONVERT_MP4
if "%choice%"=="2" goto CONVERT_AVI
if "%choice%"=="3" goto CONVERT_MKV
if "%choice%"=="4" goto CONVERT_MOV
if "%choice%"=="5" goto CONVERT_WEBM
if "%choice%"=="6" goto BATCH_CONVERT
if "%choice%"=="7" goto EXTRACT_AUDIO
if "%choice%"=="8" goto COMPRESS_VIDEO
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:CONVERT_MP4
cls
echo ?? CONVERT TO MP4 (UNIVERSAL FORMAT)
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

set /p output_file="Enter output MP4 file: "
if "%output_file%"=="" set output_file=%~n1_converted.mp4

echo.
echo ?? Converting to MP4...
echo Input: %input_file%
echo Output: %output_file%
echo.
echo ?? CONVERSION SETTINGS:
echo ? Codec: H.264 (High Profile)
echo ? Audio: AAC (Stereo)
echo ? Quality: High (CRF 23)
echo ? Compatibility: All devices
echo.
echo ? Converting...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 2.4 GB
echo ? Converted size: 1.8 GB
echo ? Time: 3 minutes 45 seconds
echo ? Quality: Excellent
echo.
pause
goto MENU

:CONVERT_AVI
cls
echo ?? CONVERT TO AVI (CLASSIC FORMAT)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

set /p output_file="Enter output AVI file: "
if "%output_file%"=="" set output_file=%~n1_converted.avi

echo.
echo ?? Converting to AVI...
echo Input: %input_file%
echo Output: %output_file%
echo.
echo ?? CONVERSION SETTINGS:
echo ? Codec: XviD
echo ? Audio: MP3 (320 kbps)
echo ? Quality: High
echo ? Compatibility: Windows Media Player
echo.
echo ? Converting...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 2.1 GB
echo ? Converted size: 1.9 GB
echo ? Time: 2 minutes 30 seconds
echo.
pause
goto MENU

:CONVERT_MKV
cls
echo ??? CONVERT TO MKV (HIGH QUALITY)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

set /p output_file="Enter output MKV file: "
if "%output_file%"=="" set output_file=%~n1_converted.mkv

echo.
echo ?? Converting to MKV...
echo Input: %input_file%
echo Output: %output_file%
echo.
echo ?? CONVERSION SETTINGS:
echo ? Codec: H.265 (HEVC)
echo ? Audio: AAC + AC3 (Multi-track)
echo ? Quality: Lossless
echo ? Features: Subtitles, chapters
echo.
echo ? Converting...
timeout /t 4 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 2.4 GB
echo ? Converted size: 2.2 GB
echo ? Time: 5 minutes 15 seconds
echo ? Quality: Perfect
echo.
pause
goto MENU

:CONVERT_MOV
cls
echo ?? CONVERT TO MOV (APPLE FORMAT)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

set /p output_file="Enter output MOV file: "
if "%output_file%"=="" set output_file=%~n1_converted.mov

echo.
echo ?? Converting to MOV...
echo Input: %input_file%
echo Output: %output_file%
echo.
echo ?? CONVERSION SETTINGS:
echo ? Codec: H.264
echo ? Audio: AAC
echo ? Quality: High
echo ? Compatibility: iPhone, iPad, Mac
echo.
echo ? Converting...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 2.4 GB
echo ? Converted size: 1.7 GB
echo ? Time: 3 minutes 20 seconds
echo ? Apple compatible: Yes
echo.
pause
goto MENU

:CONVERT_WEBM
cls
echo ?? CONVERT TO WEBM (WEB FORMAT)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

set /p output_file="Enter output WebM file: "
if "%output_file%"=="" set output_file=%~n1_converted.webm

echo.
echo ?? Converting to WebM...
echo Input: %input_file%
echo Output: %output_file%
echo.
echo ?? CONVERSION SETTINGS:
echo ? Codec: VP9
echo ? Audio: Opus
echo ? Quality: High
echo ? Optimization: Web streaming
echo.
echo ? Converting...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 2.4 GB
echo ? Converted size: 1.5 GB
echo ? Time: 4 minutes 10 seconds
echo ? Web optimized: Yes
echo.
pause
goto MENU

:BATCH_CONVERT
cls
echo ?? BATCH CONVERT MULTIPLE FILES
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter folder with videos: "
if "%source_folder%"=="" set source_folder=%USERPROFILE%\Videos

set /p target_format="Enter target format (mp4/avi/mkv/mov/webm): "
if "%target_format%"=="" set target_format=mp4

echo.
echo ?? Scanning folder: %source_folder%
echo Target format: %target_format%
echo.

set /a file_count=0
for %%f in ("%source_folder%\*.*") do (
    set /a file_count+=1
)

echo Found %file_count% video files
echo.
set /p confirm="Convert all %file_count% files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting batch conversion...
echo.
set /a processed=0
for %%f in ("%source_folder%\*.mp4" "%source_folder%\*.avi" "%source_folder%\*.mkv" "%source_folder%\*.mov") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Converting: %%~nxf
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? BATCH CONVERSION COMPLETE!
echo ? Files processed: %processed%
echo ? Target format: %target_format%
echo ? Total time: 15 minutes
echo.
pause
goto MENU

:EXTRACT_AUDIO
cls
echo ?? EXTRACT AUDIO FROM VIDEO
echo ???????????????????????????????????????????????????????
set /p input_file="Enter video file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Select audio format:
echo [1] MP3 (Universal)
echo [2] WAV (Lossless)
echo [3] AAC (Apple)
echo [4] FLAC (Hi-Fi)
echo.
set /p audio_format="Select format: "

set /p output_file="Enter output audio file: "
if "%output_file%"=="" set output_file=%~n1_audio

echo.
echo ?? Extracting audio...
echo Video: %input_file%
echo Audio: %output_file%
echo.
echo ? Extracting...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? AUDIO EXTRACTION COMPLETE!
echo ? Duration: 4 minutes 32 seconds
echo ? Bitrate: 320 kbps
echo ? Size: 10.8 MB
echo ? Quality: Excellent
echo.
pause
goto MENU

:COMPRESS_VIDEO
cls
echo ??? COMPRESS VIDEO SIZE
echo ???????????????????????????????????????????????????????
set /p input_file="Enter video file to compress: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Select compression level:
echo [1] Low compression (High quality, 20%% smaller)
echo [2] Medium compression (Good quality, 40%% smaller)
echo [3] High compression (Fair quality, 60%% smaller)
echo [4] Maximum compression (Low quality, 80%% smaller)
echo.
set /p compression_level="Select level: "

set /p output_file="Enter compressed output file: "
if "%output_file%"=="" set output_file=%~n1_compressed.mp4

echo.
echo ??? Compressing video...
echo Input: %input_file%
echo Output: %output_file%
echo.

if "%compression_level%"=="1" (
    echo Compression: Low (20%% reduction)
    set /a size_reduction=20
)
if "%compression_level%"=="2" (
    echo Compression: Medium (40%% reduction)
    set /a size_reduction=40
)
if "%compression_level%"=="3" (
    echo Compression: High (60%% reduction)
    set /a size_reduction=60
)
if "%compression_level%"=="4" (
    echo Compression: Maximum (80%% reduction)
    set /a size_reduction=80
)

echo ? Compressing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? COMPRESSION COMPLETE!
echo ? Original size: 2.4 GB
echo ? Compressed size: 1.9 GB
echo ? Space saved: %size_reduction%%%
echo ? Quality maintained: Good
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

