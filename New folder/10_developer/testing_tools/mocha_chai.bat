@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  ☕ Mocha + Chai - Testing Framework%WHITE%
echo %RED%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
npm list mocha chai >nul 2>&1 && (
    echo %GREEN%✓ Mocha + Chai مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    goto :CREATE_PROJECT
)

echo %YELLOW%جارٍ تثبيت Mocha + Chai...%WHITE%

set "MOCHA_PROJECT=%USERPROFILE%\mocha-chai-tests"
if not exist "!MOCHA_PROJECT!" mkdir "!MOCHA_PROJECT!" >nul
cd /d "!MOCHA_PROJECT!"

:: إنشاء package.json
(
echo {
echo   "name": "mocha-chai-tests",
echo   "version": "1.0.0",
echo   "description": "Mocha + Chai Testing Project",
echo   "main": "index.js",
echo   "scripts": {
echo     "test": "mocha tests/**/*.js",
echo     "test:watch": "mocha --watch tests/**/*.js",
echo     "test:reporter": "mocha --reporter spec tests/**/*.js",
echo     "test:grep": "mocha --grep \"Unit Tests\" tests/**/*.js",
echo     "test:timeout": "mocha --timeout 10000 tests/**/*.js",
echo     "test:parallel": "mocha --parallel tests/**/*.js"
echo   },
echo   "keywords": ["mocha", "chai", "testing", "javascript"],
echo   "author": "Knoux Developer",
echo   "license": "MIT",
echo   "devDependencies": {
echo     "mocha": "^10.2.0",
echo     "chai": "^4.3.10",
echo     "sinon": "^17.0.1",
echo     "nyc": "^15.1.0"
echo   },
echo   "nyc": {
echo     "exclude": [
echo       "tests/**",
echo       "node_modules/**"
echo     ],
echo     "reporter": ["text", "html", "lcov"]
echo   }
echo }
) > package.json

npm install >nul 2>&1

:: التحقق من التثبيت
npm list mocha chai >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Mocha + Chai%WHITE%

:CREATE_PROJECT
echo %YELLOW%جارٍ إنشاء هيكل المشروع...%WHITE%

:: إنشاء مجلدات المشروع
mkdir tests tests\unit tests\integration tests\api tests\helpers >nul 2>&1

:: إنشاء مساعدين
(
echo const { expect, assert } = require('chai');
echo const sinon = require('sinon');
echo 
echo // Helper functions for testing
echo const testHelpers = {
echo   // Create a mock object
echo   createMock: (methods) => {
echo     const mock = {};
echo     methods.forEach(method => {
echo       mock[method] = sinon.stub().resolves();
echo     });
echo     return mock;
echo   },
echo 
echo   // Wait for a specified time (for async tests)
echo   delay: (ms) => new Promise(resolve => setTimeout(resolve, ms)),
echo 
echo   // Generate random test data
echo   generateTestData: (count) => {
echo     return Array.from({ length: count }, (_, i) => ({
echo       id: i + 1,
echo       name: `Test User ${i + 1}`,
echo       email: `test${i + 1}@example.com`,
echo       active: i % 2 === 0
echo     }));
echo   },
echo 
echo   // Validate response structure
echo   validateApiResponse: (response, expectedKeys) => {
echo     expect(response).to.be.an('object');
echo     expectedKeys.forEach(key => {
echo       expect(response).to.have.property(key);
echo     });
echo   }
echo };
echo 
echo module.exports = testHelpers;
) > tests\helpers\test-helpers.js

:: إنشاء وحدة تجريبية
(
echo /**
echo  * String utility functions
echo  */
echo 
echo /**
echo  * Capitalize first letter of string
echo  * @param {string} str - Input string
echo  * @returns {string} String with first letter capitalized
echo  */
echo const capitalize = (str) => {
echo   if (typeof str !== 'string') {
echo     throw new Error('Input must be a string');
echo   }
echo   if (str.length === 0) return str;
echo   return str.charAt(0).toUpperCase() + str.slice(1);
echo };
echo 
echo /**
echo  * Reverse a string
echo  * @param {string} str - Input string
echo  * @returns {string} Reversed string
echo  */
echo const reverse = (str) => {
echo   if (typeof str !== 'string') {
echo     throw new Error('Input must be a string');
echo   }
echo   return str.split('').reverse().join('');
echo };
echo 
echo /**
echo  * Count vowels in a string
echo  * @param {string} str - Input string
echo  * @returns {number} Number of vowels
echo  */
echo const countVowels = (str) => {
echo   if (typeof str !== 'string') {
echo     throw new Error('Input must be a string');
echo   }
echo   const vowels = str.toLowerCase().match(/[aeiou]/g);
echo   return vowels ? vowels.length : 0;
echo };
echo 
echo module.exports = {
echo   capitalize,
echo   reverse,
echo   countVowels
echo };
) > src\string-utils.js

