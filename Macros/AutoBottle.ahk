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
				filedelete, Macros\AutoBottle.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/AutoBottle.ahk, Macros\AutoBottle.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Macros\AutoBottle.ahk") ) 
				{
					msgbox, AutoBottle.ahk Download failed!
					ExitApp
				}
				IniWrite, %AutoBottleVersion%, %config%, AutoBottle, Version
				Msgbox, Updating to latest version: %AutoBottleVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Macros\AutoBottle.ahk
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
		Process, Wait, PathOfExileSteam.exe, 0
		PoEPID := ErrorLevel
		if not PoEPID
		{
			MsgBox Процесс PathOfExile не найден, запустите игру а потом скрипт
			ExitApp
		}
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
	IniRead, HotkeyAutoBottle, %A_WorkingDir%\Data\Settings.ini, AutoBottle, Key
	if (HotkeyAutoBottle != "")
	{
		Hotkey, %HotkeyAutoBottle%, Start
	}
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
	SetTimer, Blessing, off
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}
return

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

;$t::
{
	ifWinNotActive ahk_group POE
	{
		SetTimer, Blessing, off
		return
	}
	
	gosub, Blessing
	
}
return
	
	
Blessing:
	{
		ifWinNotActive ahk_group POE
		{
			return
		}
		If (StartLoop = 1)
		{
			BlockInput On
			Send {2}
			sleep, 100
			Send {t down}
			sleep, 200
			Send {t up}
			BlockInput Off
			SetTimer, Blessing, -16000
		}
		If (StartLoop = 0)
		{
			Send {t}
			SetTimer, Blessing, Off
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
			SetTimer, Blessing, off
			Return
		}
		sleep, 100
		
		If (StartLoop = 1)
		{
			if (Bottle1 = 1)
			{
				PixelSearch, Px1, Py1, 314, 1065, 344, 1075, 0x99D7F9, 0, Fast
				PixelGetColor, color1, %Px1%, %Py1%
				if not (color1 = 0x99D7F9)
				{
					ifWinNotActive ahk_group POE
					{
						SetTimer, Blessing, off
						Return
					}
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
						SetTimer, Blessing, off
						Return
					}
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
						SetTimer, Blessing, off
						Return
					}
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
						SetTimer, Blessing, off
						Return
					}
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
						SetTimer, Blessing, off
						Return
					}
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