#SingleInstance Force
#Include lib\WebIniParse.ahk
global StartLoop := 0
global StartLoopBlessing := 0
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Bottle1, %config%, SelectAutoBootle, Bottle1
IniRead, Bottle2, %config%, SelectAutoBootle, Bottle2
IniRead, Bottle3, %config%, SelectAutoBootle, Bottle3
IniRead, Bottle4, %config%, SelectAutoBootle, Bottle4
IniRead, Bottle5, %config%, SelectAutoBootle, Bottle5
IniRead, IsProgenesisAutoBottle1, %config%, SelectAutoBootle, ProgenesisBottle1
IniRead, IsManaAutoBottle2, %config%, SelectAutoBootle, ManaBottle2
IniRead, IsTinctureAutoBottle4, %config%, SelectAutoBootle, TinctureBottle4
IniRead, HotkeyAutoBottle, %config%, AutoBottle, Key
IniRead, IsEnableBlessing, %config%, Blessing, Enable
IniRead, CDBlessing, %config%, Blessing, CD
IniRead, HotkeyBlessing, %config%, Blessing, Key
IniRead, BlessingInGame, %config%, Blessing, KeyInGame
IniRead, The_VersionName, %config%, AutoBottle, Version
IniRead, CheckforUpdates, %config%, AutoBottle, CheckforUpdates

ColorProgenesis := 0xE52D32
ColorManaBottle := 0x732B12
ColorTincture := 0x384CB9
ColorUtilityBootle := 0x3D9227
RangeColors := 15

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

StatusBlessing()
{
	Gui, StatusBlessing:Color,lime
	Gui, StatusBlessing:-Caption +Toolwindow +AlwaysOnTop +LastFound
	Gui, StatusBlessing:Show, X1696 Y1038 W20 H20 NA
	WinSet, Region, e W20 H20 0-0
}

WinActive() 
{
	Suspend Off
	IniRead, HotkeyAutoBottle, %A_WorkingDir%\Data\Settings.ini, AutoBottle, Key
	IniRead, IsEnableBlessing, %A_WorkingDir%\Data\Settings.ini, Blessing, Enable
	IniRead, HotkeyBlessing, %A_WorkingDir%\Data\Settings.ini, Blessing, Key
	IniRead, BlessingInGame, %A_WorkingDir%\Data\Settings.ini, Blessing, KeyInGame
	if (HotkeyAutoBottle != "")
	{
		Hotkey, %HotkeyAutoBottle%, Start
	}
	if (HotkeyBlessing != "")
	{
		Hotkey, %HotkeyBlessing%, Blessing
	}
	Status()
	If (IsEnableBlessing)
	{
		StatusBlessing()
	}
	else
	{
		Gui, StatusBlessing:hide
	}
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() 
{
	Gui, Status:Hide
	If (IsEnableBlessing)
		{
			Gui, StatusBlessing:Hide
		}
	StartLoopBlessing := 0
	StartLoop := 0
	SetTimer, LoopBlessing, off
	SetTimer, Loop, Off
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
	StartLoopBlessing := !StartLoopBlessing

	LoopBlessing:
	{
		IniRead, IsEnableBlessing, %config%, Blessing, Enable
		IniRead, CDBlessing, %config%, Blessing, CD
		IniRead, BlessingInGame, %config%, Blessing, KeyInGame
		CDBlessingMS := Round(CDBlessing * 1000) - 500

		ifWinActive ahk_group POE
		{
			Gui, StatusBlessing:Hide
		}
		ifWinNotActive ahk_group POE
		{
			Return
		}

		if (IsEnableBlessing = 1)
		{
			If (StartLoopBlessing = 1)
			{
				Send {%BlessingInGame%}
			}
		}
	}
	If (StartLoopBlessing = 0)
	{
		SetTimer, LoopBlessing, Off
		StatusBlessing()
		return
	}
	SetTimer, LoopBlessing, -%CDBlessingMS%
return


Start:
	StartLoop := !StartLoop

	Loop:
	{
		IniRead, Bottle1, %config%, SelectAutoBootle, Bottle1
		IniRead, IsProgenesisAutoBottle1, %config%, SelectAutoBootle, ProgenesisBottle1
		IniRead, Bottle2, %config%, SelectAutoBootle, Bottle2
		IniRead, IsManaAutoBottle2, %config%, SelectAutoBootle, ManaBottle2
		IniRead, Bottle3, %config%, SelectAutoBootle, Bottle3
		IniRead, Bottle4, %config%, SelectAutoBootle, Bottle4
		IniRead, IsTinctureAutoBottle3, %config%, SelectAutoBootle, TinctureBottle3
		IniRead, IsTinctureAutoBottle4, %config%, SelectAutoBootle, TinctureBottle4
		IniRead, Bottle5, %config%, SelectAutoBootle, Bottle5
		CDBlessingMS := Round(CDBlessing * 1000)

		ifWinActive ahk_group POE
		{
			Gui, Status:Hide
		}
		ifWinNotActive ahk_group POE
		{
			Return
		}
		sleep, 100
		
		If (StartLoop = 1)
		{
			if (Bottle1 = 1)
			{
				PixelSearch, , , 314, 1065, 344, 1075, 0x99D7F9, 0, Fast
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					if (IsProgenesisAutoBottle1 = 0)
					{
						PixelSearch, , , 309, 1048, 343, 1065, %ColorUtilityBootle%, %RangeColors%, Fast
						if (ErrorLevel = 0)
						{
							Send {1}
						}
					}
					else if (IsProgenesisAutoBottle1 = 1)
					{
						PixelSearch, , , 309, 1048, 343, 1065, %ColorProgenesis%, 10, Fast
						if (ErrorLevel = 0)
						{
							Send {1}
						}
					}
				}
			}
			
			if (Bottle2 = 1)
			{
				PixelSearch, , , 355, 1065, 395, 1075, 0x99D7F9, 0, Fast
				if (ErrorLevel != 0)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					if (IsManaAutoBottle2 = 0)
					{
						PixelSearch, , , 357, 1048, 388, 1065, %ColorUtilityBootle%, %RangeColors%, Fast
						if (ErrorLevel = 0)
						{
							Send {2}
						}
					}
					else if (IsManaAutoBottle2 = 1)
					{
						PixelSearch, , , 357, 1048, 388, 1065, %ColorManaBottle%, 30, Fast
						if (ErrorLevel = 0)
						{
							Send {2}
						}
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
						Return
					}
					if (IsTinctureAutoBottle3 = 0)
						{
							PixelSearch, , , 404, 1048, 435, 1065, %ColorUtilityBootle%, %RangeColors%, Fast
							if (ErrorLevel = 0)
							{
								Send {3}
							}
						}
					else if (IsTinctureAutoBottle3 = 1)
					{
						PixelSearch, , , 403, 981, 437, 995, %ColorTincture%, 5, Fast
						if (ErrorLevel != 0)
						{
							Send {3}
						}
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
						Return
					}
					if (IsTinctureAutoBottle4 = 0)
						{
							PixelSearch, , , 448, 1048, 482, 1064, %ColorUtilityBootle%, %RangeColors%, Fast
							if (ErrorLevel = 0)
							{
								Send {4}
							}
						}
					else if (IsTinctureAutoBottle4 = 1)
					{
						PixelSearch, , , 444, 981, 483, 995, %ColorTincture%, 5, Fast
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
						Return
					}
					PixelSearch, , , 493, 1048, 527, 1064, %ColorUtilityBootle%, %RangeColors%, Fast
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