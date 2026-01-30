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
echo %PURPLE%  🎪 Puppeteer - اختبار المتصفح الآلي%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
npm list puppeteer >nul 2>&1 && (
    echo %GREEN%✓ Puppeteer مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    goto :CREATE_PROJECT
)

echo %YELLOW%[1/4] جارٍ تثبيت Puppeteer...%WHITE%
call :LOADING_ANIMATION 6

set "PUPPETEER_PROJECT=%USERPROFILE%\puppeteer-tests"
if not exist "!PUPPETEER_PROJECT!" mkdir "!PUPPETEER_PROJECT!" >nul
cd /d "!PUPPETEER_PROJECT!"

:: إنشاء package.json
(
echo {
echo   "name": "puppeteer-tests",
echo   "version": "1.0.0",
echo   "description": "Puppeteer Browser Automation Tests",
echo   "main": "index.js",
echo   "scripts": {
echo     "test": "node tests/basic.test.js",
echo     "test:all": "npm run test:basic && npm run test:advanced && npm run test:pdf",
echo     "test:basic": "node tests/basic.test.js",
echo     "test:advanced": "node tests/advanced.test.js",
echo     "test:pdf": "node tests/pdf.test.js",
echo     "test:auth": "node tests/auth.test.js",
echo     "test:api": "node tests/api.test.js",
echo     "screenshot": "node scripts/screenshot.js",
echo     "record": "node scripts/record.js"
echo   },
echo   "keywords": ["puppeteer", "automation", "testing", "browser"],
echo   "author": "Knoux Developer",
echo   "license": "MIT",
echo   "dependencies": {
echo     "puppeteer": "^21.5.2",
echo     "puppeteer-core": "^21.5.2"
echo   },
echo   "devDependencies": {
echo     "jest": "^29.7.0",
echo     "expect-puppeteer": "^9.0.0",
echo     "jest-puppeteer": "^9.0.0",
echo     "pdf-lib": "^1.17.1"
echo   }
echo }
) > package.json

npm install >nul 2>&1

npm list puppeteer >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Puppeteer%WHITE%

:CREATE_PROJECT
echo %YELLOW%[2/4] جارٍ إنشاء مشروع تجريبي...%WHITE%

:: إنشاء مجلدات المشروع
mkdir tests scripts utils config screenshots downloads reports temp >nul 2>&1

:: إنشاء ملف إعدادات Puppeteer
(
echo module.exports = {
echo   // Launch options for Puppeteer
echo   launch: {
echo     headless: false, // Change to true for headless mode
echo     devtools: false, // Open devtools
echo     args: [
echo       '--no-sandbox',
echo       '--disable-setuid-sandbox',
echo       '--disable-dev-shm-usage',
echo       '--disable-accelerated-2d-canvas',
echo       '--no-first-run',
echo       '--no-zygote',
echo       '--disable-gpu'
echo     ]
echo   },
echo   // Browser context options
echo   context: {
echo     viewport: {
echo       width: 1920,
echo       height: 1080
echo     },
echo     userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36'
echo   },
echo   // Timeout settings
echo   timeout: 30000,
echo   // Screenshot settings
echo   screenshot: {
echo     type: 'png',
echo     quality: 80,
echo     fullPage: true
echo   }
echo };
) > config\puppeteer.config.js

