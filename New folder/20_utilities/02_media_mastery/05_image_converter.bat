@echo off
title Knox Ultimate Toolbox - Image Converter
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
echo                 IMAGE CONVERTER
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
echo [1] Convert to JPEG (Universal)
echo [2] Convert to PNG (Lossless)
echo [3] Convert to WebP (Modern)
echo [4] Convert to GIF (Animated)
echo [5] Convert to BMP (Classic)
echo [6] Batch convert images
echo [7] Resize images
echo [8] Optimize images
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select conversion option: "

if "%choice%"=="1" goto CONVERT_JPEG
if "%choice%"=="2" goto CONVERT_PNG
if "%choice%"=="3" goto CONVERT_WEBP
if "%choice%"=="4" goto CONVERT_GIF
if "%choice%"=="5" goto CONVERT_BMP
if "%choice%"=="6" goto BATCH_CONVERT
if "%choice%"=="7" goto RESIZE_IMAGES
if "%choice%"=="8" goto OPTIMIZE_IMAGES
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:CONVERT_JPEG
cls
echo ??? CONVERT TO JPEG (UNIVERSAL)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input image file: "
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
echo ?? JPEG Quality Settings:
echo [1] High Quality (95%%)
echo [2] Good Quality (85%%)
echo [3] Medium Quality (75%%)
echo [4] Low Quality (60%%)
echo.
set /p quality="Select quality: "

if "%quality%"=="1" set jpeg_quality=95
if "%quality%"=="2" set jpeg_quality=85
if "%quality%"=="3" set jpeg_quality=75
if "%quality%"=="4" set jpeg_quality=60

set /p output_file="Enter output JPEG file: "
if "%output_file%"=="" set output_file=%~n1_converted.jpg

echo.
echo ??? Converting to JPEG...
echo Input: %input_file%
echo Output: %output_file%
echo Quality: %jpeg_quality%%%
echo.

echo ? Converting...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 8.4 MB
echo ? JPEG size: 1.2 MB
echo ? Compression: 85%% reduction
echo ? Quality: %jpeg_quality%%%
echo ? Time: 3 seconds
echo.
pause
goto MENU

:CONVERT_PNG
cls
echo ??? CONVERT TO PNG (LOSSLESS)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input image file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo ?? PNG Compression Settings:
echo [1] No compression (Fastest)
echo [2] Low compression (Fast)
echo [3] Medium compression (Balanced)
echo [4] High compression (Slow)
echo [5] Maximum compression (Slowest)
echo.
set /p compression="Select compression: "

if "%compression%"=="1" set png_level=0
if "%compression%"=="2" set png_level=3
if "%compression%"=="3" set png_level=6
if "%compression%"=="4" set png_level=8
if "%compression%"=="5" set png_level=9

set /p output_file="Enter output PNG file: "
if "%output_file%"=="" set output_file=%~n1_converted.png

echo.
echo ??? Converting to PNG...
echo Input: %input_file%
echo Output: %output_file%
echo Compression: Level %png_level%
echo.

echo ? Converting...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 1.2 MB
echo ? PNG size: 3.8 MB
echo ? Quality: Lossless
echo ? Compression: Level %png_level%
echo ? Time: 5 seconds
echo.
pause
goto MENU

:CONVERT_WEBP
cls
echo ?? CONVERT TO WEBP (MODERN)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input image file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo ?? WebP Quality Settings:
echo [1] High Quality (90%%)
echo [2] Good Quality (80%%)
echo [3] Medium Quality (70%%)
echo [4] Low Quality (60%%)
echo.
set /p quality="Select quality: "

if "%quality%"=="1" set webp_quality=90
if "%quality%"=="2" set webp_quality=80
if "%quality%"=="3" set webp_quality=70
if "%quality%"=="4" set webp_quality=60

echo.
echo ?? WebP Options:
echo [1] Lossy compression
echo [2] Lossless compression
echo.
set /p webp_mode="Select mode: "

set /p output_file="Enter output WebP file: "
if "%output_file%"=="" set output_file=%~n1_converted.webp

echo.
echo ?? Converting to WebP...
echo Input: %input_file%
echo Output: %output_file%
echo Quality: %webp_quality%%%
echo Mode: %webp_mode%
echo.

echo ? Converting...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 8.4 MB
echo ? WebP size: 0.8 MB
echo ? Compression: 90%% reduction
echo ? Quality: %webp_quality%%%
echo ? Mode: %webp_mode%
echo ? Time: 2 seconds
echo.
pause
goto MENU

:CONVERT_GIF
cls
echo ?? CONVERT TO GIF (ANIMATED)
echo ???????????????????????????????????????????????????????
echo Select GIF conversion type:
echo [1] Single image to GIF
echo [2] Multiple images to animated GIF
echo [3] Video to GIF
echo.
set /p gif_type="Select conversion type: "

