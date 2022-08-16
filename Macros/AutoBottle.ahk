#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Bottle1, %config%, SelectAutoBootle, Bottle1
IniRead, Bottle2, %config%, SelectAutoBootle, Bottle2
IniRead, Bottle3, %config%, SelectAutoBootle, Bottle3
IniRead, Bottle4, %config%, SelectAutoBootle, Bottle4
IniRead, Bottle5, %config%, SelectAutoBootle, Bottle5
IniRead, The_VersionName, %config%, AutoBottle, Version
IniRead, CheckforUpdates, %config%, AutoBottle, CheckforUpdates


if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, AutoBottle, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, AutoBottle, CheckforUpdates
}

if (CheckforUpdates != 0)
	{
	AutoBottleVersion := CheckVersion("AutoBottle")
	if (AutoBottleVersion != "") 
	{
		if (The_VersionName != AutoBottleVersion) 
		{
			Msgbox, 4, Update, Found a new version: %AutoBottleVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, AutoBottle.ahk
				IniWrite, %AutoBottleVersion%, %config%, AutoBottle, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/AutoBottle.ahk, AutoBottle.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("AutoBottle.ahk") ) 
				{
					msgbox, AutoBottle.ahk Download failed!
					ExitApp
				}
				Msgbox, Updating to latest version: %AutoBottleVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run AutoBottle.ahk
			}
		}
	}
}

Gui,Color,lime
Gui, -Caption +Toolwindow +AlwaysOnTop +LastFound
WinSet, Region, 0-0 W235 H12 



Suspend On
GroupAdd POE, % "Path of Exile"
WinNotActive()
Return

WinActive() {
	Suspend Off
	Gui,Show, X302 Y962 W235 H12 NA
	WinGetTitle, winTitle, A
	WinGet, winProcessName, ProcessName, A
	sleep, 35
	
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() {
	Gui, Hide
	;SetTimer, VaalBootleAndSkills, 	Off
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

;numpad1::
VaalBootleAndSkills:
	{
	ifWinNotActive ahk_group POE
		{
		Return
		}	
		
	Send, {1}
	sleep, 150
	Send, {e}
	sleep, 150
	Send, {r}
	sleep, 150
	Send, {t}
	sleep, 150

	SetTimer, VaalBootleAndSkills, 14200
	}
	return
	
;$capslock::
	ifWinNotActive ahk_group POE
		{
		Return
		}
	Send, {r}
	Send, {r}
	sleep, 50
	Send, {t}
	sleep, 50
	return

numpad2::
Loop,
{
	{
	ifWinActive ahk_group POE
		{
		Gui, Hide
		Sleep, 100
		}
	ifWinNotActive ahk_group POE
		{
		Gui,Color,Lime
		Break
		}
	}
	sleep, 100
	
	if (Bottle1 = 1)
		{
		PixelSearch, Px1, Py1, 314, 1065, 344, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color1, %Px1%, %Py1%
		if not (color1 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {1}
			}
		}
	
	if (Bottle2 = 1)
		{
		PixelSearch, Px2, Py2, 355, 1065, 395, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color2, %Px2%, %Py2%
		if not (color2 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {2}
			}
		}
		
	if (Bottle3 = 1)
		{
		PixelSearch, Px3, Py3, 403, 1065, 440, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color3, %Px3%, %Py3%
		if not (color3 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				return
				}
			sleep, 50
			Send {3}
			}
		}
		
	if (Bottle4 = 1)
		{
		PixelSearch, Px4, Py4, 452, 1065, 490, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color4, %Px4%, %Py4%
		if not (color4 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {4}
			}
		}
		
	if (Bottle5 = 1)
		{
		PixelSearch, Px5, Py5, 500, 1065, 540, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color5, %Px5%, %Py5%
		if not (color5 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {5}
			}
		}
	}
return
		
;F8::
		X = 309
		Y = 117
	;	Mousemove, %X%, %Y%
	;	MouseGetPos, MouseX, MouseY
		PixelGetColor, color, %X%, %Y%
	;	PixelGetColor, color, %MouseX%, %MouseY%
		clipboard := color
	;	msgbox %color% , %MouseX%, %MouseY%
	return


numpad5::
	;SetTimer, VaalBootleAndSkills, 	Off
	Reload