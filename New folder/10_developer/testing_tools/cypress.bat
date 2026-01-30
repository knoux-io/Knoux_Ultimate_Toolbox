@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  ⚡ Cypress - اختبار End-to-End متقدم%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
where cypress >nul 2>&1 && (
    echo %GREEN%✓ Cypress مثبت مسبقًا%WHITE%
    cypress --version
    goto :CREATE_PROJECT
)

echo %YELLOW%جارٍ تثبيت Cypress...%WHITE%

set "CYPRESS_PROJECT=%USERPROFILE%\cypress-tests"
if not exist "!CYPRESS_PROJECT!" mkdir "!CYPRESS_PROJECT!" >nul
cd /d "!CYPRESS_PROJECT!"

:: إنشاء package.json
(
echo {
echo   "name": "cypress-tests",
echo   "version": "1.0.0",
echo   "description": "Cypress E2E Testing Project",
echo   "main": "index.js",
echo   "scripts": {
echo     "cypress:open": "cypress open",
echo     "cypress:run": "cypress run",
echo     "test:e2e": "cypress run --headed",
echo     "test:chrome": "cypress run --browser chrome",
echo     "test:firefox": "cypress run --browser firefox"
echo   },
echo   "keywords": ["cypress", "e2e", "testing", "automation"],
echo   "author": "Knoux Developer",
echo   "license": "MIT",
echo   "devDependencies": {
echo     "cypress": "^13.6.0"
echo   }
echo }
) > package.json

npm install >nul 2>&1

where cypress >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Cypress%WHITE%

:CREATE_PROJECT
echo %YELLOW%جارٍ إنشاء هيكل المشروع...%WHITE%

:: إنشاء ملف إعدادات Cypress
(
echo {
echo   "projectId": "knoux-cypress",
echo   "video": true,
echo   "screenshotOnRunFailure": true,
echo   "chromeWebSecurity": false,
echo   "viewportWidth": 1280,
echo   "viewportHeight": 720,
echo   "defaultCommandTimeout": 10000,
echo   "pageLoadTimeout": 60000,
echo   "requestTimeout": 5000,
echo   "responseTimeout": 30000,
echo   "retries": {
echo     "runMode": 2,
echo     "openMode": 0
echo   },
echo   "e2e": {
echo     "setupNodeEvents"(on, config) {
echo       return require('./cypress/plugins/index')(on, config);
echo     },
echo     "baseUrl": "http://localhost:3000",
echo     "specPattern": "cypress/e2e/**/*.cy.{js,jsx,ts,tsx}",
echo     "supportFile": "cypress/support/e2e.{js,jsx,ts,tsx}"
echo   }
echo }
) > cypress.config.js

:: إنشاء مجلدات المشروع
mkdir cypress\e2e cypress\fixtures cypress\support cypress\plugins >nul 2>&1

:: إنشاء ملف دعم عام
(
echo // ***********************************************************
echo // This example support/index.js is processed and
echo // loaded automatically before your test files.
echo //
echo // This is a great place to put global configuration and
echo // behavior that modifies Cypress.
echo //
echo // You can change the location of this file or turn off
echo // automatically serving support files with the
echo // 'supportFile' configuration option.
echo //
echo // You can read more here:
echo // https://on.cypress.io/configuration
echo // ***********************************************************
echo 
echo // Import commands.js using ES2015 syntax:
echo import './commands'
echo 
echo // Alternatively you can use CommonJS syntax:
echo // require('./commands')
echo 
echo // Prevent 'before each' hook from failing
echo Cypress.on('uncaught:exception', (err, runnable) => {
echo   // returning false here prevents Cypress from
echo   // failing the test
echo   if (err.message.includes('ResizeObserver loop limit exceeded')) {
echo     return false
echo   }
echo })
) > cypress\support\e2e.js

:: إنشاء أوامر مخصصة
(
echo // ***********************************************
echo // This example commands.js shows you how to
echo // create various custom commands and overwrite
echo // existing commands.
echo //
echo // For more comprehensive examples of custom
echo // commands please read more here:
echo // https://on.cypress.io/custom-commands
echo // ***********************************************
echo 
echo // -- This is a parent command --
echo Cypress.Commands.add('login', (email, password) => {
echo   cy.visit('/login')
echo   cy.get('[data-cy=email]').type(email)
echo   cy.get('[data-cy=password]').type(password)
echo   cy.get('[data-cy=submit]').click()
echo })
echo 
echo // -- This is a child command --
echo Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => {
echo   subject.trigger('mousedown')
echo   cy.get('body').trigger('mousemove', options.to).trigger('mouseup')
echo })
echo 
echo // -- This is a dual command --
echo Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => {
echo   if (subject) {
echo     cy.wrap(subject).click({ force: true })
echo   } else {
echo     cy.get('[data-cy=close]').click({ force: true })
echo   }
echo })
) > cypress\support\commands.js

