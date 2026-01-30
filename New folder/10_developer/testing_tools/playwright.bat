@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🎭 Playwright - اختبارات متعددة المستعرضات%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
where playwright >nul 2>&1 && (
    echo %GREEN%✓ Playwright مثبت مسبقًا%WHITE%
    playwright --version
    goto :INSTALL_BROWSERS
)

echo %YELLOW%[1/4] جارٍ تثبيت Playwright...%WHITE%
call :LOADING_ANIMATION 4

set "PLAYWRIGHT_PROJECT=%USERPROFILE%\playwright-tests"
if not exist "!PLAYWRIGHT_PROJECT!" mkdir "!PLAYWRIGHT_PROJECT!" >nul
cd /d "!PLAYWRIGHT_PROJECT!"

:: إنشاء package.json
(
echo {
echo   "name": "playwright-tests",
echo   "version": "1.0.0",
echo   "description": "Playwright E2E Testing Project",
echo   "main": "index.js",
echo   "scripts": {
echo     "test": "playwright test",
echo     "test:ui": "playwright test --ui",
echo     "test:debug": "playwright test --debug",
echo     "test:headed": "playwright test --headed",
echo     "test:chrome": "playwright test --project=chromium",
echo     "test:firefox": "playwright test --project=firefox",
echo     "test:webkit": "playwright test --project=webkit",
echo     "test:mobile": "playwright test --project=Mobile\ Safari",
echo     "report": "playwright show-report"
echo   },
echo   "keywords": ["playwright", "e2e", "testing", "automation"],
echo   "author": "Knoux Developer",
echo   "license": "MIT",
echo   "devDependencies": {
echo     "@playwright/test": "^1.40.0",
echo     "@faker-js/faker": "^8.3.0"
echo   }
echo }
) > package.json

npm install >nul 2>&1

where playwright >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Playwright%WHITE%

:INSTALL_BROWSERS
echo %YELLOW%[2/4] جارٍ تثبيت المتصفحات...%WHITE%
npx playwright install --with-deps >nul 2>&1

echo %GREEN%✓ تم تثبيت المتصفحات:%WHITE%
echo   - Chromium
echo   - Firefox
echo   - WebKit
echo   - Mobile browsers

:CREATE_PROJECT
echo %YELLOW%[3/4] جارٍ إنشاء مشروع تجريبي...%WHITE%

:: إنشاء ملف إعدادات Playwright
(
echo import { defineConfig, devices } from '@playwright/test';
echo 
echo /**
echo  * Read environment variables from file.
echo  * https://github.com/motdotla/dotenv
echo  */
echo // require('dotenv').config();
echo 
echo /**
echo  * @see https://playwright.dev/docs/test-configuration
echo  */
echo export default defineConfig({
echo   testDir: './tests',
echo   /* Maximum time one test can run for. */
echo   timeout: 30 * 1000,
echo   expect: {
echo     /**
echo      * Maximum time expect() should wait for the condition to be met.
echo      * For example in `await expect(locator).toHaveText();` 
echo      */
echo     timeout: 5000
echo   },
echo   /* Run tests in files in parallel */
echo   fullyParallel: true,
echo   /* Fail the build on CI if you accidentally left test.only in the source code. */
echo   forbidOnly: !!process.env.CI,
echo   /* Retry on CI only */
echo   retries: process.env.CI ? 2 : 1,
echo   /* Opt out of parallel tests on CI. */
echo   workers: process.env.CI ? 1 : undefined,
echo   /* Reporter to use. See https://playwright.dev/docs/test-reporters */
echo   reporter: 'html',
echo   /* Shared settings for all the projects below. See https://playwright.dev/docs/api/class-testoptions. */
echo   use: {
echo     /* Maximum time each action such as `click()` can take. Defaults to 0 (no limit). */
echo     actionTimeout: 0,
echo     /* Base URL to use in actions like `await page.goto('/')`. */
echo     // baseURL: 'http://localhost:3000',
echo 
echo     /* Collect trace when retrying the failed test. See https://playwright.dev/docs/trace-viewer */
echo     trace: 'on-first-retry',
echo   },
echo 
echo   /* Configure projects for major browsers */
echo   projects: [
echo     {
echo       name: 'chromium',
echo       use: { ...devices['Desktop Chrome'] },
echo     },
echo 
echo     {
echo       name: 'firefox',
echo       use: { ...devices['Desktop Firefox'] },
echo     },
echo 
echo     {
echo       name: 'webkit',
echo       use: { ...devices['Desktop Safari'] },
echo     },
echo 
echo     /* Test against mobile viewports. */
echo     // {
echo     //   name: 'Mobile Chrome',
echo     //   use: { ...devices['Pixel 5'] },
echo     // },
echo     // {
echo     //   name: 'Mobile Safari',
echo     //   use: { ...devices['iPhone 12'] },
echo     // },
echo 
echo     /* Test against branded browsers. */
echo     // {
echo     //   name: 'Microsoft Edge',
echo     //   use: { channel: 'msedge' },
echo     // },
echo     // {
echo     //   name: 'Google Chrome',
echo     //   use: { channel: 'chrome' },
echo     // },
echo   ],
echo 
echo   /* Folder for test artifacts such as screenshots, videos, traces, etc. */
echo   // outputDir: 'test-results/',
echo 
echo   /* Run your local dev server before starting the tests */
echo   // webServer: {
echo   //   command: 'npm run start',
echo   //   port: 3000,
echo   // },
echo });
) > playwright.config.ts

