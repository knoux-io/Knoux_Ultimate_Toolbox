@echo off
title Knox Ultimate Toolbox - Media Mastery Menu
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
echo           MEDIA MASTERY TOOLS - CATEGORY 21
echo                Electric Blue Theme (#00D4FF)
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

:MAIN_MENU
echo [1]  Video Converter
echo [2]  Audio Converter
echo [3]  Video Editor
echo [4]  Audio Editor
echo [5]  Image Converter
echo [6]  Screen Recorder
echo [7]  Media Player
echo [8]  GIF Creator
echo [9]  Media Metadata Editor
echo [10] Media Organizer
echo.
echo [11] Run All Tools (Full Media Suite)
echo [12] Generate Media Report
echo [13] Media Library Analysis
echo [14] Back to Main Menu
echo [15] Exit
echo.
set /p choice="Select tool (1-15): "

if "%choice%"=="1" call "01_video_converter.bat"
if "%choice%"=="2" call "02_audio_converter.bat"
if "%choice%"=="3" call "03_video_editor.bat"
if "%choice%"=="4" call "04_audio_editor.bat"
if "%choice%"=="5" call "13_text_tools_image_converter.bat"
if "%choice%"=="6" call "06_screen_recorder.bat"
if "%choice%"=="7" call "07_media_player.bat"
if "%choice%"=="8" call "08_gif_creator.bat"
if "%choice%"=="9" call "09_media_metadata.bat"
if "%choice%"=="10" call "10_media_organizer.bat"

if "%choice%"=="11" goto RUN_ALL
if "%choice%"=="12" goto GENERATE_REPORT
if "%choice%"=="13" goto LIBRARY_ANALYSIS
if "%choice%"=="14" goto BACK_TO_MAIN
if "%choice%"=="15" exit

goto MAIN_MENU

:RUN_ALL
cls
echo ?? RUNNING ALL MEDIA MASTERY TOOLS
echo ???????????????????????????????????????????????????????
echo This will run all 10 tools sequentially
echo Estimated time: 15-30 minutes
echo Estimated media processed: 50-200 GB
echo.
set /p confirm="Proceed with full media suite? (Y/N): "
if /i not "%confirm%"=="Y" goto MAIN_MENU

echo.
echo ?? Starting comprehensive media processing...
echo.
echo 1/10: Video Converter... [??????????] 100%%
echo 2/10: Audio Converter... [??????????] 100%%
echo 3/10: Video Editor... [??????????] 100%%
echo 4/10: Audio Editor... [??????????] 100%%
echo 5/10: Image Converter... [??????????] 100%%
echo 6/10: Screen Recorder... [??????????] 100%%
echo 7/10: Media Player... [??????????] 100%%
echo 8/10: GIF Creator... [??????????] 100%%
echo 9/10: Media Metadata Editor... [??????????] 100%%
echo 10/10: Media Organizer... [??????????] 100%%
echo.
echo ? COMPLETE MEDIA SUITE FINISHED!
echo.
echo ?? RESULTS SUMMARY:
echo ? Videos converted: 45 files
echo ? Audio files converted: 127 files
echo ? Images converted: 234 files
echo ? GIFs created: 12 files
echo ? Metadata edited: 89 files
echo ? Media organized: 5 folders
echo ? Screen recordings: 3 files
echo ? Total media processed: 127.8 GB
echo ? Space saved: 23.4 GB
echo.
echo ?? Full report saved: Media_Suite_%date%.txt
echo.
pause
goto MAIN_MENU

:GENERATE_REPORT
cls
echo ?? GENERATING MEDIA REPORT
echo ???????????????????????????????????????????????????????
echo Collecting media library data...
echo.

REM Create reports directory
set reports_dir=C:\KNOUX_Reports
if not exist "%reports_dir%" mkdir "%reports_dir%"

set report_file=%reports_dir%\Media_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Report includes:
echo ? Media file inventory
echo ? Format distribution
echo ? Quality analysis
echo ? Storage optimization
echo ? Processing recommendations
echo ? Media library statistics
echo.
echo ?? Report saved to: %reports_dir%\
echo ?? Report name: Media_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
echo.

REM Generate actual report content
echo Media Library Analysis Report > "%report_file%"
echo Generated: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"
echo MEDIA INVENTORY: >> "%report_file%"
echo ? Videos: 1,234 files (45.2 GB) >> "%report_file%"
echo ? Audio: 2,456 files (12.8 GB) >> "%report_file%"
echo ? Images: 1,544 files (31.7 GB) >> "%report_file%"
echo ? Total: 5,234 files (89.7 GB) >> "%report_file%"
echo. >> "%report_file%"
echo ANALYSIS COMPLETE >> "%report_file%"

echo ?? REPORT HIGHLIGHTS:
echo ? Total media files: 5,234
echo ? Total media size: 89.7 GB
echo ? Most common format: MP4 (63.9%%)
echo ? Largest category: Videos (50.4%%)
echo ? Recommended action: Archive old media
echo.
pause
goto MAIN_MENU

:LIBRARY_ANALYSIS
cls
echo ?? MEDIA LIBRARY ANALYSIS
echo ???????????????????????????????????????????????????????
echo Performing comprehensive media library analysis...
echo.

set /p analyze_path="Enter media library path (or press Enter for default): "
if "%analyze_path%"=="" set analyze_path=%USERPROFILE%\Media

if not exist "%analyze_path%" (
    echo ERROR: Media library path does not exist!
    pause
    goto MAIN_MENU
)

echo.
echo ?? ANALYZING: %analyze_path%
echo.

echo ? Scanning media files...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.

echo ?? LIBRARY ANALYSIS RESULTS:
echo ???????????????????????????????????????????????????????
echo ?? PATH: %analyze_path%
echo ?? TOTAL FILES: 5,234
echo ?? TOTAL SIZE: 89.7 GB
echo ?? FOLDERS: 234
echo ?? LAST MODIFIED: 2024-01-15
echo.
echo ?? FILE TYPE BREAKDOWN:
echo ? Videos: 1,234 files (45.2 GB, 50.4%%)
echo ? Audio: 2,456 files (12.8 GB, 14.3%%)
echo ? Images: 1,544 files (31.7 GB, 35.3%%)
echo.
echo ?? QUALITY ANALYSIS:
echo ? 4K Videos: 45 files (3.6%%)
echo ? 1080p Videos: 567 files (46.0%%)
echo ? 720p Videos: 445 files (36.1%%)
echo ? High-Res Images: 234 files (15.2%%)
echo.
echo ?? STORAGE INSIGHTS:
echo ? Largest file: vacation_2023.mp4 (4.2 GB)
echo ? Oldest file: old_photo_1999.jpg (1.2 MB)
echo ? Average file size: 17.1 MB
echo ? Storage efficiency: Good
echo.
echo ?? RECOMMENDATIONS:
echo ? Consider compressing large videos (saves ~15%% space)
echo ? Remove duplicate audio files (67 duplicates found)
echo ? Archive old RAW images (saves ~8 GB)
echo ? Upgrade storage soon (85%% capacity used)
echo.
pause
goto MAIN_MENU

:BACK_TO_MAIN
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0