:: إنشاء مساعدات
(
echo const puppeteer = require('puppeteer');
echo const config = require('./config/puppeteer.config');
echo 
echo class PuppeteerHelper {
echo   constructor() {
echo     this.browser = null;
echo     this.page = null;
echo   }
echo 
echo   async launch() {
echo     this.browser = await puppeteer.launch(config.launch);
echo     this.page = await this.browser.newPage();
echo     await this.page.setViewport(config.context.viewport);
echo     await this.page.setUserAgent(config.context.userAgent);
echo     return this.page;
echo   }
echo 
echo   async close() {
echo     if (this.browser) {
echo       await this.browser.close();
echo     }
echo   }
echo 
echo   async takeScreenshot(filename) {
echo     if (this.page) {
echo       await this.page.screenshot({
echo         path: `screenshots/${filename}`,
echo         ...config.screenshot
echo       });
echo     }
echo   }
echo 
echo   async waitForNavigation() {
echo     return this.page.waitForNavigation({ waitUntil: 'networkidle2' });
echo   }
echo 
echo   async typeSafe(selector, text) {
echo     const element = await this.page.$(selector);
echo     if (element) {
echo       await element.focus();
echo       await element.type(text);
echo     }
echo   }
echo 
echo   async clickSafe(selector) {
echo     const element = await this.page.$(selector);
echo     if (element) {
echo       await element.click();
echo     }
echo   }
echo 
echo   async waitForElement(selector, timeout = config.timeout) {
echo     return this.page.waitForSelector(selector, { timeout });
echo   }
echo 
echo   async getElementText(selector) {
echo     const element = await this.page.$(selector);
echo     if (element) {
echo       return await element.evaluate(el => el.textContent);
echo     }
echo     return null;
echo   }
echo 
echo   async scrollToBottom() {
echo     await this.page.evaluate(() => {
echo       window.scrollTo(0, document.body.scrollHeight);
echo     });
echo   }
echo }
echo 
echo module.exports = PuppeteerHelper;
) > utils\puppeteer-helper.js

:: إنشاء اختبار أساسي
(
echo const PuppeteerHelper = require('../utils/puppeteer-helper');
echo 
echo async function runTests() {
echo   const helper = new PuppeteerHelper();
echo   let page;
echo 
echo   try {
echo     console.log('Starting Puppeteer tests...');
echo     page = await helper.launch();
echo 
echo     // Navigate to a test page
echo     console.log('Navigating to example.com...');
echo     await page.goto('https://example.com');
echo     await page.waitForSelector('h1');
echo 
echo     // Take screenshot
echo     await helper.takeScreenshot('example-page.png');
echo     console.log('Screenshot taken!');
echo 
echo     // Check page title
echo     const title = await page.title();
echo     console.log('Page title:', title);
echo     console.assert(title.includes('Example'), 'Title should contain "Example"');
echo 
echo     // Check heading text
echo     const heading = await page.$eval('h1', el => el.textContent);
echo     console.log('Heading text:', heading);
echo     console.assert(heading.includes('Example Domain'), 'Heading should contain "Example Domain"');
echo 
echo     // Test navigation
echo     console.log('Testing navigation...');
echo     await page.goto('https://httpbin.org');
echo     await page.waitForSelector('h1');
echo     const httpBinTitle = await page.title();
echo     console.log('HTTPBin title:', httpBinTitle);
echo 
echo     // Form testing
echo     console.log('Testing form submission...');
echo     await page.goto('https://httpbin.org/forms/post');
echo     await page.waitForSelector('form');
echo     
echo     // Fill form
echo     await page.type('input[name="custname"]', 'Test Customer');
echo     await page.type('input[name="custtel"]', '123-456-7890');
echo     await page.type('input[name="custemail"]', 'test@example.com');
echo     await page.click('input[value="Mozzarella"]');
echo     await page.click('input[value="Sauce"]');
echo     await page.type('textarea[name="comments"]', 'This is a test comment');
echo     
echo     // Submit form
echo     await Promise.all([
echo       page.waitForNavigation(),
echo       page.click('button[type="submit"]')
echo     ]);
echo 
echo     console.log('✅ All basic tests passed!');
echo   } catch (error) {
echo     console.error('❌ Test failed:', error);
echo     process.exit(1);
echo   } finally {
echo     await helper.close();
echo   }
echo }
echo 
echo runTests();
) > tests\basic.test.js

