@if (@X)==(@Y) @end /* hybrid line, JScript comment

:: --- Batch section within JScript comment that calls the internal JScript ---
::   _              _           _   
::  | |_ ___  ___  | |__   __ _| |_ 
::  | __/ _ \/ _ \ | '_ \ / _` | __|
::  | ||  __/  __/_| |_) | (_| | |_ 
::   \__\___|\___(_)_.__/ \__,_|\__|
::                                    
::  `tee.bat` Author: https://stackexchange.com/users/996187/dbenham
::  Original Post: https://stackoverflow.com/questions/10711839
::                                        
::  Main Program: winscout-full.bat
::  Helper Files: winscout-main.bat, tee.bat
::  Winscout Diagnostic Script
::  Description: This batch file echoes output while also saving it to a specified file.
::  Winscout Author: Adam Anderson
::  Code Repo: https://github.com/84adam/winscout
::  

@echo off
cscript //E:JScript //nologo "%~f0" %*
exit /b

----- End of JScript comment, beginning of normal JScript  ------------------*/
var fso = new ActiveXObject("Scripting.FileSystemObject");
var mode=2;
if (WScript.Arguments.Count()==2) {mode=8;}
var out = fso.OpenTextFile(WScript.Arguments(0),mode,true);
var chr;
while( !WScript.StdIn.AtEndOfStream ) {
  chr=WScript.StdIn.Read(1);
  WScript.StdOut.Write(chr);
  out.Write(chr);
}