:: إنشاء اختبار تجريبي
(
echo /// <reference types="cypress" />
echo 
echo describe('Knoux Test Suite - Arabic Support', () => {
echo   beforeEach(() => {
echo     cy.visit('https://example.cypress.io/todo')
echo   })
echo 
echo   it('should add a new todo item', () => {
echo     const newTodo = 'Learn Cypress in Arabic'
echo     cy.get('[data-cy=new-todo]').type(`${newTodo}{enter}`)
echo     cy.get('.todo-list li').should('have.length', 3)
echo     cy.get('.todo-list li').eq(2).should('contain.text', newTodo)
echo   })
echo 
echo   it('should mark a todo as completed', () => {
echo     cy.get('.todo-list li').eq(0).find('.toggle').click()
echo     cy.get('.todo-list li').eq(0).should('have.class', 'completed')
echo   })
echo 
echo   it('should filter todos', () => {
echo     cy.get('.filters').contains('Active').click()
echo     cy.get('.todo-list li').should('have.length', 2)
echo   })
echo 
echo   it('should work with Arabic content', () => {
echo     cy.visit('https://example.cypress.io/')
echo     cy.get('h1').should('exist')
echo     cy.contains('Welcome').should('be.visible')
echo   })
echo })
) > cypress\e2e\example.cy.js

:: إنشاء اختبار ويب تجريبي
(
echo /// <reference types="cypress" />
echo 
echo describe('Web Application Testing', () => {
echo   it('should navigate through pages', () => {
echo     cy.visit('/')
echo     cy.url().should('include', '/')
echo     
echo     cy.get('nav a').contains('Products').click()
echo     cy.url().should('include', '/products')
echo     
echo     cy.get('nav a').contains('Contact').click()
echo     cy.url().should('include', '/contact')
echo   })
echo 
echo   it('should submit contact form', () => {
echo     cy.visit('/contact')
echo     cy.get('#name').type('محمد')
echo     cy.get('#email').type('mohammed@example.com')
echo     cy.get('#message').type('مرحباً، هذا اختبار Cypress!')
echo     cy.get('button[type=submit]').click()
echo     
echo     cy.get('.success-message').should('be.visible')
echo   })
echo 
echo   it('should handle file uploads', () => {
echo     cy.visit('/upload')
echo     cy.get('input[type=file]').attachFile('sample.pdf')
echo     cy.get('button.upload-btn').click()
echo     cy.get('.upload-success').should('be.visible')
echo   })
echo })
) > cypress\e2e\web-testing.cy.js

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Cypress Test Runner - Knoux Toolbox
echo echo ===================================
echo echo.
echo echo Choose test option:
echo echo 1. Open Cypress GUI
echo echo 2. Run headless tests
echo echo 3. Run in Chrome
echo echo 4. Run in Firefox
echo echo.
echo set /p "CHOICE=Enter choice (1-4): "
echo 
echo cd /d "!CYPRESS_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Opening Cypress GUI...
echo     npx cypress open
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running headless tests...
echo     npx cypress run
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running tests in Chrome...
echo     npx cypress run --browser chrome
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running tests in Firefox...
echo     npx cypress run --browser firefox
echo )
echo 
echo pause
) > "!CYPRESS_PROJECT!\run-cypress.bat"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Cypress!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!CYPRESS_PROJECT!%WHITE%
echo   GUI: %GRAY%npx cypress open%WHITE%
echo   Headless: %GRAY%npx cypress run%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبار E2E متكامل
echo   ✓ واجهة رسومية سهلة
echo   ✓ تسجيل وتشغيل تلقائي
echo   ✓ دعم جميع المتصفحات
echo   ✓ إدارة الفيديو واللقطات
echo   ✓ اختبارات متزامنة
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!CYPRESS_PROJECT!"
echo   2. npx cypress open ← لفتح الواجهة
echo   3. npx cypress run ← لتشغيل تلقائي
echo   4. ./run-cypress.bat ← لاختيارات سريعة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Cypress with test project >> "!LOG_FILE!"

timeout /t 8 >nul
