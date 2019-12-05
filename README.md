# winscout

***Windows PC Diagnostic Tool***

- Open `CMD` as an Administrator, then run **`winscout-full.bat`**.
- **REQUIRED**: **`winscout-main.bat`** and **`tee.bat`** must be in the same directory prior to running the script.
- The script should take about 1 minute to complete.

**Types of information gathered:**

- systeminfo
- baseboard, BIOS, CPU
- RAM
- disks, volumes, partitions
- drive fragmentation percentage
- network interfaces
- ping & tracert times to localhost and google.com
- OPTIONAL: `sfc /verifynow` checks for damaged system files. This takes a long time to run. Uncomment to run if desired.

[Tested on Microsoft Windows Version 10.0.17134.885.]
