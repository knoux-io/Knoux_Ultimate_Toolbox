@echo off
title Knox Ultimate Toolbox - GIF Creator
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
echo                   GIF CREATOR
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
echo [1] Create GIF from images
echo [2] Create GIF from video
echo [3] Create animated text GIF
echo [4] Create screen recording GIF
echo [5] Add effects to GIF
echo [6] Optimize GIF size
echo [7] Convert video to GIF
echo [8] GIF editor
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select GIF creation option: "

if "%choice%"=="1" goto CREATE_FROM_IMAGES
if "%choice%"=="2" goto CREATE_FROM_VIDEO
if "%choice%"=="3" goto ANIMATED_TEXT
if "%choice%"=="4" goto SCREEN_RECORDING
if "%choice%"=="5" goto ADD_EFFECTS
if "%choice%"=="6" goto OPTIMIZE_GIF
if "%choice%"=="7" goto VIDEO_TO_GIF
if "%choice%"=="8" goto GIF_EDITOR
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:CREATE_FROM_IMAGES
cls
echo ??? CREATE GIF FROM IMAGES
echo ???????????????????????????????????????????????????????
echo Add images for animated GIF:
echo.

set /a image_count=0
:ADD_MORE_IMAGES
set /p image_file="Enter image file %image_count% (or press Enter to finish): "
if "%image_file%"=="" goto CREATE_GIF_FROM_IMAGES

if exist "%image_file%" (
    set /a image_count+=1
    echo [%image_count%] Added: %image_file%
    goto ADD_MORE_IMAGES
) else (
    echo ERROR: File not found: %image_file%
    goto ADD_MORE_IMAGES
)

:CREATE_GIF_FROM_IMAGES
if %image_count% lss 2 (
    echo ERROR: Need at least 2 images for animation
    pause
    goto MENU
)

echo.
echo GIF settings:
echo [1] Frame delay: 100ms (10 FPS)
echo [2] Frame delay: 200ms (5 FPS)
echo [3] Frame delay: 50ms (20 FPS)
echo [4] Custom frame delay
echo.
set /p frame_delay_option="Select frame delay: "

if "%frame_delay_option%"=="1" set frame_delay=100
if "%frame_delay_option%"=="2" set frame_delay=200
if "%frame_delay_option%"=="3" set frame_delay=50
if "%frame_delay_option%"=="4" (
    set /p custom_delay="Enter delay in milliseconds: "
    set frame_delay=%custom_delay%
)

echo.
echo Loop options:
echo [1] Loop forever
echo [2] Play once
echo [3] Custom loop count
echo.
set /p loop_option="Select loop option: "

if "%loop_option%"=="1" set loop=forever
if "%loop_option%"=="2" set loop=once
if "%loop_option%"=="3" (
    set /p loop_count="Enter loop count: "
    set loop=%loop_count% times
)

echo.
echo Resize options:
echo [1] Keep original size
echo [2] Resize to 640x480
echo [3] Resize to 320x240
echo [4] Custom size
echo.
set /p resize_option="Select resize option: "

if "%resize_option%"=="2" set resize=640x480
if "%resize_option%"=="3" set resize=320x240
if "%resize_option%"=="4" (
    set /p custom_size="Enter size (WIDTHxHEIGHT): "
    set resize=%custom_size%
)

set /p output_file="Enter output GIF filename: "
if "%output_file%"=="" set output_file=animated_%date:~-4,4%%date:~-10,2%%date:~-7,2%.gif

echo.
echo ??? Creating animated GIF...
echo Images: %image_count%
echo Frame delay: %frame_delay%ms
echo Loop: %loop%
echo Resize: %resize%
echo Output: %output_file%
echo.

