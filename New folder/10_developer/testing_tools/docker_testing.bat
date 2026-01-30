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
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🐳 Docker Testing - اختبار الحاويات%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

docker --version >nul 2>&1 || (
    echo %RED%✗ Docker غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً containers\docker.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
docker images >nul 2>&1 && (
    echo %GREEN%✓ Docker يعمل%WHITE%
    timeout /t 3 >nul
    goto :CREATE_PROJECT
)

echo %YELLOW%جارٍ التحقق من Docker...%WHITE%
timeout /t 5 >nul

:CREATE_PROJECT
echo %YELLOW%[1/4] جارٍ إنشاء مشروع اختبار الحاويات...%WHITE%

set "DOCKER_TEST_PROJECT=%USERPROFILE%\docker-testing"
if not exist "!DOCKER_TEST_PROJECT!" mkdir "!DOCKER_TEST_PROJECT!" >nul
cd /d "!DOCKER_TEST_PROJECT!"

:: إنشاء Dockerfile لاختبار التطبيق
(
echo # Multi-stage Dockerfile for testing
echo FROM node:18-alpine AS builder
echo 
echo WORKDIR /app
echo COPY package*.json ./
echo RUN npm ci --only=production
echo 
echo # Test stage
echo FROM node:18-alpine AS test
echo 
echo WORKDIR /app
echo COPY package*.json ./
echo RUN npm ci
echo COPY . .
echo 
echo # Install testing dependencies
echo RUN npm install -g jest
echo 
echo # Run tests
echo CMD ["npm", "test"]
echo 
echo # Production stage
echo FROM node:18-alpine AS production
echo 
echo WORKDIR /app
echo COPY --from=builder /app/node_modules ./node_modules
echo COPY . .
echo 
echo EXPOSE 3000
echo CMD ["node", "server.js"]
) > Dockerfile

:: إنشاء docker-compose.yml للاختبار
(
echo version: '3.8'
echo 
echo services:
echo   app:
echo     build:
echo       context: .
echo       target: test
echo     volumes:
echo       - .:/app
echo       - /app/node_modules
echo     environment:
echo       - NODE_ENV=test
echo       - DATABASE_URL=postgresql://test:test@db:5432/testdb
echo     depends_on:
echo       - db
echo       - redis
echo     command: npm test
echo     networks:
echo       - test-network
echo 
echo   db:
echo     image: postgres:15-alpine
echo     environment:
echo       POSTGRES_DB: testdb
echo       POSTGRES_USER: test
echo       POSTGRES_PASSWORD: test
echo     volumes:
echo       - postgres_data:/var/lib/postgresql/data
echo     networks:
echo       - test-network
echo     healthcheck:
echo       test: ["CMD-SHELL", "pg_isready -U test -d testdb"]
echo       interval: 10s
echo       timeout: 5s
echo       retries: 5
echo 
echo   redis:
echo     image: redis:7-alpine
echo     volumes:
echo       - redis_data:/data
echo     networks:
echo       - test-network
echo     healthcheck:
echo       test: ["CMD", "redis-cli", "ping"]
echo       interval: 10s
echo       timeout: 5s
echo       retries: 5
echo 
echo   selenium:
echo     image: selenium/standalone-chrome:latest
echo     environment:
echo       - SE_NODE_MAX_SESSIONS=5
echo       - SE_NODE_SESSION_TIMEOUT=60
echo     ports:
echo       - "4444:4444"
echo     networks:
echo       - test-network
echo     volumes:
echo       - /dev/shm:/dev/shm
echo 
echo   test-runner:
echo     build:
echo       context: .
echo       target: test
echo     volumes:
echo       - .:/app
echo       - /app/node_modules
echo     environment:
echo       - SELENIUM_REMOTE_URL=http://selenium:4444/wd/hub
echo       - TEST_ENV=docker
echo     depends_on:
echo       - app
echo       - db
echo       - redis
echo       - selenium
echo     command: npm run test:e2e
echo     networks:
echo       - test-network
echo 
echo volumes:
echo   postgres_data:
echo   redis_data:
echo 
echo networks:
echo   test-network:
echo     driver: bridge
) > docker-compose.test.yml

:: إنشاء Dockerfile مخصص للاختبارات
(
echo FROM node:18-alpine
echo 
echo # Install testing dependencies
echo RUN npm install -g jest mocha chai cypress
echo 
echo # Install browser dependencies for Cypress
echo RUN apk add --no-cache \
echo     dumb-init \
echo     xvfb \
echo     gtk+3.0 \
echo     libxss1 \
echo     gconf-service \
echo     libasound2 \
echo     libatk-bridge2.0-0 \
echo     libdrm2 \
echo     libxcomposite1 \
echo     libxdamage1 \
echo     libxrandr2 \
echo     libgbm1 \
echo     libxkbcommon0 \
echo     libxshmfence1
echo 
echo WORKDIR /app
echo 
echo # Copy test files
echo COPY package*.json ./
echo RUN npm ci
echo COPY . .
echo 
echo # Create test user
echo RUN addgroup -g 1001 -S nodejs && \
echo     adduser -S nodejs -u 1001
echo 
echo USER nodejs
echo 
echo # Default command
echo CMD ["npm", "test"]
) > Dockerfile.test

echo %YELLOW%[2/4] جارٍ إنشاء ملفات الاختبار...%WHITE%

:: إنشاء package.json للمشروع
(
echo {
echo   "name": "docker-testing-app",
echo   "version": "1.0.0",
echo   "description": "Docker-based testing application",
echo   "main": "server.js",
echo   "scripts": {
echo     "start": "node server.js",
echo     "test": "jest",
echo     "test:watch": "jest --watch",
echo     "test:coverage": "jest --coverage",
echo     "test:e2e": "cypress run",
echo     "test:integration": "mocha tests/integration/*.js",
echo     "docker:test": "docker-compose -f docker-compose.test.yml up --build --abort-on-container-exit",
echo     "docker:test:clean": "docker-compose -f docker-compose.test.yml down -v"
echo   },
echo   "dependencies": {
echo     "express": "^4.18.2",
echo     "pg": "^8.11.3",
echo     "redis": "^4.6.10"
echo   },
echo   "devDependencies": {
echo     "jest": "^29.7.0",
echo     "cypress": "^13.6.0",
echo     "mocha": "^10.2.0",
echo     "chai": "^4.3.10",
echo     "supertest": "^6.3.3"
echo   }
echo }
) > package.json

:: إنشاء اختبار وحدة بسيط
(
echo /**
echo  * Simple unit test for Docker testing
echo  */
echo 
echo const request = require('supertest');
echo const express = require('express');
echo 
echo const app = express();
echo app.get('/health', (req, res) => {
echo   res.json({ status: 'healthy', timestamp: new Date().toISOString() });
echo });
echo 
echo describe('Health Check API', () => {
echo   test('should return healthy status', async () => {
echo     const response = await request(app)
echo       .get('/health')
echo       .expect(200);
echo     
echo     expect(response.body.status).toBe('healthy');
echo     expect(response.body.timestamp).toBeDefined();
echo   });
echo });
) > tests\health.test.js

:: إنشاء اختبار تكامل
(
echo /**
echo  * Integration tests for Docker environment
echo  */
echo 
echo const { expect } = require('chai');
echo const request = require('supertest');
echo 
echo describe('Integration Tests', () => {
echo   let baseUrl;
echo   
echo   before(() => {
echo     baseUrl = process.env.TEST_ENV === 'docker' 
echo       ? 'http://app:3000' 
echo       : 'http://localhost:3000';
echo   });
echo 
echo   it('should connect to the application', async () => {
echo     try {
echo       const response = await request(baseUrl)
echo         .get('/health')
echo         .timeout(5000);
echo       
echo       expect(response.status).to.equal(200);
echo       expect(response.body).to.have.property('status');
echo     } catch (error) {
echo       console.log('Integration test failed - app might not be ready');
echo       throw error;
echo     }
echo   });
echo 
echo   it('should handle database connection', async () => {
echo     // Test database connectivity
echo     const { Client } = require('pg');
echo     const client = new Client({
echo       connectionString: process.env.DATABASE_URL
echo     });
echo     
echo     try {
echo       await client.connect();
echo       const result = await client.query('SELECT NOW()');
echo       expect(result.rows).to.have.length(1);
echo       await client.end();
echo     } catch (error) {
echo       console.log('Database connection test failed');
echo       throw error;
echo     }
echo   });
echo });
) > tests\integration\docker-integration.test.js

:: إنشاء اختبار Cypress E2E
(
echo describe('Docker E2E Tests', () => {
echo   beforeEach(() => {
echo     const baseUrl = Cypress.env('TEST_ENV') === 'docker' 
echo       ? 'http://app:3000' 
echo       : 'http://localhost:3000';
echo     cy.visit(baseUrl);
echo   });
echo 
echo   it('should load the application', () => {
echo     cy.contains('Welcome').should('be.visible');
echo   });
echo 
echo   it('should check health endpoint', () => {
echo     cy.request('/health').then((response) => {
echo       expect(response.status).to.equal(200);
echo       expect(response.body).to.have.property('status', 'healthy');
echo     });
echo   });
echo });
) > cypress\e2e\docker-app.cy.js

echo %YELLOW%[3/4] جارٍ إنشاء سكربتات Docker...%WHITE%

:: إنشاء سكربت بناء الاختبار
(
echo @echo off
echo echo Building Docker Test Image...
echo echo ==============================
echo 
echo docker build -f Dockerfile.test -t docker-testing-app .
echo 
echo if %%errorlevel%% equ 0 (
echo     echo ✓ Test image built successfully
echo ) else (
echo     ✗ Failed to build test image
echo     exit /b 1
echo )
) > build-test-image.bat

:: إنشاء سكربت تشغيل الاختبارات
(
echo @echo off
echo echo Running Docker Tests...
echo echo ========================
echo 
echo echo Starting test environment...
echo docker-compose -f docker-compose.test.yml up --build --abort-on-container-exit
echo 
echo echo Cleaning up...
echo docker-compose -f docker-compose.test.yml down -v
echo 
echo echo Tests completed!
) > run-docker-tests.bat

:: إنشاء سكربت تشغيل اختبارات Selenium
(
echo @echo off
echo echo Running Selenium Tests in Docker...
echo echo ==================================
echo 
echo echo Starting Selenium container...
echo docker run -d -p 4444:4444 --name selenium-test selenium/standalone-chrome:latest
echo 
echo echo Waiting for Selenium to be ready...
echo timeout /t 10
echo 
echo echo Running tests...
echo set SELENIUM_REMOTE_URL=http://localhost:4444/wd/hub
echo npm run test:e2e
echo 
echo echo Cleaning up...
echo docker stop selenium-test
echo docker rm selenium-test
echo 
echo echo Selenium tests completed!
) > run-selenium-tests.bat

echo %YELLOW%[4/4] جارٍ إنشاء ملفات التكوين...%WHITE%

:: إنشاء ملف تكوين Jest لـ Docker
(
echo module.exports = {
echo   testEnvironment: 'node',
echo   testMatch: ['**/tests/**/*.test.js'],
echo   collectCoverageFrom: [
echo     'src/**/*.js',
echo     '!src/**/*.test.js'
echo   ],
echo   coverageDirectory: 'coverage',
echo   coverageReporters: ['text', 'lcov', 'html'],
echo   setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
echo   testTimeout: 30000,
echo   verbose: true
echo };
) > jest.config.js

:: إنشاء ملف الإعداد للاختبارات
(
echo // Global test setup
echo 
echo // Set test environment variables
echo process.env.NODE_ENV = 'test';
echo process.env.TEST_ENV = process.env.TEST_ENV || 'local';
echo 
echo // Global test timeout
echo jest.setTimeout(30000);
echo 
echo // Mock console methods in test environment
echo global.console = {
echo   ...console,
echo   log: jest.fn(),
echo   warn: jest.fn(),
echo   error: jest.fn()
echo };
) > tests\setup.js

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لاختبار Docker!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!DOCKER_TEST_PROJECT!%WHITE%
echo   اختبارات: %GRAY%docker-compose -f docker-compose.test.yml up%WHITE%
echo   بناء: %GRAY%docker build -f Dockerfile.test -t test-app .%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات وحدة في حاويات
echo   ✓ اختبارات تكامل مع PostgreSQL و Redis
echo   ✓ اختبارات E2E مع Selenium
echo   ✓ بيئة اختبار معزولة
echo   ✓ تنظيف تلقائي للموارد
echo   ✓ دعم CI/CD
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!DOCKER_TEST_PROJECT!"
echo   2. run-docker-tests.bat ← لتشغيل جميع الاختبارات
echo   3. docker-compose -f docker-compose.test.yml up ← يدوي
echo   4. run-selenium-tests.bat ← لاختبارات المتصفح

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Set up Docker testing environment with comprehensive test suite >> "!LOG_FILE!"

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