:: إنشاء اختبار وحدة
(
echo const { expect, assert } = require('chai');
echo const { capitalize, reverse, countVowels } = require('../src/string-utils');
echo const helpers = require('../tests/helpers/test-helpers');
echo 
echo describe('String Utility Functions - Unit Tests', function() {
echo   this.timeout(5000); // Set timeout for all tests in this suite
echo 
echo   describe('capitalize function', () => {
echo     it('should capitalize first letter of string', () => {
echo       const result = capitalize('hello');
echo       expect(result).to.equal('Hello');
echo     });
echo 
echo     it('should handle single character strings', () => {
echo       expect(capitalize('a')).to.equal('A');
echo       expect(capitalize('z')).to.equal('Z');
echo     });
echo 
echo     it('should handle empty string', () => {
echo       expect(capitalize('')).to.equal('');
echo     });
echo 
echo     it('should throw error for non-string input', () => {
echo       expect(() => capitalize(123)).to.throw('Input must be a string');
echo       expect(() => capitalize(null)).to.throw('Input must be a string');
echo       expect(() => capitalize(undefined)).to.throw('Input must be a string');
echo     });
echo 
echo     it('should preserve rest of string case', () => {
echo       expect(capitalize('hELLo')).to.equal('HELLO');
echo       expect(capitalize('JavaScript')).to.equal('JavaScript');
echo     });
echo   });
echo 
echo   describe('reverse function', () => {
echo     it('should reverse string correctly', () => {
echo       expect(reverse('hello')).to.equal('olleh');
echo       expect(reverse('world')).to.equal('dlrow');
echo     });
echo 
echo     it('should handle palindromes', () => {
echo       expect(reverse('racecar')).to.equal('racecar');
echo       expect(reverse('madam')).to.equal('madam');
echo     });
echo 
echo     it('should handle empty string', () => {
echo       expect(reverse('')).to.equal('');
echo     });
echo 
echo     it('should throw error for non-string input', () => {
echo       expect(() => reverse(123)).to.throw('Input must be a string');
echo     });
echo 
echo     it('should handle special characters', () => {
echo       expect(reverse('hello!')).to.equal('!olleh');
echo       expect(reverse('123@#')).to.equal('#@321');
echo     });
echo   });
echo 
echo   describe('countVowels function', () => {
echo     it('should count vowels correctly', () => {
echo       expect(countVowels('hello')).to.equal(2); // e, o
echo       expect(countVowels('aeiou')).to.equal(5); // a, e, i, o, u
echo       expect(countVowels('bcdfg')).to.equal(0); // no vowels
echo     });
echo 
echo     it('should be case insensitive', () => {
echo       expect(countVowels('AEIOU')).to.equal(5);
echo       expect(countVowels('Hello')).to.equal(2);
echo     });
echo 
echo     it('should handle empty string', () => {
echo       expect(countVowels('')).to.equal(0);
echo     });
echo 
echo     it('should throw error for non-string input', () => {
echo       expect(() => countVowels(123)).to.throw('Input must be a string');
echo     });
echo 
echo     it('should handle special characters', () => {
echo       expect(countVowels('hello world!')).to.equal(3); // e, o, o
echo       expect(countVowels('test@email.com')).to.equal(4); // e, a, i, o
echo     });
echo   });
echo 
echo   describe('Integration with helpers', () => {
echo     it('should generate test data correctly', () => {
echo       const testData = helpers.generateTestData(3);
echo       expect(testData).to.be.an('array');
echo       expect(testData).to.have.lengthOf(3);
echo       expect(testData[0]).to.have.property('id', 1);
echo       expect(testData[0]).to.have.property('name', 'Test User 1');
echo     });
echo 
echo     it('should validate response structure', () => {
echo       const response = { id: 1, name: 'John', email: 'john@example.com' };
echo       const expectedKeys = ['id', 'name', 'email'];
echo       expect(() => helpers.validateApiResponse(response, expectedKeys)).to.not.throw();
echo     });
echo   });
echo });
) > tests\unit\string-utils.test.js

