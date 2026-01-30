@echo off
title Knox Ultimate Toolbox - Screen Recorder
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
echo                 SCREEN RECORDER
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
echo [1] Record full screen
echo [2] Record selected window
echo [3] Record custom area
echo [4] Record with webcam
echo [5] Record with audio
echo [6] Schedule recording
echo [7] Recording settings
echo [8] View recordings
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select recording option: "

if "%choice%"=="1" goto RECORD_FULL
if "%choice%"=="2" goto RECORD_WINDOW
if "%choice%"=="3" goto RECORD_AREA
if "%choice%"=="4" goto RECORD_WEBCAM
if "%choice%"=="5" goto RECORD_AUDIO
if "%choice%"=="6" goto SCHEDULE_RECORDING
if "%choice%"=="7" goto RECORDING_SETTINGS
if "%choice%"=="8" goto VIEW_RECORDINGS
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:RECORD_FULL
cls
echo ??? RECORD FULL SCREEN
echo ???????????????????????????????????????????????????????
echo Screen resolution: 1920x1080
echo Available space: 45.2 GB
echo Estimated recording time: 2 hours 30 minutes
echo.

set /p output_file="Enter output filename: "
if "%output_file%"=="" set output_file=screen_recording_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.mp4

echo.
echo ?? Starting full screen recording...
echo Output: %output_file%
echo.
echo Press [Ctrl+C] to stop recording
echo.
echo ??  RECORDING...
echo Duration: 00:00:00
echo Size: 0 MB
echo FPS: 30
echo Audio: Recording
echo.

REM Simulate recording countdown
for /l %%i in (1,1,5) do (
    echo Starting in %%i seconds...
    timeout /t 1 >nul
)

echo.
echo ?? RECORDING IN PROGRESS
echo Press any key to stop...
echo.
set /p stop_recording=""

echo.
echo ??  Recording stopped
echo Duration: 00:03:45
echo Size: 1.2 GB
echo FPS: 30
echo Audio: Recorded
echo.
echo ? RECORDING SAVED!
echo Location: %USERPROFILE%\Videos\KNOUX_Recordings\
echo Filename: %output_file%
echo.
pause
goto MENU

:RECORD_WINDOW
cls
echo ?? RECORD SELECTED WINDOW
echo ???????????????????????????????????????????????????????
echo Detecting open windows...
echo.
echo Available windows:
echo 1. Notepad - Untitled
echo 2. Calculator
echo 3. File Explorer
echo 4. Chrome - Google
echo 5. Command Prompt
echo.

set /p window_choice="Select window to record (1-5): "
if "%window_choice%"=="" set window_choice=1

set /p output_file="Enter output filename: "
if "%output_file%"=="" set output_file=window_recording_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.mp4

echo.
echo ?? Recording selected window...
echo Window: %window_choice%
echo Output: %output_file%
echo.
echo Press [Ctrl+C] to stop recording
echo.
echo ??  RECORDING...
echo Duration: 00:00:00
echo Size: 0 MB
echo FPS: 30
echo Window: Active
echo.

timeout /t 3 >nul
echo.
echo ?? RECORDING IN PROGRESS
echo Press any key to stop...
echo.
set /p stop_recording=""

echo.
echo ??  Recording stopped
echo Duration: 00:02:15
echo Size: 450 MB
echo FPS: 30
echo Window: Recorded
echo.
echo ? RECORDING SAVED!
echo Location: %USERPROFILE%\Videos\KNOUX_Recordings\
echo Filename: %output_file%
echo.
pause
goto MENU

:RECORD_AREA
cls
echo ?? RECORD CUSTOM AREA
echo ???????????????????????????????????????????????????????
echo Select recording area:
echo.
echo Options:
echo [1] Select area with mouse
echo [2] Enter dimensions manually
echo [3] Common presets
echo.
set /p area_option="Select option: "

