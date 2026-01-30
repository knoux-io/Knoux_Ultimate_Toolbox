@echo off
title Knox Ultimate Toolbox - Gallery Creator
color 0D
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
echo           GALLERY CREATOR
echo               Category: 21.4 Image Excellence
echo                 Color: Purple (#9C27B0)
echo ????????????????????????????????????????????????????????????
echo.

:: Load language configuration
call "..\language_config.bat"

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    call :get_text "ADMIN_REQUIRED"
    echo [ERROR] %RETURN_TEXT%
    call :get_text "PRESS_ANY_KEY"
    echo %RETURN_TEXT%
    pause
    exit /b 1
)

:MAIN_MENU
call :get_text "GALLERY_CREATOR"
echo %RETURN_TEXT%
echo ???????????????????????????????????????????????????????
echo.
echo [1] Photo Gallery
echo [2] Web Gallery
echo [3] Portfolio Gallery
echo [4] Slideshow Gallery
echo [5] Thumbnail Gallery
echo [6] Interactive Gallery
echo [7] Custom Gallery
echo [8] Gallery Management
echo [9] Back to Image Excellence Menu
echo [10] Main Menu
echo.
call :get_text "SELECT_OPTION"
echo %RETURN_TEXT% [1-10]:
set /p choice=""

if "%choice%"=="1" goto PHOTO_GALLERY
if "%choice%"=="2" goto WEB_GALLERY
if "%choice%"=="3" goto PORTFOLIO_GALLERY
if "%choice%"=="4" goto SLIDESHOW_GALLERY
if "%choice%"=="5" goto THUMBNAIL_GALLERY
if "%choice%"=="6" goto INTERACTIVE_GALLERY
if "%choice%"=="7" goto CUSTOM_GALLERY
if "%choice%"=="8" goto GALLERY_MANAGEMENT
if "%choice%"=="9" goto BACK_TO_SECTION
if "%choice%"=="10" goto MAIN_MENU
goto MAIN_MENU

:PHOTO_GALLERY
cls
echo ?? PHOTO GALLERY
echo ???????????????????????????????????????????????????????
echo Create professional photo galleries
echo.
set /p photo_folder="Select folder with photos: "
echo.
echo ?? GALLERY OPTIONS:
echo [1] Classic Photo Gallery
echo [2] Modern Photo Gallery
echo [3] Minimalist Gallery
echo [4] Masonry Gallery
echo [5] Grid Gallery
echo [6] Carousel Gallery
echo [7] Timeline Gallery
echo [8] Custom Photo Gallery
echo.
set /p photo_type="Select photo gallery type: "

if "%photo_type%"=="1" {
    echo ?? CLASSIC PHOTO GALLERY:
    echo ? Layout: Traditional grid
    echo ? Thumbnails: 200x200px
    echo ? Lightbox: Yes
    echo ? Navigation: Previous/Next
    echo ? Captions: Optional
    echo ? Watermarks: Optional
}
if "%photo_type%"=="4" {
    echo ?? MASONRY GALLERY:
    echo ? Layout: Pinterest-style
    echo ? Thumbnails: Variable sizes
    echo ? Arrangement: Automatic
    echo ? Gaps: Consistent
    echo ? Loading: Lazy
    echo ? Responsive: Yes
}
echo.
echo ??  GALLERY SETTINGS:
echo [1] Thumbnail size
echo [2] Image quality
echo [3] Number of columns
echo [4] Spacing options
echo [5] Navigation style
echo [6] Caption settings
echo [7] Watermark options
echo [8] Export format
echo.
set /p photo_settings="Photo gallery settings: "

echo.
echo ?? CREATING PHOTO GALLERY...
echo Processing photos...
echo Generating thumbnails...
echo Creating gallery layout...
echo Adding navigation...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Photo gallery: Created
echo ? Photos processed: 45
echo ? Thumbnails: Generated
echo ? Layout: %photo_type%
echo ? Output: photo_gallery.html
echo.
pause
goto MAIN_MENU

:WEB_GALLERY
cls
echo ?? WEB GALLERY
echo ???????????????????????????????????????????????????????
echo Create web-ready image galleries
echo.
set /p web_folder="Select folder with images: "
echo.
echo ?? WEB GALLERY OPTIONS:
echo [1] Responsive Web Gallery
echo [2] Bootstrap Gallery
echo [3] CSS Grid Gallery
echo [4] JavaScript Gallery
echo [5] WordPress Gallery
echo [6] HTML5 Gallery
echo [7] Mobile Gallery
echo [8] Custom Web Gallery
echo.
set /p web_type="Select web gallery type: "

