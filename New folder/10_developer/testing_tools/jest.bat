@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %YELLOW%===================================================%WHITE%
echo %YELLOW%  🃏 Jest - اختبار JavaScript/TypeScript%WHITE%
echo %YELLOW%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
where jest >nul 2>&1 && (
    echo %GREEN%✓ Jest مثبت مسبقًا%WHITE%
    jest --version 2>nul || echo Version: latest
    goto :CREATE_PROJECT
)

echo %YELLOW%جارٍ تثبيت Jest...%WHITE%

set "JEST_PROJECT=%USERPROFILE%\jest-tests"
if not exist "!JEST_PROJECT!" mkdir "!JEST_PROJECT!" >nul
cd /d "!JEST_PROJECT!"

:: إنشاء package.json
(
echo {
echo   "name": "jest-tests",
echo   "version": "1.0.0",
echo   "description": "Jest Testing Project",
echo   "main": "index.js",
echo   "scripts": {
echo     "test": "jest",
echo     "test:watch": "jest --watch",
echo     "test:coverage": "jest --coverage",
echo     "test:verbose": "jest --verbose",
echo     "test:debug": "node --inspect-brk node_modules/.bin/jest --runInBand",
echo     "test:update": "jest --updateSnapshot"
echo   },
echo   "keywords": ["jest", "testing", "javascript", "typescript"],
echo   "author": "Knoux Developer",
echo   "license": "MIT",
echo   "devDependencies": {
echo     "jest": "^29.7.0",
echo     "@types/jest": "^29.5.8",
echo     "ts-jest": "^29.1.1",
echo     "typescript": "^5.2.2"
echo   },
echo   "jest": {
echo     "preset": "ts-jest",
echo     "testEnvironment": "node",
echo     "collectCoverageFrom": [
echo       "**/*.{js,ts}",
echo       "!**/node_modules/**",
echo       "!**/vendor/**"
echo     ],
echo     "coverageThreshold": {
echo       "global": {
echo         "branches": 80,
echo         "functions": 80,
echo         "lines": 80,
echo         "statements": 80
echo       }
echo     }
echo   }
echo }
) > package.json

npm install >nul 2>&1

where jest >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Jest%WHITE%

:CREATE_PROJECT
echo %YELLOW%جارٍ إنشاء هيكل المشروع...%WHITE%

:: إنشاء ملف إعدادات TypeScript
(
echo {
echo   "compilerOptions": {
echo     "target": "es2018",
echo     "module": "commonjs",
echo     "lib": ["es2018"],
echo     "strict": true,
echo     "esModuleInterop": true,
echo     "skipLibCheck": true,
echo     "forceConsistentCasingInFileNames": true,
echo     "outDir": "./dist",
echo     "rootDir": "./src",
echo     "declaration": true,
echo     "declarationMap": true,
echo     "sourceMap": true,
echo     "removeComments": true,
echo     "noImplicitAny": true,
echo     "strictNullChecks": true,
echo     "strictFunctionTypes": true,
echo     "noImplicitThis": true,
echo     "noUnusedLocals": true,
echo     "noUnusedParameters": true,
echo     "noImplicitReturns": true,
echo     "noFallthroughCasesInSwitch": true,
echo     "moduleResolution": "node",
echo     "baseUrl": "./",
echo     "paths": {
echo       "@/*": ["src/*"]
echo     }
echo   },
echo   "include": [
echo     "src/**/*",
echo     "tests/**/*"
echo   ],
echo   "exclude": [
echo     "node_modules",
echo     "dist"
echo   ]
echo }
) > tsconfig.json

:: إنشاء مجلدات المشروع
mkdir src src\utils src\services tests tests\unit tests\integration >nul 2>&1

:: إنشاء وحدة تجريبية
(
echo /**
echo  * Math utility functions
echo  */
echo 
echo /**
echo  * Add two numbers
echo  * @param {number} a - First number
echo  * @param {number} b - Second number
echo  * @returns {number} Sum of a and b
echo  */
echo export const add = (a: number, b: number): number => {
echo   if (typeof a !== 'number' || typeof b !== 'number') {
echo     throw new Error('Both arguments must be numbers');
echo   }
echo   return a + b;
echo };
echo 
echo /**
echo  * Subtract two numbers
echo  * @param {number} a - First number
echo  * @param {number} b - Second number
echo  * @returns {number} Difference of a and b
echo  */
echo export const subtract = (a: number, b: number): number => {
echo   if (typeof a !== 'number' || typeof b !== 'number') {
echo     throw new Error('Both arguments must be numbers');
echo   }
echo   return a - b;
echo };
echo 
echo /**
echo  * Multiply two numbers
echo  * @param {number} a - First number
echo  * @param {number} b - Second number
echo  * @returns {number} Product of a and b
echo  */
echo export const multiply = (a: number, b: number): number => {
echo   if (typeof a !== 'number' || typeof b !== 'number') {
echo     throw new Error('Both arguments must be numbers');
echo   }
echo   return a * b;
echo };
echo 
echo /**
echo  * Divide two numbers
echo  * @param {number} a - First number
echo  * @param {number} b - Second number
echo  * @returns {number} Quotient of a and b
echo  */
echo export const divide = (a: number, b: number): number => {
echo   if (typeof a !== 'number' || typeof b !== 'number') {
echo     throw new Error('Both arguments must be numbers');
echo   }
echo   if (b === 0) {
echo     throw new Error('Cannot divide by zero');
echo   }
echo   return a / b;
echo };
) > src\utils\math.ts

