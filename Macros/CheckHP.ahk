#SingleInstance Force
#Include lib\WebIniParse.ahk
global StartLoop := 0
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Debug, %config%, CheckHP, Debug
IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
IniRead, HotkeyCheckHP, %config%, CheckHP, Key
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

if (HotkeyCheckHP != "")
{
	Hotkey, %HotkeyCheckHP%, Start
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
				filedelete, CheckHP.ahk
				IniWrite, %CheckHPVersion%, %config%, CheckHP, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/CheckHP.ahk, Macros\CheckHP.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("CheckHP.ahk") ) 
				{
					msgbox, CheckHP.ahk Download failed!
					ExitApp
				}
				Msgbox, Updating to latest version: %CheckHPVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run CheckHP.ahk
			}
		}
	}
}

Status()
{
	Gui, Status:Color,Lime
	Gui, Status:-Caption +Toolwindow +AlwaysOnTop +LastFound
	Gui, Status:Show, X90 Y1000 W70 H70 NA
	WinSet, Region, e W70 H70 0-0
}


Suspend On
GroupAdd POE, % "Path of Exile"
WinNotActive()
Return

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

Start:
	StartLoop := !StartLoop
	
	IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
	IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
	IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
	
	if (CheckHP70 = 1)
	{
		X := 109
		Y := 924
	}
	
	if (CheckHP48 = 1)
	{
		X := 118
		Y := 980
	}	
	
	if (CheckHP30 = 1)
	{
		X := 118
		Y := 1013
	}
	ifWinActive ahk_group POE
	{
		Gui, Status:Hide
	}
	ifWinNotActive ahk_group POE
	{
		Return
	}
		
	PixelGetColor, color1, %X%, %Y%
	
	Loop:
	{
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
			PixelGetColor, color, %X%, %Y%
			
			IniRead, Debug, %config%, CheckHP, Debug
			if (Debug = 1)
			{
				if (color != color1)
				{
					ifWinNotActive ahk_group POE
					{
						Return
					}
					FileAppend, %color% `n, CheckHPDebug.ini
					sleep, 300
				}
			}
			
			if (color = 0x020102 or color = 0x020100 or color = 0x000000 or color = 0x060606)
			{	
			}
			
			if (color != color1)
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
	If (StartLoop = 0)
	{
		SetTimer, Loop, Off
		Status()
		return
	}
	SetTimer, Loop, 1
return


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
