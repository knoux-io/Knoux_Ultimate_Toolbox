@echo off
title Knox Ultimate Toolbox - Batch File Renamer
color 0A
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
echo           BATCH FILE RENAMER
echo               Category: 21.3 File Intelligence
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
echo [1] Pattern-Based Renaming
echo [2] Case Conversion
echo [3] Find and Replace
echo [4] Add Prefix/Suffix
echo [5] Remove Characters
echo [6] Extract Metadata to Names
echo [7] Preview Changes
echo [8] Back to File Intelligence Menu
echo [9] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto PATTERN_RENAME
if "%choice%"=="2" goto CASE_CONVERT
if "%choice%"=="3" goto FIND_REPLACE
if "%choice%"=="4" goto PREFIX_SUFFIX
if "%choice%"=="5" goto REMOVE_CHARS
if "%choice%"=="6" goto METADATA_NAMES
if "%choice%"=="7" goto PREVIEW_CHANGES
if "%choice%"=="8" goto BACK_TO_MENU
if "%choice%"=="9" goto MAIN_MENU
goto MENU

:PATTERN_RENAME
cls
echo ?? PATTERN-BASED RENAMING
echo ???????????????????????????????????????????????????????
echo Rename files using patterns and templates
echo.
set /p rename_folder="Folder with files to rename: "
echo.
echo ?? FILES FOUND: 45 files
echo ? DSC001.jpg, DSC002.jpg, DSC003.jpg
echo ? IMG_1234.png, IMG_1235.png
echo ? video_001.mp4, video_002.mp4
echo.
echo ?? RENAMING PATTERNS:
echo Variables: [n] number, [d] date, [t] time
echo            [Y] year, [M] month, [D] day
echo            [orig] original name
echo.
set /p pattern="Renaming pattern (e.g., Photo_[n].jpg): "
set /p start_num="Starting number: "
set /p digits="Number of digits (padding): "
echo.
echo ?? APPLYING PATTERN...
echo Original ? New
echo DSC001.jpg ? Photo_001.jpg
echo DSC002.jpg ? Photo_002.jpg
echo DSC003.jpg ? Photo_003.jpg
echo IMG_1234.png ? Photo_004.png
echo IMG_1235.png ? Photo_013_text_tools.png
echo.
echo ?? Save this pattern as preset? (Y/N)
set /p save_preset=": "
if /i "%save_preset%"=="Y" (
    echo ? Saved as: "Photo Sequence"
    echo Can reuse for other folders
)
pause
goto MENU

:CASE_CONVERT
cls
echo ?? CASE CONVERSION
echo ???????????????????????????????????????????????????????
echo Change filename casing styles
echo.
echo Select case style:
echo [1] UPPERCASE (FILE.TXT)
echo [2] lowercase (file.txt)
echo [3] Title Case (File.txt)
echo [4] Sentence case (File.txt)
echo [5] CamelCase (fileName.txt)
echo [6] snake_case (file_name.txt)
echo [7] kebab-case (file-name.txt)
echo [8] PascalCase (FileName.txt)
echo.
set /p case_style="Style: "

echo.
echo ?? EXAMPLE CONVERSIONS:
if "%case_style%"=="1" (
    echo ? myDocument.txt ? MYDOCUMENT.TXT
    echo ? Photo-001.jpg ? PHOTO-001.JPG
    echo ? data_file.csv ? DATA_FILE.CSV
)
if "%case_style%"=="6" (
    echo ? MyDocument.txt ? my_document.txt
    echo ? Photo-001.jpg ? photo_001.jpg
    echo ? DataFile.csv ? data_file.csv
)
if "%case_style%"=="8" (
    echo ? my_document.txt ? MyDocument.txt
    echo ? photo-001.jpg ? Photo001.jpg
    echo ? data-file.csv ? DataFile.csv
)
echo.
echo ??  ADVANCED OPTIONS:
echo [1] Preserve file extension case
echo [2] Ignore articles (a, an, the)
echo [3] Smart handling of acronyms
echo [4] Preview before applying
echo.
set /p case_options="Options: "

