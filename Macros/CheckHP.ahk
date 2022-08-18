#SingleInstance Force
#Include lib\WebIniParse.ahk
global StartLoopCheckHP := 0
global StartLoopCWDT := 0
global ActivityCWDT := 0
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Debug, %config%, CheckHP, Debug
IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
IniRead, CWDT70, %config%, SelectCheckHP, CWDT70
IniRead, CWDT48, %config%, SelectCheckHP, CWDT48
IniRead, CWDT30, %config%, SelectCheckHP, CWDT30
IniRead, HotkeyCheckHP, %config%, CheckHP, Key
IniRead, HotkeyCWDTKey, %config%, CheckHP, CWDTKey
IniRead, ActivityCWDT, %config%, CheckHP, ActivityCWDT
IniRead, The_VersionName, %config%, CheckHP, Version
IniRead, CheckforUpdates, %config%, CheckHP, CheckforUpdates

if (Debug == "ERROR" or Debug == "")
{
	Debug := 0
	IniWrite, %Debug%, %config%, CheckHP, Debug
}
if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, CheckHP, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, CheckHP, CheckforUpdates
}

if (CheckforUpdates != 0)
{
	CheckHPVersion := CheckVersion("CheckHP")
	if (CheckHPVersion != "") 
	{
		if (The_VersionName != CheckHPVersion) 
		{
			Msgbox, 4, Update, Found a new version: %CheckHPVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Macros\CheckHP.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/CheckHP.ahk, Macros\CheckHP.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Macros\CheckHP.ahk") ) 
				{
					msgbox, CheckHP.ahk Download failed!
					ExitApp
				}
				IniWrite, %CheckHPVersion%, %config%, CheckHP, Version
				Msgbox, Updating to latest version: %CheckHPVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Macros\CheckHP.ahk
			}
		}
	}
}

Status()
{
	Gui, Status:Color,Lime
	Gui, Status:-Caption +Toolwindow +AlwaysOnTop +LastFound
	Gui, Status:Show, X21 Y1000 W20 H20 NA
	WinSet, Region, e W20 H20 0-0
}

StatusCWDT()
{
	Gui, StatusCWDT:Color,Lime
	Gui, StatusCWDT:-Caption +Toolwindow +AlwaysOnTop +LastFound
	Gui, StatusCWDT:Show, X20 Y1050 W20 H20 NA
}

GroupAdd POE, % "Path of Exile"
WinNotActive()
Suspend On
Return