:: إنشاء اختبار وحدة
(
echo import { add, subtract, multiply, divide } from '../src/utils/math';
echo 
echo describe('Math Utility Functions', () => {
echo   describe('add function', () => {
echo     test('should add two positive numbers correctly', () => {
echo       expect(add(2, 3)).toBe(5);
echo     });
echo 
echo     test('should add negative numbers correctly', () => {
echo       expect(add(-2, -3)).toBe(-5);
echo     });
echo 
echo     test('should add mixed positive and negative numbers', () => {
echo       expect(add(5, -3)).toBe(2);
echo     });
echo 
echo     test('should throw error for non-number inputs', () => {
echo       expect(() => add('2' as any, 3)).toThrow('Both arguments must be numbers');
echo       expect(() => add(2, '3' as any)).toThrow('Both arguments must be numbers');
echo     });
echo   });
echo 
echo   describe('subtract function', () => {
echo     test('should subtract two numbers correctly', () => {
echo       expect(subtract(5, 3)).toBe(2);
echo     });
echo 
echo     test('should handle negative results', () => {
echo       expect(subtract(3, 5)).toBe(-2);
echo     });
echo 
echo     test('should throw error for non-number inputs', () => {
echo       expect(() => subtract('5' as any, 3)).toThrow('Both arguments must be numbers');
echo     });
echo   });
echo 
echo   describe('multiply function', () => {
echo     test('should multiply two numbers correctly', () => {
echo       expect(multiply(4, 3)).toBe(12);
echo     });
echo 
echo     test('should handle zero multiplication', () => {
echo       expect(multiply(5, 0)).toBe(0);
echo       expect(multiply(0, 5)).toBe(0);
echo     });
echo 
echo     test('should throw error for non-number inputs', () => {
echo       expect(() => multiply('4' as any, 3)).toThrow('Both arguments must be numbers');
echo     });
echo   });
echo 
echo   describe('divide function', () => {
echo     test('should divide two numbers correctly', () => {
echo       expect(divide(12, 3)).toBe(4);
echo     });
echo 
echo     test('should handle decimal results', () => {
echo       expect(divide(7, 2)).toBeCloseTo(3.5);
echo     });
echo 
echo     test('should throw error when dividing by zero', () => {
echo       expect(() => divide(10, 0)).toThrow('Cannot divide by zero');
echo     });
echo 
echo     test('should throw error for non-number inputs', () => {
echo       expect(() => divide('12' as any, 3)).toThrow('Both arguments must be numbers');
echo     });
echo   });
echo });
) > tests\unit\math.test.ts

:: إنشاء خدمة تجريبية
(
echo import { add, multiply } from '../src/utils/math';
echo 
echo interface CalculatorConfig {
echo   precision?: number;
echo }
echo 
echo export class Calculator {
echo   private config: CalculatorConfig;
echo 
echo   constructor(config: CalculatorConfig = {}) {
echo     this.config = {
echo       precision: 2,
echo       ...config
echo     };
echo   }
echo 
echo   public calculate(operation: string, ...numbers: number[]): number {
echo     switch (operation) {
echo       case 'add':
echo         return numbers.reduce((sum, num) => add(sum, num), 0);
echo       case 'multiply':
echo         return numbers.reduce((product, num) => multiply(product, num), 1);
echo       case 'average':
echo         const sum = numbers.reduce((total, num) => add(total, num), 0);
echo         return this.round(add(sum, 0) / numbers.length);
echo       default:
echo         throw new Error(`Unsupported operation: ${operation}`);
echo     }
echo   }
echo 
echo   private round(value: number): number {
echo     const multiplier = Math.pow(10, this.config.precision!);
echo     return Math.round(value * multiplier) / multiplier;
echo   }
echo }
) > src\services\calculator.ts

