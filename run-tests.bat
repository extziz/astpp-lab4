@echo off
rem Usage: run-tests.bat [smoke|load|stress|all]   (jmeter.bat must be in PATH)
cd /d "%~dp0"
set TARGET=%1
if "%TARGET%"=="" set TARGET=all
if /I "%TARGET%"=="all" (
  call :run smoke
  call :run load
  call :run stress
) else (
  call :run %TARGET%
)
goto :eof

:run
if exist Results\%1-report rmdir /s /q Results\%1-report
if exist Results\%1.jtl del Results\%1.jtl
set PLAN=TestPlans\CTRS_%1.jmx
jmeter -n -t %PLAN% -l Results\%1.jtl -j Results\%1.log -Jjmeter.reportgenerator.overall_granularity=5000 -e -o Results\%1-report
goto :eof