:: إنشاء اختبار متقدم
(
echo const PuppeteerHelper = require('../utils/puppeteer-helper');
echo const fs = require('fs');
echo 
echo async function runAdvancedTests() {
echo   const helper = new PuppeteerHelper();
echo   let page;
echo 
echo   try {
echo     console.log('Starting advanced Puppeteer tests...');
echo     page = await helper.launch();
echo 
echo     // Performance testing
echo     console.log('Testing page performance...');
echo     const start = Date.now();
echo     await page.goto('https://www.wikipedia.org');
echo     const loadTime = Date.now() - start;
echo     console.log(`Page loaded in ${loadTime}ms`);
echo     
echo     // Take performance metrics
echo     const metrics = await page.metrics();
echo     console.log('Performance metrics:', {
echo       Timestamp: new Date().toISOString(),
echo       JSHeapUsedSize: Math.round(metrics.JSHeapUsedSize / 1024 / 1024 * 100) / 100 + ' MB',
echo       LayoutCount: metrics.LayoutCount,
echo       RecalcStyleCount: metrics.RecalcStyleCount,
echo       UsedJSHeapSize: Math.round(metrics.UsedJSHeapSize / 1024 / 1024 * 100) / 100 + ' MB'
echo     });
echo 
echo     // Screenshot testing
echo     console.log('Testing responsive design...');
echo     const viewports = [
echo       { width: 375, height: 667, name: 'mobile' },
echo       { width: 768, height: 1024, name: 'tablet' },
echo       { width: 1920, height: 1080, name: 'desktop' }
echo     ];
echo     
echo     for (const viewport of viewports) {
echo       await page.setViewport({ width: viewport.width, height: viewport.height });
echo       await page.screenshot({ path: `screenshots/responsive-${viewport.name}.png` });
echo       console.log(`Responsive screenshot saved: responsive-${viewport.name}.png`);
echo     }
echo 
echo     // Accessibility testing
echo     console.log('Testing accessibility...');
echo     await page.goto('https://dequeuniversity.com/demo/mars/');
echo     const headings = await page.$$eval('h1, h2, h3, h4, h5, h6', els => els.map(el => el.textContent));
echo     console.log('Headings found:', headings);
echo 
echo     // Scroll testing
echo     console.log('Testing infinite scroll...');
echo     await page.goto('https://infinite-scroll.com/demo/full-page/');
echo     for (let i = 0; i < 3; i++) {
echo       await page.evaluate(() => {
echo         window.scrollBy(0, window.innerHeight);
echo       });
echo       await page.waitForTimeout(1000);
echo     }
echo 
echo     console.log('✅ All advanced tests passed!');
echo   } catch (error) {
echo     console.error('❌ Advanced test failed:', error);
echo     process.exit(1);
echo   } finally {
echo     await helper.close();
echo   }
echo }
echo 
echo runAdvancedTests();
) > tests\advanced.test.js

:: إنشاء اختبار PDF
(
echo const PuppeteerHelper = require('../utils/puppeteer-helper');
echo const fs = require('fs');
echo const path = require('path');
echo 
echo async function runPDFTests() {
echo   const helper = new PuppeteerHelper();
echo   let page;
echo 
echo   try {
echo     console.log('Starting PDF generation tests...');
echo     page = await helper.launch();
echo 
echo     // Create a sample HTML page
echo     const htmlContent = `
echo       <!DOCTYPE html>
echo       <html>
echo       <head>
echo         <title>Test PDF Document</title>
echo         <style>
echo           body { font-family: Arial, sans-serif; margin: 40px; }
echo           h1 { color: #333; border-bottom: 2px solid #ccc; padding-bottom: 10px; }
echo           .content { margin: 20px 0; }
echo           .footer { margin-top: 40px; text-align: center; color: #666; font-size: 12px; }
echo         </style>
echo       </head>
echo       <body>
echo         <h1>Knoux Test Report</h1>
echo         <div class="content">
echo           <h2>Test Results Summary</h2>
echo           <p>Date: ${new Date().toISOString()}</p>
echo           <p>This is a sample PDF generated using Puppeteer.</p>
echo           <ul>
echo             <li>Test 1: Passed</li>
echo             <li>Test 2: Passed</li>
echo             <li>Test 3: Passed</li>
echo           </ul>
echo         </div>
echo         <div class="footer">
echo           Generated by Knoux Puppeteer Test Suite
echo         </div>
echo       </body>
echo       </html>
echo     `;
echo 
echo     // Write HTML to file and load it
echo     const tempHtmlPath = path.join(__dirname, '..', 'temp', 'test-report.html');
echo     if (!fs.existsSync(path.dirname(tempHtmlPath))) {
echo       fs.mkdirSync(path.dirname(tempHtmlPath), { recursive: true });
echo     }
echo     fs.writeFileSync(tempHtmlPath, htmlContent);
echo     
echo     await page.goto(`file://${tempHtmlPath}`, { waitUntil: 'networkidle2' });
echo 
echo     // Generate PDF
echo     const pdfBuffer = await page.pdf({
echo       format: 'A4',
echo       printBackground: true,
echo       margin: {
echo         top: '20px',
echo         right: '20px',
echo         bottom: '20px',
echo         left: '20px'
echo       }
echo     });
echo 
echo     // Save PDF
echo     const pdfPath = path.join(__dirname, '..', 'reports', 'test-report.pdf');
echo     if (!fs.existsSync(path.dirname(pdfPath))) {
echo       fs.mkdirSync(path.dirname(pdfPath), { recursive: true });
echo     }
echo     fs.writeFileSync(pdfPath, pdfBuffer);
echo     console.log('PDF generated successfully:', pdfPath);
echo 
echo     console.log('✅ All PDF tests passed!');
echo   } catch (error) {
echo     console.error('❌ PDF test failed:', error);
echo     process.exit(1);
echo   } finally {
echo     await helper.close();
echo     // Clean up temp file
echo     const tempPath = path.join(__dirname, '..', 'temp', 'test-report.html');
echo     if (fs.existsSync(tempPath)) {
echo       fs.unlinkSync(tempPath);
echo     }
echo   }
echo }
echo 
echo runPDFTests();
) > tests\pdf.test.js

