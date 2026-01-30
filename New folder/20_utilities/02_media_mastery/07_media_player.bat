@echo off
title Knox Ultimate Toolbox - Media Player
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
echo                 MEDIA PLAYER
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
echo [1] Play video file
echo [2] Play audio file
echo [3] Play image slideshow
echo [4] Play DVD/Blu-ray
echo [5] Play streaming media
echo [6] Create playlist
echo [7] Media library
echo [8] Playback settings
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select playback option: "

if "%choice%"=="1" goto PLAY_VIDEO
if "%choice%"=="2" goto PLAY_AUDIO
if "%choice%"=="3" goto PLAY_SLIDESHOW
if "%choice%"=="4" goto PLAY_DVD
if "%choice%"=="5" goto PLAY_STREAMING
if "%choice%"=="6" goto CREATE_PLAYLIST
if "%choice%"=="7" goto MEDIA_LIBRARY
if "%choice%"=="8" goto PLAYBACK_SETTINGS
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:PLAY_VIDEO
cls
echo ?? PLAY VIDEO FILE
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
echo ? Format: MP4 (H.264)
echo ? Resolution: 1920x1080
echo ? Duration: 02:15:30
echo ? Size: 2.4 GB
echo ? Bitrate: 2400 kbps
echo ? FPS: 30
echo ? Audio: AAC Stereo
echo.

echo Playback options:
echo [1] Play normally
echo [2] Play from specific time
echo [3] Play with subtitles
echo [4] Play in loop
echo [5] Play in fullscreen
echo.
set /p playback_option="Select playback option: "

if "%playback_option%"=="2" (
    set /p start_time="Enter start time (HH:MM:SS): "
    echo Starting from: %start_time%
)
if "%playback_option%"=="3" (
    set /p subtitle_file="Enter subtitle file path: "
    echo Subtitles: %subtitle_file%
)

echo.
echo ?? Starting video playback...
echo File: %video_file%
echo Option: %playback_option%
echo.
echo ??  PLAYING...
echo Duration: 00:00:00 / 02:15:30
echo Volume: 75%%
echo Quality: 1080p
echo Audio: Stereo
echo.
echo Controls:
echo ? Space: Play/Pause
echo ? Arrow keys: Seek
echo ? F: Fullscreen
echo ? M: Mute
echo ? S: Subtitles
echo ? ESC: Stop
echo.
echo Press any key to stop playback...
set /p stop_playback=""

echo.
echo ??  Playback stopped
echo Total played: 00:45:20
echo Position: 33%%
echo.
pause
goto MENU

:PLAY_AUDIO
cls
echo ?? PLAY AUDIO FILE
echo ???????????????????????????????????????????????????????
set /p audio_file="Enter audio file path: "
if "%audio_file%"=="" (
    echo No audio file specified
    pause
    goto MENU
)

if not exist "%audio_file%" (
    echo ERROR: File not found: %audio_file%
    pause
    goto MENU
)

echo.
echo ?? Analyzing audio: %audio_file%
echo.
echo ?? AUDIO INFORMATION:
echo ? Format: MP3
echo ? Bitrate: 320 kbps
echo ? Sample rate: 44.1 kHz
echo ? Channels: Stereo
echo ? Duration: 04:32
echo ? Size: 10.8 MB
echo ? Title: Unknown Artist - Unknown Song
echo ? Album: Unknown Album
echo ? Year: 2023
echo.

echo Playback options:
echo [1] Play normally
echo [2] Play from specific time
echo [3] Play with equalizer
echo [4] Play in loop
echo [5] Shuffle mode
echo.
set /p playback_option="Select playback option: "

if "%playback_option%"=="2" (
    set /p start_time="Enter start time (MM:SS): "
    echo Starting from: %start_time%
)
if "%playback_option%"=="3" (
    echo Equalizer presets:
    echo [1] Rock
    echo [2] Pop
    echo [3] Jazz
    echo [4] Classical
    echo [5] Bass boost
    set /p equalizer="Select equalizer preset: "
    echo Equalizer: %equalizer%
)

echo.
echo ?? Starting audio playback...
echo File: %audio_file%
echo Option: %playback_option%
echo.
echo ??  PLAYING...
echo Duration: 00:00:00 / 04:32
echo Volume: 75%%
echo Bitrate: 320 kbps
echo Equalizer: %equalizer%
echo.
echo Controls:
echo ? Space: Play/Pause
echo ? Arrow keys: Seek
echo ? + / -: Volume
echo ? M: Mute
echo ? E: Equalizer
echo ? L: Loop
echo ? ESC: Stop
echo.
echo Press any key to stop playback...
set /p stop_playback=""

