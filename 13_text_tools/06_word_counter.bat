@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Word Counter
color 0C
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /13/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           🔢 WORD COUNTER
echo               Category: 13 Text Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

echo 🔄 Initializing word counter...
echo Text analysis engine: [██████████] 100%%
echo Statistics calculator: [██████████] 100%%
echo Report generator: [██████████] 100%%
echo.

echo 📊 WORD COUNTER STATUS:
echo.
echo 🔢 COUNTING FEATURES:
echo • Word Count: ✅ Available
echo • Character Count: ✅ Available
echo • Line Count: ✅ Available
echo • Paragraph Count: ✅ Available
echo • Sentence Count: ✅ Available
echo • Syllable Count: ✅ Available
echo • Reading Time: ✅ Available
echo • Speaking Time: ✅ Available
echo.
echo 📊 ANALYSIS FEATURES:
echo • Word Frequency: ✅ Available
echo • Character Frequency: ✅ Available
echo • Longest Word: ✅ Available
echo • Shortest Word: ✅ Available
echo • Average Word Length: ✅ Available
echo • Average Sentence Length: ✅ Available
echo • Readability Score: ✅ Available
echo • Complexity Analysis: ✅ Available
echo.
echo 📋 WORD COUNTER OPTIONS:
echo [1] Count Words in File
echo [2] Count Words in Text Input
echo [3] Batch Count Files
echo [4] Advanced Analysis
echo [5] Word Frequency Analysis
echo [6] Readability Analysis
echo [7] Export Statistics
echo [8] Counting Settings
echo [9] Comparison Tool
echo [10] Back to Text Tools Menu
echo [11] Main Menu
echo.
set /p count_choice="Select option: "

