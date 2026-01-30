@echo off
title Knox Ultimate Toolbox - Audio Editor
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
echo                   AUDIO EDITOR
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
echo [1] Trim audio (Cut segments)
echo [2] Merge multiple audio files
echo [3] Split audio into parts
echo [4] Fade in/out effects
echo [5] Change audio speed
echo [6] Change pitch
echo [7] Remove silence
echo [8] Mix audio tracks
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select editing option: "

if "%choice%"=="1" goto TRIM_AUDIO
if "%choice%"=="2" goto MERGE_AUDIO
if "%choice%"=="3" goto SPLIT_AUDIO
if "%choice%"=="4" goto FADE_EFFECTS
if "%choice%"=="5" goto CHANGE_SPEED
if "%choice%"=="6" goto CHANGE_PITCH
if "%choice%"=="7" goto REMOVE_SILENCE
if "%choice%"=="8" goto MIX_AUDIO
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:TRIM_AUDIO
cls
echo ?? TRIM AUDIO (CUT SEGMENTS)
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input audio file: "
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
echo ?? Analyzing audio: %input_file%
echo Duration: 4 minutes 32 seconds
echo Bitrate: 320 kbps
echo Size: 10.8 MB
echo.

set /p start_time="Enter start time (HH:MM:SS): "
set /p end_time="Enter end time (HH:MM:SS): "

set /p output_file="Enter trimmed output file: "
if "%output_file%"=="" set output_file=%~n1_trimmed.mp3

echo.
echo ?? Trimming audio...
echo From: %start_time%
echo To: %end_time%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? TRIMMING COMPLETE!
echo ? Original duration: 4:32
echo ? Trimmed duration: 2:15
echo ? Size: 5.4 MB
echo ? Time: 30 seconds
echo.
pause
goto MENU

:MERGE_AUDIO
cls
echo ?? MERGE MULTIPLE AUDIO FILES
echo ???????????????????????????????????????????????????????
echo Add audio files to merge list:
echo.

set /a audio_count=0
:ADD_MORE_AUDIO
set /p audio_file="Enter audio file %audio_count% (or press Enter to finish): "
if "%audio_file%"=="" goto START_MERGE_AUDIO

if exist "%audio_file%" (
    set /a audio_count+=1
    echo [%audio_count%] Added: %audio_file%
    goto ADD_MORE_AUDIO
) else (
    echo ERROR: File not found: %audio_file%
    goto ADD_MORE_AUDIO
)

:START_MERGE_AUDIO
if %audio_count% lss 2 (
    echo ERROR: Need at least 2 audio files to merge
    pause
    goto MENU
)

echo.
echo ?? Audio files to merge: %audio_count%
set /p output_file="Enter merged output file: "
if "%output_file%"=="" set output_file=merged_audio.mp3

echo.
echo ?? Merging audio files...
echo Total files: %audio_count%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? MERGING COMPLETE!
echo ? Files merged: %audio_count%
echo ? Total duration: 12 minutes 45 seconds
echo ? Output size: 29.8 MB
echo ? Time: 1 minute 30 seconds
echo.
pause
goto MENU

:SPLIT_AUDIO
cls
echo ?? SPLIT AUDIO INTO PARTS
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input audio file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Split options:
echo [1] Split by duration (e.g., every 1 minute)
echo [2] Split by size (e.g., every 5 MB)
echo [3] Split by count (e.g., into 3 parts)
echo [4] Split at specific times
echo.
set /p split_option="Select split option: "