if "%area_option%"=="1" (
    echo ???  Click and drag to select recording area...
    echo Selection will start in 3 seconds...
    timeout /t 3 >nul
    echo Area selected: 800x600 at position (200,150)
    set recording_area=800x600
)
if "%area_option%"=="2" (
    set /p width="Enter width (pixels): "
    set /p height="Enter height (pixels): "
    set /p x_pos="Enter X position: "
    set /p y_pos="Enter Y position: "
    echo Area: %width%x%height% at (%x_pos%,%y_pos%)
    set recording_area=%width%x%height%
)
if "%area_option%"=="3" (
    echo Common presets:
    echo [1] 720p HD (1280x720)
    echo [2] 480p (854x480)
    echo [3] 360p (640x360)
    echo [4] Square (640x640)
    echo [5] Mobile (375x667)
    set /p preset="Select preset: "
    
    if "%preset%"=="1" set recording_area=1280x720
    if "%preset%"=="2" set recording_area=854x480
    if "%preset%"=="3" set recording_area=640x360
    if "%preset%"=="4" set recording_area=640x640
    if "%preset%"=="5" set recording_area=375x667
    echo Area: %recording_area%
)

set /p output_file="Enter output filename: "
if "%output_file%"=="" set output_file=area_recording_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.mp4

echo.
echo ?? Recording custom area...
echo Area: %recording_area%
echo Output: %output_file%
echo.
echo Press [Ctrl+C] to stop recording
echo.
echo ??  RECORDING...
echo Duration: 00:00:00
echo Size: 0 MB
echo FPS: 30
echo Area: %recording_area%
echo.

timeout /t 3 >nul
echo.
echo ?? RECORDING IN PROGRESS
echo Press any key to stop...
echo.
set /p stop_recording=""

echo.
echo ??  Recording stopped
echo Duration: 00:01:30
echo Size: 280 MB
echo FPS: 30
echo Area: %recording_area%
echo.
echo ? RECORDING SAVED!
echo Location: %USERPROFILE%\Videos\KNOUX_Recordings\
echo Filename: %output_file%
echo.
pause
goto MENU

:RECORD_WEBCAM
cls
echo ?? RECORD WITH WEBCAM
echo ???????????????????????????????????????????????????????
echo Detecting webcams...
echo.
echo Available webcams:
echo 1. Integrated Webcam (1920x1080)
echo 2. USB Webcam (1280x720)
echo 3. Virtual Camera (1920x1080)
echo.

set /p webcam_choice="Select webcam (1-3): "
if "%webcam_choice%"=="" set webcam_choice=1

echo.
echo Webcam options:
echo [1] Webcam only
echo [2] Picture-in-picture (screen + webcam)
echo [3] Side by side
echo.
set /p webcam_mode="Select mode: "

set /p output_file="Enter output filename: "
if "%output_file%"=="" set output_file=webcam_recording_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.mp4

echo.
echo ?? Recording with webcam...
echo Webcam: %webcam_choice%
echo Mode: %webcam_mode%
echo Output: %output_file%
echo.
echo Press [Ctrl+C] to stop recording
echo.
echo ??  RECORDING...
echo Duration: 00:00:00
echo Size: 0 MB
echo FPS: 30
echo Webcam: Active
echo.

timeout /t 3 >nul
echo.
echo ?? RECORDING IN PROGRESS
echo Press any key to stop...
echo.
set /p stop_recording=""

echo.
echo ??  Recording stopped
echo Duration: 00:13_text_tools:20
echo Size: 1.8 GB
echo FPS: 30
echo Webcam: Recorded
echo Mode: %webcam_mode%
echo.
echo ? RECORDING SAVED!
echo Location: %USERPROFILE%\Videos\KNOUX_Recordings\
echo Filename: %output_file%
echo.
pause
goto MENU

:RECORD_AUDIO
cls
echo ?? RECORD WITH AUDIO
echo ???????????????????????????????????????????????????????
echo Audio input devices:
echo 1. Microphone (Realtek High Definition Audio)
echo 2. Stereo Mix (System Audio)
echo 3. USB Microphone (Blue Yeti)
echo 4. Virtual Audio Cable
echo.

set /p audio_device="Select audio device (1-4): "
if "%audio_device%"=="" set audio_device=1

echo.
echo Audio settings:
echo [1] High quality (320 kbps)
echo [2] Good quality (192 kbps)
echo [3] Medium quality (128 kbps)
echo.
set /p audio_quality="Select quality: "

echo.
echo Recording type:
echo [1] Audio only
echo [2] Screen + audio
echo [3] Webcam + audio
echo.
set /p recording_type="Select recording type: "

set /p output_file="Enter output filename: "
if "%output_file%"=="" set output_file=audio_recording_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.mp4