WinActive() 
{
	Suspend Off
	IniRead, HotkeyCheckHP, %A_WorkingDir%\Data\Settings.ini, CheckHP, Key
	IniRead, HotkeyCWDTKey, %A_WorkingDir%\Data\Settings.ini, CheckHP, CWDTKey
	IniRead, ActivityCWDT, %A_WorkingDir%\Data\Settings.ini, CheckHP, ActivityCWDT
	if (HotkeyCheckHP != "")
	{
		Hotkey, %HotkeyCheckHP%, StartCheckHP
	}
	if (ActivityCWDT = 1)
	{
		if (HotkeyCWDTKey != "")
		{
			Hotkey, %HotkeyCWDTKey%, StartCWDT
		}
		StatusCWDT()
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
	StartLoopCheckHP := 0
	SetTimer, LoopCheckHP, Off
	
	if (ActivityCWDT = 1)
	{
		Gui, StatusCWDT:Hide
		StartLoopCWDT := 0
		SetTimer, LoopCWDT, Off
	}
	
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}


StartCheckHP:
	StartLoopCheckHP := !StartLoopCheckHP
	
	IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
	IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
	IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
	
	if (CheckHP70 = 1)
	{
		CheckHPX := 109
		CheckHPY := 924
	}
	
	if (CheckHP48 = 1)
	{
		CheckHPX := 118
		CheckHPY := 980
	}	
	
	if (CheckHP30 = 1)
	{
		CheckHPX := 118
		CheckHPY := 1013
	}
	ifWinActive ahk_group POE
	{
		Gui, Status:Hide
	}
	ifWinNotActive ahk_group POE
	{
		Return
	}
		
	PixelGetColor, ColorCheckHPPreLoop, %CheckHPX%, %CheckHPY%
	
	LoopCheckHP:
	{
		ifWinActive ahk_group POE
		{
			Gui, Status:Hide
		}
		ifWinNotActive ahk_group POE
		{
			Return
		}
		
		If (StartLoopCheckHP = 1)
		{
			PixelGetColor, ColorCheckHPInLoop, %CheckHPX%, %CheckHPY%
			
			IniRead, Debug, %config%, CheckHP, Debug
			if (Debug = 1)
			{
				if (ColorCheckHPInLoop != ColorCheckHPPreLoop)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					FileAppend, %ColorCheckHPInLoop% `n, CheckHPDebug.ini
					sleep, 300
				}
			}
			
			if (ColorCheckHPInLoop = 0x020102 or ColorCheckHPInLoop = 0x020100 or ColorCheckHPInLoop = 0x000000 or ColorCheckHPInLoop = 0x060606)
			{	
			}
			
			if (ColorCheckHPInLoop != ColorCheckHPPreLoop)
			{
				ifWinNotActive ahk_group POE
				{
					Return
				}
				Send {1}
				sleep, 100
			}
		}
	}
	If (StartLoopCheckHP = 0)
	{
		SetTimer, LoopCheckHP, Off
		Status()
		return
	}
	SetTimer, LoopCheckHP, 1
return

StartCWDT:
if (ActivityCWDT = 1)
{
	StartLoopCWDT := !StartLoopCWDT
	
	IniRead, CWDT70, %config%, SelectCheckHP, CWDT70
	IniRead, CWDT48, %config%, SelectCheckHP, CWDT48
	IniRead, CWDT30, %config%, SelectCheckHP, CWDT30
	
	if (CWDT70 = 1)
	{
		CWDTX := 109
		CWDTY := 924
	}
	
	if (CWDT48 = 1)
	{
		CWDTX := 118
		CWDTY := 980
	}	
	
	if (CWDT30 = 1)
	{
		CWDTX := 118
		CWDTY := 1013
	}
	ifWinActive ahk_group POE
	{
		Gui, StatusCWDT:Hide
	}
	ifWinNotActive ahk_group POE
	{
		Return
	}
		
	PixelGetColor, ColorCWDTPreLoop, %CWDTX%, %CWDTY%
	
	LoopCWDT:
	{
		ifWinActive ahk_group POE
		{
			Gui, StatusCWDT:Hide
		}
		ifWinNotActive ahk_group POE
		{
			Return
		}
		
		If (StartLoopCWDT = 1)
		{
			PixelGetColor, ColorCWDTInLoop, %CWDTX%, %CWDTY%
			if (ColorCWDTInLoop = 0x020102 or ColorCWDTInLoop = 0x020100 or ColorCWDTInLoop = 0x000000 or ColorCWDTInLoop = 0x060606)
			{	
			}
			
			if (ColorCWDTInLoop != ColorCWDTPreLoop)
			{
				ifWinNotActive ahk_group POE
				{
					Return
				}
				Send {t}
				sleep, 100
			}
		}
	}
	If (StartLoopCWDT = 0)
	{
		SetTimer, LoopCWDT, Off
		StatusCWDT()
		return
	}
	SetTimer, LoopCWDT, 1
Return
}
Return


;PgUp::							;Отладка всего макроса (по дефолту выключено)
	SwithDebug += 1
	if (SwithDebug = 3)
		{
		SwithDebug -= 2
		}
	if (SwithDebug = 1)
		{
		tooltip, Режим работы Дебаг Координаты, 1825, 1010
		}
	if (SwithDebug = 2)
		{
		tooltip, Режим работы Дебаг Цвет, 1825, 1010
		}
	SetTimer, RemoveToolTip, -10000
	return
	RemoveToolTip:
	tooltip
	return
	
;PgDn::							;Отладка всего макроса (по дефолту выключено)
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	if (SwithDebug = 1)
		{
		clipboard = %MouseX%, %MouseY% 
		}
	if (SwithDebug = 2)
		{
		clipboard := color
		}
	return	