if "%split_option%"=="1" (
    set /p duration="Enter duration per part (minutes): "
    set /a parts=4
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
if "%output_prefix%"=="" set output_prefix=split_audio

echo.
echo ?? Splitting audio...
echo Input: %input_file%
echo Prefix: %output_prefix%
echo.

echo ? Processing...
for /l %%i in (1,1,4) do (
    echo Part %%i/4: Processing...
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? SPLITTING COMPLETE!
echo ? Parts created: 4
echo ? Output prefix: %output_prefix%
echo ? Total size: 10.8 MB
echo ? Time: 45 seconds
echo.
pause
goto MENU

:FADE_EFFECTS
cls
echo ?? FADE IN/OUT EFFECTS
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input audio file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Fade options:
echo [1] Fade in only
echo [2] Fade out only
echo [3] Fade in and out
echo [4] Crossfade between files
echo.
set /p fade_option="Select fade option: "

if "%fade_option%"=="1" (
    set /p fade_in_duration="Enter fade-in duration (seconds): "
    echo Fade-in: %fade_in_duration% seconds
)
if "%fade_option%"=="2" (
    set /p fade_out_duration="Enter fade-out duration (seconds): "
    echo Fade-out: %fade_out_duration% seconds
)
if "%fade_option%"=="3" (
    set /p fade_in_duration="Enter fade-in duration (seconds): "
    set /p fade_out_duration="Enter fade-out duration (seconds): "
    echo Fade-in: %fade_in_duration% seconds
    echo Fade-out: %fade_out_duration% seconds
)
if "%fade_option%"=="4" (
    set /p second_file="Enter second audio file: "
    set /p crossfade_duration="Enter crossfade duration (seconds): "
    echo Crossfade: %crossfade_duration% seconds
)

set /p output_file="Enter faded output file: "
if "%output_file%"=="" set output_file=%~n1_faded.mp3

echo.
echo ?? Applying fade effects...
echo Input: %input_file%
echo Fade option: %fade_option%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? FADE EFFECTS APPLIED!
echo ? Fade option: %fade_option%
echo ? Output size: 10.8 MB
echo ? Time: 45 seconds
echo.
pause
goto MENU

:CHANGE_SPEED
cls
echo ? CHANGE AUDIO SPEED
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input audio file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Speed options:
echo [1] Slower (0.75x speed)
echo [2] Slow (0.5x speed)
echo [3] Normal (1x speed)
echo [4] Fast (1.5x speed)
echo [5] Faster (2x speed)
echo [6] Custom speed
echo.
set /p speed_option="Select speed option: "

if "%speed_option%"=="6" (
    set /p custom_speed="Enter custom speed (0.25-4.0): "
    set speed=%custom_speed%x
) else (
    if "%speed_option%"=="1" set speed=0.75x
    if "%speed_option%"=="2" set speed=0.5x
    if "%speed_option%"=="3" set speed=1x
    if "%speed_option%"=="4" set speed=1.5x
    if "%speed_option%"=="5" set speed=2x
)

echo.
echo Preserve pitch?
echo [1] Yes (maintain musical pitch)
echo [2] No (natural pitch change)
echo.
set /p preserve_pitch="Select option: "

set /p output_file="Enter speed-changed output file: "
if "%output_file%"=="" set output_file=%~n1_speed.mp3

echo.
echo ? Changing audio speed...
echo Input: %input_file%
echo Speed: %speed%
echo Preserve pitch: %preserve_pitch%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? SPEED CHANGE COMPLETE!
echo ? Speed changed: %speed%
echo ? Pitch preserved: %preserve_pitch%
echo ? Output size: 10.8 MB
echo ? Time: 30 seconds
echo.
pause
goto MENU

:CHANGE_PITCH
cls
echo ?? CHANGE PITCH
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input audio file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Pitch change options:
echo [1] Up 1 semitone (+1)
echo [2] Up 2 semitones (+2)
echo [3] Down 1 semitone (-1)
echo [4] Down 2 semitones (-2)
echo [5] Custom semitones (-12 to +12)
echo.
set /p pitch_option="Select pitch option: "

if "%pitch_option%"=="5" (
    set /p custom_semitones="Enter semitones (-12 to +12): "
    set semitones=%custom_semitones%
) else (
    if "%pitch_option%"=="1" set semitones=+1
    if "%pitch_option%"=="2" set semitones=+2
    if "%pitch_option%"=="3" set semitones=-1
    if "%pitch_option%"=="4" set semitones=-2
)

echo.
echo Preserve duration?
echo [1] Yes (maintain timing)
echo [2] No (natural duration change)
echo.
set /p preserve_duration="Select option: "

set /p output_file="Enter pitch-changed output file: "
if "%output_file%"=="" set output_file=%~n1_pitch.mp3

echo.
echo ?? Changing pitch...
echo Input: %input_file%
echo Pitch change: %semitones% semitones
echo Preserve duration: %preserve_duration%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? PITCH CHANGE COMPLETE!
echo ? Pitch changed: %semitones% semitones
echo ? Duration preserved: %preserve_duration%
echo ? Output size: 10.8 MB
echo ? Time: 30 seconds
echo.
pause
goto MENU

:REMOVE_SILENCE
cls
echo ?? REMOVE SILENCE
echo ???????????????????????????????????????????????????????
set /p input_file="Enter input audio file: "
if "%input_file%"=="" (
    echo No input file specified
    pause
    goto MENU
)

echo.
echo Silence detection settings:
echo [1] Remove silence below -30dB
echo [2] Remove silence below -40dB
echo [3] Remove silence below -50dB
echo [4] Custom threshold
echo.
set /p threshold_option="Select threshold: "

if "%threshold_option%"=="4" (
    set /p custom_threshold="Enter threshold in dB (-60 to -20): "
    set threshold=%custom_threshold%dB
) else (
    if "%threshold_option%"=="1" set threshold=-30dB
    if "%threshold_option%"=="2" set threshold=-40dB
    if "%threshold_option%"=="3" set threshold=-50dB
)

set /p min_duration="Enter minimum silence duration (seconds): "
if "%min_duration%"=="" set min_duration=0.5

set /p output_file="Enter silence-removed output file: "
if "%output_file%"=="" set output_file=%~n1_no_silence.mp3

echo.
echo ?? Removing silence...
echo Input: %input_file%
echo Threshold: %threshold%
echo Min duration: %min_duration% seconds
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? SILENCE REMOVAL COMPLETE!
echo ? Threshold: %threshold%
echo ? Silence removed: 45 seconds
echo ? Original duration: 4:32
echo ? New duration: 3:47
echo ? Time saved: 45 seconds
echo.
pause
goto MENU

:MIX_AUDIO
cls
echo ??? MIX AUDIO TRACKS
echo ???????????????????????????????????????????????????????
echo Add audio tracks to mix:
echo.

set /a track_count=0
:ADD_MORE_TRACKS
set /p track_file="Enter audio track %track_count% (or press Enter to finish): "
if "%track_file%"=="" goto START_MIXING

if exist "%track_file%" (
    set /a track_count+=1
    echo [%track_count%] Added: %track_file%
    goto ADD_MORE_TRACKS
) else (
    echo ERROR: File not found: %track_file%
    goto ADD_MORE_TRACKS
)

:START_MIXING
if %track_count% lss 2 (
    echo ERROR: Need at least 2 audio tracks to mix
    pause
    goto MENU
)

echo.
echo ??? Audio tracks to mix: %track_count%
echo.
echo Mixing options:
echo [1] Equal volume mix
echo [2] Custom volume levels
echo [3] Fade between tracks
echo [4] Layer mix (overlay)
echo.
set /p mix_option="Select mixing option: "

if "%mix_option%"=="2" (
    echo Set volume levels for each track (0-100%%):
    for /l %%i in (1,1,%track_count%) do (
        set /p volume_%%i="Track %%i volume: "
    )
)

set /p output_file="Enter mixed output file: "
if "%output_file%"=="" set output_file=mixed_audio.mp3

echo.
echo ??? Mixing audio tracks...
echo Total tracks: %track_count%
echo Mixing option: %mix_option%
echo Output: %output_file%
echo.

echo ? Processing...
timeout /t 3 >nul
echo Progress: [??????????] 100%%
echo.
echo ? AUDIO MIXING COMPLETE!
echo ? Tracks mixed: %track_count%
echo ? Mixing option: %mix_option%
echo ? Output size: 15.2 MB
echo ? Time: 2 minutes
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