:: إنشاء اختبار تكامل
(
echo import { Calculator } from '../src/services/calculator';
echo 
echo describe('Calculator Service - Integration Tests', () => {
echo   let calculator: Calculator;
echo 
echo   beforeEach(() => {
echo     calculator = new Calculator({ precision: 2 });
echo   });
echo 
echo   test('should perform multiple operations in sequence', () => {
echo     const result = calculator.calculate('add', 10, 20, 30);
echo     expect(result).toBe(60);
echo 
echo     const multiplyResult = calculator.calculate('multiply', 2, 3, 4);
echo     expect(multiplyResult).toBe(24);
echo   });
echo 
echo   test('should calculate average correctly', () => {
echo     const avg = calculator.calculate('average', 10, 20, 30);
echo     expect(avg).toBe(20);
echo   });
echo 
echo   test('should handle floating point precision', () => {
echo     const calc = new Calculator({ precision: 3 });
echo     const result = calc.calculate('add', 0.1, 0.2);
echo     expect(result).toBe(0.3);
echo   });
echo 
echo   test('should throw error for unsupported operation', () => {
echo     expect(() => calculator.calculate('power', 2, 3))
echo       .toThrow('Unsupported operation: power');
echo   });
echo 
echo   test('should handle edge cases', () => {
echo     // Empty array for addition should return 0
echo     expect(calculator.calculate('add')).toBe(0);
echo     
echo     // Single number for multiplication should return that number
echo     expect(calculator.calculate('multiply', 5)).toBe(5);
echo     
echo     // Single number for average should return that number
echo     expect(calculator.calculate('average', 10)).toBe(10);
echo   });
echo });
) > tests\integration\calculator.test.ts

:: إنشاء اختبار مزيف
(
echo // Mock external API service
echo export const mockApiService = {
echo   getData: jest.fn(),
echo   postData: jest.fn(),
echo   deleteData: jest.fn(),
echo };
echo 
echo // Real implementation would connect to actual API
echo export const realApiService = {
echo   async getData(id: string) {
echo     // In real scenario: fetch from API
echo     return { id, name: `Item ${id}`, status: 'active' };
echo   },
echo 
echo   async postData(data: any) {
echo     // In real scenario: post to API
echo     return { id: Math.floor(Math.random() * 1000), ...data, createdAt: new Date() };
echo   },
echo 
echo   async deleteData(id: string) {
echo     // In real scenario: delete from API
echo     return { deleted: true, id };
echo   }
echo };
) > src\services\mock-api.ts

:: إنشاء اختبار مزيف
(
echo import { realApiService, mockApiService } from '../src/services/mock-api';
echo 
echo describe('Mock Service Tests', () => {
echo   beforeEach(() => {
echo     // Clear all mocks
echo     jest.clearAllMocks();
echo   });
echo 
echo   test('should use mock implementation', async () => {
echo     // Mock the function
echo     mockApiService.getData.mockResolvedValue({ id: '123', name: 'Test Item' });
echo     
echo     const result = await mockApiService.getData('123');
echo     
echo     expect(mockApiService.getData).toHaveBeenCalledWith('123');
echo     expect(result.id).toBe('123');
echo     expect(result.name).toBe('Test Item');
echo   });
echo 
echo   test('should track mock calls', async () => {
echo     mockApiService.postData.mockResolvedValue({ id: '456', status: 'created' });
echo     
echo     await mockApiService.postData({ name: 'New Item' });
echo     await mockApiService.postData({ name: 'Another Item' });
echo     
echo     expect(mockApiService.postData).toHaveBeenCalledTimes(2);
echo     expect(mockApiService.postData).toHaveBeenNthCalledWith(1, { name: 'New Item' });
echo     expect(mockApiService.postData).toHaveBeenNthCalledWith(2, { name: 'Another Item' });
echo   });
echo 
echo   test('should spy on real service', async () => {
echo     const spy = jest.spyOn(realApiService, 'getData');
echo     
echo     const result = await realApiService.getData('789');
echo     
echo     expect(spy).toHaveBeenCalledWith('789');
echo     expect(result.id).toBe('789');
echo     
echo     spy.mockRestore(); // Clean up
echo   });
echo });
) > tests\unit\mock-service.test.ts

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Jest Test Runner - Knoux Toolbox
echo echo ===============================
echo echo.
echo echo Choose test option:
echo echo 1. Run all tests
echo echo 2. Run in watch mode
echo echo 3. Run with coverage
echo echo 4. Run verbose mode
echo echo 5. Update snapshots
echo echo.
echo set /p "CHOICE=Enter choice (1-5): "
echo 
echo cd /d "!JEST_PROJECT!"
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
echo     echo Running tests with coverage...
echo     npm run test:coverage
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running tests in verbose mode...
echo     npm run test:verbose
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Updating snapshots...
echo     npm run test:update
echo )
echo 
echo pause
) > "!JEST_PROJECT!\run-jest.bat"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Jest!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!JEST_PROJECT!%WHITE%
echo   تشغيل: %GRAY%npm test%WHITE%
echo   تغطية: %GRAY%npm run test:coverage%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات وحدة وتكامل
echo   ✓ دعم TypeScript
echo   ✓ تغطية الكود التلقائية
echo   ✓ مزيفات (Mocks) وسبيز (Spies)
echo   ✓ وضع المراقبة (Watch Mode)
echo   ✓ مقارنة الصور (Snapshots)
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!JEST_PROJECT!"
echo   2. npm test ← لتشغيل الاختبارات
echo   3. npm run test:watch ← للمراقبة الحية
echo   4. npm run test:coverage ← لتغطية الكود

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Jest with comprehensive test suite >> "!LOG_FILE!"

timeout /t 8 >nul