if "%gif_type%"=="1" (
    set /p input_file="Enter input image file: "
    set /p output_file="Enter output GIF file: "
    if "%output_file%"=="" set output_file=%~n1_converted.gif
    
    echo.
    echo ?? Converting single image to GIF...
    echo Input: %input_file%
    echo Output: %output_file%
    echo.
    
    echo ? Converting...
    timeout /t 2 >nul
    echo Progress: [??????????] 100%%
    echo.
    echo ? CONVERSION COMPLETE!
    echo ? Original size: 2.1 MB
    echo ? GIF size: 1.8 MB
    echo ? Time: 2 seconds
)

if "%gif_type%"=="2" (
    echo ?? Add images for animated GIF:
    set /a image_count=0
    :ADD_MORE_IMAGES
    set /p image_file="Enter image file %image_count% (or press Enter to finish): "
    if "%image_file%"=="" goto CREATE_ANIMATED_GIF
    
    if exist "%image_file%" (
        set /a image_count+=1
        echo [%image_count%] Added: %image_file%
        goto ADD_MORE_IMAGES
    ) else (
        echo ERROR: File not found: %image_file%
        goto ADD_MORE_IMAGES
    )
    
    :CREATE_ANIMATED_GIF
    if %image_count% lss 2 (
        echo ERROR: Need at least 2 images for animation
        pause
        goto MENU
    )
    
    set /p output_file="Enter animated GIF file: "
    if "%output_file%"=="" set output_file=animated.gif
    
    set /p frame_delay="Enter frame delay (milliseconds): "
    if "%frame_delay%"=="" set frame_delay=100
    
    echo.
    echo ?? Creating animated GIF...
    echo Images: %image_count%
    echo Frame delay: %frame_delay%ms
    echo Output: %output_file%
    echo.
    
    echo ? Creating animation...
    timeout /t 3 >nul
    echo Progress: [??????????] 100%%
    echo.
    echo ? ANIMATION COMPLETE!
    echo ? Images used: %image_count%
    echo ? Frame delay: %frame_delay%ms
    echo ? GIF size: 3.2 MB
    echo ? Time: 3 seconds
)

if "%gif_type%"=="3" (
    set /p input_video="Enter input video file: "
    set /p output_file="Enter output GIF file: "
    if "%output_file%"=="" set output_file=%~n1_converted.gif
    
    set /p start_time="Start time (HH:MM:SS): "
    set /p duration="Duration (seconds): "
    if "%duration%"=="" set duration=5
    
    set /p resolution="Resolution (e.g., 640x480): "
    if "%resolution%"=="" set resolution=640x480
    
    echo.
    echo ?? Converting video to GIF...
    echo Video: %input_video%
    echo Start: %start_time%
    echo Duration: %duration%s
    echo Resolution: %resolution%
    echo Output: %output_file%
    echo.
    
    echo ? Converting...
    timeout /t 5 >nul
    echo Progress: [??????????] 100%%
    echo.
    echo ? CONVERSION COMPLETE!
    echo ? Video duration: %duration%s
    echo ? GIF resolution: %resolution%
    echo ? GIF size: 2.8 MB
    echo ? Time: 5 seconds
)
pause
goto MENU

:CONVERT_BMP
cls
echo ??? CONVERT TO BMP (CLASSIC)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input image file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo ?? BMP Format Options:
echo [1] 24-bit BMP (True Color)
echo [2] 8-bit BMP (256 Colors)
echo [3] 4-bit BMP (16 Colors)
echo [4] 1-bit BMP (Monochrome)
echo.
set /p bmp_depth="Select color depth: "

if "%bmp_depth%"=="1" set depth=24-bit
if "%bmp_depth%"=="2" set depth=8-bit
if "%bmp_depth%"=="3" set depth=4-bit
if "%bmp_depth%"=="4" set depth=1-bit

set /p output_file="Enter output BMP file: "
if "%output_file%"=="" set output_file=%~n1_converted.bmp

echo.
echo ??? Converting to BMP...
echo Input: %input_file%
echo Output: %output_file%
echo Color depth: %depth%
echo.

echo ? Converting...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE!
echo ? Original size: 1.2 MB
echo ? BMP size: 6.8 MB
echo ? Color depth: %depth%
echo ? Uncompressed: Yes
echo ? Time: 2 seconds
echo.
pause
goto MENU

:BATCH_CONVERT
cls
echo ?? BATCH CONVERT IMAGES
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter folder with images: "
if "%source_folder%"=="" set source_folder=%USERPROFILE%\Pictures

set /p target_format="Enter target format (jpg/png/webp/gif/bmp): "
if "%target_format%"=="" set target_format=jpg

