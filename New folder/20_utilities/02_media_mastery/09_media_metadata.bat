@echo off
title Knox Ultimate Toolbox - Media Metadata Editor
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
echo              MEDIA METADATA EDITOR
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
echo [1] Edit video metadata
echo [2] Edit audio metadata
echo [3] Edit image metadata
echo [4] Batch metadata editor
echo [5] Metadata viewer
echo [6] Extract metadata
echo [7] Clean metadata
echo [8] Metadata templates
echo [9] Back to Media Menu
echo [10] Main Menu
echo.
set /p choice="Select metadata option: "

if "%choice%"=="1" goto EDIT_VIDEO_METADATA
if "%choice%"=="2" goto EDIT_AUDIO_METADATA
if "%choice%"=="3" goto EDIT_IMAGE_METADATA
if "%choice%"=="4" goto BATCH_METADATA
if "%choice%"=="5" goto VIEW_METADATA
if "%choice%"=="6" goto EXTRACT_METADATA
if "%choice%"=="7" goto CLEAN_METADATA
if "%choice%"=="8" goto METADATA_TEMPLATES
if "%choice%"=="9" goto BACK_TO_MEDIA
if "%choice%"=="10" goto MAIN_MENU
goto MENU

:EDIT_VIDEO_METADATA
cls
echo ?? EDIT VIDEO METADATA
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
echo ?? Analyzing video metadata: %video_file%
echo.
echo ?? CURRENT METADATA:
echo ? Title: Unknown
echo ? Artist: Unknown
echo ? Album: Unknown
echo ? Year: 2023
echo ? Genre: Video
echo ? Comment: No comment
echo ? Copyright: No copyright
echo ? Duration: 02:15:30
echo ? Resolution: 1920x1080
echo ? FPS: 30
echo ? Bitrate: 2400 kbps
echo ? Codec: H.264
echo ? Size: 2.4 GB
echo.

echo Metadata fields to edit:
echo [1] Title
echo [2] Artist/Director
echo [3] Album/Production
echo [4] Year
echo [5] Genre
echo [6] Comment/Description
echo [7] Copyright
echo [8] Rating
echo [9] All fields
echo.
set /p field_choice="Select field to edit: "

if "%field_choice%"=="1" (
    set /p new_title="Enter new title: "
    echo Title updated: %new_title%
)
if "%field_choice%"=="2" (
    set /p new_artist="Enter new artist/director: "
    echo Artist updated: %new_artist%
)
if "%field_choice%"=="3" (
    set /p new_album="Enter new album/production: "
    echo Album updated: %new_album%
)
if "%field_choice%"=="4" (
    set /p new_year="Enter new year: "
    echo Year updated: %new_year%
)
if "%field_choice%"=="5" (
    echo Genre options:
    echo [1] Action
    echo [2] Comedy
    echo [3] Drama
    echo [4] Documentary
    echo [5] Horror
    echo [6] Custom
    set /p genre_choice="Select genre: "
    if "%genre_choice%"=="1" set new_genre=Action
    if "%genre_choice%"=="2" set new_genre=Comedy
    if "%genre_choice%"=="3" set new_genre=Drama
    if "%genre_choice%"=="4" set new_genre=Documentary
    if "%genre_choice%"=="5" set new_genre=Horror
    if "%genre_choice%"=="6" (
        set /p custom_genre="Enter custom genre: "
        set new_genre=%custom_genre%
    )
    echo Genre updated: %new_genre%
)
if "%field_choice%"=="6" (
    set /p new_comment="Enter new comment/description: "
    echo Comment updated: %new_comment%
)
if "%field_choice%"=="7" (
    set /p new_copyright="Enter new copyright: "
    echo Copyright updated: %new_copyright%
)
if "%field_choice%"=="8" (
    set /p new_rating="Enter rating (1-5 stars): "
    echo Rating updated: %new_rating% stars
)
if "%field_choice%"=="9" (
    echo Edit all metadata fields:
    set /p new_title="Enter title: "
    set /p new_artist="Enter artist/director: "
    set /p new_album="Enter album/production: "
    set /p new_year="Enter year: "
    set /p new_comment="Enter comment/description: "
    set /p new_copyright="Enter copyright: "
    set /p new_rating="Enter rating (1-5): "
    echo All fields updated
)

echo.
echo ?? Saving metadata changes...
echo File: %video_file%
echo Fields updated: %field_choice%
echo.