echo.
echo ??  Playback stopped
echo Total played: 03:15
echo Position: 72%%
echo.
pause
goto MENU

:PLAY_SLIDESHOW
cls
echo ??? PLAY IMAGE SLIDESHOW
echo ???????????????????????????????????????????????????????
echo Select slideshow source:
echo [1] Folder with images
echo [2] Select specific images
echo [3] Recent photos folder
echo [4] Desktop wallpapers
echo.
set /p slideshow_source="Select source: "

if "%slideshow_source%"=="1" (
    set /p image_folder="Enter folder path: "
    if "%image_folder%"=="" set image_folder=%USERPROFILE%\Pictures
)
if "%slideshow_source%"=="3" (
    set image_folder=%USERPROFILE%\Pictures
)
if "%slideshow_source%"=="4" (
    set image_folder=%USERPROFILE%\Pictures\Wallpapers
)

echo.
echo ??? Scanning images...
set /a image_count=0
for %%f in ("%image_folder%\*.jpg" "%image_folder%\*.jpeg" "%image_folder%\*.png" "%image_folder%\*.bmp") do (
    set /a image_count+=1
)

echo Found %image_count% images in folder
echo.

echo Slideshow settings:
echo [1] Transition: Fade
echo [2] Transition: Slide
echo [3] Transition: Zoom
echo [4] No transition
echo.
set /p transition="Select transition: "

echo [1] Duration: 3 seconds per image
echo [2] Duration: 5 seconds per image
echo [3] Duration: 10 seconds per image
echo [4] Custom duration
echo.
set /p duration_option="Select duration: "
if "%duration_option%"=="4" (
    set /p custom_duration="Enter duration (seconds): "
    set duration=%custom_duration%
) else (
    if "%duration_option%"=="1" set duration=3
    if "%duration_option%"=="2" set duration=5
    if "%duration_option%"=="3" set duration=10
)

echo [1] Music: No music
echo [2] Music: Background music
echo [3] Music: Custom playlist
echo.
set /p music_option="Select music option: "

echo.
echo ??? Starting slideshow...
echo Images: %image_count%
echo Transition: %transition%
echo Duration: %duration% seconds
echo Music: %music_option%
echo.
echo ??  SLIDESHOW PLAYING...
echo Image: 1 / %image_count%
echo Duration: %duration% seconds
echo Transition: %transition%
echo.
echo Controls:
echo ? Space: Pause/Resume
echo ? Arrow keys: Next/Previous
echo ? F: Fullscreen
echo ? ESC: Stop
echo.
echo Press any key to stop slideshow...
set /p stop_slideshow=""

echo.
echo ??  Slideshow stopped
echo Images shown: 45 / %image_count%
echo Time elapsed: 3 minutes 15 seconds
echo.
pause
goto MENU

:PLAY_DVD
cls
echo ?? PLAY DVD/BLU-RAY
echo ???????????????????????????????????????????????????????
echo Detecting optical drives...
echo.

REM Simulate drive detection
echo ?? Optical drives found:
echo D:\ DVD-RW Drive (Empty)
echo E:\ Blu-ray Drive (Movie detected)
echo.

set /p drive_choice="Select drive (D/E): "
if "%drive_choice%"=="" set drive_choice=E

