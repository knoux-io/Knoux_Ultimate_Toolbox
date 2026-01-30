@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Text Tools Menu
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
echo           📝 TEXT TOOLS
echo               Category: 13 Text Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Text Encryptor
echo [2] Encoding Converter
echo [3] Text Optimizer
echo [4] Text Cleaner
echo [5] Document Power Tools
echo [6] Word Counter
echo [7] Text Analyzer
echo [8] Format Converter
echo [9] Batch Text Processor
echo [10] Text Search & Replace
echo [11] Back to Main Menu
echo.
set /p choice="Select option (1-11): "

if "%choice%"=="1" call "%SCRIPT_DIR%01_text_encryptor.bat"
if "%choice%"=="2" call "%SCRIPT_DIR%02_encoding_converter.bat"
if "%choice%"=="3" call "%SCRIPT_DIR%03_text_optimizer.bat"
if "%choice%"=="4" call "%SCRIPT_DIR%04_text_cleaner.bat"
if "%choice%"=="5" call "%SCRIPT_DIR%05_document_power.bat"
if "%choice%"=="6" call "%SCRIPT_DIR%06_word_counter.bat"
if "%choice%"=="7" call "%SCRIPT_DIR%07_text_analyzer.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%08_format_converter.bat"
if "%choice%"=="9" call "%SCRIPT_DIR%09_batch_processor.bat"
if "%choice%"=="10" call "%SCRIPT_DIR%10_search_replace.bat"
if "%choice%"=="11" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU
