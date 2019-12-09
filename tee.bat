@if (@X)==(@Y) @end /* hybrid line, JScript comment

:: --- Batch section within JScript comment that calls the internal JScript ---
:: Author: https://stackexchange.com/users/996187/dbenham
:: Code from answer posted here: https://stackoverflow.com/questions/10711839
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