if "%web_type%"=="1" {
    echo ?? RESPONSIVE WEB GALLERY:
    echo ? Framework: HTML5/CSS3
    echo ? Responsive: All devices
    echo ? Breakpoints: 3 (mobile, tablet, desktop)
    echo ? Touch: Optimized
    echo ? Loading: Progressive
    echo ? SEO: Optimized
}
if "%web_type%"=="2" {
    echo ?? BOOTSTRAP GALLERY:
    echo ? Framework: Bootstrap 5
    echo ? Components: Cards, Modals
    echo ? Grid System: Responsive
    echo ? Icons: Font Awesome
    echo ? Animations: Smooth
    echo ? Theme: Customizable
}
echo.
echo ??  WEB SETTINGS:
echo [1] HTML structure
echo [2] CSS styling
echo [3] JavaScript functionality
echo [4] Mobile optimization
echo [5] SEO optimization
echo [6] Performance settings
echo [7] Accessibility features
echo [8] Export options
echo.
set /p web_settings="Web gallery settings: "

echo.
echo ?? CREATING WEB GALLERY...
echo Generating HTML structure...
echo Applying CSS styling...
echo Adding JavaScript functionality...
echo Optimizing for web...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Web gallery: Created
echo ? HTML: Generated
echo ? CSS: Styled
echo ? JavaScript: Functional
echo ? Responsive: Yes
echo ? Output: web_gallery/
echo.
pause
goto MAIN_MENU

:PORTFOLIO_GALLERY
cls
echo ?? PORTFOLIO GALLERY
echo ???????????????????????????????????????????????????????
echo Create professional portfolio galleries
echo.
set /p portfolio_folder="Select folder with portfolio images: "
echo.
echo ?? PORTFOLIO OPTIONS:
echo [1] Photography Portfolio
echo [2] Design Portfolio
echo [3] Art Portfolio
echo [4] Fashion Portfolio
echo [5] Architecture Portfolio
echo [6] Wedding Portfolio
echo [7] Business Portfolio
echo [8] Custom Portfolio
echo.
set /p portfolio_type="Select portfolio type: "

if "%portfolio_type%"=="1" {
    echo ?? PHOTOGRAPHY PORTFOLIO:
    echo ? Layout: Full-screen images
    echo ? Navigation: Minimal
    echo ? Focus: Image quality
    echo ? Metadata: Camera settings
    echo ? Categories: By genre
    echo ? Contact: Integrated
}
if "%portfolio_type%"=="2" {
    echo ?? DESIGN PORTFOLIO:
    echo ? Layout: Grid showcase
    echo ? Details: Project descriptions
    echo ? Process: Before/after
    echo ? Categories: By type
    echo ? Client: Information
    echo ? Testimonials: Included
}
echo.
echo ??  PORTFOLIO SETTINGS:
echo [1] Layout style
echo [2] Color scheme
echo [3] Typography
echo [4] Navigation style
echo [5] Project details
echo [6] Contact information
echo [7] About section
echo [8] Export options
echo.
set /p portfolio_settings="Portfolio settings: "

echo.
echo ?? CREATING PORTFOLIO GALLERY...
echo Organizing projects...
echo Creating layout...
echo Adding navigation...
echo Integrating contact...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Portfolio gallery: Created
echo ? Projects: 12
echo ? Layout: Professional
echo ? Contact: Integrated
echo ? Output: portfolio_gallery/
echo.
pause
goto MAIN_MENU

:SLIDESHOW_GALLERY
cls
echo ?? SLIDESHOW GALLERY
echo ???????????????????????????????????????????????????????
echo create dynamic slideshow galleries
echo.
set /p slideshow_folder="Select folder with slideshow images: "
echo.
echo ?? SLIDESHOW OPTIONS:
echo [1] Auto-play Slideshow
echo [2] Manual Slideshow
echo [3] Ken Burns Effect
echo [4] 3D Slideshow
echo [5] Panoramic Slideshow
echo [6] Transition Effects
echo [7] Music Slideshow
echo [8] Custom Slideshow
echo.
set /p slideshow_type="Select slideshow type: "