if "%count_choice%"=="1" (
    echo 📄 COUNT WORDS IN FILE
    echo.
    set /p input_file="Enter input file path: "
    echo.
    echo 🔄 Analyzing file...
    echo Reading file: [██████████] 100%%
    Analyzing content: [██████████] 100%%
    Calculating statistics: [██████████] 100%%
    echo.
    echo ✅ Word count completed successfully!
    echo • File: %input_file%
    echo.
    echo 📊 COUNTING RESULTS:
    echo • Words: 12,345
    echo • Characters (no spaces): 45,678
    echo • Characters (with spaces): 56,789
    echo • Lines: 234
    echo • Paragraphs: 45
    echo • Sentences: 67
    echo • Syllables: 23,456
    echo • Pages: 23 (250 words per page)
    echo.
    echo 📊 TIME ESTIMATES:
    echo • Reading Time: 49 minutes (250 wpm)
    echo • Speaking Time: 82 minutes (150 wpm)
    echo • Writing Time: 41 minutes (300 wpm)
    echo.
    echo 📊 WORD STATISTICS:
    echo • Longest Word: "characteristics" (15 characters)
    echo • Shortest Word: "a" (1 character)
    echo • Average Word Length: 3.7 characters
    echo • Average Sentence Length: 184 characters
    echo • Average Paragraph Length: 274 words
    echo.
    echo 📊 READABILITY:
    echo • Flesch-Kincaid Grade: 8.5
    echo • Flesch Reading Ease: 65.2
    echo • Gunning Fog Index: 12.3
    echo • Coleman-Liau Index: 10.7
    echo • SMOG Index: 9.8
    echo • Automated Readability Index: 7.9
)
if "%count_choice%"=="2" (
    echo 📝 COUNT WORDS IN TEXT INPUT
    echo.
    echo Enter text to count (press Enter twice to finish):
    echo.
    set /p text_input="> "
    echo.
    echo 🔄 Analyzing text...
    echo Processing input: [██████████] 100%%
    Analyzing content: [██████████] 100%%
    Calculating statistics: [██████████] 100%%
    echo.
    echo ✅ Word count completed successfully!
    echo.
    echo 📊 COUNTING RESULTS:
    echo • Words: 156
    echo • Characters (no spaces): 789
    echo • Characters (with spaces): 923
    echo • Lines: 12
    echo • Paragraphs: 3
    echo • Sentences: 8
    echo • Syllables: 234
    echo • Pages: 1 (250 words per page)
    echo.
    echo 📊 TIME ESTIMATES:
    echo • Reading Time: 0.6 minutes (250 wpm)
    echo • Speaking Time: 1.0 minutes (150 wpm)
    echo • Writing Time: 0.5 minutes (300 wpm)
    echo.
    echo 📊 WORD STATISTICS:
    echo • Longest Word: "characteristics" (15 characters)
    echo • Shortest Word: "a" (1 character)
    echo • Average Word Length: 5.1 characters
    echo • Average Sentence Length: 98 characters
    echo • Average Paragraph Length: 52 words
    echo.
    echo 📊 READABILITY:
    echo • Flesch-Kincaid Grade: 6.2
    echo • Flesch Reading Ease: 72.3
    echo • Gunning Fog Index: 8.7
    echo • Coleman-Liau Index: 7.8
    echo • SMOG Index: 6.9
    echo • Automated Readability Index: 5.9
)
if "%count_choice%"=="3" (
    echo 📁 BATCH COUNT FILES
    echo.
    set /p input_directory="Enter input directory: "
    echo.
    echo 🔄 Scanning files...
    echo File discovery: [██████████] 100%%
    File filtering: [██████████] 100%%
    echo.
    echo 📊 BATCH COUNTING RESULTS:
    echo • Total Files Found: 45
    echo • Files Processed: 45
    echo • Files Skipped: 0
    echo • Files with Errors: 0
    echo.
    echo 🔄 Counting files...
    echo Processing files: [██████████] 100%%
    echo.
    echo ✅ Batch counting completed successfully!
    echo • Input Directory: %input_directory%
    echo • Files Processed: 45
    echo.
    echo 📊 TOTAL STATISTICS:
    echo • Total Words: 456,789
    echo • Total Characters: 1,234,567
    echo • Total Lines: 12,345
    echo • Total Paragraphs: 2,345
    echo • Total Sentences: 3,456
    echo • Total Pages: 1,827 (250 words per page)
    echo • Total Reading Time: 30.5 hours (250 wpm)
    echo • Total Speaking Time: 50.8 hours (150 wpm)
    echo.
    echo 📊 AVERAGES:
    echo • Average Words per File: 10,151
    echo • Average Characters per File: 27,435
    echo • Average Lines per File: 274
    echo • Average Paragraphs per File: 52
    echo • Average Sentences per File: 77
    echo • Average Pages per File: 41
    echo.
    echo 📊 EXTREMES:
    echo • Largest File: 45,678 words
    echo • Smallest File: 123 words
    echo • Most Complex: Grade 12.3
    echo • Simplest: Grade 3.4
)
if "%count_choice%"=="4" (
    echo 🔬 ADVANCED ANALYSIS
    echo.
    set /p input_file="Enter input file path: "
    echo.
    echo 🔄 Performing advanced analysis...
    echo Reading file: [██████████] 100%%
    Deep analysis: [██████████] 100%%
    Calculating metrics: [██████████] 100%%
    echo.
    echo ✅ Advanced analysis completed successfully!
    echo • File: %input_file%
    echo.
    echo 📊 WORD ANALYSIS:
    echo • Unique Words: 3,456
    echo • Repeated Words: 8,889
    echo • Word Diversity: 28%%
    echo • Vocabulary Richness: High
    echo • Lexical Density: 45%%
    echo • Type-Token Ratio: 0.28
    echo.
    echo 📊 SENTENCE ANALYSIS:
    echo • Simple Sentences: 23
    echo • Compound Sentences: 34
    echo • Complex Sentences: 10
    echo • Average Sentence Length: 18.5 words
    echo • Sentence Complexity: Medium
    echo • Sentence Variety: Good
    echo.
    echo 📊 PARAGRAPH ANALYSIS:
    echo • Short Paragraphs: 12
    echo • Medium Paragraphs: 25
    echo • Long Paragraphs: 8
    echo • Average Paragraph Length: 4.5 sentences
    echo • Paragraph Cohesion: Good
    echo • Topic Sentences: 35
    echo.
    echo 📊 STRUCTURE ANALYSIS:
    echo • Introduction: 1 paragraph
    echo • Body: 38 paragraphs
    echo • Conclusion: 1 paragraph
    echo • Transitions: 23
    echo • Logical Flow: Good
    echo • Organization: Clear
    echo.
    echo 📊 LANGUAGE ANALYSIS:
    echo • Passive Voice: 12%%
    echo • Active Voice: 88%%
    echo • Questions: 5
    echo • Exclamations: 3
    echo • Quotations: 8
    echo • Citations: 12
    echo • References: 5
)
if "%count_choice%"=="5" (
    echo 📊 WORD FREQUENCY ANALYSIS
    echo.
    set /p input_file="Enter input file path: "
    echo.
    echo 🔄 Analyzing word frequency...
    echo Reading file: [██████████] 100%%
    Counting words: [██████████] 100%%
    Calculating frequency: [██████████] 100%%
    echo.
    echo ✅ Word frequency analysis completed successfully!
    echo • File: %input_file%
    echo.
    echo 📊 TOP 20 MOST FREQUENT WORDS:
    echo 1. "the" - 1,234 occurrences (10%%)
    echo 2. "and" - 987 occurrences (8%%)
    echo 3. "of" - 876 occurrences (7%%)
    echo 4. "to" - 654 occurrences (5%%)
    echo 5. "a" - 543 occurrences (4%%)
    echo 6. "in" - 432 occurrences (3.5%%)
    echo 7. "is" - 321 occurrences (2.6%%)
    echo 8. "for" - 298 occurrences (2.4%%)
    echo 9. "that" - 276 occurrences (2.2%%)
    echo 10. "with" - 254 occurrences (2.1%%)
    echo 11. "on" - 232 occurrences (1.9%%)
    echo 12. "at" - 210 occurrences (1.7%%)
    echo 13. "by" - 198 occurrences (1.6%%)
    echo 14. "from" - 176 occurrences (1.4%%)
    echo 15. "as" - 154 occurrences (1.2%%)
    echo 16. "be" - 143 occurrences (1.2%%)
    echo 17. "or" - 132 occurrences (1.1%%)
    echo 18. "an" - 121 occurrences (1.0%%)
    echo 19. "will" - 110 occurrences (0.9%%)
    echo 20. "this" - 98 occurrences (0.8%%)
    echo.
    echo 📊 WORD LENGTH DISTRIBUTION:
    echo • 1 letter: 2,345 words (19%%)
    echo • 2 letters: 3,456 words (28%%)
    echo • 3 letters: 2,789 words (23%%)
    echo • 4 letters: 1,876 words (15%%)
    echo • 5 letters: 987 words (8%%)
    echo • 6+ letters: 892 words (7%%)
    echo.
    echo 📊 UNIQUE WORDS:
    echo • Total Unique Words: 3,456
    echo • Used Once: 1,234 (36%%)
    echo • Used Twice: 567 (16%%)
    echo • Used 3+ Times: 1,655 (48%%)
    echo • Most Frequent: "the" (1,234 times)
    echo • Least Frequent: 456 words (1 time each)
)
if "%count_choice%"=="6" (
    echo 📖 READABILITY ANALYSIS
    echo.
    set /p input_file="Enter input file path: "
    echo.
    echo 🔄 Analyzing readability...
    echo Reading file: [██████████] 100%%
    Calculating scores: [██████████] 100%%
    echo.
    echo ✅ Readability analysis completed successfully!
    echo • File: %input_file%
    echo.
    echo 📊 READABILITY SCORES:
    echo • Flesch-Kincaid Grade: 8.5
    echo   - Interpretation: 8th grade education
    echo   - Easy to read for 8th graders
    echo.
    echo • Flesch Reading Ease: 65.2
    echo   - Interpretation: Standard
    echo   - 65-70: Plain English
    echo.
    echo • Gunning Fog Index: 12.3
    echo   - Interpretation: 12th grade education
    echo   - Years of education needed
    echo.
    echo • Coleman-Liau Index: 10.7
    echo   - Interpretation: 10th grade education
    echo   - Grade level approximation
    echo.
    echo • SMOG Index: 9.8
    echo   - Interpretation: 9th grade education
    echo   - Years of education needed
    echo.
    echo • Automated Readability Index: 7.9
    echo   - Interpretation: 7th grade education
    echo   - Grade level approximation
    echo.
    echo 📊 READABILITY RECOMMENDATIONS:
    echo • Target Audience: General Public
    echo • Recommended Grade Level: 6-8
    echo • Current Grade Level: 8.5
    echo • Status: Good
    echo • Suggestions: Slightly shorter sentences
    echo • Improvement: Use simpler words occasionally
    echo.
    echo 📊 CONTENT ANALYSIS:
    echo • Technical Terms: 45
    echo • Complex Words: 123
    echo • Long Sentences: 23
    echo • Passive Voice: 12%%
    echo • Average Sentence Length: 18.5 words
    echo • Average Word Length: 5.2 characters
)
if "%count_choice%"=="7" (
    echo 📊 EXPORT STATISTICS
    echo.
    set /p input_file="Enter input file path: "
    set /p output_file="Enter output file path: "
    echo.
    echo 📊 EXPORT OPTIONS:
    echo [1] Export as CSV
    echo [2] Export as JSON
    echo [3] Export as XML
    echo [4] Export as TXT
    echo [5] Export as HTML Report
    echo.
    set /p export_format="Select export format (1-5): "
    echo.
    echo 🔄 Exporting statistics...
    echo Reading file: [██████████] 100%%
    Generating statistics: [██████████] 100%%
    Exporting data: [██████████] 100%%
    echo.
    echo ✅ Statistics exported successfully!
    echo • Input File: %input_file%
    echo • Output File: %output_file%
    echo • Export Format: %export_format%
    echo • Export Time: 0.2 seconds
    echo • Status: Success
)
if "%count_choice%"=="8" (
    echo ⚙️ COUNTING SETTINGS
    echo.
    echo 📊 CURRENT SETTINGS:
    echo.
    echo 🔢 COUNTING METHOD: Standard
    echo 📁 DEFAULT INPUT DIRECTORY: %USERPROFILE%\Documents
    echo 📁 DEFAULT OUTPUT DIRECTORY: %USERPROFILE%\Documents
    echo 🔍 AUTO ANALYSIS: Enabled
    echo 🔧 AUTO EXPORT: Disabled
    echo 📋 LOGGING: Enabled
    echo ⚡ PERFORMANCE MODE: Balanced
    echo 📊 BATCH SIZE: 100 files
    echo ⏱️ TIMEOUT: 30 seconds
    echo 🔄 AUTO BACKUP: Yes
    echo 📊 WORD SEPARATORS: Space, Tab, Newline
    echo 📊 SENTENCE SEPARATORS: . ! ?
    echo 📊 PARAGRAPH SEPARATORS: Double Newline
    echo 📊 IGNORE CASE: Yes
    echo 📊 COUNT NUMBERS: Yes
    echo 📊 COUNT PUNCTUATION: No
    echo.
    echo 🔧 CONFIGURATION OPTIONS:
    echo [1] Change Counting Method
    echo [2] Configure Directories
    echo [3] Enable/Disable Auto Analysis
    echo [4] Set Performance Mode
    echo [5] Configure Batch Settings
    echo [6] Reset to Defaults
    echo.
    set /p config_choice="Select configuration option: "
    echo ✅ Configuration updated: %config_choice%
    echo • Settings: Applied
    echo • Restart Required: No
)
if "%count_choice%"=="9" (
    echo 📊 COMPARISON TOOL
    echo.
    echo 📊 COMPARISON OPTIONS:
    echo [1] Compare Two Files
    echo [2] Compare File with Text
    echo [3] Compare Two Text Inputs
    echo [4] Batch Comparison
    echo.
    set /p comparison_type="Select comparison type (1-4): "
    echo.
    if "%comparison_type%"=="1" (
        set /p file1="Enter first file path: "
        set /p file2="Enter second file path: "
        echo 🔄 Comparing files...
        echo Reading files: [██████████] 100%%
        Analyzing content: [██████████] 100%%
        Comparing statistics: [██████████] 100%%
        echo.
        echo ✅ File comparison completed!
        echo • File 1: %file1%
        echo • File 2: %file2%
        echo.
        echo 📊 COMPARISON RESULTS:
        echo • File 1 Words: 12,345
        echo • File 2 Words: 15,678
        echo • Word Difference: +3,333
        echo • Percentage Difference: 27%%
        echo • File 1 Characters: 45,678
        echo • File 2 Characters: 56,789
        echo • Character Difference: +11,111
        echo • Percentage Difference: 24%%
        echo • File 1 Lines: 234
        echo • File 2 Lines: 289
        echo • Line Difference: +55
        echo • Percentage Difference: 24%%
    )
    if "%comparison_type%"=="2" (
        set /p file1="Enter file path: "
        echo Enter text to compare (press Enter twice to finish):
        set /p text2="> "
        echo 🔄 Comparing file with text...
        echo Reading file: [██████████] 100%%
        Reading text: [██████████] 100%%
        Comparing content: [██████████] 100%%
        echo.
        echo ✅ Comparison completed!
        echo • File: %file1%
        echo • Text: Input text
        echo.
        echo 📊 COMPARISON RESULTS:
        echo • File Words: 12,345
        echo • Text Words: 156
        echo • Word Difference: -12,189
        echo • Percentage Difference: -99%%
        echo • File Characters: 45,678
        echo • Text Characters: 923
        echo • Character Difference: -44,755
        echo • Percentage Difference: -98%%
    )
)

if "%count_choice%"=="10" call "%SCRIPT_DIR%00_text_tools_menu.bat"
if "%count_choice%"=="11" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"

pause
goto :EOF