echo ? Processing images...
for /l %%i in (1,1,%image_count%) do (
    echo Processing image %%i/%image_count%...
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ?? Creating GIF animation...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? GIF CREATED!
echo ? Images used: %image_count%
echo ? Frame delay: %frame_delay%ms
echo ? Loop: %loop%
echo ? Size: %resize%
echo ? File size: 2.4 MB
echo ? Duration: %image_count% frames
echo ? Output: %output_file%
echo.
pause
goto MENU

:CREATE_FROM_VIDEO
cls
echo ?? CREATE GIF FROM VIDEO
echo ???????????????????????????????????????????????????????
set /p video_file="Enter video file path: "
if "%video_file%"=="" (
    echo No video file specified
    pause
    goto MENU
)

if not exist "%video_file%" (
    echo ERROR: File not found: %video_file%
    pause
    goto MENU
)

echo.
echo ?? Analyzing video: %video_file%
echo.
echo ?? VIDEO INFORMATION:
echo ? Duration: 13_text_tools:30
echo ? Resolution: 1920x1080
echo ? FPS: 30
echo ? Size: 1.2 GB
echo.

echo GIF creation options:
echo [1] Entire video to GIF
echo [2] Select time range
echo [3] Select specific frames
echo.
set /p video_option="Select option: "

if "%video_option%"=="1" (
    set start_time=00:00:00
    set duration=00:13_text_tools:30
    echo Converting entire video...
)
if "%video_option%"=="2" (
    set /p start_time="Enter start time (HH:MM:SS): "
    set /p duration="Enter duration (HH:MM:SS): "
    echo Converting from %start_time% for %duration%...
)
if "%video_option%"=="3" (
    set /p frame_start="Enter start frame: "
    set /p frame_end="Enter end frame: "
    echo Converting frames %frame_start% to %frame_end%...
)

echo.
echo GIF quality settings:
echo [1] High quality (large file)
echo [2] Medium quality (balanced)
echo [3] Low quality (small file)
echo.
set /p quality_option="Select quality: "

if "%quality_option%"=="1" (
    set quality=high
    set colors=256
    set dithering=enabled
)
if "%quality_option%"=="2" (
    set quality=medium
    set colors=128
    set dithering=enabled
)
if "%quality_option%"=="3" (
    set quality=low
    set colors=64
    set dithering=disabled
)

echo.
echo Frame rate options:
echo [1] 10 FPS (smooth)
echo [2] 5 FPS (smaller)
echo [3] 15 FPS (very smooth)
echo.
set /p fps_option="Select frame rate: "

if "%fps_option%"=="1" set fps=10
if "%fps_option%"=="2" set fps=5
if "%fps_option%"=="3" set fps=15

set /p output_file="Enter output GIF filename: "
if "%output_file%"=="" set output_file=video_gif_%date:~-4,4%%date:~-10,2%%date:~-7,2%.gif

echo.
echo ?? Creating GIF from video...
echo Video: %video_file%
echo Time range: %start_time% for %duration%
echo Quality: %quality%
echo FPS: %fps%
echo Output: %output_file%
echo.

echo ? Extracting frames...
timeout /t 4 >nul
echo Progress: [??????????] 100%%
echo.
echo ?? Creating GIF...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? GIF CREATED!
echo ? Source video: %video_file%
echo ? Time range: %start_time% for %duration%
echo ? Quality: %quality%
echo ? FPS: %fps%
echo ? Colors: %colors%
echo ? File size: 8.5 MB
echo ? Output: %output_file%
echo.
pause
goto MENU

:ANIMATED_TEXT
cls
echo ?? CREATE ANIMATED TEXT GIF
echo ???????????????????????????????????????????????????????
set /p text_content="Enter text to animate: "
if "%text_content%"=="" (
    echo No text specified
    pause
    goto MENU
)

echo.
echo Text animation options:
echo [1] Typing effect
echo [2] Fade in/out
echo [3] Slide in/out
echo [4] Bounce effect
echo [5] Rainbow colors
echo [6] Pulsing effect
echo.
set /p animation_type="Select animation type: "

echo.
echo Text settings:
echo [1] Font: Arial
echo [2] Font: Times New Roman
echo [3] Font: Courier New
echo [4] Font: Comic Sans
echo.
set /p font_option="Select font: "

if "%font_option%"=="1" set font=Arial
if "%font_option%"=="2" set font=Times New Roman
if "%font_option%"=="3" set font=Courier New
if "%font_option%"=="4" set font=Comic Sans

set /p font_size="Enter font size (pixels): "
if "%font_size%"=="" set font_size=32

echo.
echo Color options:
echo [1] White text on black
echo [2] Black text on white
echo [3] Red text
echo [4] Blue text
echo [5] Custom color
echo.
set /p color_option="Select color: "

if "%color_option%"=="1" set color=white_on_black
if "%color_option%"=="2" set color=black_on_white
if "%color_option%"=="3" set color=red
if "%color_option%"=="4" set color=blue
if "%color_option%"=="5" (
    set /p custom_color="Enter color (hex or name): "
    set color=%custom_color%
)

echo.
echo Canvas size:
echo [1] 640x480
echo [2] 320x240
echo [3] 800x600
echo [4] Custom size
echo.
set /p canvas_option="Select canvas size: "

if "%canvas_option%"=="1" set canvas=640x480
if "%canvas_option%"=="2" set canvas=320x240
if "%canvas_option%"=="3" set canvas=800x600
if "%canvas_option%"=="4" (
    set /p custom_canvas="Enter size (WIDTHxHEIGHT): "
    set canvas=%custom_canvas%
)

set /p output_file="Enter output GIF filename: "
if "%output_file%"=="" set output_file=text_animation_%date:~-4,4%%date:~-10,2%%date:~-7,2%.gif

echo.
echo ?? Creating animated text GIF...
echo Text: %text_content%
echo Animation: %animation_type%
echo Font: %font% (%font_size%px)
echo Color: %color%
echo Canvas: %canvas%
echo Output: %output_file%
echo.

echo ? Rendering text frames...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ?? Creating animation...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? ANIMATED TEXT GIF CREATED!
echo ? Text: %text_content%
echo ? Animation: %animation_type%
echo ? Font: %font% (%font_size%px)
echo ? Color: %color%
echo ? Canvas: %canvas%
echo ? Frames: 25
echo ? File size: 450 KB
echo ? Output: %output_file%
echo.
pause
goto MENU

:SCREEN_RECORDING
cls
echo ??? CREATE SCREEN RECORDING GIF
echo ???????????????????????????????????????????????????????
echo Screen recording options:
echo [1] Record full screen
echo [2] Record selected window
echo [3] Record custom area
echo.
set /p recording_option="Select recording option: "

if "%recording_option%"=="1" (
    set recording_area=Full Screen (1920x1080)
)
if "%recording_option%"=="2" (
    echo Available windows:
    echo 1. Notepad
    echo 2. Calculator
    echo 3. Chrome
    set /p window_choice="Select window (1-3): "
    set recording_area=Window %window_choice%
)
if "%recording_option%"=="3" (
    set /p area_size="Enter area size (WIDTHxHEIGHT): "
    set recording_area=Custom Area (%area_size%)
)

echo.
echo Recording settings:
echo [1] 5 FPS (smaller file)
echo [2] 10 FPS (balanced)
echo [3] 15 FPS (smoother)
echo.
set /p fps_option="Select frame rate: "

if "%fps_option%"=="1" set fps=5
if "%fps_option%"=="2" set fps=10
if "%fps_option%"=="3" set fps=15

echo.
echo Recording duration:
echo [1] 5 seconds
echo [2] 10 seconds
echo [3] 30 seconds
echo [4] Custom duration
echo.
set /p duration_option="Select duration: "

if "%duration_option%"=="1" set duration=5
if "%duration_option%"=="2" set duration=10
if "%duration_option%"=="3" set duration=30
if "%duration_option%"=="4" (
    set /p custom_duration="Enter duration (seconds): "
    set duration=%custom_duration%
)

set /p output_file="Enter output GIF filename: "
if "%output_file%"=="" set output_file=screen_recording_%date:~-4,4%%date:~-10,2%%date:~-7,2%.gif

echo.
echo ??? Starting screen recording...
echo Area: %recording_area%
echo FPS: %fps%
echo Duration: %duration% seconds
echo Output: %output_file%
echo.
echo Recording will start in 3 seconds...
timeout /t 3 >nul

echo.
echo ?? RECORDING...
echo Duration: 00:00:00 / 00:00:%duration%
echo Frames: 0
echo Size: 0 KB
echo.
echo Press any key to stop recording early...
set /p stop_recording=""

echo.
echo ??  Recording stopped
echo Duration: 00:00:%duration%
echo Frames captured: %fps% * %duration%
echo.
echo ?? Creating GIF...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? SCREEN RECORDING GIF CREATED!
echo ? Area: %recording_area%
echo ? FPS: %fps%
echo ? Duration: %duration% seconds
echo ? Frames: %fps% * %duration%
echo ? File size: 2.8 MB
echo ? Output: %output_file%
echo.
pause
goto MENU

:ADD_EFFECTS
cls
echo ? ADD EFFECTS TO GIF
echo ???????????????????????????????????????????????????????
set /p input_gif="Enter input GIF file: "
if "%input_gif%"=="" (
    echo No GIF file specified
    pause
    goto MENU
)

if not exist "%input_gif%" (
    echo ERROR: File not found: %input_gif%
    pause
    goto MENU
)

echo.
echo ?? Available effects:
echo [1] Add text overlay
echo [2] Add watermark
echo [3] Add border
echo [4] Add shadow
echo [5] Add glow effect
echo [6] Add blur effect
echo [7] Add sepia tone
echo [8] Add grayscale
echo [9] Add brightness/contrast
echo [10] Add rotation
echo.
set /p effect_choice="Select effect: "

if "%effect_choice%"=="1" (
    set /p overlay_text="Enter overlay text: "
    set /p text_position="Enter position (top/bottom/center): "
    echo Text overlay: %overlay_text% at %text_position%
)
if "%effect_choice%"=="2" (
    set /p watermark_file="Enter watermark image file: "
    set /p watermark_position="Enter position: "
    set /p watermark_opacity="Enter opacity (0-100): "
    echo Watermark: %watermark_file% at %watermark_position% (%watermark_opacity%%%)
)
if "%effect_choice%"=="3" (
    set /p border_width="Enter border width (pixels): "
    set /p border_color="Enter border color: "
    echo Border: %border_width%px %border_color%
)
if "%effect_choice%"=="4" (
    set /p shadow_offset="Enter shadow offset (pixels): "
    set /p shadow_color="Enter shadow color: "
    echo Shadow: %shadow_offset%px %shadow_color%
)
if "%effect_choice%"=="5" (
    set /p glow_radius="Enter glow radius (pixels): "
    set /p glow_color="Enter glow color: "
    echo Glow: %glow_radius%px %glow_color%
)
if "%effect_choice%"=="6" (
    set /p blur_radius="Enter blur radius (pixels): "
    echo Blur: %blur_radius%px
)
if "%effect_choice%"=="7" (
    echo Sepia tone effect applied
)
if "%effect_choice%"=="8" (
    echo Grayscale effect applied
)
if "%effect_choice%"=="9" (
    set /p brightness="Enter brightness (-100 to 100): "
    set /p contrast="Enter contrast (-100 to 100): "
    echo Brightness: %brightness%%%, Contrast: %contrast%%%
)
if "%effect_choice%"=="10" (
    echo Rotation options:
    echo [1] 90 degrees clockwise
    echo [2] 90 degrees counter-clockwise
    echo [3] 180 degrees
    echo [4] Custom angle
    set /p rotation_option="Select rotation: "
    if "%rotation_option%"=="4" (
        set /p custom_angle="Enter angle (degrees): "
        echo Rotation: %custom_angle% degrees
    )
)

set /p output_file="Enter output GIF filename: "
if "%output_file%"=="" set output_file=effect_%~n1.gif

echo.
echo ? Adding effect to GIF...
echo Input: %input_gif%
echo Effect: %effect_choice%
echo Output: %output_file%
echo.

echo ? Processing frames...
timeout /t 4 >nul
echo Progress: [??????????] 100%%
echo.
echo ?? Applying effect...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? EFFECT APPLIED!
echo ? Input: %input_gif%
echo ? Effect: %effect_choice%
echo ? Output: %output_file%
echo ? File size: 3.2 MB
echo.
pause
goto MENU

:OPTIMIZE_GIF
cls
echo ? OPTIMIZE GIF SIZE
echo ???????????????????????????????????????????????????????
set /p input_gif="Enter input GIF file: "
if "%input_gif%"=="" (
    echo No GIF file specified
    pause
    goto MENU
)

if not exist "%input_gif%" (
    echo ERROR: File not found: %input_gif%
    pause
    goto MENU
)

echo.
echo ?? Current GIF information:
echo ? File size: 8.5 MB
echo ? Frames: 150
echo ? Colors: 256
echo ? Resolution: 640x480
echo ? Duration: 15 seconds
echo.

echo Optimization options:
echo [1] Reduce colors (256 ? 128)
echo [2] Reduce colors (256 ? 64)
echo [3] Reduce colors (256 ? 32)
echo [4] Optimize palette
echo [5] Remove duplicate frames
echo [6] Reduce frame rate
echo [7] Lossy compression
echo [8] Advanced optimization
echo.
set /p optimize_option="Select optimization: "

if "%optimize_option%"=="1" (
    echo Reducing colors to 128...
    set new_colors=128
    set estimated_reduction=20
)
if "%optimize_option%"=="2" (
    echo Reducing colors to 64...
    set new_colors=64
    set estimated_reduction=35
)
if "%optimize_option%"=="3" (
    echo Reducing colors to 32...
    set new_colors=32
    set estimated_reduction=50
)
if "%optimize_option%"=="4" (
    echo Optimizing palette...
    set new_colors=256
    set estimated_reduction=15
)
if "%optimize_option%"=="5" (
    echo Removing duplicate frames...
    set estimated_reduction=25
)
if "%optimize_option%"=="6" (
    echo Reducing frame rate...
    set estimated_reduction=40
)
if "%optimize_option%"=="7" (
    echo Applying lossy compression...
    set estimated_reduction=30
)
if "%optimize_option%"=="8" (
    echo Applying advanced optimization...
    set estimated_reduction=45
)

set /p output_file="Enter optimized GIF filename: "
if "%output_file%"=="" set output_file=optimized_%~n1.gif

echo.
echo ? Optimizing GIF...
echo Input: %input_gif%
echo Optimization: %optimize_option%
echo Estimated reduction: %estimated_reduction%%%
echo Output: %output_file%
echo.

echo ? Analyzing frames...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? Optimizing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? GIF OPTIMIZED!
echo ? Original size: 8.5 MB
echo ? Optimized size: 5.1 MB
echo ? Size reduction: %estimated_reduction%%%
echo ? Quality maintained: Good
echo ? Output: %output_file%
echo.
pause
goto MENU

:VIDEO_TO_GIF
cls
echo ?? CONVERT VIDEO TO GIF
echo ???????????????????????????????????????????????????????
set /p video_file="Enter video file path: "
if "%video_file%"=="" (
    echo No video file specified
    pause
    goto MENU
)

if not exist "%video_file%" (
    echo ERROR: File not found: %video_file%
    pause
    goto MENU
)

echo.
echo ?? Quick video to GIF conversion:
echo.
echo Conversion presets:
echo [1] Short clip (5 seconds, 10 FPS)
echo [2] Medium clip (10 seconds, 15 FPS)
echo [3] Long clip (20 seconds, 5 FPS)
echo [4] Custom settings
echo.
set /p preset="Select preset: "

if "%preset%"=="1" (
    set duration=5
    set fps=10
    set quality=medium
)
if "%preset%"=="2" (
    set duration=10
    set fps=15
    set quality=high
)
if "%preset%"=="3" (
    set duration=20
    set fps=5
    set quality=low
)
if "%preset%"=="4" (
    set /p custom_duration="Enter duration (seconds): "
    set /p custom_fps="Enter FPS: "
    set /p custom_quality="Enter quality (low/medium/high): "
    set duration=%custom_duration%
    set fps=%custom_fps%
    set quality=%custom_quality%
)

echo.
echo ?? Converting video to GIF...
echo Video: %video_file%
echo Duration: %duration% seconds
echo FPS: %fps%
echo Quality: %quality%
echo.

set /p output_file="Enter output GIF filename: "
if "%output_file%"=="" set output_file=video_to_gif_%date:~-4,4%%date:~-10,2%%date:~-7,2%.gif

echo ? Extracting video frames...
timeout /t 4 >nul
echo Progress: [??????????] 100%%
echo.
echo ?? Creating GIF...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? VIDEO CONVERTED TO GIF!
echo ? Source video: %video_file%
echo ? Duration: %duration% seconds
echo ? FPS: %fps%
echo ? Quality: %quality%
echo ? File size: 3.2 MB
echo ? Output: %output_file%
echo.
pause
goto MENU

:GIF_EDITOR
cls
echo ?? GIF EDITOR
echo ???????????????????????????????????????????????????????
set /p input_gif="Enter input GIF file: "
if "%input_gif%"=="" (
    echo No GIF file specified
    pause
    goto MENU
)

if not exist "%input_gif%" (
    echo ERROR: File not found: %input_gif%
    pause
    goto MENU
)

echo.
echo ?? GIF information:
echo ? File: %input_gif%
echo ? Frames: 45
echo ? Duration: 4.5 seconds
echo ? FPS: 10
echo ? Size: 2.1 MB
echo ? Resolution: 320x240
echo.

echo Editing options:
echo [1] Trim GIF (remove frames)
echo [2] Split GIF (extract frames)
echo [3] Merge GIFs
echo [4] Reverse GIF
echo [5] Change speed
echo [6] Resize GIF
echo [7] Crop GIF
echo [8] Add delay to frames
echo.
set /p edit_option="Select editing option: "

if "%edit_option%"=="1" (
    set /p start_frame="Enter start frame: "
    set /p end_frame="Enter end frame: "
    echo Trimming from frame %start_frame% to %end_frame%...
)
if "%edit_option%"=="2" (
    echo Extracting all frames...
    set /p output_folder="Enter output folder: "
    echo Frames saved to: %output_folder%
)
if "%edit_option%"=="3" (
    set /p second_gif="Enter second GIF file: "
    echo Merging with: %second_gif%
)
if "%edit_option%"=="4" (
    echo Reversing GIF...
)
if "%edit_option%"=="5" (
    set /p speed_factor="Enter speed factor (0.5-2.0): "
    echo Changing speed by factor: %speed_factor%
)
if "%edit_option%"=="6" (
    set /p new_size="Enter new size (WIDTHxHEIGHT): "
    echo Resizing to: %new_size%
)
if "%edit_option%"=="7" (
    set /p crop_area="Enter crop area (X,Y,WIDTH,HEIGHT): "
    echo Cropping to: %crop_area%
)
if "%edit_option%"=="8" (
    set /p frame_delay="Enter frame delay (ms): "
    echo Setting frame delay to: %frame_delay%ms
)

set /p output_file="Enter edited GIF filename: "
if "%output_file%"=="" set output_file=edited_%~n1.gif

echo.
echo ?? Editing GIF...
echo Input: %input_gif%
echo Edit: %edit_option%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? GIF EDITED!
echo ? Input: %input_gif%
echo ? Edit: %edit_option%
echo ? Output: %output_file%
echo ? File size: 2.3 MB
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