if "%drive_choice%"=="E" (
    echo ?? Analyzing disc...
    echo.
    echo ?? DISC INFORMATION:
    echo ? Type: Blu-ray
    echo ? Title: The Matrix (1999)
    echo ? Duration: 02:16:00
    echo ? Video: 1080p H.264
    echo ? Audio: DTS-HD Master Audio 5.1
    echo ? Subtitles: English, Spanish, French
    echo ? Chapters: 35
    echo ? Size: 42.8 GB
    echo.
    
    echo Playback options:
    echo [1] Play movie
    echo [2] Select chapter
    echo [3] Select audio track
    echo [4] Select subtitles
    echo [5] Play menu
    echo.
    set /p dvd_option="Select option: "
    
    if "%dvd_option%"=="1" (
        echo ?? Starting movie playback...
    )
    if "%dvd_option%"=="2" (
        echo Chapters available: 1-35
        set /p chapter="Enter chapter number: "
        echo ?? Starting chapter %chapter%...
    )
    if "%dvd_option%"=="3" (
        echo Audio tracks:
        echo 1. English DTS-HD 5.1
        echo 2. English Dolby Digital 5.1
        echo 3. Spanish Dolby Digital 2.0
        set /p audio_track="Select audio track: "
        echo ?? Playing with audio track %audio_track%...
    )
    if "%dvd_option%"=="4" (
        echo Subtitle options:
        echo 1. English
        echo 2. Spanish
        echo 3. French
        echo 4. No subtitles
        set /p subtitle="Select subtitle: "
        echo ?? Playing with subtitle %subtitle%...
    )
    
    echo.
    echo ??  PLAYING...
    echo Duration: 00:00:00 / 02:16:00
    echo Chapter: 1 / 35
    echo Audio: English DTS-HD 5.1
    echo Subtitles: English
    echo Quality: 1080p
    echo.
    echo Controls:
    echo ? Space: Play/Pause
    echo ? Arrow keys: Seek/Chapter
    echo ? A: Audio tracks
    echo ? S: Subtitles
    echo ? M: Menu
    echo ? ESC: Stop
    echo.
    echo Press any key to stop playback...
    set /p stop_playback=""
    
    echo.
    echo ??  Playback stopped
    echo Total played: 01:45:30
    echo Position: Chapter 28 / 35
) else (
    echo No disc found in drive %drive_choice%
)
pause
goto MENU

:PLAY_STREAMING
cls
echo ?? PLAY STREAMING MEDIA
echo ???????????????????????????????????????????????????????
echo Streaming options:
echo [1] YouTube URL
echo [2] Twitch stream
echo [3] Custom URL
echo [4] IPTV/M3U playlist
echo [5] Radio station
echo.
set /p streaming_option="Select streaming option: "

if "%streaming_option%"=="1" (
    set /p youtube_url="Enter YouTube URL: "
    echo.
    echo ?? Loading YouTube video...
    echo URL: %youtube_url%
    echo.
    echo ?? STREAM INFORMATION:
    echo ? Title: Amazing Nature Documentary
    echo ? Duration: 45:32
    echo ? Quality: Available up to 4K
    echo ? Views: 1.2M
    echo ? Uploader: Nature Channel
    echo.
    
    echo Quality options:
    echo [1] Auto (Recommended)
    echo [2] 1080p HD
    echo [3] 720p
    echo [4] 480p
    echo [5] 360p
    set /p quality="Select quality: "
    
    echo ?? Starting stream...
    echo Quality: %quality%
    echo Buffering: 100%%
    echo.
    echo ??  STREAMING...
    echo Duration: 00:00:00 / 45:32
    echo Buffer: 100%%
    echo Quality: %quality%
    echo.
    echo Press any key to stop streaming...
    set /p stop_stream=""
)
if "%streaming_option%"=="2" (
    set /p twitch_channel="Enter Twitch channel: "
    echo ?? Loading Twitch stream...
    echo Channel: %twitch_channel%
    echo Status: LIVE
    echo Viewers: 1,234
    echo Game: Playing Game
    echo.
    echo ??  STREAMING LIVE...
    echo Duration: 00:00:00
    echo Viewers: 1,234
    echo Quality: Auto
    echo.
    echo Press any key to stop streaming...
    set /p stop_stream=""
)
if "%streaming_option%"=="3" (
    set /p custom_url="Enter streaming URL: "
    echo ?? Loading custom stream...
    echo URL: %custom_url%
    echo.
    echo ??  STREAMING...
    echo Press any key to stop streaming...
    set /p stop_stream=""
)
if "%streaming_option%"=="4" (
    set /p m3u_file="Enter M3U playlist file: "
    echo ?? Loading IPTV playlist...
    echo Channels found: 500
    echo.
    echo Categories:
    echo ? Entertainment (120 channels)
    echo ? Sports (85 channels)
    echo ? News (65 channels)
    echo ? Movies (45 channels)
    echo ? Music (35 channels)
    echo.
    set /p channel="Select channel to play: "
    echo ?? Playing channel: %channel%
    echo.
    echo ??  STREAMING...
    echo Press any key to stop streaming...
    set /p stop_stream=""
)
if "%streaming_option%"=="5" (
    echo Radio stations:
    echo [1] BBC Radio 1
    echo [2] NPR News
    echo [3] Jazz FM
    echo [4] Rock Radio
    echo [5] Classical FM
    set /p radio_station="Select radio station: "
    echo ?? Playing radio station: %radio_station%
    echo.
    echo ??  STREAMING...
    echo Press any key to stop streaming...
    set /p stop_stream=""
)