:: إنشاء اختبار API
(
echo const PuppeteerHelper = require('../utils/puppeteer-helper');
echo 
echo async function runAPITests() {
echo   const helper = new PuppeteerHelper();
echo   let page;
echo 
echo   try {
echo     console.log('Starting API interaction tests...');
echo     page = await helper.launch();
echo 
echo     // Intercept network requests
echo     await page.setRequestInterception(true);
echo     page.on('request', request => {
echo       console.log('->', request.method(), request.url());
echo       request.continue();
echo     });
echo 
echo     page.on('response', response => {
echo       console.log('<-', response.status(), response.url());
echo     });
echo 
echo     // Test API endpoints through browser
echo     console.log('Testing API endpoints...');
echo     await page.goto('https://jsonplaceholder.typicode.com');
echo 
echo     // Use browser to make API calls
echo     const posts = await page.evaluate(async () => {
echo       const response = await fetch('/posts?_limit=5');
echo       return await response.json();
echo     });
echo 
echo     console.log('Fetched posts:', posts.length);
echo     console.assert(posts.length === 5, 'Should fetch 5 posts');
echo 
echo     // Test POST request
echo     const newPost = await page.evaluate(async () => {
echo       const response = await fetch('/posts', {
echo         method: 'POST',
echo         headers: {
echo           'Content-Type': 'application/json',
echo         },
echo         body: JSON.stringify({
echo           title: 'Test Post',
echo           body: 'This is a test post',
echo           userId: 1
echo         })
echo       });
echo       return await response.json();
echo     });
echo 
echo     console.log('Created post:', newPost.id);
echo     console.assert(newPost.title === 'Test Post', 'Post title should match');
echo 
echo     console.log('✅ All API tests passed!');
echo   } catch (error) {
echo     console.error('❌ API test failed:', error);
echo     process.exit(1);
echo   } finally {
echo     await helper.close();
echo   }
echo }
echo 
echo runAPITests();
) > tests\api.test.js

