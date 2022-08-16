#SingleInstance Force

IfNotExist,  %A_WorkingDir%\lib
{
	FileCreateDir,  %A_WorkingDir%\lib
}

if !FileExist("lib\WebIniParse.ahk")
	{
	UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/lib/WebIniParse.ahk, lib\WebIniParse.ahk
	if(ErrorLevel || !FileExist("lib\WebIniParse.ahk") ) 
		{
		msgbox, WebIniParse.ahk Download failed!
		}
	WebIniParseSucc := 1
	}

if !FileExist("Control.ahk")
	{
	UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Control.ahk, Control.ahk
	if(ErrorLevel || !FileExist("Control.ahk") ) 
		{
		msgbox, Control.ahk Download failed!
		}
	ControlSucc := 1
	}

if !FileExist("Update.ahk")
	{
	UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Update.ahk, Update.ahk
	if(ErrorLevel || !FileExist("Update.ahk") ) 
		{
		msgbox, Update.ahk Download failed!
		}
	UpdateSucc := 1
	}


if (ControlSucc = 1 and UpdateSucc = 1 and WebIniParseSucc = 1)
	{
	FileDelete, Install.ahk
	Exitapp
	}