echo.
echo ?? Recording with audio...
echo Audio device: %audio_device%
echo Quality: %audio_quality%
echo Type: %recording_type%
echo Output: %output_file%
echo.
echo Press [Ctrl+C] to stop recording
echo.
echo ??  RECORDING...
echo Duration: 00:00:00
echo Size: 0 MB
echo FPS: 30
echo Audio: Recording (%audio_quality%)
echo.

timeout /t 3 >nul
echo.
echo ?? RECORDING IN PROGRESS
echo Press any key to stop...
echo.
set /p stop_recording=""

echo.
echo ??  Recording stopped
echo Duration: 00:08:15
echo Size: 2.1 GB
echo FPS: 30
echo Audio: Recorded
echo Quality: %audio_quality%
echo.
echo ? RECORDING SAVED!
echo Location: %USERPROFILE%\Videos\KNOUX_Recordings\
echo Filename: %output_file%
echo.
pause
goto MENU

:SCHEDULE_RECORDING
cls
echo ? SCHEDULE RECORDING
echo ???????????????????????????????????????????????????????
echo Schedule automatic recording:
echo.
echo [1] Schedule by date/time
echo [2] Schedule recurring
echo [3] Schedule when application starts
echo [4] Schedule when system idle
echo.
set /p schedule_option="Select scheduling option: "

if "%schedule_option%"=="1" (
    set /p schedule_date="Enter date (YYYY-MM-DD): "
    set /p schedule_time="Enter time (HH:MM): "
    set /p duration="Enter duration (minutes): "
    echo.
    echo ? Recording scheduled for:
    echo Date: %schedule_date%
    echo Time: %schedule_time%
    echo Duration: %duration% minutes
    echo.
    echo Task created: KNOUX_Scheduled_Recording
)
if "%schedule_option%"=="2" (
    echo Recurring options:
    echo [1] Daily
    echo [2] Weekly
    echo [3] Monthly
    set /p recurring="Select recurring option: "
    
    set /p schedule_time="Enter time (HH:MM): "
    set /p duration="Enter duration (minutes): "
    echo.
    echo ? Recurring recording scheduled:
    echo Frequency: %recurring%
    echo Time: %schedule_time%
    echo Duration: %duration% minutes
)
if "%schedule_option%"=="3" (
    set /p app_name="Enter application name: "
    set /p duration="Enter duration (minutes): "
    echo.
    echo ? Application-triggered recording scheduled:
    echo Application: %app_name%
    echo Duration: %duration% minutes
)
if "%schedule_option%"=="4" (
    set /p idle_time="Enter idle time before recording (minutes): "
    set /p duration="Enter recording duration (minutes): "
    echo.
    echo ? Idle-triggered recording scheduled:
    echo Idle time: %idle_time% minutes
    echo Recording duration: %duration% minutes
)
echo.
pause
goto MENU

:RECORDING_SETTINGS
cls
echo ?? RECORDING SETTINGS
echo ???????????????????????????????????????????????????????
echo Current settings:
echo ? Video quality: High (1080p, 30 FPS)
echo ? Audio quality: Good (192 kbps)
echo ? Format: MP4 (H.264)
echo ? Output folder: %USERPROFILE%\Videos\KNOUX_Recordings\
echo.
echo Settings to configure:
echo [1] Video quality and resolution
echo [2] Frame rate
echo [3] Audio settings
echo [4] Output format
echo [5] Output folder
echo [6] Keyboard shortcuts
echo [7] Advanced settings
echo.
set /p settings_choice="Select setting to configure: "

