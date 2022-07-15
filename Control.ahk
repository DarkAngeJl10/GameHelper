#SingleInstance Force
DetectHiddenWindows, On
SetTitleMatchMode, 2

config = %A_WorkingDir%\Data\Settings.ini

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

CheckVersion()
{
	Endpoint := "https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/version.json"
	LatestAPI := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	LatestAPI.Open("GET", Endpoint, False)
	LatestAPI.Send()
	The_LatestVersion := LatestAPI.ResponseText
	return The_LatestVersion
}

MW = %A_ScreenWidth%
MH = %A_ScreenHeight%



global AutoBottle := 0
global CheckHP := 0
global Main := 0

if !FileExist("Update.ahk")
{
	UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Update.ahk, Update.ahk
	if(ErrorLevel || !FileExist("Update.ahk") ) 
	{
		msgbox, Update.ahk Download failed!
		return
	}
}

	Gui, Control: New,, Control
if (MW = 1920 and MH = 1080)
	{
	Gui, Add, Checkbox,		x10 y10 	gAutoBottle, 	Auto Bottle
	}
if (MW = 2560 and MH = 1440)
	{
	Gui, Add, Checkbox,		x10 y10 	gAutoBottle2k, 	Auto Bottle
	}
	Gui, Add, Checkbox,		x150 y10 	gCheckHP,  		Check HP
	Gui, Add, Checkbox, 	x10 y40 	gMain, 	 		Main
	
	Gui, Add, DropDownList, x10 y70 	gListOfBottle vChoice,  Disable|Bottle 1-5|Bottle 2-5|Bottle 3-5|Bottle 4-5

	Gui, Add, Button, 	x170 y300 	w150 h30 	gExitMacros Center, 	Выключить все макросы
	Gui, show
return

ListOfBottle:
GuiControlGet, Choice,
if (Choice = "Disable")
{
	GroupAdd, Bottle15, Bottle 1-5.ahk
	WinClose, ahk_group Bottle15
	GroupAdd, Bottle25, Bottle 2-5.ahk
	WinClose, ahk_group Bottle25
	GroupAdd, Bottle35, Bottle 3-5.ahk
	WinClose, ahk_group Bottle35
	GroupAdd, Bottle45, Bottle 4-5.ahk
	WinClose, ahk_group Bottle45
}
if (Choice = "Bottle 1-5")
{
	if !FileExist("Bottle 1-5.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, Bottle 1-5, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Bottle1-5.ahk, Bottle 1-5.ahk
		if(ErrorLevel || !FileExist("Bottle 1-5.ahk") ) 
		{
			msgbox, Bottle 1-5.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group Bottle15)
	{
		Run, Bottle 1-5.ahk
		GroupAdd, Bottle15, Bottle 1-5.ahk
	}
}
else
{
	WinClose, ahk_group Bottle15
}
if (Choice = "Bottle 2-5")
{
	if !FileExist("Bottle 2-5.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, Bottle 2-5, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Bottle2-5.ahk, Bottle 2-5.ahk
		if(ErrorLevel || !FileExist("Bottle 2-5.ahk") ) 
		{
			msgbox, Bottle 2-5.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group Bottle25)
	{
		Run, Bottle 2-5.ahk
		GroupAdd, Bottle25, Bottle 2-5.ahk
	}
}
else
{
	WinClose, ahk_group Bottle25
}
if (Choice = "Bottle 3-5")
{
	if !FileExist("Bottle 3-5.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, Bottle 3-5, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Bottle3-5.ahk, Bottle 3-5.ahk
		if(ErrorLevel || !FileExist("Bottle 3-5.ahk") ) 
		{
			msgbox, Bottle 3-5.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group Bottle35)
	{
		Run, Bottle 3-5.ahk
		GroupAdd, Bottle35, Bottle 3-5.ahk
	}
}
else
{
	WinClose, ahk_group Bottle35
}
if (Choice = "Bottle 4-5")
{
	if !FileExist("Bottle 4-5.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, Bottle 4-5, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Bottle4-5.ahk, Bottle 4-5.ahk
		if(ErrorLevel || !FileExist("Bottle 4-5.ahk") ) 
		{
			msgbox, Bottle 4-5.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group Bottle45)
	{
		Run, Bottle 4-5.ahk
		GroupAdd, Bottle45, Bottle 4-5.ahk
	}
}
else
{
	WinClose, ahk_group Bottle45
}
return

AutoBottle:
ControlGet, AutoBottle, Checked , , Button1, Control
if (AutoBottle != 0)
{
	if !FileExist("AutoBottle.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, AutoBottle, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/AutoBottle.ahk, AutoBottle.ahk
		if(ErrorLevel || !FileExist("AutoBottle.ahk") ) 
		{
			msgbox, AutoBottle.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group AutoBottle)
	{
		Run, AutoBottle.ahk
		GroupAdd, AutoBottle, AutoBottle.ahk
	}
}
else
{
	WinClose, ahk_group AutoBottle
}
return

AutoBottle2k:
ControlGet, AutoBottle2k, Checked , , Button1, Control
if (AutoBottle2k != 0)
{
	if !FileExist("AutoBottle2k.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, AutoBottle 2k, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/AutoBottle2k.ahk, AutoBottle 2k.ahk
		if(ErrorLevel || !FileExist("AutoBottle 2k.ahk") ) 
		{
			msgbox, AutoBottle 2k.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group AutoBottle2k)
	{
		Run, AutoBottle 2k.ahk
		GroupAdd, AutoBottle2k, AutoBottle 2k.ahk
	}
}
else
{
	WinClose, ahk_group AutoBottle2k
}
return

CheckHP:
ControlGet, CheckHP, Checked , , Button2, Control
if (CheckHP != 0)
{
	if !FileExist("CheckHP.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, CheckHP, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/CheckHP.ahk, CheckHP.ahk
		if(ErrorLevel || !FileExist("CheckHP.ahk") ) 
		{
			msgbox, CheckHP.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group CheckHP)
	{
		Run, CheckHP.ahk
		GroupAdd, CheckHP, CheckHP.ahk
	}
}
else
{
	WinClose, ahk_group CheckHP
}
return

Main:
ControlGet, Main, Checked , , Button3, Control
if (Main != 0)
{
	if !FileExist("Main.ahk")
	{
		Version := CheckVersion()
		IniWrite, %Version%, %config%, Main, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Main.ahk, Main.ahk
		if(ErrorLevel || !FileExist("Main.ahk") ) 
		{
			msgbox, Main.ahk Download failed!
			return
		}
	}
	if WinExist(ahk_group Main)
	{
		Run, Main.ahk
		GroupAdd, Main, Main.ahk
	}
}
else
{
	WinClose, ahk_group Main
}
return

ExitMacros:
		GroupAdd, ExitMacros, AutoBottle.ahk
		Control, Uncheck ,, Button1,
		
		GroupAdd, ExitMacros, AutoBottle 2k.ahk
		Control, Uncheck ,, Button1,
		
		GroupAdd, ExitMacros, CheckHP.ahk
		Control, Uncheck ,, Button2,
		
		GroupAdd, ExitMacros, Main.ahk
		Control, Uncheck ,, Button3,
		
		GroupAdd, ExitMacros, Bottle 1-5.ahk
		GroupAdd, ExitMacros, Bottle 2-5.ahk
		GroupAdd, ExitMacros, Bottle 3-5.ahk
		GroupAdd, ExitMacros, Bottle 4-5.ahk
		
		WinClose, ahk_group ExitMacros

return

MainGuiClose:
ExitApp

F4::
	reload
