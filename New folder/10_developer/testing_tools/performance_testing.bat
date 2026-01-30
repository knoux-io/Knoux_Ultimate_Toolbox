@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  📊 Performance Testing - اختبار الأداء%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
npm list -g artillery k6 >nul 2>&1 && (
    echo %GREEN%✓ أدوات اختبار الأداء مثبتة%WHITE%
    timeout /t 3 >nul
    goto :CREATE_PROJECT
)

echo %YELLOW%جارٍ تثبيت أدوات اختبار الأداء...%WHITE%

npm install -g artillery >nul 2>&1
npm install -g k6 >nul 2>&1

echo %GREEN%✓ تم تثبيت أدوات اختبار الأداء%WHITE%

:CREATE_PROJECT
echo %YELLOW%جارٍ إنشاء مشروع اختبار الأداء...%WHITE%

set "PERF_TEST_PROJECT=%USERPROFILE%\performance-testing"
if not exist "!PERF_TEST_PROJECT!" mkdir "!PERF_TEST_PROJECT!" >nul
cd /d "!PERF_TEST_PROJECT!"

:: إنشاء ملف إعدادات Artillery
(
echo config:
echo   target: 'https://jsonplaceholder.typicode.com'
echo   phases:
echo     - duration: 60
echo       arrivalRate: 5
echo       name: "Warm up"
echo     - duration: 120
echo       arrivalRate: 10
echo       name: "Load test"
echo     - duration: 60
echo       arrivalRate: 20
echo       name: "Stress test"
echo   processor: "./processor.js"
echo   payload:
echo     path: "./data.csv"
echo     fields:
echo       - "userId"
echo       - "postId"
echo   defaults:
echo     headers:
echo       Content-Type: "application/json"
echo       User-Agent: "Knoux Performance Test/1.0"
echo 
echo scenarios:
echo   - name: "API Load Testing"
echo     weight: 70
echo     flow:
echo       - get:
echo           url: "/posts"
echo           expect:
echo             - statusCode: 200
echo             - contentType: "application/json"
echo       
echo       - loop:
echo           - get:
echo               url: "/posts/{{ postId }}"
echo               expect:
echo                 - statusCode: 200
echo                 - hasBody: true
echo           count: 5
echo 
echo   - name: "POST Request Testing"
echo     weight: 20
echo     flow:
echo       - post:
echo           url: "/posts"
echo           json:
echo             title: "Performance Test Post"
echo             body: "This is a performance test post"
echo             userId: "{{ userId }}"
echo           expect:
echo             - statusCode: 201
echo             - hasBody: true
echo 
echo   - name: "Error Handling Test"
echo     weight: 10
echo     flow:
echo       - get:
echo           url: "/nonexistent"
echo           expect:
echo             - statusCode: 404
) > artillery-config.yml

:: إنشاء ملف معالج Artillery
(
echo module.exports = {
echo   // Custom processor functions for Artillery
echo   
echo   generateRandomUserId: function(userContext, events, done) {
echo     const userId = Math.floor(Math.random() * 10) + 1;
echo     userContext.vars.userId = userId;
echo     return done();
echo   },
echo   
echo   generateRandomPostId: function(userContext, events, done) {
echo     const postId = Math.floor(Math.random() * 100) + 1;
echo     userContext.vars.postId = postId;
echo     return done();
echo   },
echo   
echo   logRequestStart: function(userContext, events, done) {
echo     console.log(`Starting request for user: ${userContext.vars.userId}`);
echo     return done();
echo   },
echo   
echo   logRequestEnd: function(userContext, events, done) {
echo     console.log(`Completed request for user: ${userContext.vars.userId}`);
echo     return done();
echo   }
echo };
) > processor.js

:: إنشاء ملف بيانات للاختبار
(
echo userId,postId
echo 1,1
echo 2,2
echo 3,3
echo 4,4
echo 5,5
echo 6,6
echo 7,7
echo 8,8
echo 9,9
echo 10,10
) > data.csv

:: إنشاء سكربت K6 لاختبار الأداء
(
echo import http from 'k6/http';
echo import { check, sleep } from 'k6';
echo import { Rate } from 'k6/metrics';
echo 
echo // Custom metrics
echo const errorRate = new Rate('errors');
echo 
echo // Test configuration
echo export const options = {
echo   stages: [
echo     { duration: '2m', target: 10 }, // Ramp up to 10 users
echo     { duration: '5m', target: 10 }, // Stay at 10 users
echo     { duration: '2m', target: 50 }, // Ramp up to 50 users
echo     { duration: '5m', target: 50 }, // Stay at 50 users
echo     { duration: '2m', target: 0 },  // Ramp down to 0 users
echo   ],
echo   thresholds: {
echo     http_req_duration: ['p(95)<500'], // 95% of requests should be below 500ms
echo     http_req_failed: ['rate<0.1'],    // Error rate should be less than 10%
echo     errors: ['rate<0.1'],             // Custom error rate
echo   },
echo };
echo 
echo const BASE_URL = 'https://jsonplaceholder.typicode.com';
echo 
echo // Test data
echo const testPosts = [
echo   { id: 1, title: 'Test Post 1', body: 'Test body 1', userId: 1 },
echo   { id: 2, title: 'Test Post 2', body: 'Test body 2', userId: 2 },
echo   { id: 3, title: 'Test Post 3', body: 'Test body 3', userId: 3 },
echo ];
echo 
echo export default function () {
echo   // Test GET requests
echo   let response = http.get(`${BASE_URL}/posts`);
echo   let success = check(response, {
echo     'status is 200': (r) => r.status === 200,
echo     'response time < 500ms': (r) => r.timings.duration < 500,
echo     'response has data': (r) => r.json().length > 0,
echo   });
echo   
echo   errorRate.add(!success);
echo   sleep(1);
echo   
echo   // Test POST requests
echo   const randomPost = testPosts[Math.floor(Math.random() * testPosts.length)];
echo   response = http.post(`${BASE_URL}/posts`, randomPost, {
echo     headers: { 'Content-Type': 'application/json' },
echo   });
echo   
echo   success = check(response, {
echo     'status is 201': (r) => r.status === 201,
echo     'response time < 1000ms': (r) => r.timings.duration < 1000,
echo     'response has id': (r) => r.json().hasOwnProperty('id'),
echo   });
echo   
echo   errorRate.add(!success);
echo   sleep(1);
echo   
echo   // Test individual post retrieval
echo   const postId = Math.floor(Math.random() * 100) + 1;
echo   response = http.get(`${BASE_URL}/posts/${postId}`);
echo   
echo   success = check(response, {
echo     'status is 200 or 404': (r) => r.status === 200 || r.status === 404,
echo     'response time < 300ms': (r) => r.timings.duration < 300,
echo   });
echo   
echo   errorRate.add(!success);
echo   sleep(1);
echo }
echo 
echo export function handleSummary(data) {
echo   return {
echo     'performance-report.json': JSON.stringify(data, null, 2),
echo     stdout: textSummary(data, { indent: ' ', enableColors: true }),
echo   };
echo }
) > k6-performance-test.js

