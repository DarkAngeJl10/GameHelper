#SingleInstance Force
#Include lib\WebIniParse.ahk
global StartLoop := 0
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Bottle1, %config%, SelectAutoBootle, Bottle1
IniRead, Bottle2, %config%, SelectAutoBootle, Bottle2
IniRead, Bottle3, %config%, SelectAutoBootle, Bottle3
IniRead, Bottle4, %config%, SelectAutoBootle, Bottle4
IniRead, Bottle5, %config%, SelectAutoBootle, Bottle5
IniRead, HotkeyAutoBottle, %config%, AutoBottle, Key
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

if (HotkeyAutoBottle != "")
{
	Hotkey, %HotkeyAutoBottle%, Start
}

if (CheckforUpdates != 0)
	{
	AutoBottle2kVersion := CheckVersion("AutoBottle")
	if (AutoBottle2kVersion != "") 
	{
		if (The_VersionName != AutoBottle2kVersion) 
		{
			Msgbox, 4, Update, Found a new version: %AutoBottle2kVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Macros\AutoBottle 2k.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/AutoBottle2k.ahk, Macros\AutoBottle 2k.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Macros\AutoBottle 2k.ahk") ) 
				{
					msgbox, AutoBottle 2k.ahk Download failed!
					ExitApp
				}
				IniWrite, %AutoBottle2kVersion%, %config%, AutoBottle, Version
				Msgbox, Updating to latest version: %AutoBottle2kVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Macros\AutoBottle 2k.ahk
			}
		}
	}
}

Process, Wait, PathOfExile_x64.exe, 0
PoEPID := ErrorLevel
if not PoEPID
{
	Process, Wait, PathOfExile.exe, 0
	PoEPID := ErrorLevel
	if not PoEPID
	{
		MsgBox Процесс PathOfExile не найден, запустите игру а потом скрипт
		ExitApp
	}
}
GroupAdd, POE, ahk_pid %PoEPID%
WinNotActive()

Status()
{
	Gui, Status:Color,lime
	Gui, Status:-Caption +Toolwindow +AlwaysOnTop +LastFound
	Gui, Status:Show, X302 Y962 W235 H12 NA
}

WinActive() 
{
	Suspend Off
	Status()
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() 
{
	Gui, Status:Hide
	StartLoop := 0
	SetTimer, Loop, Off
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}
return

Start:
	StartLoop := !StartLoop
	
	Loop:
	{
		IniRead, Bottle1, %config%, SelectAutoBootle, Bottle1
		IniRead, Bottle2, %config%, SelectAutoBootle, Bottle2
		IniRead, Bottle3, %config%, SelectAutoBootle, Bottle3
		IniRead, Bottle4, %config%, SelectAutoBootle, Bottle4
		IniRead, Bottle5, %config%, SelectAutoBootle, Bottle5
		ifWinActive ahk_group POE
		{
			Gui, Status:Hide
		}
		ifWinNotActive ahk_group POE
		{
			Return
		}
		
		If (StartLoop = 1)
		{
			if (Bottle1 = 1)
			{
				PixelSearch, Px1, Py1, 414, 1424, 458, 1432, 0x99D7F9, 0, Fast
				PixelGetColor, color1, %Px1%, %Py1%
				if not (color1 = 0x99D7F9)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					sleep, 50
					Send {1}
				}
			}
	
			if (Bottle2 = 1)
			{
				PixelSearch, Px2, Py2, 477, 1424, 521, 1432, 0x99D7F9, 0, Fast
				PixelGetColor, color2, %Px2%, %Py2%
				if not (color2 = 0x99D7F9)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					sleep, 50
					Send {2}
				}
			}
	
			if (Bottle3 = 1)
			{
				PixelSearch, Px3, Py3, 540, 1424, 584, 1432, 0x99D7F9, 0, Fast
				PixelGetColor, color3, %Px3%, %Py3%
				if not (color3 = 0x99D7F9)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					sleep, 50
					Send {3}
				}
			}
		
			if (Bottle4 = 1)
			{
				PixelSearch, Px4, Py4, 604, 1424, 648, 1432, 0x99D7F9, 0, Fast
				PixelGetColor, color4, %Px4%, %Py4%
				if not (color4 = 0x99D7F9)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					sleep, 50
					Send {4}
				}
			}
		
			if (Bottle5 = 1)
			{
				PixelSearch, Px5, Py5, 665, 1424, 709, 1432, 0x99D7F9, 0, Fast
				PixelGetColor, color5, %Px5%, %Py5%
				if not (color5 = 0x99D7F9)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					sleep, 50
					Send {5}
				}
			}
		}
	}
	If (StartLoop = 0)
	{
		SetTimer, Loop, Off
		Status()
		return
	}
	SetTimer, Loop, 1
return
		
;F10::
;	X = 155
;	Y = 939
;	Mousemove, 354, 1065
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	msgbox %color% , %MouseX%, %MouseY%
return
