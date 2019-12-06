@echo OFF 

REM This batch file captures OS, hardware, and networking configuration/status.
title Winscout
echo Checking system information...

REM Horizontal Rule
set y=----------
set y=%y%%y%%y%%y%%y%%y%%y%%y%

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

REM OPTIONAL: Uncomment `sfc` line (delete `REM`) to run.
REM Section 5: System File Checker (verify only).
REM echo %y%
REM sfc /verifyonly
REM echo %y%
