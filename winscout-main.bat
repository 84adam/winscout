@echo off

title Winscout Diagnoser

REM   __    __ _       __                 _   
REM  / / /\ \ (_)_ __ / _\ ___ ___  _   _| |_ 
REM  \ \/  \/ / | '_ \\ \ / __/ _ \| | | | __|
REM   \  /\  /| | | | |\ \ (_| (_) | |_| | |_ 
REM    \/  \/ |_|_| |_\__/\___\___/ \__,_|\__|
REM                                           
REM  Main Program: winscout-full.bat
REM  Helper Files: winscout-main.bat, tee.bat
REM  Winscout Diagnostic Script
REM  Description: This batch file captures OS, hardware, and networking configuration/status.
REM  Author: Adam Anderson
REM  Code Repo: https://github.com/84adam/winscout

REM Horizontal Rules:
set x=##########
set x=%x%%x%%x%%x%%x%%x%%x%%x%
set y=----------
set y=%y%%y%%y%%y%%y%%y%%y%%y%
set z=__________
set z=%z%%z%%z%%z%%z%%z%%z%%z%

REM timestamp
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "timestamp=%datestamp%_%timestamp%"

echo %x%
echo %x%
echo WINSCOUT DIAGNOSTIC SCAN
echo SCAN START TIME: %timestamp%
echo %x%
echo %x%
echo.
echo Checking system information...

REM Section 1: System and OS information.
echo %y%
echo SYSTEM INFO
echo %y%
echo MAC ADDRESSES
ipconfig /all | findstr Physical
echo %y%
ver
systeminfo
echo %y%
echo BASEBOARD
wmic baseboard get
echo %y%
echo BIOS
wmic bios list
echo %y%
echo CSPRODUCT
wmic csproduct list
echo %y%
echo CPU
wmic cpu list
echo %y%
echo MEMCACHE
wmic memcache list
echo %y%
echo MEMORYCHIP
wmic memorychip list

REM Section 2: Check volume, drive fragmentation, and run CHKDSK (scan only).
echo %x%
echo.
echo DISKDRIVE
wmic diskdrive list
echo %y%
echo VOLUME
vol
echo %y%
wmic volume list
echo %y%
echo LOGICAL DISKS
wmic logicaldisk list
echo %y%
echo PARTITIONS
wmic partition get
echo %y%
echo FRAGMENTATION CHECK
defrag C: /A
echo %y%
echo CHECK DISK
chkdsk /scan
echo %y%
echo S.M.A.R.T. FAILURE PREDICTION CHECK
echo NOTE: If not supported by drive(s), no output will be logged in this section.
wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus

REM Section 3: List available COM devices.
echo %x%
echo.
mode

REM Section 4: System Event Logs (error or critical only)
echo %x%
echo.
echo SYSTEM EVENT LOGS
echo Most recent CRITICAL (Level 1) events:
WEVTUtil qe System /c:10 /rd:true /f:text /q:"Event[System[(Level=1)]]"
echo %y%
echo Most recent ERROR (Level 2) events:
WEVTUtil qe System /c:10 /rd:true /f:text /q:"Event[System[(Level=2)]]"
echo %y%
echo Most recent Memory Diagnostic Results:
WEVTUtil qe System /c:10 /rd:true /f:text /q:"Event[System[Provider[@Name='Microsoft-Windows-MemoryDiagnostics-Results']]]"

REM Section 5: Networking information.
echo %x%
echo.
echo NETWORK INFO
echo %y%
echo NETWORK INTERFACE CONFIGURATION
echo %y%
netsh interface show interface
echo %y%
ipconfig /all
echo %y%
echo PATHPING: LOCALHOST
pathping /h 5 localhost /q 5
echo %y%
echo PATHPING: GOOGLE.COM
pathping /h 5 google.com /q 5

REM Section 6 [OPTIONAL]: System File Check (Verify Only)
echo %z%
echo SYSTEM FILE CHECK `sfc` [VERIFY ONLY]
:Ask
echo Would you like to run `sfc`? (Y/N)
set INPUT=
set /P INPUT=Type input: %=%
if /I "%INPUT%"=="y" goto yes 
if /I "%INPUT%"=="n" goto no
echo Please select 'Y'/'N': & goto Ask
:yes
echo.
echo %y%
echo Starting System File Check...
echo NOTE: Depending on the system, this may take a while.
sfc /verifyonly
echo %y%
echo SFC ERRORS AND WARNINGS:
findstr /c:"[SR]" %windir%\logs\cbs\cbs.log | findstr /i "warning critical error cannot corrupt"
goto cont
:no
echo.
echo %y%
echo Skipping System File Check...
:cont