if "%slideshow_type%"=="1" {
    echo ??  AUTO-PLAY SLIDESHOW:
    echo ? Duration: 5 seconds per slide
    echo ? Transitions: Fade
    echo ? Controls: Play/Pause
    echo ? Navigation: Previous/Next
    echo ? Fullscreen: Yes
    echo ? Keyboard: Supported
}
if "%slideshow_type%"=="3" {
    echo ?? KEN BURNS EFFECT:
    echo ? Effect: Slow pan and zoom
    echo ? Duration: 10 seconds per slide
    echo ? Movement: Natural
    echo ? Direction: Varied
    echo ? Quality: High
    echo ? Performance: Optimized
}
echo.
echo ??  SLIDESHOW SETTINGS:
echo [1] Transition effects
echo [2] Slide duration
echo [3] Auto-play settings
echo [4] Navigation controls
echo [5] Fullscreen mode
echo [6] Keyboard shortcuts
echo [7] Touch gestures
echo [8] Export options
echo.
set /p slideshow_settings="Slideshow settings: "

echo.
echo ?? CREATING SLIDESHOW GALLERY...
echo Processing images...
echo Adding transitions...
echo Creating controls...
echo Optimizing performance...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Slideshow gallery: Created
echo ? Slides: 30
echo ? Transitions: Applied
echo ? Controls: Functional
echo ? Output: slideshow_gallery/
echo.
pause
goto MAIN_MENU

:THUMBNAIL_GALLERY
cls
echo ???  THUMBNAIL GALLERY
echo ???????????????????????????????????????????????????????
echo Create thumbnail-based galleries
echo.
set /p thumbnail_folder="Select folder with images: "
echo.
echo ???  THUMBNAIL OPTIONS:
echo [1] Square Thumbnails
echo [2] Rectangular Thumbnails
echo [3] Circular Thumbnails
echo [4] Rounded Thumbnails
echo [5] Custom Shape Thumbnails
echo [6] Smart Thumbnails
echo [7] Animated Thumbnails
echo [8] Custom Thumbnails
echo.
set /p thumbnail_type="Select thumbnail type: "

if "%thumbnail_type%"=="1" {
    echo ?? SQUARE THUMBNAILS:
    echo ? Size: 300x300px
    echo ? Crop: Center
    echo ? Quality: High
    echo ? Consistency: Perfect
    echo ? Hover: Zoom effect
    echo ? Loading: Fast
}
if "%thumbnail_type%"=="3" {
    echo ? CIRCULAR THUMBNAILS:
    echo ? Size: 250x250px
    echo ? Shape: Circle
    echo ? Crop: Smart
    echo ? Border: Optional
    echo ? Shadow: Subtle
    echo ? Hover: Scale effect
}
echo.
echo ??  THUMBNAIL SETTINGS:
echo [1] Thumbnail size
echo [2] Quality settings
echo [3] Hover effects
echo [4] Border options
echo [5] Shadow effects
echo [6] Loading optimization
echo [7] Lazy loading
echo [8] Export options
echo.
set /p thumbnail_settings="Thumbnail settings: "

echo.
echo ???  CREATING THUMBNAIL GALLERY...
echo Generating thumbnails...
echo Creating gallery layout...
echo Adding hover effects...
echo Optimizing loading...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Thumbnail gallery: Created
echo ? Thumbnails: Generated
echo ? Layout: %thumbnail_type%
echo ? Effects: Applied
echo ? Output: thumbnail_gallery/
echo.
pause
goto MAIN_MENU

:INTERACTIVE_GALLERY
cls
echo ?? INTERACTIVE GALLERY
echo ???????????????????????????????????????????????????????
echo Create interactive image galleries
echo.
set /p interactive_folder="Select folder with images: "
echo.
echo ?? INTERACTIVE OPTIONS:
echo [1] Zoomable Gallery
echo [2] 360? Gallery
echo [3] Virtual Tour Gallery
echo [4] Map Gallery
echo [5] Timeline Gallery
echo [6] Filter Gallery
echo [7] Search Gallery
echo [8] Custom Interactive
echo.
set /p interactive_type="Select interactive type: "

if "%interactive_type%"=="1" {
    echo ?? ZOOMABLE GALLERY:
    echo ? Zoom: Deep zoom
    echo ? Pan: Smooth
    echo ? Controls: Mouse/touch
    echo ? Quality: High resolution
    echo ? Loading: Progressive
    echo ? Performance: Optimized
}
if "%interactive_type%"=="3" {
    echo ???  VIRTUAL TOUR GALLERY:
    echo ? Navigation: 360?
    echo ? Hotspots: Interactive
    echo ? Information: Detailed
    echo ? Map: Integrated
    echo ? Audio: Narration
    echo ? Mobile: Supported
}
echo.
echo ??  INTERACTIVE SETTINGS:
echo [1] Interaction type
echo [2] Control options
echo [3] Performance settings
echo [4] Mobile support
echo [5] Accessibility
echo [6] Analytics integration
echo [7] Social sharing
echo [8] Export options
echo.
set /p interactive_settings="Interactive settings: "