:: إنشاء سكربت لTaking Screenshots
(
echo const PuppeteerHelper = require('./utils/puppeteer-helper');
echo const fs = require('fs');
echo 
echo async function takeScreenshots() {
echo   const helper = new PuppeteerHelper();
echo   let page;
echo 
echo   try {
echo     console.log('Starting screenshot automation...');
echo     page = await helper.launch();
echo 
echo     // Create screenshots directory
echo     if (!fs.existsSync('screenshots')) {
echo       fs.mkdirSync('screenshots');
echo     }
echo 
echo     // Websites to screenshot
echo     const websites = [
echo       { url: 'https://example.com', name: 'example' },
echo       { url: 'https://github.com', name: 'github' },
echo       { url: 'https://stackoverflow.com', name: 'stackoverflow' },
echo       { url: 'https://wikipedia.org', name: 'wikipedia' }
echo     ];
echo 
echo     for (const site of websites) {
echo       console.log(`Capturing ${site.name}...`);
echo       await page.goto(site.url, { waitUntil: 'networkidle2' });
echo       await page.screenshot({
echo         path: `screenshots/${site.name}.png`,
echo         fullPage: true
echo       });
echo       console.log(`Screenshot saved: ${site.name}.png`);
echo     }
echo 
echo     // Responsive screenshots
echo     console.log('Taking responsive screenshots...');
echo     const responsiveSizes = [
echo       { width: 375, height: 667, suffix: 'mobile' },
echo       { width: 768, height: 1024, suffix: 'tablet' },
echo       { width: 1920, height: 1080, suffix: 'desktop' }
echo     ];
echo 
echo     await page.goto('https://example.com', { waitUntil: 'networkidle2' });
echo 
echo     for (const size of responsiveSizes) {
echo       await page.setViewport({ width: size.width, height: size.height });
echo       await page.screenshot({
echo         path: `screenshots/example-${size.suffix}.png` 
echo       });
echo       console.log(`Responsive screenshot saved: example-${size.suffix}.png`);
echo     }
echo 
echo     console.log('✅ All screenshots captured!');
echo   } catch (error) {
echo     console.error('❌ Screenshot failed:', error);
echo   } finally {
echo     await helper.close();
echo   }
echo }
echo 
echo takeScreenshots();
) > scripts\screenshot.js

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Puppeteer Test Runner - Knoux Toolbox
echo echo ===================================
echo echo.
echo echo Choose test option:
echo echo 1. Run basic tests
echo echo 2. Run advanced tests
echo echo 3. Run PDF tests
echo echo 4. Run API tests
echo echo 5. Run all tests
echo echo 6. Take screenshots
echo echo 7. Record user actions
echo echo.
echo set /p "CHOICE=Enter choice (1-7): "
echo 
echo cd /d "!PUPPETEER_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Running basic tests...
echo     npm run test:basic
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running advanced tests...
echo     npm run test:advanced
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running PDF tests...
echo     npm run test:pdf
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running API tests...
echo     npm run test:api
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Running all tests...
echo     npm run test:all
echo )
echo if "%%CHOICE%%"=="6" (
echo     echo Taking screenshots...
echo     npm run screenshot
echo )
echo if "%%CHOICE%%"=="7" (
echo     echo Recording user actions...
echo     node scripts/record.js
echo )
echo 
echo pause
) > "!PUPPETEER_PROJECT!\run-puppeteer.bat"

echo %YELLOW%[3/4] جارٍ إنشاء مجلدات النتائج...%WHITE%

echo %YELLOW%[4/4] جارٍ إنشاء بيئة الاختبار...%WHITE%

:: إنشاء ملف README
(
echo # Puppeteer Test Suite - Knoux Toolbox
echo 
echo This project contains automated browser testing using Puppeteer.
echo 
echo ## Features
echo 
echo - Basic browser automation
echo - Advanced testing scenarios
echo - PDF generation
echo - API interaction
echo - Screenshot automation
echo - Responsive design testing
echo - Performance monitoring
echo 
echo ## Getting Started
echo 
echo 1. Install dependencies: `npm install` 
echo 2. Run tests: `npm test` 
echo 3. View reports in the `reports/` directory
echo 
echo ## Scripts
echo 
echo - `npm run test:basic` - Run basic browser tests
echo - `npm run test:advanced` - Run advanced scenarios
echo - `npm run test:pdf` - Generate PDF reports
echo - `npm run test:api` - Test API interactions
echo - `npm run screenshot` - Take website screenshots
echo 
echo ## Results
echo 
echo Test results and screenshots are saved in:
echo - `screenshots/` - Browser screenshots
echo - `reports/` - PDF reports
echo - `downloads/` - Downloaded files
) > README.md

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Puppeteer!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!PUPPETEER_PROJECT!%WHITE%
echo   تشغيل: %GRAY%cd "!PUPPETEER_PROJECT!" && npm test%WHITE%
echo   لقطات: %GRAY%screenshots/%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات المتصفح الآلية
echo   ✓ إنشاء PDF
echo   ✓ لقطات الشاشة
echo   ✓ اختبارات API
echo   ✓ اختبارات الاستجابة
echo   ✓ مراقبة الأداء
echo   ✓ تحليل الشبكة
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!PUPPETEER_PROJECT!"
echo   2. npm test ← لتشغيل الاختبارات
echo   3. npm run screenshot ← لأخذ لقطات
echo   4. ./run-puppeteer.bat ← لاختيارات سريعة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Puppeteer with comprehensive test suite >> "!LOG_FILE!"

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
