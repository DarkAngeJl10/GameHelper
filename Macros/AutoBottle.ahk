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
		IniRead, IsManaAutoBottle2, %config%, SelectAutoBootle, ManaBottle2
		IniRead, IsTinctureAutoBottle4, %config%, SelectAutoBootle, TinctureBottle4
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
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						SetTimer, Blessing, off
						Return
					}
					PixelSearch, Px1, Py1, 317, 1055, 338, 1062, 0x477324, 35, Fast
					if (ErrorLevel = 0)
					{
						Send {1}
					}
				}
			}
			
			if (Bottle2 = 1)
			{
				PixelSearch, Px2, Py2, 355, 1065, 395, 1075, 0x99D7F9, 0, Fast
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						SetTimer, Blessing, off
						Return
					}
					if (IsManaAutoBottle2 = 0)
					{
						ColorBottle2 := 0x477324
					}
					else if (IsManaAutoBottle2 = 1)
					{
						ColorBottle2 := 0x732B12
					}
					PixelSearch, Px1, Py1, 363, 1055, 385, 1058, %ColorBottle2%, 30, Fast
					if (ErrorLevel = 0)
					{
						Send {2}
					}
				}
			}
				
			if (Bottle3 = 1)
			{
				PixelSearch, , , 403, 1065, 440, 1075, 0x99D7F9, 0, Fast
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						SetTimer, Blessing, off
						Return
					}
					PixelSearch, , , 409, 1055, 430, 1062, 0x477324, 35, Fast
					if (ErrorLevel = 0)
					{
						Send {3}
					}
				}
			}
				
			if (Bottle4 = 1)
			{
				PixelSearch, , , 452, 1065, 490, 1075, 0x99D7F9, 0, Fast
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						SetTimer, Blessing, off
						Return
					}
					if (IsTinctureAutoBottle4 = 0)
						{
							PixelSearch, , , 455, 1055, 476, 1062, 0x477324, 35, Fast
							if (ErrorLevel = 0)
							{
								Send {4}
							}
						}
					else if (IsTinctureAutoBottle4 = 1)
					{
						PixelSearch, test22, test33, 444, 981, 483, 995, 0x384CB9, 5, Fast
						if (ErrorLevel != 0)
						{
							Send {4}
						}
					}
				}
			}
				
			if (Bottle5 = 1)
			{
				PixelSearch, Px5, Py5, 500, 1065, 540, 1075, 0x99D7F9, 0, Fast
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						SetTimer, Blessing, off
						Return
					}
					PixelSearch, Px1, Py1, 501, 1055, 521, 1062, 0x477324, 35, Fast
					if (ErrorLevel = 0)
					{
						Send {5}
					}
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

F6::
 MouseGetPos, MouseX, MouseY
 PixelGetColor, color, %MouseX%,%MouseY%
 Clipboard := color
 ;msgbox color , %MouseX%,%MouseY%
return

F7::
 MouseGetPos, MouseX, MouseY
 PixelGetColor, color, %MouseX%,%MouseY%
 Clipboard = %MouseX%, %MouseY%
 ;msgbox color , %MouseX%,%MouseY%
return

F8::
PixelGetColor, test, 478, 991
Clipboard := test
return