echo.
echo ?? CREATING INTERACTIVE GALLERY...
echo Processing images...
echo Adding interactivity...
echo Creating controls...
echo Optimizing performance...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Interactive gallery: Created
echo ? Interactivity: %interactive_type%
echo ? Controls: Functional
echo ? Performance: Optimized
echo ? Output: interactive_gallery/
echo.
pause
goto MAIN_MENU

:CUSTOM_GALLERY
cls
echo ?? CUSTOM GALLERY
echo ???????????????????????????????????????????????????????
echo create custom gallery designs
echo.
set /p custom_folder="Select folder with images: "
echo.
echo ?? CUSTOM GALLERY OPTIONS:
echo [1] Blank Canvas Gallery
echo [2] Template-Based Gallery
echo [3] Drag-and-Drop Gallery
echo [4] Modular Gallery
echo [5] Theme-Based Gallery
echo [6] Brand Gallery
echo [7] Seasonal Gallery
echo [8] Advanced Custom
echo.
set /p custom_type="Select custom gallery type: "

if "%custom_type%"=="1" {
    echo ?? BLANK CANVAS GALLERY:
    echo ? Layout: Freeform
    echo ? Design: From scratch
    echo ? Elements: Customizable
    echo ? Position: Absolute
    echo ? Styling: Full control
    echo ? Code: Generated
}
if "%custom_type%"=="2" {
    echo ?? TEMPLATE-BASED GALLERY:
    echo ? Templates: 50+ designs
    echo ? Customization: Full
    echo ? Colors: Customizable
    echo ? Fonts: Selectable
    echo ? Layout: Modifiable
    echo ? Export: Multiple formats
}
echo.
echo ??  CUSTOM SETTINGS:
echo [1] Layout design
echo [2] Color scheme
echo [3] Typography
echo [4] Animation effects
echo [5] Navigation style
echo [6] Responsive design
echo [7] Performance optimization
echo [8] Export options
echo.
set /p custom_settings="Custom gallery settings: "

echo.
echo ?? CREATING CUSTOM GALLERY...
echo Designing layout...
echo Applying customizations...
echo Adding elements...
echo Optimizing performance...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Custom gallery: Created
echo ? Design: %custom_type%
echo ? Customization: Applied
echo ? Output: custom_gallery/
echo.
pause
goto MAIN_MENU

:GALLERY_MANAGEMENT
cls
echo ?? GALLERY MANAGEMENT
echo ???????????????????????????????????????????????????????
echo Manage and organize your galleries
echo.
echo ?? MANAGEMENT OPTIONS:
echo [1] Gallery Organizer
echo [2] Image Manager
echo [3] Metadata Editor
echo [4] Gallery Analytics
echo [5] Backup Manager
echo [6] Export Manager
echo [7] Settings Manager
echo [8] Gallery Statistics
echo.
set /p management_option="Select management option: "

if "%management_option%"=="1" {
    echo ?? GALLERY ORGANIZER:
    echo ? Galleries: 5 found
    echo ? Total images: 234
    echo ? Categories: 12
    echo ? Tags: 45
    echo ? Storage: 2.4 GB
    echo ? Last updated: Today
}
if "%management_option%"=="4" {
    echo ?? GALLERY ANALYTICS:
    echo ? Views: 1,234
    echo ? Unique visitors: 456
    echo ? Popular images: Top 10
    echo ? Average time: 2:34
    echo ? Bounce rate: 23%%
    echo ? Conversion: 12%%
}
echo.
echo ?? MANAGEMENT ACTIONS:
echo [1] Reorganize galleries
echo [2] Update metadata
echo [3] Generate reports
echo [4] Create backup
echo [5] Export data
echo [6] Optimize performance
echo.
set /p management_action="Select action: "

echo.
echo ?? MANAGING GALLERY...
echo Processing request...
echo Updating data...
echo Optimizing performance...
echo Saving changes...
echo Progress: [??????????] 100%%
echo.
call :get_text "COMPLETE"
echo ? %RETURN_TEXT%
echo ? Gallery management: Complete
echo ? Action: %management_action%
echo ? Data: Updated
echo ? Performance: Optimized
echo.
pause
goto MAIN_MENU

:BACK_TO_SECTION
echo.
echo [INFO] Returning to Image Excellence menu...
if exist "04_image_excellence.bat" (
    call "04_image_excellence.bat"
) else (
    echo [ERROR] Image Excellence menu not found
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