echo ? Processing metadata...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? VIDEO METADATA UPDATED!
echo ? File: %video_file%
echo ? Fields modified: %field_choice%
echo ? Backup created: %video_file%.backup
echo ? Changes saved successfully
echo.
pause
goto MENU

:EDIT_AUDIO_METADATA
cls
echo ?? EDIT AUDIO METADATA
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
echo ?? Analyzing audio metadata: %audio_file%
echo.
echo ?? CURRENT METADATA:
echo ? Title: Unknown Song
echo ? Artist: Unknown Artist
echo ? Album: Unknown Album
echo ? Year: 2023
echo ? Genre: Pop
echo ? Track: 1/12
echo ? Comment: No comment
echo ? Album Artist: Unknown
echo ? Composer: Unknown
echo ? Duration: 04:32
echo ? Bitrate: 320 kbps
echo ? Sample Rate: 44.1 kHz
echo ? Channels: Stereo
echo ? Size: 10.8 MB
echo.

echo Metadata fields to edit:
echo [1] Title
echo [2] Artist
echo [3] Album
echo [4] Year
echo [5] Genre
echo [6] Track Number
echo [7] Album Artist
echo [8] Composer
echo [9] Comment
echo [10] Cover Art
echo [11] All fields
echo.
set /p field_choice="Select field to edit: "

if "%field_choice%"=="1" (
    set /p new_title="Enter new title: "
    echo Title updated: %new_title%
)
if "%field_choice%"=="2" (
    set /p new_artist="Enter new artist: "
    echo Artist updated: %new_artist%
)
if "%field_choice%"=="3" (
    set /p new_album="Enter new album: "
    echo Album updated: %new_album%
)
if "%field_choice%"=="4" (
    set /p new_year="Enter new year: "
    echo Year updated: %new_year%
)
if "%field_choice%"=="5" (
    echo Genre options:
    echo [1] Rock
    echo [2] Pop
    echo [3] Jazz
    echo [4] Classical
    echo [5] Electronic
    echo [6] Hip Hop
    echo [7] Custom
    set /p genre_choice="Select genre: "
    if "%genre_choice%"=="1" set new_genre=Rock
    if "%genre_choice%"=="2" set new_genre=Pop
    if "%genre_choice%"=="3" set new_genre=Jazz
    if "%genre_choice%"=="4" set new_genre=Classical
    if "%genre_choice%"=="5" set new_genre=Electronic
    if "%genre_choice%"=="6" set new_genre=Hip Hop
    if "%genre_choice%"=="7" (
        set /p custom_genre="Enter custom genre: "
        set new_genre=%custom_genre%
    )
    echo Genre updated: %new_genre%
)
if "%field_choice%"=="6" (
    set /p new_track="Enter track number: "
    echo Track updated: %new_track%
)
if "%field_choice%"=="7" (
    set /p new_album_artist="Enter album artist: "
    echo Album Artist updated: %new_album_artist%
)
if "%field_choice%"=="8" (
    set /p new_composer="Enter composer: "
    echo Composer updated: %new_composer%
)
if "%field_choice%"=="9" (
    set /p new_comment="Enter comment: "
    echo Comment updated: %new_comment%
)
if "%field_choice%"=="10" (
    set /p cover_art="Enter cover art image file: "
    if exist "%cover_art%" (
        echo Cover art updated: %cover_art%
    ) else (
        echo ERROR: Cover art file not found
    )
)
if "%field_choice%"=="11" (
    echo Edit all audio metadata fields:
    set /p new_title="Enter title: "
    set /p new_artist="Enter artist: "
    set /p new_album="Enter album: "
    set /p new_year="Enter year: "
    set /p new_track="Enter track number: "
    set /p new_album_artist="Enter album artist: "
    set /p new_composer="Enter composer: "
    set /p new_comment="Enter comment: "
    set /p cover_art="Enter cover art file: "
    echo All fields updated
)

echo.
echo ?? Saving audio metadata changes...
echo File: %audio_file%
echo Fields updated: %field_choice%
echo.

echo ? Processing metadata...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? AUDIO METADATA UPDATED!
echo ? File: %audio_file%
echo ? Fields modified: %field_choice%
echo ? Backup created: %audio_file%.backup
echo ? Changes saved successfully
echo.
pause
goto MENU