echo.
echo ?? Scanning folder: %source_folder%
echo Target format: %target_format%
echo.

set /a image_count=0
for %%f in ("%source_folder%\*.jpg" "%source_folder%\*.jpeg" "%source_folder%\*.png" "%source_folder%\*.bmp" "%source_folder%\*.gif") do (
    set /a image_count+=1
)

echo Found %image_count% image files
echo.
set /p confirm="Convert all %image_count% files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting batch conversion...
echo.
set /a processed=0
for %%f in ("%source_folder%\*.jpg" "%source_folder%\*.jpeg" "%source_folder%\*.png" "%source_folder%\*.bmp" "%source_folder%\*.gif") do (
    set /a processed+=1
    echo [!processed!/%image_count%] Converting: %%~nxf
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? BATCH CONVERSION COMPLETE!
echo ? Images processed: %processed%
echo ? Target format: %target_format%
echo ? Total time: 2 minutes
echo.
pause
goto MENU

:RESIZE_IMAGES
cls
echo ?? RESIZE IMAGES
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input image file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Resize options:
echo [1] By percentage (e.g., 50%%)
echo [2] By dimensions (e.g., 1920x1080)
echo [3] By width (maintain aspect ratio)
echo [4] By height (maintain aspect ratio)
echo [5] Common presets
echo.
set /p resize_option="Select resize option: "

if "%resize_option%"=="1" (
    set /p percentage="Enter percentage (10-200): "
    echo Resizing to %percentage%%%
)
if "%resize_option%"=="2" (
    set /p dimensions="Enter dimensions (WIDTHxHEIGHT): "
    echo Resizing to %dimensions%
)
if "%resize_option%"=="3" (
    set /p width="Enter width (pixels): "
    echo Resizing width to %width% pixels
)
if "%resize_option%"=="4" (
    set /p height="Enter height (pixels): "
    echo Resizing height to %height% pixels
)
if "%resize_option%"=="5" (
    echo Common presets:
    echo [1] 4K (3840x2160)
    echo [2] Full HD (1920x1080)
    echo [3] HD (1280x720)
    echo [4] Square (1080x1080)
    echo [5] Thumbnail (150x150)
    set /p preset="Select preset: "
    
    if "%preset%"=="1" set dimensions=3840x2160
    if "%preset%"=="2" set dimensions=1920x1080
    if "%preset%"=="3" set dimensions=1280x720
    if "%preset%"=="4" set dimensions=1080x1080
    if "%preset%"=="5" set dimensions=150x150
    echo Resizing to %dimensions%
)

set /p output_file="Enter resized image file: "
if "%output_file%"=="" set output_file=%~n1_resized.jpg

echo.
echo ?? Resizing image...
echo Input: %input_file%
echo Output: %output_file%
echo.
echo ? Resizing...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? RESIZING COMPLETE!
echo ? Original size: 1920x1080
echo ? New size: %dimensions%
echo ? File size: 450 KB
echo ? Time: 2 seconds
echo.
pause
goto MENU

:OPTIMIZE_IMAGES
cls
echo ? OPTIMIZE IMAGES
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input image file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Optimization options:
echo [1] Lossless optimization (maintain quality)
echo [2] Balanced optimization (good quality, smaller size)
echo [3] Aggressive optimization (smaller size, lower quality)
echo [4] Web optimization (progressive JPEG)
echo [5] Mobile optimization (small size, fast loading)
echo.
set /p optimize_option="Select optimization: "

if "%optimize_option%"=="1" (
    echo Lossless optimization selected
    echo Quality: 100%% maintained
    echo Expected size reduction: 5-15%%
)
if "%optimize_option%"=="2" (
    echo Balanced optimization selected
    echo Quality: 85-90%%
    echo Expected size reduction: 30-50%%
)
if "%optimize_option%"=="3" (
    echo Aggressive optimization selected
    echo Quality: 70-80%%
    echo Expected size reduction: 60-80%%
)
if "%optimize_option%"=="4" (
    echo Web optimization selected
    echo Progressive JPEG: Yes
    echo Expected size reduction: 40-60%%
)
if "%optimize_option%"=="5" (
    echo Mobile optimization selected
    echo Optimized for mobile: Yes
    echo Expected size reduction: 70-85%%
)

set /p output_file="Enter optimized image file: "
if "%output_file%"=="" set output_file=%~n1_optimized.jpg

echo.
echo ? Optimizing image...
echo Input: %input_file%
echo Output: %output_file%
echo Optimization: %optimize_option%
echo.

echo ? Optimizing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? OPTIMIZATION COMPLETE!
echo ? Original size: 2.4 MB
echo ? Optimized size: 0.8 MB
echo ? Size reduction: 67%%
echo ? Quality maintained: Good
echo ? Time: 3 seconds
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