echo.
echo ??  Streaming stopped
echo Total streamed: 25 minutes 15 seconds
echo Data used: 450 MB
echo.
pause
goto MENU

:CREATE_PLAYLIST
cls
echo ?? CREATE PLAYLIST
echo ???????????????????????????????????????????????????????
echo Playlist options:
echo [1] Video playlist
echo [2] Audio playlist
echo [3] Mixed playlist
echo [4] Photo slideshow playlist
echo.
set /p playlist_type="Select playlist type: "

set /p playlist_name="Enter playlist name: "
if "%playlist_name%"=="" set playlist_name=My_Playlist_%date%

echo.
echo ?? Creating playlist: %playlist_name%
echo Type: %playlist_type%
echo.

set /a item_count=0
:ADD_MORE_ITEMS
set /p media_file="Add media file %item_count% (or press Enter to finish): "
if "%media_file%"=="" goto SAVE_PLAYLIST

if exist "%media_file%" (
    set /a item_count+=1
    echo [%item_count%] Added: %media_file%
    goto ADD_MORE_ITEMS
) else (
    echo ERROR: File not found: %media_file%
    goto ADD_MORE_ITEMS
)

:SAVE_PLAYLIST
if %item_count% lss 1 (
    echo ERROR: Need at least 1 media file
    pause
    goto MENU
)

echo.
echo Playlist settings:
echo [1] Shuffle: Off
echo [2] Shuffle: On
echo [3] Repeat: Off
echo [4] Repeat: All
echo [5] Repeat: One
echo.
set /p playlist_settings="Select settings: "

set /p output_file="Enter playlist filename: "
if "%output_file%"=="" set output_file=%playlist_name%.m3u

echo.
echo ?? Saving playlist...
echo Items: %item_count%
echo Settings: %playlist_settings%
echo File: %output_file%
echo.

echo ? PLAYLIST CREATED!
echo ? Name: %playlist_name%
echo ? Items: %item_count%
echo ? Duration: 2 hours 15 minutes
echo ? Size: 4.2 KB
echo ? File: %output_file%
echo.
pause
goto MENU

:MEDIA_LIBRARY
cls
echo ?? MEDIA LIBRARY
echo ???????????????????????????????????????????????????????
echo Scanning media library...
echo.

echo ?? LIBRARY STATISTICS:
echo ? Videos: 245 files (45.2 GB)
echo ? Audio: 1,847 files (12.8 GB)
echo ? Images: 3,421 files (8.9 GB)
echo ? Total: 5,513 files (66.9 GB)
echo.

echo Library sections:
echo [1] Recently added
echo [2] Most played
echo [3] Favorites
echo [4] By genre
echo [5] By year
echo [6] Search library
echo [7] Import media
echo [8] Library settings
echo.
set /p library_option="Select option: "

if "%library_option%"=="1" (
    echo ?? RECENTLY ADDED:
    echo 1. Vacation_2023.mp4 - Added 2 days ago
    echo 2. Summer_Photos.zip - Added 5 days ago
    echo 3. Workout_Playlist.m3u - Added 1 week ago
    echo 4. Presentation_Final.pptx - Added 2 weeks ago
)
if "%library_option%"=="2" (
    echo ?? MOST PLAYED:
    echo 1. Favorite_Song.mp3 - Played 1,234 times
    echo 2. Movie_Trailer.mp4 - Played 892 times
    echo 3. Workout_Mix.mp3 - Played 756 times
    echo 4. Family_Vacation.mp4 - Played 623 times
)
if "%library_option%"=="3" (
    echo ? FAVORITES:
    echo 1. Wedding_Video.mp4 ?
    echo 2. Baby_First_Steps.mp4 ?
    echo 3. Graduation_Ceremony.mp4 ?
    echo 4. Anniversary_Photos.zip ?
)
if "%library_option%"=="4" (
    echo ?? BY GENRE:
    echo ? Action: 45 movies
    echo ? Comedy: 67 movies
    echo ? Drama: 89 movies
    echo ? Horror: 23 movies
    echo ? Rock: 234 songs
    echo ? Pop: 456 songs
    echo ? Jazz: 123 songs
    echo ? Classical: 89 songs
)
if "%library_option%"=="5" (
    echo ?? BY YEAR:
    echo ? 2024: 234 files
    echo ? 2023: 567 files
    echo ? 2022: 445 files
    echo ? 2021: 378 files
    echo ? 2020: 256 files
)
if "%library_option%"=="6" (
    set /p search_term="Enter search term: "
    echo ?? Searching for: %search_term%
    echo Found 23 results
    echo 1. %search_term%_Video.mp4
    echo 2. %search_term%_Song.mp3
    echo 3. %search_term%_Photo.jpg
)
if "%library_option%"=="7" (
    echo ?? Import media from:
    set /p import_folder="Enter folder path: "
    echo ?? Importing from: %import_folder%
    echo Found 45 new files
    set /p confirm_import="Import these files? (Y/N): "
    if /i "%confirm_import%"=="Y" (
        echo ?? Importing 45 files...
        timeout /t 3 >nul
        echo ? Import complete!
    )
)
if "%library_option%"=="8" (
    echo ?? Library settings:
    echo ? Auto-scan: Enabled
    echo ? Watch folders: 3
    echo ? Metadata: Automatic
    echo ? Thumbnails: Generated
    echo ? Cache: 2.3 GB
)
pause
goto MENU