:: إنشاء سكربت Node.js لاختبار الأداء المخصص
(
echo const http = require('http');
echo const https = require('https');
echo const { performance } = require('perf_hooks');
echo 
echo class PerformanceTester {
echo   constructor(options = {}) {
echo     this.concurrent = options.concurrent || 10;
echo     this.duration = options.duration || 60000; // 1 minute
echo     this.url = options.url || 'https://jsonplaceholder.typicode.com/posts';
echo     this.results = [];
echo     this.errors = [];
echo   }
echo 
echo   async makeRequest() {
echo     return new Promise((resolve, reject) => {
echo       const startTime = performance.now();
echo       const protocol = this.url.startsWith('https') ? https : http;
echo       
echo       const req = protocol.get(this.url, (res) => {
echo         let data = '';
echo         res.on('data', chunk => data += chunk);
echo         res.on('end', () => {
echo           const endTime = performance.now();
echo           const responseTime = endTime - startTime;
echo           
echo           resolve({
echo             statusCode: res.statusCode,
echo             responseTime,
echo             contentLength: data.length,
echo             timestamp: new Date().toISOString()
echo           });
echo         });
echo       });
echo       
echo       req.on('error', (error) => {
echo         const endTime = performance.now();
echo         const responseTime = endTime - startTime;
echo         
echo         reject({
echo           error: error.message,
echo           responseTime,
echo           timestamp: new Date().toISOString()
echo         });
echo       });
echo       
echo       req.setTimeout(10000, () => {
echo         req.destroy();
echo         reject({
echo           error: 'Request timeout',
echo           responseTime: 10000,
echo           timestamp: new Date().toISOString()
echo         });
echo       });
echo     });
echo   }
echo 
echo   async runConcurrentTest() {
echo     console.log(`Starting performance test: ${this.concurrent} concurrent requests for ${this.duration}ms`);
echo     console.log(`Target URL: ${this.url}`);
echo     
echo     const startTime = Date.now();
echo     const endTime = startTime + this.duration;
echo     
echo     while (Date.now() < endTime) {
echo       const promises = [];
echo       
echo       for (let i = 0; i < this.concurrent; i++) {
echo         promises.push(
echo           this.makeRequest()
echo             .then(result => this.results.push(result))
echo             .catch(error => this.errors.push(error))
echo         );
echo       }
echo       
echo       await Promise.all(promises);
echo       await new Promise(resolve => setTimeout(resolve, 100)); // Small delay between batches
echo     }
echo     
echo     this.generateReport();
echo   }
echo 
echo   generateReport() {
echo     const totalRequests = this.results.length + this.errors.length;
echo     const successfulRequests = this.results.length;
echo     const failedRequests = this.errors.length;
echo     
echo     if (successfulRequests > 0) {
echo       const responseTimes = this.results.map(r => r.responseTime);
echo       const avgResponseTime = responseTimes.reduce((a, b) => a + b, 0) / responseTimes.length;
echo       const minResponseTime = Math.min(...responseTimes);
echo       const maxResponseTime = Math.max(...responseTimes);
echo       
echo       // Calculate percentiles
echo       const sortedTimes = responseTimes.sort((a, b) => a - b);
echo       const p50 = sortedTimes[Math.floor(sortedTimes.length * 0.5)];
echo       const p95 = sortedTimes[Math.floor(sortedTimes.length * 0.95)];
echo       const p99 = sortedTimes[Math.floor(sortedTimes.length * 0.99)];
echo       
echo       console.log('\n=== Performance Test Report ===');
echo       console.log(`Total Requests: ${totalRequests}`);
echo       console.log(`Successful: ${successfulRequests} (${((successfulRequests/totalRequests)*100).toFixed(2)}%)`);
echo       console.log(`Failed: ${failedRequests} (${((failedRequests/totalRequests)*100).toFixed(2)}%)`);
echo       console.log(`\nResponse Times (ms):`);
echo       console.log(`Average: ${avgResponseTime.toFixed(2)}`);
echo       console.log(`Min: ${minResponseTime.toFixed(2)}`);
echo       console.log(`Max: ${maxResponseTime.toFixed(2)}`);
echo       console.log(`50th percentile: ${p50.toFixed(2)}`);
echo       console.log(`95th percentile: ${p95.toFixed(2)}`);
echo       console.log(`99th percentile: ${p99.toFixed(2)}`);
echo       
echo       if (this.errors.length > 0) {
echo         console.log(`\nErrors:`);
echo         this.errors.slice(0, 5).forEach(error => {
echo           console.log(`- ${error.error || error.message}`);
echo         });
echo         if (this.errors.length > 5) {
echo           console.log(`... and ${this.errors.length - 5} more errors`);
echo         }
echo       }
echo     } else {
echo       console.log('No successful requests completed.');
echo     }
echo     
echo     // Save detailed report to file
echo     const report = {
echo       summary: {
echo         totalRequests,
echo         successfulRequests,
echo         failedRequests,
echo         successRate: (successfulRequests/totalRequests)*100
echo       },
echo       results: this.results,
echo       errors: this.errors,
echo       timestamp: new Date().toISOString()
echo     };
echo     
echo     require('fs').writeFileSync('performance-report.json', JSON.stringify(report, null, 2));
echo     console.log('\nDetailed report saved to: performance-report.json');
echo   }
echo }
echo 
echo // Run the test if this file is executed directly
echo if (require.main === module) {
echo   const tester = new PerformanceTester({
echo     concurrent: 20,
echo     duration: 30000, // 30 seconds
echo     url: process.argv[2] || 'https://jsonplaceholder.typicode.com/posts'
echo   });
echo   
echo   tester.runConcurrentTest().catch(console.error);
echo }
echo 
echo module.exports = PerformanceTester;
) > custom-performance-test.js