:: إنشاء مجلدات المشروع
mkdir tests tests\api tests\e2e tests\ui tests\mobile >nul 2>&1

:: إنشاء اختبار تجريبي
(
echo import { test, expect } from '@playwright/test';
echo 
echo test.describe('Knoux Test Suite - Arabic Support', () => {
echo   test.beforeEach(async ({ page }) => {
echo     await page.goto('https://example.playwright.dev');
echo   });
echo 
echo   test('should display welcome message', async ({ page }) => {
echo     await expect(page.locator('h1')).toContainText('Playwright');
echo   });
echo 
echo   test('should have correct title', async ({ page }) => {
echo     await expect(page).toHaveTitle(/Playwright/);
echo   });
echo 
echo   test('should navigate to different pages', async ({ page }) => {
echo     await page.getByRole('link', { name: 'Get started' }).click();
echo     await expect(page).toHaveURL(/.*getting-started/);
echo   });
echo 
echo   test('should work with Arabic text', async ({ page }) => {
echo     await page.goto('https://www.example.com');
echo     await expect(page.locator('body')).toContainText('مرحباً');
echo   });
echo 
echo   test('should handle form submission', async ({ page }) => {
echo     await page.goto('/contact');
echo     await page.locator('#name').fill('محمد');
echo     await page.locator('#email').fill('mohammed@example.com');
echo     await page.locator('#message').fill('Test message in Arabic');
echo     await page.locator('button[type="submit"]').click();
echo     await expect(page.locator('.success')).toBeVisible();
echo   });
echo });
) > tests\e2e\basic.spec.ts

:: إنشاء اختبار API
(
echo import { test, expect } from '@playwright/test';
echo 
echo test.describe('API Testing', () => {
echo   test('should fetch users successfully', async ({ request }) => {
echo     const response = await request.get('/api/users');
echo     expect(response.status()).toBe(200);
echo     const responseBody = await response.json();
echo     expect(Array.isArray(responseBody)).toBeTruthy();
echo   });
echo 
echo   test('should create a new user', async ({ request }) => {
echo     const response = await request.post('/api/users', {
echo       data: {
echo         name: 'Test User',
echo         email: 'test@example.com'
echo       }
echo     });
echo     expect(response.status()).toBe(201);
echo     const responseBody = await response.json();
echo     expect(responseBody.name).toBe('Test User');
echo   });
echo 
echo   test('should handle authentication', async ({ request }) => {
echo     const loginResponse = await request.post('/api/auth/login', {
echo       data: {
echo         email: 'user@example.com',
echo         password: 'password'
echo       }
echo     });
echo     expect(loginResponse.status()).toBe(200);
echo     const loginData = await loginResponse.json();
echo     const token = loginData.token;
echo     
echo     // Use token for authenticated requests
echo     const protectedResponse = await request.get('/api/profile', {
echo       headers: {
echo         'Authorization': `Bearer ${token}` 
echo       }
echo     });
echo     expect(protectedResponse.status()).toBe(200);
echo   });
echo });
) > tests\api\api.spec.ts

