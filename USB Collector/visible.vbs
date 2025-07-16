Set shell = CreateObject("WScript.Shell")
shell.Run Chr(34) & WScript.Arguments(0) & Chr(34), 0, False