:: إنشاء اختبار تكامل
(
echo const { expect } = require('chai');
echo const { capitalize, reverse, countVowels } = require('../src/string-utils');
echo 
echo describe('String Utilities - Integration Tests', () => {
echo   describe('Combined operations', () => {
echo     it('should chain multiple string operations', () => {
echo       const input = 'hello world';
echo       const result = capitalize(reverse(input)); // 'dlrow olleh' -> 'Dlrow olleh'
echo       expect(result).to.equal('Dlrow olleh');
echo     });
echo 
echo     it('should work with complex transformations', () => {
echo       const input = 'JavaScript';
echo       const reversed = reverse(input); // 'tpircSavaJ'
echo       const capitalized = capitalize(reversed); // 'TpircSavaJ'
echo       const vowelCount = countVowels(capitalized); // T, i, a, a = 4
echo       
echo       expect(reversed).to.equal('tpircSavaJ');
echo       expect(capitalized).to.equal('TpircSavaJ');
echo       expect(vowelCount).to.equal(4);
echo     });
echo 
echo     it('should handle error propagation correctly', () => {
echo       // All functions should throw same error type
echo       const inputs = [123, null, undefined, {}, []];
echo       
echo       inputs.forEach(input => {
echo         expect(() => capitalize(input)).to.throw('Input must be a string');
echo         expect(() => reverse(input)).to.throw('Input must be a string');
echo         expect(() => countVowels(input)).to.throw('Input must be a string');
echo       });
echo     });
echo 
echo     it('should maintain consistency across operations', () => {
echo       const testStrings = ['hello', 'world', 'test', 'javascript', 'mocha'];
echo       
echo       testStrings.forEach(str => {
echo         // Original string length should equal reversed string length
echo         expect(str.length).to.equal(reverse(str).length);
echo         
echo         // Capitalizing shouldn't change length
echo         expect(str.length).to.equal(capitalize(str).length);
echo         
echo         // Vowel count should be non-negative
echo         expect(countVowels(str)).to.be.at.least(0);
echo       });
echo     });
echo   });
echo 
echo   describe('Performance considerations', () => {
echo     it('should handle long strings efficiently', function() {
echo       this.timeout(10000); // Increase timeout for this test
echo       
echo       const longString = 'a'.repeat(10000);
echo       const startTime = Date.now();
echo       
echo       const reversed = reverse(longString);
echo       const endTime = Date.now();
echo       
echo       expect(reversed).to.have.lengthOf(10000);
echo       expect(endTime - startTime).to.be.lessThan(1000); // Should complete in under 1 second
echo     });
echo 
echo     it('should handle very long strings without errors', () => {
echo       const veryLongString = 'test string '.repeat(1000);
echo       expect(() => capitalize(veryLongString)).to.not.throw();
echo       expect(() => reverse(veryLongString)).to.not.throw();
echo       expect(() => countVowels(veryLongString)).to.not.throw();
echo     });
echo   });
echo });
) > tests\integration\string-integration.test.js

