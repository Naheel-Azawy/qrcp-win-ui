@echo off

set dialog="about:
set dialog=%dialog% <title>QRCP</title>
set dialog=%dialog% <p1>Send file:</p1><br>
set dialog=%dialog% <input type=file id=FILE><br>
set dialog=%dialog% <button onclick=con_write(FILE.value)>SEND</button><br><br>
set dialog=%dialog% <p1>Receive file:</p1><br>
set dialog=%dialog% <button onclick=con_write('receive')>RECEIVE</button>

set dialog=%dialog% <script>
set dialog=%dialog% resizeTo(500, 300);
set dialog=%dialog% var res = 'null';
set dialog=%dialog% var out = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
set dialog=%dialog% function con_write(txt) {
set dialog=%dialog%   if (!txt) txt = 'null';
set dialog=%dialog%   res = txt;
set dialog=%dialog%   close();
set dialog=%dialog% }
set dialog=%dialog% window.onbeforeunload = function() {
set dialog=%dialog%   out.WriteLine(res);
set dialog=%dialog% }
set dialog=%dialog% </script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "res=%%p"
echo result is : "%res%"

if "%res%" NEQ null if "%res%" == "receive" (qrcp.exe receive) else (qrcp.exe send "%res%")