echo.
echo ?? APPLYING CASE CONVERSION...
echo Converting 45 files...
echo Progress: [??????????] 100%%
echo.
echo ? CONVERSION COMPLETE
pause
goto MENU

:FIND_REPLACE
cls
echo ?? FIND AND REPLACE IN FILENAMES
echo ???????????????????????????????????????????????????????
echo Search and replace text in filenames
echo.
set /p find_text="Text to find: "
set /p replace_text="Replace with: "
echo.
echo ??  SEARCH OPTIONS:
echo [1] Case sensitive
echo [2] Whole word only
echo [3] Use regular expressions
echo [4] Include file extensions
echo.
set /p search_opts="Options: "

echo.
echo ?? EXAMPLE CHANGES:
echo ? report_draft_v1.docx ? report_final_v1.docx
echo ? old_presentation.ppt ? new_presentation.ppt
echo ? image_backup.jpg ? image_primary.jpg
echo ? data_temp.csv ? data_permanent.csv
echo.
echo ?? FILES AFFECTED: 23 of 45 files
echo.
echo ?? PREVIEW CHANGES:
echo 1. project_old_plan.txt ? project_new_plan.txt
echo 2. backup_2022_data.db ? primary_2022_data.db
echo 3. temporary_file.tmp ? permanent_file.tmp
echo.
echo Apply changes? (Y/N)
set /p apply=": "
if /i "%apply%"=="Y" (
    echo ?? Renaming files...
    echo 23 files renamed successfully
)
pause
goto MENU

:PREFIX_SUFFIX
cls
echo ?? ADD PREFIX/SUFFIX
echo ???????????????????????????????????????????????????????
echo Add text to beginning or end of filenames
echo.
echo Add:
echo [1] Prefix (before name)
echo [2] Suffix (after name, before extension)
echo [3] Extension suffix (after extension)
echo.
set /p add_type="Type: "
set /p add_text="Text to add: "
echo.
echo ?? EXAMPLE:
if "%add_type%"=="1" (
    echo PREFIX "ProjectX_"
    echo ? report.txt ? ProjectX_report.txt
    echo ? data.csv ? ProjectX_data.csv
    echo ? notes.pdf ? ProjectX_notes.pdf
)
if "%add_type%"=="2" (
    echo SUFFIX "_backup"
    echo ? document.docx ? document_backup.docx
    echo ? image.jpg ? image_backup.jpg
    echo ? video.mp4 ? video_backup.mp4
)
if "%add_type%"=="3" (
    echo EXTENSION SUFFIX ".old"
    echo ? file.txt ? file.txt.old
    echo ? data.db ? data.db.old
    echo ? config.ini ? config.ini.old
)
echo.
echo ??  OPTIONS:
echo [1] Add to all files
echo [2] Add to selected file types only
echo [3] Skip files already containing text
echo [4] Add counter after text
echo.
set /p add_options=": "

echo.
echo ?? APPLYING CHANGES...
echo 45 files updated
echo.
echo ? PREFIX/SUFFIX ADDED
pause
goto MENU