:: إنشاء اختبار مزيف
(
echo const { expect } = require('chai');
echo const sinon = require('sinon');
echo const helpers = require('../tests/helpers/test-helpers');
echo 
echo describe('Sinon Mocking and Stubbing Tests', () => {
echo   describe('Mocking external services', () => {
echo     let mockService;
echo 
echo     beforeEach(() => {
echo       mockService = helpers.createMock(['fetchData', 'postData', 'deleteData']);
echo     });
echo 
echo     afterEach(() => {
echo       sinon.restore(); // Clean up all stubs after each test
echo     });
echo 
echo     it('should mock service methods', async () => {
echo       // Setup mock behavior
echo       mockService.fetchData.resolves({ data: 'test data' });
echo       mockService.postData.resolves({ id: 1, success: true });
echo 
echo       // Test mocked behavior
echo       const result = await mockService.fetchData();
echo       expect(result).to.deep.equal({ data: 'test data' });
echo       expect(mockService.fetchData.calledOnce).to.be.true;
echo 
echo       const postResult = await mockService.postData({ test: 'data' });
echo       expect(postResult).to.deep.equal({ id: 1, success: true });
echo       expect(mockService.postData.calledOnce).to.be.true;
echo     });
echo 
echo     it('should verify mock call counts', async () => {
echo       mockService.fetchData.resolves({ data: 'first call' });
echo 
echo       await mockService.fetchData();
echo       await mockService.fetchData();
echo       await mockService.fetchData();
echo 
echo       expect(mockService.fetchData.callCount).to.equal(3);
echo       expect(mockService.fetchData.calledThrice).to.be.true;
echo     });
echo 
echo     it('should verify mock arguments', async () => {
echo       mockService.postData.resolves({ success: true });
echo 
echo       await mockService.postData({ id: 1, name: 'test' });
echo       await mockService.postData({ id: 2, name: 'another' });
echo 
echo       expect(mockService.postData.firstCall.args[0]).to.deep.equal({ id: 1, name: 'test' });
echo       expect(mockService.postData.secondCall.args[0]).to.deep.equal({ id: 2, name: 'another' });
echo     });
echo   });
echo 
echo   describe('Stubbing functions', () => {
echo     let originalFunction;
echo 
echo     beforeEach(() => {
echo       // Save original function reference
echo       originalFunction = console.log;
echo       // Replace with stub
echo       console.log = sinon.stub();
echo     });
echo 
echo     afterEach(() => {
echo       // Restore original function
echo       console.log = originalFunction;
echo     });
echo 
echo     it('should stub console.log', () => {
echo       console.log('test message');
echo       expect(console.log.calledOnce).to.be.true;
echo       expect(console.log.firstCall.args[0]).to.equal('test message');
echo     });
echo 
echo     it('should allow calling original function', () => {
echo       const logSpy = sinon.spy(console, 'log');
echo       console.log('spy test');
echo       expect(logSpy.calledOnce).to.be.true;
echo       logSpy.restore();
echo     });
echo   });
echo 
echo   describe('Fake timers', () => {
echo     let clock;
echo 
echo     beforeEach(() => {
echo       clock = sinon.useFakeTimers();
echo     });
echo 
echo     afterEach(() => {
echo       clock.restore();
echo     });
echo 
echo     it('should control time for async operations', (done) => {
echo       let executed = false;
echo       setTimeout(() => {
echo         executed = true;
echo       }, 1000);
echo 
echo       clock.tick(1000); // Fast-forward time
echo       expect(executed).to.be.true;
echo       done();
echo     });
echo   });
echo });
) > tests\unit\mocking.test.js

:: إنشاء ملف mocha.opts
(
echo --recursive
echo --require chai
echo --timeout 5000
echo --slow 100
echo --reporter spec
echo tests/**/*.js
) > mocha.opts

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Mocha + Chai Test Runner - Knoux Toolbox
echo echo ========================================
echo echo.
echo echo Choose test option:
echo echo 1. Run all tests
echo echo 2. Run in watch mode
echo echo 3. Run with different reporter
echo echo 4. Run tests matching pattern
echo echo 5. Run with timeout
echo echo 6. Run in parallel
echo echo.
echo set /p "CHOICE=Enter choice (1-6): "
echo 
echo cd /d "!MOCHA_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Running all tests...
echo     npm test
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running tests in watch mode...
echo     npm run test:watch
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running tests with spec reporter...
echo     npm run test:reporter
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running tests matching pattern...
echo     npm run test:grep
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Running tests with timeout...
echo     npm run test:timeout
echo )
echo if "%%CHOICE%%"=="6" (
echo     echo Running tests in parallel...
echo     npm run test:parallel
echo )
echo 
echo pause
) > "!MOCHA_PROJECT!\run-mocha.bat"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Mocha + Chai!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!MOCHA_PROJECT!%WHITE%
echo   تشغيل: %GRAY%npm test%WHITE%
echo   مراقبة: %GRAY%npm run test:watch%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات وحدة وتكامل
echo   ✓ دعم Chai للAssertions
echo   ✓ Sinon للمزيفات
echo   ✓ مراقبة التغطية
echo   ✓ وضع المراقبة (Watch Mode)
echo   ✓ التحكم في الوقت (Fake Timers)
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!MOCHA_PROJECT!"
echo   2. npm test ← لتشغيل الاختبارات
echo   3. npm run test:watch ← للمراقبة الحية
echo   4. ./run-mocha.bat ← لاختيارات سريعة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Mocha + Chai with comprehensive test suite >> "!LOG_FILE!"

timeout /t 8 >nul
