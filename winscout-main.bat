@echo off

REM This batch file captures OS, hardware, and networking configuration/status.
title Winscout
echo Checking system information...

REM Horizontal Rules:
set y=----------
set y=%y%%y%%y%%y%%y%%y%%y%%y%
set z=__________
set z=%z%%z%%z%%z%%z%%z%%z%%z%

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
echo %y%
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
echo NOTE: If not supported by drive(s), results in error: "Not supported"
wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus

REM Section 3: List available COM devices.
echo %y%
mode

REM Section 4: System Event Logs (error or critical only)
echo %y%
echo SYSTEM EVENT LOGS
echo %y%
WEVTUtil qe System /rd:true /c:25 /f:text /q:"Event[System[(Level=1  or Level=2)]]"

REM Section 5: Networking information.
echo %y%
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
echo %y%
echo Starting System File Check...
echo NOTE: Depending on the system, this may take a while.
sfc /verifyonly
goto cont
:no
echo %y%
echo Skipping System File Check...
:cont