:: إنشاء سكربت تشغيل اختبارات الأداء
(
echo @echo off
echo echo Performance Testing Suite - Knoux Toolbox
echo echo ==========================================
echo echo.
echo echo Choose performance test type:
echo echo 1. Artillery Load Testing
echo echo 2. K6 Performance Testing
echo echo 3. Custom Node.js Performance Test
echo echo 4. Run All Tests
echo echo.
echo set /p "CHOICE=Enter choice (1-4): "
echo 
echo cd /d "!PERF_TEST_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Running Artillery load test...
echo     artillery run artillery-config.yml
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running K6 performance test...
echo     k6 run k6-performance-test.js
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running custom Node.js performance test...
echo     node custom-performance-test.js
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running all performance tests...
echo     echo.
echo     echo 1. Artillery Test:
echo     artillery run artillery-config.yml
echo     echo.
echo     echo 2. K6 Test:
echo     k6 run k6-performance-test.js
echo     echo.
echo     echo 3. Custom Test:
echo     node custom-performance-test.js
echo )
echo 
echo pause
) > run-performance-tests.bat

:: إنشاء ملف package.json
(
echo {
echo   "name": "performance-testing",
echo   "version": "1.0.0",
echo   "description": "Performance testing suite",
echo   "scripts": {
echo     "test:artillery": "artillery run artillery-config.yml",
echo     "test:k6": "k6 run k6-performance-test.js",
echo     "test:custom": "node custom-performance-test.js",
echo     "test:all": "npm run test:artillery && npm run test:k6 && npm run test:custom"
echo   },
echo   "dependencies": {
echo     "k6": "^0.45.0"
echo   },
echo   "devDependencies": {
echo     "artillery": "^2.0.0"
echo   }
echo }
) > package.json

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لاختبار الأداء!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!PERF_TEST_PROJECT!%WHITE%
echo   Artillery: %GRAY%artillery run artillery-config.yml%WHITE%
echo   K6: %GRAY%k6 run k6-performance-test.js%WHITE%
echo   Custom: %GRAY%node custom-performance-test.js%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ Artillery لاختبار تحميل API
echo   ✓ K6 لاختبار الأداء المتقدم
echo   ✓ سكربت Node.js مخصص
echo   ✓ تقارير مفصلة JSON
echo   ✓ مقاييس مخصصة (percentiles, error rates)
echo   ✓ اختبار متزامن ومتعدد المراحل
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!PERF_TEST_PROJECT!"
echo   2. run-performance-tests.bat ← للاختيار السريع
echo   3. artillery run artillery-config.yml ← لـ Artillery
echo   4. k6 run k6-performance-test.js ← لـ K6

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Set up comprehensive performance testing suite >> "!LOG_FILE!"

timeout /t 10 >nul