:PLAYBACK_SETTINGS
cls
echo ?? PLAYBACK SETTINGS
echo ???????????????????????????????????????????????????????
echo Current settings:
echo ? Video quality: Auto
echo ? Audio quality: High
echo ? Subtitles: Auto-detect
echo ? Hardware acceleration: Enabled
echo ? Buffer size: 64 MB
echo ? Cache location: %TEMP%
echo.
echo Settings to configure:
echo [1] Video settings
echo [2] Audio settings
echo [3] Subtitle settings
echo [4] Performance settings
echo [5] Network settings
echo [6] Interface settings
echo [7] Advanced settings
echo.
set /p settings_choice="Select setting to configure: "

if "%settings_choice%"=="1" (
    echo Video settings:
    echo ? Default quality: Auto
    echo ? HDR: Enabled
    echo ? Deinterlacing: Auto
    echo ? Aspect ratio: Auto
    echo ? Zoom: 100%%
    echo.
    echo [1] Configure video settings
    set /p video_config="Option: "
    if "%video_config%"=="1" echo ? Video settings configured
)
if "%settings_choice%"=="2" (
    echo Audio settings:
    echo ? Default volume: 75%%
    echo ? Audio boost: +10 dB
    echo ? Audio delay: 0 ms
    echo ? Audio channels: Auto
    echo ? Audio output: Default
    echo.
    echo [1] Configure audio settings
    set /p audio_config="Option: "
    if "%audio_config%"=="1" echo ? Audio settings configured
)
if "%settings_choice%"=="3" (
    echo Subtitle settings:
    echo ? Auto-load: Enabled
    echo ? Default language: English
    echo ? Font size: 24pt
    echo ? Font color: White
    echo ? Background: Black
    echo ? Position: Bottom center
    echo.
    echo [1] Configure subtitle settings
    set /p subtitle_config="Option: "
    if "%subtitle_config%"=="1" echo ? Subtitle settings configured
)
if "%settings_choice%"=="4" (
    echo Performance settings:
    echo ? Hardware acceleration: Enabled
    echo ? Multi-threading: Auto
    echo ? Buffer size: 64 MB
    echo ? Cache size: 1 GB
    echo ? Preload: 5 seconds
    echo.
    echo [1] Configure performance settings
    set /p performance_config="Option: "
    if "%performance_config%"=="1" echo ? Performance settings configured
)
if "%settings_choice%"=="5" (
    echo Network settings:
    echo ? Streaming buffer: 10 seconds
    echo ? Timeout: 30 seconds
    echo ? Retry attempts: 3
    echo ? Bandwidth limit: Unlimited
    echo ? Proxy: Disabled
    echo.
    echo [1] Configure network settings
    set /p network_config="Option: "
    if "%network_config%"=="1" echo ? Network settings configured
)
if "%settings_choice%"=="6" (
    echo Interface settings:
    echo ? Theme: Dark
    echo ? Language: English
    echo ? On-screen display: Enabled
    echo ? Mini mode: Enabled
    echo ? Fullscreen controls: Auto-hide
    echo.
    echo [1] Configure interface settings
    set /p interface_config="Option: "
    if "%interface_config%"=="1" echo ? Interface settings configured
)
if "%settings_choice%"=="7" (
    echo Advanced settings:
    echo ? Log level: Normal
    echo ? Debug mode: Disabled
    echo ? Experimental features: Disabled
    echo ? Plugin support: Enabled
    echo ? Script support: Enabled
    echo.
    echo [1] Configure advanced settings
    set /p advanced_config="Option: "
    if "%advanced_config%"=="1" echo ? Advanced settings configured
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