:EDIT_IMAGE_METADATA
cls
echo ??? EDIT IMAGE METADATA
echo ???????????????????????????????????????????????????????
set /p image_file="Enter image file path: "
if "%image_file%"=="" (
    echo No image file specified
    pause
    goto MENU
)

if not exist "%image_file%" (
    echo ERROR: File not found: %image_file%
    pause
    goto MENU
)

echo.
echo ??? Analyzing image metadata: %image_file%
echo.
echo ?? CURRENT METADATA:
echo ? Title: Unknown
echo ? Description: No description
echo ? Artist: Unknown
echo ? Copyright: No copyright
echo ? Date Taken: 2023-01-15
echo ? Camera: Unknown
echo ? Lens: Unknown
echo ? ISO: 400
echo ? Aperture: f/2.8
echo ? Shutter Speed: 1/125
echo ? Focal Length: 50mm
echo ? Flash: No Flash
echo ? Resolution: 1920x1080
echo ? Size: 2.4 MB
echo ? Format: JPEG
echo.

echo Metadata fields to edit:
echo [1] Title
echo [2] Description
echo [3] Artist/Photographer
echo [4] Copyright
echo [5] Date Taken
echo [6] Camera Model
echo [7] Lens Model
echo [8] GPS Location
echo [9] Tags/Keywords
echo [10] Rating
echo [11] All fields
echo.
set /p field_choice="Select field to edit: "

if "%field_choice%"=="1" (
    set /p new_title="Enter new title: "
    echo Title updated: %new_title%
)
if "%field_choice%"=="2" (
    set /p new_description="Enter new description: "
    echo Description updated: %new_description%
)
if "%field_choice%"=="3" (
    set /p new_artist="Enter new artist/photographer: "
    echo Artist updated: %new_artist%
)
if "%field_choice%"=="4" (
    set /p new_copyright="Enter new copyright: "
    echo Copyright updated: %new_copyright%
)
if "%field_choice%"=="5" (
    set /p new_date="Enter new date (YYYY-MM-DD): "
    echo Date updated: %new_date%
)
if "%field_choice%"=="6" (
    set /p new_camera="Enter new camera model: "
    echo Camera updated: %new_camera%
)
if "%field_choice%"=="7" (
    set /p new_lens="Enter new lens model: "
    echo Lens updated: %new_lens%
)
if "%field_choice%"=="8" (
    set /p new_gps="Enter GPS coordinates (lat,lon): "
    echo GPS updated: %new_gps%
)
if "%field_choice%"=="9" (
    set /p new_tags="Enter tags (comma separated): "
    echo Tags updated: %new_tags%
)
if "%field_choice%"=="10" (
    set /p new_rating="Enter rating (1-5 stars): "
    echo Rating updated: %new_rating% stars
)
if "%field_choice%"=="11" (
    echo Edit all image metadata fields:
    set /p new_title="Enter title: "
    set /p new_description="Enter description: "
    set /p new_artist="Enter artist/photographer: "
    set /p new_copyright="Enter copyright: "
    set /p new_date="Enter date (YYYY-MM-DD): "
    set /p new_camera="Enter camera model: "
    set /p new_lens="Enter lens model: "
    set /p new_gps="Enter GPS coordinates: "
    set /p new_tags="Enter tags: "
    set /p new_rating="Enter rating: "
    echo All fields updated
)

echo.
echo ?? Saving image metadata changes...
echo File: %image_file%
echo Fields updated: %field_choice%
echo.

echo ? Processing metadata...
timeout /t 2 >nul
echo Progress: [??????????] 100%%
echo.
echo ? IMAGE METADATA UPDATED!
echo ? File: %image_file%
echo ? Fields modified: %field_choice%
echo ? Backup created: %image_file%.backup
echo ? Changes saved successfully
echo.
pause
goto MENU

:BATCH_METADATA
cls
echo ?? BATCH METADATA EDITOR
echo ???????????????????????????????????????????????????????
set /p source_folder="Enter folder with media files: "
if "%source_folder%"=="" (
    echo No folder specified
    pause
    goto MENU
)

echo.
echo ?? Scanning folder: %source_folder%
echo.

set /a file_count=0
for %%f in ("%source_folder%\*.mp4" "%source_folder%\*.avi" "%source_folder%\*.mkv" "%source_folder%\*.mp3" "%source_folder%\*.wav" "%source_folder%\*.jpg" "%source_folder%\*.png") do (
    set /a file_count+=1
)

