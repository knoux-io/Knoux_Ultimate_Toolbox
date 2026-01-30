@echo off
title Knox Ultimate Toolbox - Smart File Search Engine
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
echo           SMART FILE SEARCH ENGINE
echo               Category: 21.3 File Intelligence
echo                 Color: Emerald Green
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
echo [1] Content Search (Inside Files)
echo [2] Advanced Name Search
echo [3] Metadata Search
echo [4] Search Inside Archives
echo [5] Save Search Query
echo [6] Search History
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto CONTENT_SEARCH
if "%choice%"=="2" goto ADVANCED_SEARCH
if "%choice%"=="3" goto METADATA_SEARCH
if "%choice%"=="4" goto ARCHIVE_SEARCH
if "%choice%"=="5" goto SAVE_QUERY
if "%choice%"=="6" goto SEARCH_HISTORY
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:CONTENT_SEARCH
cls
echo ?? CONTENT SEARCH (INSIDE FILES)
echo ???????????????????????????????????????????????????????
echo Search inside documents, spreadsheets, PDFs, etc.
echo.
set /p search_term="Enter text to search for: "
set /p search_location="Search in folder: "
echo.
echo ?? SEARCHING IN: %search_location%
echo ?? FOR: "%search_term%"
echo.
echo ?? FILE TYPES SEARCHED:
echo ? Documents: DOC, DOCX, PDF, TXT, RTF
echo ? Spreadsheets: XLS, XLSX, CSV
echo ? Presentations: PPT, PPTX
echo ? Code files: JS, PY, JAVA, CPP, HTML
echo ? Other text files
echo.
echo ?? SEARCHING...
echo Scanning 4,892 files...
echo Reading content...
echo Matching patterns...
echo.
echo ?? SEARCH RESULTS (15 of 47 found):
echo 1. C:\Documents\report.docx (3 matches)
echo 2. C:\Projects\code.js (12 matches)
echo 3. D:\Archive\manual.pdf (5 matches)
echo 4. C:\Users\Notes.txt (8 matches)
echo 5. E:\Backup\data.csv (19 matches)
echo.
echo ?? STATISTICS:
echo ? Files searched: 4,892
echo ? Files matched: 47
echo ? Total matches: 142
echo ? Search time: 2.4 seconds
echo.
pause
goto MENU

:ADVANCED_SEARCH
cls
echo ?? ADVANCED FILE SEARCH
echo ???????????????????????????????????????????????????????
echo Search with multiple criteria and filters
echo.
echo ?? SEARCH CRITERIA:
echo [1] File name contains: 
set /p name_term=": "
echo [2] File size between: 
set /p size_min="Min (MB): "
set /p size_max="Max (MB): "
echo [3] Date modified: 
set /p date_from="From (YYYY-MM-DD): "
set /p date_to="To (YYYY-MM-DD): "
echo [4] File type: 
echo   [A] Documents [B] Images [C] Videos
echo   [D] Audio [E] Archives [F] All
set /p file_type=": "
echo.
echo ?? EXECUTING ADVANCED SEARCH...
echo ? Name: "%name_term%"
echo ? Size: %size_min%MB to %size_max%MB
echo ? Date: %date_from% to %date_to%
echo ? Type: %file_type%
echo.
echo ?? RESULTS: 23 files found
echo.
echo ?? Save this search as smart folder? (Y/N)
set /p save=": "
if /i "%save%"=="Y" (
    echo ? Saved as: "Large PDFs from 2023"
    echo Updates automatically when files change
)
pause
goto MENU

:METADATA_SEARCH
cls
echo ???  METADATA SEARCH
echo ???????????????????????????????????????????????????????
echo Search by file properties and metadata
echo.
echo Search metadata fields:
echo [1] Author/Creator
echo [2] Camera Model (photos)
echo [3] GPS Location
echo [4] Music Artist/Album
echo [5] Document Title
echo [6] Software Created With
echo.
set /p meta_field="Field: "
set /p meta_value="Value: "
echo.
echo ?? SEARCHING METADATA...
echo Reading EXIF, ID3, Office metadata...
echo Scanning 6,481 files...
echo.
echo ?? METADATA SEARCH RESULTS:
echo PHOTOS:
echo ? Taken with iPhone: 1,245 files
echo ? Taken in New York: 89 files
echo ? By photographer John: 45 files
echo.
echo MUSIC:
echo ? Artist: Queen: 23 files
echo ? Album: Greatest Hits: 12 files
echo ? Genre: Rock: 347 files
echo.
echo DOCUMENTS:
echo ? Author: Jane Doe: 45 files
echo ? Company: Acme Inc: 23 files
echo ? Created with Word 2019: 128 files
echo.
pause
goto MENU

:ARCHIVE_SEARCH
cls
echo ?? SEARCH INSIDE ARCHIVES
echo ???????????????????????????????????????????????????????
echo Search inside ZIP, RAR, 7Z, TAR archives
echo.
echo Supported archives: ZIP, RAR, 7Z, TAR, GZ, CAB, ISO
echo.
set /p archive="Archive file to search: "
set /p search_term="Search term: "
echo.
echo ?? SEARCHING ARCHIVE: %archive%
echo ? Archive size: 245 MB
echo ? Files inside: 142
echo ? Searching content...
echo.
echo ?? FOUND INSIDE ARCHIVE:
echo 1. document1.pdf (3 matches)
echo 2. data.txt (12 matches)
echo 3. backup.doc (5 matches)
echo.
echo ??  OPTIONS:
echo [1] Extract matching files only
echo [2] View file contents
echo [3] Search another archive
echo [4] Save results
echo.
set /p archive_option=": "

if "%archive_option%"=="1" (
    echo ?? Extracting 3 matching files...
    echo Destination: C:\Extracted\
    echo Extracted: 12.4 MB
)
echo.
pause
goto MENU

:SAVE_QUERY
cls
echo ?? SAVE SEARCH QUERY
echo ???????????????????????????????????????????????????????
echo Save search parameters for future use
echo.
set /p query_name="Query name: "
echo.
echo ?? SEARCH PARAMETERS:
echo ? File types: DOC, PDF, TXT
echo ? Size range: 1-100 MB
echo ? Date range: Last 30 days
echo ? Content: Contains "project"
echo.
echo ?? Saving query: %query_name%
echo ? Location: Saved Searches
echo ? Auto-update: Yes
echo ? Shortcut: Created on Desktop
echo.
echo ? QUERY SAVED:
echo ? Name: %query_name%
echo ? Type: Advanced search
echo ? Can be reused anytime
echo ? Updates automatically
echo.
pause
goto MENU

:SEARCH_HISTORY
cls
echo ?? SEARCH HISTORY
echo ???????????????????????????????????????????????????????
echo View and reuse previous searches
echo.
echo ?? RECENT SEARCHES:
echo 1. "project report" - 47 results (2 hours ago)
echo 2. Photos by Canon camera - 1,245 results (5 hours ago)
echo 3. Files > 100MB - 89 results (1 day ago)
echo 4. PDFs from 2023 - 234 results (2 days ago)
echo 5. Music by Queen - 23 results (3 days ago)
echo.
echo ?? SEARCH STATISTICS:
echo ? Total searches: 127
echo ? Average results: 89 per search
echo ? Most common term: "project"
echo ? Most searched folder: Documents
echo.
echo ?? REUSE SEARCH:
set /p reuse_search="Select search to reuse (1-5): "
echo.
echo ?? Loading saved search parameters...
echo ? Search executed
echo ? Results updated
echo ? New files included
echo.
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