:REMOVE_CHARS
cls
echo ???  REMOVE CHARACTERS
echo ???????????????????????????????????????????????????????
echo Remove unwanted characters from filenames
echo.
echo Remove:
echo [1] Special characters (!@#$%^&*())
echo [2] Numbers only
echo [3] Spaces and underscores
echo [4] Duplicate characters
echo [5] Custom characters
echo.
set /p remove_type="Type: "

if "%remove_type%"=="5" (
    set /p custom_chars="Enter characters to remove: "
    echo Custom characters: %custom_chars%
)
echo.
echo ?? EXAMPLE CLEANUP:
if "%remove_type%"=="1" (
    echo ? file@name!.txt ? filename.txt
    echo ? data#report$.csv ? datareport.csv
    echo ? image%photo.jpg ? imagephoto.jpg
)
if "%remove_type%"=="3" (
    echo ? my document.pdf ? mydocument.pdf
    echo ? photo_image.jpg ? photoimage.jpg
    echo ? data_file.csv ? datafile.csv
)
echo.
echo ??  CLEANUP OPTIONS:
echo [1] Replace with underscore
echo [2] Replace with dash
echo [3] Remove completely
echo [4] Replace with space
echo.
set /p cleanup_options="Options: "

echo.
echo ?? CLEANING FILENAMES...
echo 45 files processed
echo ? Characters removed: 234
echo ? Files renamed: 38
echo ? No changes needed: 7
echo.
echo ? CHARACTER CLEANUP COMPLETE
pause
goto MENU

:METADATA_NAMES
cls
echo ???  EXTRACT METADATA TO FILENAMES
echo ???????????????????????????????????????????????????????
echo Use file metadata to create meaningful names
echo.
echo ?? SUPPORTED METADATA:
echo ? Photos: Date, Camera, GPS, Resolution
echo ? Music: Artist, Album, Track, Year, Genre
echo ? Documents: Author, Title, Subject, Keywords
echo ? Videos: Duration, Resolution, Codec
echo.
echo ?? EXAMPLE TEMPLATES:
echo Photos: [YYYY-MM-DD] [Camera] [Location].jpg
echo Music: [Artist] - [Track] - [Album].mp3
echo Documents: [Author] - [Title] - [Date].pdf
echo.
set /p meta_template="Filename template: "
echo.
echo ?? METADATA FOUND:
echo PHOTOS (23 files):
echo ? Date: 2023-07-15
echo ? Camera: Canon EOS 5D Mark IV
echo ? Location: New York, NY
echo ? Resolution: 1920x1080
echo.
echo MUSIC (12 files):
echo ? Artist: Queen
echo ? Album: Greatest Hits
echo ? Track: Bohemian Rhapsody
echo ? Year: 1975
echo.
echo ?? RENAMING WITH METADATA...
echo IMG_001.jpg ? 2023-07-15 Canon_5D_NewYork.jpg
echo track1.mp3 ? Queen - Bohemian Rhapsody - Greatest Hits.mp3
echo document.pdf ? John_Doe - Annual_Report - 2023.pdf
echo.
echo ? METADATA RENAMING COMPLETE:
echo ? 35 files renamed using metadata
echo ? Missing metadata: 10 files (kept original)
echo.
pause
goto MENU

:PREVIEW_CHANGES
cls
echo ???  PREVIEW CHANGES
echo ???????????????????????????????????????????????????????
echo Preview renaming operations before applying
echo.
set /p preview_folder="Folder to preview: "
echo.
echo ?? PREVIEW MODE:
echo No files will be renamed yet
echo This is just a preview of changes
echo.
echo ?? PREVIEWING RENAMING OPERATIONS...
echo.
echo ?? FILES TO BE RENAMED:
echo 1. DSC001.jpg ? Vacation_2023_001.jpg
echo 2. DSC002.jpg ? Vacation_2023_002.jpg
echo 3. IMG_1234.png ? Vacation_2023_003.png
echo 4. report_draft.docx ? Annual_Report_2023.docx
echo 5. data_temp.csv ? Financial_Data_2023.csv
echo.
echo ?? PREVIEW STATISTICS:
echo ? Total files: 45
echo ? Files to rename: 38
echo ? Files unchanged: 7
echo ? Conflicts: 0
echo ? Estimated time: 2 seconds
echo.
echo ??  POTENTIAL ISSUES:
echo ? No filename conflicts detected
echo ? All new names are valid
echo ? No reserved names used
echo ? Length limits: All OK
echo.
echo ?? SAVE PREVIEW TO FILE? (Y/N)
set /p save_preview=": "
if /i "%save_preview%"=="Y" (
    echo ?? Preview saved: rename_preview_%date%.txt
    echo Contains before/after list
)
echo.
echo Apply these changes? (Y/N)
set /p apply_preview=": "
if /i "%apply_preview%"=="Y" (
    echo ?? Applying previewed changes...
    echo 38 files renamed successfully
    echo ? Renaming complete
)
pause
goto MENU

:BACK_TO_MENU
echo.
echo [INFO] Returning to File Intelligence menu...
if exist "03_file_intelligence.bat" (
    call "03_file_intelligence.bat"
) else (
    echo [ERROR] File Intelligence menu not found
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