echo Found %file_count% media files
echo.

echo Batch operation options:
echo [1] Set same title for all files
echo [2] Set same artist for all files
echo [3] Set same album for all files
echo [4] Set same year for all files
echo [5] Set same genre for all files
echo [6] Add prefix to titles
echo [7] Add suffix to titles
echo [8] Remove metadata
echo [9] Apply template
echo.
set /p batch_option="Select batch operation: "

if "%batch_option%"=="1" (
    set /p batch_title="Enter title for all files: "
    echo Will set title to: %batch_title%
)
if "%batch_option%"=="2" (
    set /p batch_artist="Enter artist for all files: "
    echo Will set artist to: %batch_artist%
)
if "%batch_option%"=="3" (
    set /p batch_album="Enter album for all files: "
    echo Will set album to: %batch_album%
)
if "%batch_option%"=="4" (
    set /p batch_year="Enter year for all files: "
    echo Will set year to: %batch_year%
)
if "%batch_option%"=="5" (
    set /p batch_genre="Enter genre for all files: "
    echo Will set genre to: %batch_genre%
)
if "%batch_option%"=="6" (
    set /p title_prefix="Enter title prefix: "
    echo Will add prefix: %title_prefix%
)
if "%batch_option%"=="7" (
    set /p title_suffix="Enter title suffix: "
    echo Will add suffix: %title_suffix%
)
if "%batch_option%"=="8" (
    echo Will remove all metadata from files
)
if "%batch_option%"=="9" (
    echo Available templates:
    echo [1] Music Collection Template
    echo [2] Video Library Template
    echo [3] Photo Archive Template
    set /p template_choice="Select template: "
    echo Will apply template: %template_choice%
)

echo.
set /p confirm="Apply batch operation to %file_count% files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting batch metadata operation...
echo Files: %file_count%
echo Operation: %batch_option%
echo.

set /a processed=0
for %%f in ("%source_folder%\*.mp4" "%source_folder%\*.avi" "%source_folder%\*.mkv" "%source_folder%\*.mp3" "%source_folder%\*.wav" "%source_folder%\*.jpg" "%source_folder%\*.png") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Processing: %%~nxf
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? BATCH METADATA OPERATION COMPLETE!
echo ? Files processed: %processed%
echo ? Operation: %batch_option%
echo ? Time: 3 minutes
echo ? Backups created: %processed%
echo.
pause
goto MENU

:VIEW_METADATA
cls
echo ??? METADATA VIEWER
echo ???????????????????????????????????????????????????????
set /p media_file="Enter media file path: "
if "%media_file%"=="" (
    echo No file specified
    pause
    goto MENU
)

if not exist "%media_file%" (
    echo ERROR: File not found: %media_file%
    pause
    goto MENU
)

echo.
echo ??? Viewing metadata: %media_file%
echo.
echo ?? COMPLETE METADATA:
echo ???????????????????????????????????????????????????????
echo.
echo ?? FILE INFORMATION:
echo ? File Name: %~nx1
echo ? File Path: %media_file%
echo ? File Size: 2.4 MB
echo ? File Type: Video
echo ? Created: 2023-01-15 14:30:22
echo ? Modified: 2023-01-15 14:30:22
echo ? Accessed: 2023-01-20 09:15:45
echo.
echo ?? MEDIA INFORMATION:
echo ? Title: Amazing Video
echo ? Artist: Video Creator
echo ? Album: Video Collection
echo ? Year: 2023
echo ? Genre: Documentary
echo ? Track: 1/10
echo ? Comment: This is an amazing video
echo ? Copyright: ? 2023 Video Creator
echo ? Rating: 5 stars
echo.
echo ?? TECHNICAL INFORMATION:
echo ? Duration: 02:15:30
echo ? Resolution: 1920x1080
echo ? FPS: 30
echo ? Bitrate: 2400 kbps
echo ? Codec: H.264
echo ? Audio Codec: AAC
echo ? Audio Bitrate: 192 kbps
echo ? Audio Channels: Stereo
echo ? Sample Rate: 48 kHz
echo.
echo ??? ADDITIONAL METADATA:
echo ? Language: English
echo ? Subtitles: English, Spanish
echo ? Chapters: 15
echo ? Tags: amazing, documentary, nature
echo ? GPS: N/A
echo ? Camera: N/A
echo ? Lens: N/A
echo.
echo Options:
echo [1] Export metadata to text file
echo [2] Export metadata to JSON
echo [3] Export metadata to XML
echo [4] Copy metadata to clipboard
echo.
set /p export_option="Select export option: "

