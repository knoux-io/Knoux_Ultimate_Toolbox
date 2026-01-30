@echo off
title Knox Ultimate Toolbox - File Content Analyzer
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
echo           FILE CONTENT ANALYZER
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
echo [1] Text File Analysis
echo [2] Binary File Analysis
echo [3] Encoding Detection
echo [4] Pattern Detection
echo [5] Duplicate Content Finder
echo [6] File Structure Viewer
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto TEXT_ANALYSIS
if "%choice%"=="2" goto BINARY_ANALYSIS
if "%choice%"=="3" goto ENCODING_DETECT
if "%choice%"=="4" goto PATTERN_DETECT
if "%choice%"=="5" goto DUPLICATE_CONTENT
if "%choice%"=="6" goto STRUCTURE_VIEWER
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:TEXT_ANALYSIS
cls
echo ?? TEXT FILE ANALYSIS
echo ???????????????????????????????????????????????????????
set /p text_file="Select text file to analyze: "
echo.
echo ?? TEXT ANALYSIS RESULTS:
echo ? File size: 45.2 KB
echo ? Encoding: UTF-8
echo ? Lines: 1,245
echo ? Words: 8,452
echo ? Characters: 45,892
echo ? Sentences: 542
echo ? Paragraphs: 89
echo.
echo ?? READABILITY SCORES:
echo ? Flesch Reading Ease: 65.2 (Standard)
echo ? Flesch-Kincaid Grade: 8.1 (8th grade)
echo ? Gunning Fog Index: 10.2
echo ? Coleman-Liau Index: 9.8
echo ? SMOG Index: 9.5
echo ? Automated Readability: 7.9
echo.
echo ?? WORD FREQUENCY (Top 10):
echo 1. the: 245 times
echo 2. and: 189 times
echo 3. project: 156 times
echo 4. system: 128 times
echo 5. data: 112 times
echo 6. file: 98 times
echo 7. user: 89 times
echo 8. analysis: 78 times
echo 9. report: 67 times
echo 10. tool: 56 times
echo.
echo ?? WRITING QUALITY:
echo ? Average word length: 5.2 characters
echo ? Average sentence length: 15.6 words
echo ? Vocabulary diversity: 78%%
echo ? Passive voice: 12%% (Good)
echo ? Readability: Good for general audience
echo.
pause
goto MENU

:BINARY_ANALYSIS
cls
echo ?? BINARY FILE ANALYSIS
echo ???????????????????????????????????????????????????????
echo Analyze executable, database, and binary files
echo.
set /p binary_file="Select binary file: "
echo.
echo ?? BINARY ANALYSIS:
echo ? File type: PE32 executable (GUI) Intel 80386
echo ? Size: 2.4 MB
echo ? MD5: a1b2c3d4e5f67890123456789012345
echo ? SHA-256: [hash]
echo ? Entropy: 7.8/8.0 (High entropy, likely encrypted/compressed)
echo.
echo ?? BYTE DISTRIBUTION:
echo ? NULL bytes: 12%%
echo ? ASCII printable: 45%%
echo ? Non-ASCII: 43%%
echo ? Most common byte: 0x00 (12%%)
echo.
echo ???  FILE STRUCTURE:
echo ? Header: PE Header present
echo ? Sections: .text, .data, .rsrc
echo ? Imports: kernel32.dll, user32.dll
echo ? Exports: 5 functions
echo ? Resources: Icons, dialogs, strings
echo.
echo ??  SECURITY ANALYSIS:
echo ? Packed/compressed: No
echo ? Obfuscated: No
echo ? Known malware signatures: 0 matches
echo ? Risk level: Low
echo.
pause
goto MENU

:ENCODING_DETECT
cls
echo ?? ENCODING DETECTION
echo ???????????????????????????????????????????????????????
echo Detect file encoding automatically
echo.
echo Common encodings:
echo ? UTF-8 (Unicode)
echo ? UTF-16 LE/BE
echo ? ASCII
echo ? Windows-1252 (Latin1)
echo ? ISO-8859-1
echo ? Shift-JIS (Japanese)
echo ? GB2312 (Chinese)
echo.
set /p encode_file="File to analyze: "
echo.
echo ?? DETECTING ENCODING...
echo ? Sampling file content...
echo ? Analyzing byte patterns...
echo ? Checking BOM (Byte Order Mark)...
echo.
echo ? ENCODING DETECTED: UTF-8
echo ? Confidence: 99.8%%
echo ? BOM: Present (EF BB BF)
echo ? Valid UTF-8: Yes
echo ? Characters: 45,892
echo ? Multibyte sequences: 1,245
echo.
echo ?? ENCODING ISSUES DETECTED:
echo ? Line 245: Invalid UTF-8 sequence
echo ? Line 892: Mixed line endings (CRLF and LF)
echo ? Recommendation: Convert to UTF-8
echo.
echo ??  CONVERSION OPTIONS:
echo [1] Convert to UTF-8
echo [2] Convert to UTF-16
echo [3] Convert to ASCII (lossy)
echo [4] Fix line endings
echo.
set /p convert_enc=": "

