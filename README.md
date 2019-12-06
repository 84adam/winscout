# winscout

***Windows PC Diagnostic Tool***

- Open `CMD` as an Administrator, then run **`winscout-full.bat`**
- **REQUIRED**: **`winscout-main.bat`** and **`tee.bat`** must be in the same directory prior to running the script.
- The script should take 1-2 minutes to complete if you skip `sfc /verifynow` (system file check).

**Types of information gathered:**

- systeminfo
- system event logs (error/critical)
- baseboard, BIOS, CPU
- RAM, available/reserved memory
- disks, volumes, partitions
- drive fragmentation percentage
- network interfaces
- ping & tracert times to localhost and google.com
- OPTIONAL: `sfc /verifynow` checks for damaged system files. Select 'Y' when prompted if you wish to run it.

[Tested on Microsoft Windows versions 7 and 10.]