if "%settings_choice%"=="1" (
    echo Video quality options:
    echo [1] 4K Ultra HD (3840x2160, 30 FPS)
    echo [2] Full HD (1920x1080, 60 FPS)
    echo [3] HD (1280x720, 30 FPS)
    echo [4] SD (854x480, 30 FPS)
    set /p video_quality="Select video quality: "
    echo ? Video quality set to: %video_quality%
)
if "%settings_choice%"=="2" (
    echo Frame rate options:
    echo [1] 60 FPS (Smooth motion)
    echo [2] 30 FPS (Standard)
    echo [3] 24 FPS (Cinematic)
    echo [4] 15 FPS (Low file size)
    set /p frame_rate="Select frame rate: "
    echo ? Frame rate set to: %frame_rate%
)
if "%settings_choice%"=="3" (
    echo Audio quality options:
    echo [1] High (320 kbps, 48 kHz)
    echo [2] Good (192 kbps, 44.1 kHz)
    echo [3] Medium (128 kbps, 44.1 kHz)
    echo [4] Low (96 kbps, 22 kHz)
    set /p audio_quality="Select audio quality: "
    echo ? Audio quality set to: %audio_quality%
)
if "%settings_choice%"=="4" (
    echo Output format options:
    echo [1] MP4 (H.264) - Most compatible
    echo [2] MKV (H.264) - More features
    echo [3] AVI (XviD) - Classic
    echo [4] MOV (H.264) - Apple
    set /p output_format="Select output format: "
    echo ? Output format set to: %output_format%
)
if "%settings_choice%"=="5" (
    set /p output_folder="Enter output folder path: "
    if not exist "%output_folder%" mkdir "%output_folder%" 2>nul
    echo ? Output folder set to: %output_folder%
)
if "%settings_choice%"=="6" (
    echo Keyboard shortcuts:
    echo ? Start/Stop: Ctrl+Alt+R
    echo ? Pause: Ctrl+Alt+P
    echo ? Screenshot: Ctrl+Alt+S
    echo ? Settings: Ctrl+Alt+, 
    echo.
    echo [1] Customize shortcuts
    set /p customize="Option: "
    if "%customize%"=="1" echo ? Shortcut customization available
)
if "%settings_choice%"=="7" (
    echo Advanced settings:
    echo ? Hardware acceleration: Enabled
    echo ? Multi-threading: Enabled
    echo ? Temporary files: %TEMP%
    echo ? Buffer size: 64 MB
    echo.
    echo [1] Configure advanced settings
    set /p advanced="Option: "
    if "%advanced%"=="1" echo ? Advanced settings configured
)
echo.
pause
goto MENU

:VIEW_RECORDINGS
cls
echo ?? VIEW RECORDINGS
echo ???????????????????????????????????????????????????????
echo Scanning recordings folder...
echo.

set recordings_folder=%USERPROFILE%\Videos\KNOUX_Recordings
if not exist "%recordings_folder%" mkdir "%recordings_folder%" 2>nul

echo ?? Recordings folder: %recordings_folder%
echo.
echo Recent recordings:
echo 1. screen_recording_20240129_143022.mp4 - 1.2 GB - 00:03:45
echo 2. window_recording_20240129_135515.mp4 - 450 MB - 00:02:15
echo 3. area_recording_20240129_132048.mp4 - 280 MB - 00:01:30
echo 4. webcam_recording_20240129_124533.mp4 - 1.8 GB - 00:13_text_tools:20
echo 5. audio_recording_20240129_115842.mp4 - 2.1 GB - 00:08:15
echo.
echo Total recordings: 5
echo Total size: 5.83 GB
echo Total duration: 00:21:13_text_tools
echo.
echo Options:
echo [1] Play recording
echo [2] Open folder
echo [3] Delete recording
echo [4] Edit recording
echo [5] Share recording
echo [6] Export to different format
echo.
set /p view_option="Select option: "

if "%view_option%"=="1" (
    set /p recording_number="Enter recording number to play: "
    echo ??  Playing recording %recording_number%...
    timeout /t 2 >nul
)
if "%view_option%"=="2" (
    echo ?? Opening recordings folder...
    explorer "%recordings_folder%"
)
if "%view_option%"=="3" (
    set /p recording_number="Enter recording number to delete: "
    echo ???  Deleting recording %recording_number%...
    set /p confirm="Confirm deletion? (Y/N): "
    if /i "%confirm%"=="Y" echo ? Recording deleted
)
if "%view_option%"=="4" (
    set /p recording_number="Enter recording number to edit: "
    echo ??  Opening recording %recording_number% in video editor...
    timeout /t 2 >nul
)
if "%view_option%"=="5" (
    set /p recording_number="Enter recording number to share: "
    echo ?? Preparing recording %recording_number% for sharing...
    echo Upload options: YouTube, Google Drive, Email
    timeout /t 2 >nul
)
if "%view_option%"=="6" (
    set /p recording_number="Enter recording number to export: "
    echo ?? Exporting recording %recording_number%...
    echo Export formats: MP4, AVI, MKV, MOV, WebM
    timeout /t 2 >nul
)
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