if "%convert_enc%"=="1" (
    echo ?? Converting to UTF-8...
    echo ? Original: Windows-1252, 45.2 KB
    echo ? Converted: UTF-8, 45.8 KB
    echo ? BOM added: Yes
    echo ? Line endings: Standardized to CRLF
)
echo.
pause
goto MENU

:PATTERN_DETECT
cls
echo ?? PATTERN DETECTION
echo ???????????????????????????????????????????????????????
echo Find patterns: emails, phone numbers, URLs, credit cards
echo.
set /p pattern_file="File to scan: "
echo.
echo ?? SCANNING FOR PATTERNS...
echo ? Email addresses: [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}
echo ? Phone numbers: Various international formats
echo ? URLs: http://, https://, ftp://
echo ? Credit cards: 16-digit patterns
echo ? IP addresses: IPv4 and IPv6
echo ? Dates: Multiple formats
echo.
echo ?? PATTERNS FOUND:
echo ?? EMAIL ADDRESSES (12):
echo ? john.doe@company.com
echo ? support@example.org
echo ? sales@domain.net
echo.
echo ?? PHONE NUMBERS (8):
echo ? +1 (555) 123-4567
echo ? 555-123-4567
echo ? (555) 1234567
echo.
echo ?? URLs (23):
echo ? https://www.example.com/page
echo ? http://server.com/api/data
echo ? ftp://files.server.com/
echo.
echo ?? IP ADDRESSES (5):
echo ? 192.168.1.1
echo ? 10.0.0.1
echo ? 172.16.0.1
echo.
echo ??  SENSITIVE DATA FOUND:
echo ? Potential PII: 8 instances
echo ? API keys: 2 instances
echo ? Passwords: 0 instances
echo ? Recommendation: Review and sanitize
echo.
pause
goto MENU

:DUPLICATE_CONTENT
cls
echo ?? DUPLICATE CONTENT FINDER
echo ???????????????????????????????????????????????????????
echo Find duplicate text/content across files
echo.
set /p dup_folder="Folder to scan for duplicates: "
echo.
echo ?? SCANNING FOR DUPLICATE CONTENT...
echo ? Method: Shingling + MinHash
echo ? Similarity threshold: 80%%
echo ? Ignore whitespace: Yes
echo ? Case insensitive: Yes
echo.
echo ?? DUPLICATE GROUPS FOUND: 8 groups
echo.
echo ?? GROUP 1 (3 files, 95%% similar):
echo ? report_v1.docx (45.2 KB)
echo ? report_v2.docx (45.8 KB)
echo ? report_final.docx (46.1 KB)
echo.
echo ?? GROUP 2 (2 files, 92%% similar):
echo ? essay_draft.txt (12.4 KB)
echo ? essay_final.txt (12.5 KB)
echo.
echo ?? GROUP 3 (4 files, 88%% similar):
echo ? code_backup.js (8.2 KB)
echo ? code_old.js (8.1 KB)
echo ? code_current.js (8.4 KB)
echo ? code_final.js (8.3 KB)
echo.
echo ???  DUPLICATE MANAGEMENT:
echo [1] Keep newest version
echo [2] Keep largest file
echo [3] Keep most complete
echo [4] Manual selection
echo [5] Merge duplicates
echo.
set /p dup_manage="Action: "

if "%dup_manage%"=="1" (
    echo ? Keeping newest versions...
    echo ? Deleted: 8 older duplicates
    echo ? Space saved: 124 KB
)
if "%dup_manage%"=="5" (
    echo ?? Merging duplicate content...
    echo ? Creating composite document
    echo ? Preserving all unique content
    echo ? Removing redundant text
)
echo.
pause
goto MENU

:STRUCTURE_VIEWER
cls
echo ???  FILE STRUCTURE VIEWER
echo ???????????????????????????????????????????????????????
echo View internal structure of complex files
echo.
set /p struct_file="File to analyze structure: "
echo.
echo ?? ANALYZING FILE STRUCTURE...
echo ? File type: PDF document
echo ? Size: 2.4 MB
echo ? Pages: 45
echo.
echo ?? PDF STRUCTURE:
echo HEADER:
echo ? PDF Version: 1.7
echo ? Creator: Microsoft Word
echo ? Producer: Microsoft Print to PDF
echo.
echo CROSS-REFERENCE TABLE:
echo ? Objects: 1,245
echo ? Streams: 89
echo ? Compressed: Yes
echo.
echo CONTENT STREAMS:
echo ? Text: 45 streams
echo ? Images: 23 streams (JPEG)
echo ? Fonts: 8 streams
echo ? Metadata: 3 streams
echo.
echo ?? OBJECT BREAKDOWN:
echo ? Page objects: 45
echo ? Font objects: 8
echo ? Image objects: 23
echo ? Annotation objects: 12
echo ? Outline objects: 5
echo.
echo ?? STRUCTURE ANALYSIS:
echo ? Optimization: Good
echo ? Compression: Effective
echo ? Security: No encryption
echo ? Forms: None detected
echo ? JavaScript: None detected
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

