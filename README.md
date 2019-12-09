# winscout

***Windows PC Diagnostic Tool***

**`Winscout`** is a non-invasive, Windows PC diagnostic utility with no external dependencies.

**Instructions:**

- [Download](https://github.com/84adam/winscout/archive/master.zip) and unzip the archive.
- Open `CMD` as an Administrator, then run **`winscout-full.bat`**
- **REQUIRED**: **`winscout-main.bat`** and **`tee.bat`** must be in the same directory prior to running the script.
- The script should take 1-2 minutes to complete if you skip `sfc /verifynow` (system file check).
- Opting to run Memory Check (`mdsched.exe`) will immediately reboot your PC in order to begin this test.

**Types of information gathered:**

- systeminfo
- system event logs (error/critical)
- baseboard, BIOS, CPU
- RAM, available/reserved memory
- disks, volumes, partitions
- drive fragmentation percentage
- CHKDSK and SMART* failure prediction statistics (\*if available)
- network interfaces
- ping & tracert times to localhost and google.com
- OPTIONAL: `sfc /verifynow` checks for damaged system files. Select 'Y' when prompted if you wish to run this.
- OPTIONAL: `mdsched.exe` reboots and checks the health of your RAM. Select 'Y' when prompted if you wish to run this.

[Tested on Microsoft Windows versions 7 and 10.]