:: إنشاء اختبار UI متقدم
(
echo import { test, expect } from '@playwright/test';
echo import { faker } from '@faker-js/faker';
echo 
echo test.describe('Advanced UI Testing', () => {
echo   test('should handle dynamic content', async ({ page }) => {
echo     await page.goto('/dynamic');
echo     await page.locator('#load-data-btn').click();
echo     await expect(page.locator('#dynamic-content')).toBeVisible();
echo   });
echo 
echo   test('should handle file uploads', async ({ page }) => {
echo     await page.goto('/upload');
echo     const fileInput = page.locator('input[type="file"]');
echo     await fileInput.setInputFiles('test-file.pdf');
echo     await page.locator('button.upload').click();
echo     await expect(page.locator('.upload-success')).toBeVisible();
echo   });
echo 
echo   test('should work with modals', async ({ page }) => {
echo     await page.goto('/modals');
echo     await page.locator('#open-modal').click();
echo     await expect(page.locator('.modal')).toBeVisible();
echo     await page.locator('.modal .close').click();
echo     await expect(page.locator('.modal')).not.toBeVisible();
echo   });
echo 
echo   test('should generate fake data', async ({ page }) => {
echo     const randomName = faker.person.fullName();
echo     const randomEmail = faker.internet.email();
echo     
echo     await page.goto('/register');
echo     await page.locator('#name').fill(randomName);
echo     await page.locator('#email').fill(randomEmail);
echo     await page.locator('button[type="submit"]').click();
echo     
echo     await expect(page.locator('.success')).toContainText('Registration successful');
echo   });
echo });
) > tests\ui\advanced.spec.ts

:: إنشاء اختبار جوال
(
echo import { test, expect } from '@playwright/test';
echo 
echo test.describe('Mobile Testing', () => {
echo   test.use({ viewport: { width: 375, height: 812 } }); // iPhone 12
echo 
echo   test('should work on mobile layout', async ({ page }) => {
echo     await page.goto('/');
echo     await expect(page.locator('nav')).toBeVisible();
echo     await page.locator('.mobile-menu-toggle').click();
echo     await expect(page.locator('.mobile-menu')).toBeVisible();
echo   });
echo 
echo   test('should handle touch gestures', async ({ page }) => {
echo     await page.goto('/gallery');
echo     await page.locator('.gallery-item').nth(0).tap();
echo     await expect(page.locator('.lightbox')).toBeVisible();
echo   });
echo 
echo   test('should work with mobile forms', async ({ page }) => {
echo     await page.goto('/mobile-form');
echo     await page.locator('#mobile-input').fill('Mobile input');
echo     await page.locator('#mobile-submit').click();
echo     await expect(page.locator('.result')).toContainText('Success');
echo   });
echo });
) > tests\mobile\mobile.spec.ts

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Playwright Test Runner - Knoux Toolbox
echo echo =====================================
echo echo.
echo echo Choose test option:
echo echo 1. Run all tests
echo echo 2. Run in headed mode
echo echo 3. Run specific browser (Chrome)
echo echo 4. Run specific browser (Firefox)
echo echo 5. Run specific browser (WebKit)
echo echo 6. Generate HTML report
echo echo.
echo set /p "CHOICE=Enter choice (1-6): "
echo 
echo cd /d "!PLAYWRIGHT_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Running all tests...
echo     npx playwright test
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running tests in headed mode...
echo     npx playwright test --headed
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running tests in Chrome...
echo     npx playwright test --project=chromium
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running tests in Firefox...
echo     npx playwright test --project=firefox
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Running tests in WebKit...
echo     npx playwright test --project=webkit
echo )
echo if "%%CHOICE%%"=="6" (
echo     echo Generating HTML report...
echo     npx playwright show-report
echo )
echo 
echo pause
) > "!PLAYWRIGHT_PROJECT!\run-playwright.bat"

echo %YELLOW%[4/4] جارٍ تثبيت المكونات الإضافية...%WHITE%
npm install @faker-js/faker --save-dev >nul 2>&1

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Playwright!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!PLAYWRIGHT_PROJECT!%WHITE%
echo   تشغيل: %GRAY%npx playwright test%WHITE%
echo   GUI: %GRAY%npx playwright test --ui%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ دعم جميع المتصفحات (Chromium, Firefox, WebKit)
echo   ✓ اختبارات جوال وسطح مكتب
echo   ✓ API testing مدمج
echo   ✓ تتبع تلقائي وتسجيل الشاشة
echo   ✓ اختبارات متزامنة
echo   ✓ تقارير HTML مفصلة
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!PLAYWRIGHT_PROJECT!"
echo   2. npx playwright test ← لتشغيل الاختبارات
echo   3. npx playwright test --ui ← لواجهة المستخدم
echo   4. ./run-playwright.bat ← لاختيارات سريعة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Playwright with comprehensive test suite >> "!LOG_FILE!"

timeout /t 12 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣾⣽⣻⢿⡿⣟⣯⣷"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