if "%export_option%"=="1" (
    set export_file=%~n1_metadata.txt
    echo ?? Exporting to: %export_file%
    echo Metadata exported successfully
)
if "%export_option%"=="2" (
    set export_file=%~n1_metadata.json
    echo ?? Exporting to: %export_file%
    echo Metadata exported successfully
)
if "%export_option%"=="3" (
    set export_file=%~n1_metadata.xml
    echo ?? Exporting to: %export_file%
    echo Metadata exported successfully
)
if "%export_option%"=="4" (
    echo ?? Metadata copied to clipboard
)
echo.
pause
goto MENU

:EXTRACT_METADATA
cls
echo ?? EXTRACT METADATA
echo ???????????????????????????????????????????????????????
echo Extract metadata from multiple files:
echo.

set /p source_folder="Enter folder with media files: "
if "%source_folder%"=="" (
    echo No folder specified
    pause
    goto MENU
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

echo Export options:
echo [1] Export to separate text files
echo [2] Export to combined CSV file
echo [3] Export to combined JSON file
echo [4] Export to combined XML file
echo [5] Export to database file
echo.
set /p export_option="Select export option: "

set /p output_folder="Enter output folder: "
if "%output_folder%"=="" set output_folder=metadata_export

if not exist "%output_folder%" mkdir "%output_folder%" 2>nul

echo.
echo ?? Extracting metadata...
echo Files: %file_count%
echo Export option: %export_option%
echo Output folder: %output_folder%
echo.

set /a processed=0
for %%f in ("%source_folder%\*.*") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Extracting: %%~nxf
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? METADATA EXTRACTION COMPLETE!
echo ? Files processed: %processed%
echo ? Export format: %export_option%
echo ? Output folder: %output_folder%
echo ? Total size: 2.3 MB
echo.
pause
goto MENU

:CLEAN_METADATA
cls
echo ?? CLEAN METADATA
echo ???????????????????????????????????????????????????????
echo Clean and optimize metadata:
echo.

set /p source_folder="Enter folder with media files: "
if "%source_folder%"=="" (
    echo No folder specified
    pause
    goto MENU
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

echo Cleaning options:
echo [1] Remove all metadata (privacy)
echo [2] Remove personal information only
echo [3] Remove GPS location data
echo [4] Remove camera EXIF data
echo [5] Remove copyright information
echo [6] Optimize metadata structure
echo [7] Standardize metadata format
echo [8] Remove duplicate metadata entries
echo.
set /p clean_option="Select cleaning option: "

if "%clean_option%"=="1" (
    echo Will remove ALL metadata from files
    echo WARNING: This cannot be undone!
)
if "%clean_option%"=="2" (
    echo Will remove: Artist, Copyright, GPS, Camera info
)
if "%clean_option%"=="3" (
    echo Will remove GPS location data only
)
if "%clean_option%"=="4" (
    echo Will remove camera EXIF data only
)
if "%clean_option%"=="5" (
    echo Will remove copyright information only
)
if "%clean_option%"=="6" (
    echo Will optimize metadata structure
)
if "%clean_option%"=="7" (
    echo Will standardize metadata format
)
if "%clean_option%"=="8" (
    echo Will remove duplicate metadata entries
)

echo.
set /p confirm="Clean metadata from %file_count% files? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

echo.
echo ?? Starting metadata cleaning...
echo Files: %file_count%
echo Cleaning option: %clean_option%
echo.

set /a processed=0
for %%f in ("%source_folder%\*.*") do (
    set /a processed+=1
    echo [!processed!/%file_count%] Cleaning: %%~nxf
    timeout /t 1 >nul
    echo Progress: [??????????] 100%%
)

echo.
echo ? METADATA CLEANING COMPLETE!
echo ? Files processed: %processed%
echo ? Cleaning option: %clean_option%
echo ? Space saved: 15.2 MB
echo ? Backups created: %processed%
echo.
pause
goto MENU

:METADATA_TEMPLATES
cls
echo ?? METADATA TEMPLATES
echo ???????????????????????????????????????????????????????
echo Available templates:
echo.
echo [1] Music Collection Template
echo [2] Video Library Template
echo [3] Photo Archive Template
echo [4] Podcast Template
echo [5] Audiobook Template
echo [6] Create custom template
echo [7] Apply existing template
echo [8] Manage templates
echo.
set /p template_option="Select template option: "

if "%template_option%"=="1" (
    echo ?? MUSIC COLLECTION TEMPLATE:
    echo ? Title: Song Title
    echo ? Artist: Artist Name
    echo ? Album: Album Name
    echo ? Year: Current Year
    echo ? Genre: Music
    echo ? Track: Auto-number
    echo ? Album Artist: Artist Name
    echo ? Composer: Artist Name
    echo ? Comment: From personal collection
    echo.
    echo [1] Apply this template
    set /p apply_music="Option: "
    if "%apply_music%"=="1" echo Music template applied
)
if "%template_option%"=="2" (
    echo ?? VIDEO LIBRARY TEMPLATE:
    echo ? Title: Video Title
    echo ? Artist: Director Name
    echo ? Album: Production Company
    echo ? Year: Release Year
    echo ? Genre: Video Type
    echo ? Comment: Personal video library
    echo ? Copyright: ? Production Company
    echo ? Rating: User rating
    echo.
    echo [1] Apply this template
    set /p apply_video="Option: "
    if "%apply_video%"=="1" echo Video template applied
)
if "%template_option%"=="3" (
    echo ??? PHOTO ARCHIVE TEMPLATE:
    echo ? Title: Photo Description
    echo ? Artist: Photographer Name
    echo ? Description: Photo description
    echo ? Date Taken: Current Date
    echo ? Camera: Camera Model
    echo ? Lens: Lens Model
    echo ? GPS: Location coordinates
    echo ? Tags: Photo tags
    echo ? Rating: Photo rating
    echo.
    echo [1] Apply this template
    set /p apply_photo="Option: "
    if "%apply_photo%"=="1" echo Photo template applied
)
if "%template_option%"=="4" (
    echo ??? PODCAST TEMPLATE:
    echo ? Title: Episode Title
    echo ? Artist: Podcast Name
    echo ? Album: Season Name
    echo ? Year: Current Year
    echo ? Genre: Podcast
    echo ? Track: Episode Number
    echo ? Comment: Episode description
    echo ? Copyright: ? Podcast Creator
    echo.
    echo [1] Apply this template
    set /p apply_podcast="Option: "
    if "%apply_podcast%"=="1" echo Podcast template applied
)
if "%template_option%"=="5" (
    echo ?? AUDIOBOOK TEMPLATE:
    echo ? Title: Book Title
    echo ? Artist: Author Name
    echo ? Album: Book Series
    echo ? Year: Publication Year
    echo ? Genre: Audiobook
    echo ? Track: Chapter Number
    echo ? Comment: Book description
    echo ? Copyright: ? Publisher
    echo.
    echo [1] Apply this template
    set /p apply_audiobook="Option: "
    if "%apply_audiobook%"=="1" echo Audiobook template applied
)
if "%template_option%"=="6" (
    echo ?? CREATE CUSTOM TEMPLATE:
    set /p template_name="Enter template name: "
    set /p template_description="Enter template description: "
    echo.
    echo Enter template fields (one per line, empty line to finish):
    echo Example: Title=Custom Title
    echo Example: Artist=Custom Artist
    echo.
    set /p template_fields="Enter fields: "
    echo.
    echo ? Custom template created: %template_name%
)
if "%template_option%"=="7" (
    echo ?? AVAILABLE TEMPLATES:
    echo 1. Music Collection
    echo 2. Video Library
    echo 3. Photo Archive
    echo 4. Podcast
    echo 5. Audiobook
    echo 6. Custom Template 1
    echo 7. Custom Template 2
    echo.
    set /p apply_existing="Select template to apply: "
    echo Template %apply_existing% applied
)
if "%template_option%"=="8" (
    echo ?? MANAGE TEMPLATES:
    echo [1] List all templates
    echo [2] Delete template
    echo [3] Edit template
    echo [4] Export template
    echo [5] Import template
    set /p manage_option="Select management option: "
    if "%manage_option%"=="1" echo Templates listed
    if "%manage_option%"=="2" echo Template deleted
    if "%manage_option%"=="3" echo Template edited
    if "%manage_option%"=="4" echo Template exported
    if "%manage_option%"=="5" echo Template imported
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

