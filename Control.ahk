#SingleInstance Force
DetectHiddenWindows, On
SetTitleMatchMode, 2
#Include lib\WebIniParse.ahk
global AutoBottle := 0
global CheckHP := 0
global Main := 0

config = %A_WorkingDir%\Data\Settings.ini

IniRead, AutoBottle1, %config%, SelectAutoBootle, Bottle1
IniRead, AutoBottle2, %config%, SelectAutoBootle, Bottle2
IniRead, AutoBottle3, %config%, SelectAutoBootle, Bottle3
IniRead, AutoBottle4, %config%, SelectAutoBootle, Bottle4
IniRead, AutoBottle5, %config%, SelectAutoBootle, Bottle5
IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
IniRead, SmokeMine, %config%, Main, SmokeMine
IniRead, DefaultMine, %config%, Main, DefaultMine
IniRead, The_VersionName, %config%, Control, Version
IniRead, CheckforUpdates, %config%, Control, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}
IfNotExist,  %A_WorkingDir%\Macros
{
	FileCreateDir,  %A_WorkingDir%\Macros
}

if (AutoBottle1 == "ERROR" or AutoBottle1 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle1
}
if (AutoBottle2 == "ERROR" or AutoBottle2 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle2
}
if (AutoBottle4 == "ERROR" or AutoBottle3 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle3
}
if (AutoBottle4 == "ERROR" or AutoBottle4 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle4
}
if (AutoBottle5 == "ERROR" or AutoBottle5 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle5
}

if (Bottle15 == "ERROR" or Bottle15 == "")
{
	IniWrite, 0, %config%, SelectBootle, Bottle1-5
}
if (Bottle25 == "ERROR" or Bottle25 == "")
{
	IniWrite, 0, %config%, SelectBootle, Bottle2-5
}
if (Bottle35 == "ERROR" or Bottle35 == "")
{
	IniWrite, 0, %config%, SelectBootle, Bottle3-5
}
if (Bottle45 == "ERROR" or Bottle45 == "")
{
	IniWrite, 0, %config%, SelectBootle, Bottle4-5
}

if (CheckHP70 == "ERROR" or CheckHP70 == "")
{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP70
}
if (CheckHP48 == "ERROR" or CheckHP48 == "")
{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP48
}
if (CheckHP30 == "ERROR" or CheckHP30 == "")
{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP30
}

if (SmokeMine == "ERROR" or SmokeMine == "")
{
	IniWrite, 0, %config%, Main, SmokeMine
}
if (DefaultMine == "ERROR" or DefaultMine == "")
{
	IniWrite, 0, %config%, Main, DefaultMine
}

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, Control, Version
}

if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, Control, CheckforUpdates
}

if (CheckforUpdates != 0)
	{
	ControlVersion := CheckVersion("Control")
	if (ControlVersion != "") 
		{
		if (The_VersionName != ControlVersion) 
			{
			Msgbox, 4, Update, Found a new version: %ControlVersion%`n`nWant to update?
			IfMsgBox Yes
				{
				filedelete, Control.ahk
				IniWrite, %ControlVersion%, %config%, Control, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Control.ahk, Control.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Control.ahk") ) 
					{
					msgbox, Control.ahk Download failed!
					ExitApp
					}
				Msgbox, Updating to latest version: %ControlVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Control.ahk
				}
			}
		}
	}

MW = %A_ScreenWidth%
MH = %A_ScreenHeight%

if (MW = 1920 and MH = 1080)
	{
	Gui, 1:Add, Checkbox,		x10 y10 	gAutoBottle vAutoBottle, 		Auto Bottle
	}
if (MW = 2560 and MH = 1440)
	{
	Gui, 1:Add, Checkbox,		x10 y10 	gAutoBottle2k vAutoBottle2k, 	Auto Bottle
	}
	Gui, 1:Add, Checkbox,		x140 y10 	gCheckHP vCheckHP,  			Check HP
	Gui, 1:Add, Checkbox, 		x10 y40 	gMain vMain, 	 				Main
	
	Gui, 1:Add, Text,			x270 y10, 	Бутылки по кнопке
	Gui, 1:Add, DropDownList,	x270 y30 	gListOfBottle vChoice Choose1,  Disable|Bottle

	Gui, 1:Add, Button, 		x10 y360 	w150 h30 	gSettings Center, 		Настройки
	Gui, 1:Add, Button, 		x240 y360 	w150 h30 	gExitMacros Center, 	Выключить все макросы
	Gui, 1:show, w400 h400
return

Settings:
	Gui, 1:hide
	Gui, 2:Add, Text,			x10 y10, 	Выберите что хотите настроить
	Gui, 2:Add, Button,			x10 y30 	gSettingsAutoBottle, 	Авто бутылки
	Gui, 2:Add, Button,			x140 y30 	gSettingsBottle, 		Бутылки по кнопке
	Gui, 2:Add, Button,			x10 y70 	gSettingsCheckHP, 		Авто ХП
	Gui, 2:Add, Text,			x10 y320, 	Mines
	Gui, 2:Add, Checkbox,		x10 y340 	gSmokeMine 		Checked%SmokeMine%, 	Smoke Mine Setup on Q
	Gui, 2:Add, Checkbox,		x10 y360	gDefaultMine	Checked%DefaultMine%, 	Any Mines on R
	Gui, 2:Show, w400 h400,
return

SettingsAutoBottle:
	IniRead, AutoBottle1, %config%, SelectAutoBootle, Bottle1
	IniRead, AutoBottle2, %config%, SelectAutoBootle, Bottle2
	IniRead, AutoBottle3, %config%, SelectAutoBootle, Bottle3
	IniRead, AutoBottle4, %config%, SelectAutoBootle, Bottle4
	IniRead, AutoBottle5, %config%, SelectAutoBootle, Bottle5
	Gui, 2:hide
	Gui, 3:Add, Text,			x10 y10, 	Выберите какие бутылки будут активны
	
	Gui, 3:Add, Checkbox,		x10 y40 	gAutoBottle1 Checked%AutoBottle1%, 	1 Бутылка
	Gui, 3:Add, Checkbox,		x10 y70 	gAutoBottle2 Checked%AutoBottle2%, 	2 Бутылка
	Gui, 3:Add, Checkbox,		x10 y100 	gAutoBottle3 Checked%AutoBottle3%, 	3 Бутылка
	Gui, 3:Add, Checkbox,		x10 y130 	gAutoBottle4 Checked%AutoBottle4%, 	4 Бутылка
	Gui, 3:Add, Checkbox,		x10 y160 	gAutoBottle5 Checked%AutoBottle5%, 	5 Бутылка
	
	Gui, 3:Add, Button, 		x240 y360 	w150 h30 	gAccept Center, 	Применить
	Gui, 3:Show, w400 h400,
return

SettingsBottle:
	IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
	IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
	IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
	IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
	Gui, 2:hide
	Gui, 4:Add, Text,			x10 y10, 	Выберите какие бутылки будут активны
	
	Gui, 4:Add, radio,			x10 y40 	gBottle15 Checked%Bottle15%, 	1-5 Бутылки
	Gui, 4:Add, radio,			x10 y70 	gBottle25 Checked%Bottle25%, 	2-5 Бутылки
	Gui, 4:Add, radio,			x10 y100 	gBottle35 Checked%Bottle35%, 	3-5 Бутылки
	Gui, 4:Add, radio,			x10 y130 	gBottle45 Checked%Bottle45%, 	4-5 Бутылки
	
	Gui, 4:Add, Button, 		x240 y360 	w150 h30 	gAccept Center, 	Применить
	Gui, 4:Show, w400 h400,
return

SettingsCheckHP:
	IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
	IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
	IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
	Gui, 2:hide
	Gui, 5:Add, Text,			x10 y10, 	Выберите какие бутылки будут активны
	
	Gui, 5:Add, radio,			x10 y40 	gCheckHP70 Checked%CheckHP70%, 	70 Процентов ХП
	Gui, 5:Add, radio,			x10 y70 	gCheckHP48 Checked%CheckHP48%, 	48 Процентов ХП
	Gui, 5:Add, radio,			x10 y100 	gCheckHP30 Checked%CheckHP30%, 	30 Процентов ХП
	
	Gui, 5:Add, Button, 		x240 y360 	w150 h30 	gAccept Center, 	Применить
	Gui, 5:Show, w400 h400,
return

Accept:
	Gui, 3:hide
	Gui, 4:hide
	Gui, 5:hide
	Gui, 1:show
return

ListOfBottle:
GuiControlGet, Choice,
if (Choice = "Disable")
{
	GroupAdd, Bottle, Bottle.ahk
	WinClose, ahk_group Bottle
}
if (Choice = "Bottle")
{
	if (Bottle15 = 0 and Bottle25 = 0 and Bottle35 = 0 and Bottle45 = 0)
	{
		Gui, 1:Cancel
		GuiControl, Choose, Choice, 1
		msgbox, Вы не выбрали бутылки
		goto, SettingsBottle
	}
	if !FileExist("Macros\Bottle.ahk")
	{
		Version := CheckVersion("Bottle")
		IniWrite, %Version%, %config%, Bottle, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/Bottle.ahk, Macros\Bottle.ahk
		if(ErrorLevel || !FileExist("Macros\Bottle.ahk") ) 
		{
			msgbox, Bottle.ahk Download failed!
			return
		}
	}
	if !WinExist("ahk_group Bottle")
	{
		Run, Macros\Bottle.ahk
		GroupAdd, Bottle, Bottle.ahk
		CABottle := 1
	}
}
else
{
	CABottle := 0
	SetTimer, ListOfBottle, off
	WinClose, ahk_group Bottle
}
if (CABottle = 1)
	{
	SetTimer, ListOfBottle, 1000
	}
return

AutoBottle:
ControlGet, AutoBottle, Checked , , Button1,
if (AutoBottle1 = 0 and AutoBottle2 = 0 and AutoBottle3 = 0 and AutoBottle4 = 0 and AutoBottle5 = 0)
{
	GuiControl,,AutoBottle,0
	Gui, 1:hide
	msgbox, Вы не выбрали активные бутылки
	goto, SettingsAutoBottle
}
if (AutoBottle != 0)
{
	if !FileExist("Macros\AutoBottle.ahk")
	{
		Version := CheckVersion("AutoBottle")
		IniWrite, %Version%, %config%, AutoBottle, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/AutoBottle.ahk, Macros\AutoBottle.ahk
		if(ErrorLevel || !FileExist("Macros\AutoBottle.ahk") ) 
		{
			msgbox, AutoBottle.ahk Download failed!
			return
		}
	}
	if !WinExist("ahk_group AutoBottle")
	{
		Run, Macros\AutoBottle.ahk
		GroupAdd, AutoBottle, AutoBottle.ahk
		CAAutoBottle := 1
	}
}
else
{
	CAAutoBottle := 0
	SetTimer, AutoBottle, off
	WinClose, ahk_group AutoBottle
}

if (CAAutoBottle = 1)
	{
	SetTimer, AutoBottle, 1000
	}
return

AutoBottle2k:
ControlGet, AutoBottle2k, Checked , , Button1,

if (Bottle1 = 0 and Bottle2 = 0 and Bottle3 = 0 and Bottle4 = 0 and Bottle5 = 0)
{
	GuiControl,,AutoBottle2k,0
	Gui, 1:hide
	msgbox, Вы не выбрали активные бутылки
	goto, SettingsAutoBottle
}

if (AutoBottle2k != 0)
{
	if !FileExist("Macros\AutoBottle2k.ahk")
	{
		Version := CheckVersion("AutoBottle 2k")
		IniWrite, %Version%, %config%, AutoBottle 2k, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/AutoBottle2k.ahk, Macros\AutoBottle 2k.ahk
		if(ErrorLevel || !FileExist("Macros\AutoBottle 2k.ahk") ) 
		{
			msgbox, AutoBottle 2k.ahk Download failed!
			return
		}
	}
	if !WinExist("ahk_group AutoBottle2k")
	{
		Run, Macros\AutoBottle 2k.ahk
		GroupAdd, AutoBottle2k, AutoBottle 2k.ahk
		CAAutoBottle2k := 1
	}
}
else
{
	CAAutoBottle2k := 0
	SetTimer, AutoBottle2k, off
	WinClose, ahk_group AutoBottle2k
}
if (CAAutoBottle2k = 1)
	{
	SetTimer, AutoBottle2k, 1000
	}
return

CheckHP:
ControlGet, CheckHP, Checked , , Button2,
if (CheckHP70 = 0 and CheckHP48 = 0 and CheckHP30 = 0)
{
	GuiControl,,CheckHP,0
	Gui, 1:hide
	msgbox, Вы не выбрали процент для Авто ХП
	goto, SettingsCheckHP
}
if (CheckHP != 0)
{
	if !FileExist("Macros\CheckHP.ahk")
	{
		Version := CheckVersion("CheckHP")
		IniWrite, %Version%, %config%, CheckHP, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/CheckHP.ahk, Macros\CheckHP.ahk
		if(ErrorLevel || !FileExist("Macros\CheckHP.ahk") ) 
		{
			msgbox, CheckHP.ahk Download failed!
			return
		}
	}
	if !WinExist("ahk_group CheckHP")
	{
		Run, Macros\CheckHP.ahk
		GroupAdd, CheckHP, CheckHP.ahk
		CACheckHP := 1
	}
}
else
{
	CACheckHP := 0
	SetTimer, CheckHP, off
	WinClose, ahk_group CheckHP
}
if (CACheckHP = 1)
	{
	SetTimer, CheckHP, 1000
	}
return

Main:
ControlGet, Main, Checked , , Button3,
if (Main != 0)
{
	if !FileExist("Macros\Main.ahk")
	{
		Version := CheckVersion("Main")
		IniWrite, %Version%, %config%, Main, Version
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/Main.ahk, Macros\Main.ahk
		if(ErrorLevel || !FileExist("Macros\Main.ahk") ) 
		{
			msgbox, Main.ahk Download failed!
			return
		}
	}
	if !WinExist("ahk_group Main")
	{
		Run, Macros\Main.ahk
		GroupAdd, Main, Main.ahk
		CAMain := 1
	}
}
else
{
	CAMain := 0
	SetTimer, Main, off
	WinClose, ahk_group Main
}
if (CAMain = 1)
	{
	SetTimer, Main, 1000
	}
return


ExitMacros:
	GroupAdd, CloseMacros, AutoBottle.ahk
	SetTimer, AutoBottle, off
	GuiControl,,AutoBottle,0
	
	GroupAdd, CloseMacros, AutoBottle 2k.ahk
	SetTimer, AutoBottle2k, off
	GuiControl,,AutoBottle2k,0
	
	GroupAdd, CloseMacros, CheckHP.ahk
	SetTimer, CheckHP, off
	GuiControl,,CheckHP,0
	
	GroupAdd, CloseMacros, Main.ahk
	SetTimer, Main, off
	GuiControl,,Main,0
	
	GroupAdd, CloseMacros, Bottle.ahk
	SetTimer, ListOfBottle, off
	GuiControl, Choose, Choice, 1
	
	WinClose, ahk_group CloseMacros
return

AutoBottle1:
ControlGet, AutoBottle1, Checked , , Button1,
if (AutoBottle1 != 0)
	{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle1
	}
else
	{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle1
	}
return

AutoBottle2:
ControlGet, AutoBottle2, Checked , , Button2,
if (AutoBottle2 != 0)
	{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle2
	}
else
	{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle2
	}
return

AutoBottle3:
ControlGet, AutoBottle3, Checked , , Button3,
if (AutoBottle3 != 0)
	{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle3
	}
else
	{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle3
	}
return

AutoBottle4:
ControlGet, AutoBottle4, Checked , , Button4,
if (AutoBottle4 != 0)
	{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle4
	}
else
	{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle4
	}
return

AutoBottle5:
ControlGet, AutoBottle5, Checked , , Button5,
if (AutoBottle5 != 0)
	{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle5
	}
else
	{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle5
	}
return

;---------------------------------------- BOTTLE ----------------------------------------

Bottle15:
ControlGet, Bottle15, Checked , , Button1,
if (Bottle15 != 0)
	{
	IniWrite, 1, %config%, SelectBootle, Bottle1-5
	IniWrite, 0, %config%, SelectBootle, Bottle2-5
	IniWrite, 0, %config%, SelectBootle, Bottle3-5
	IniWrite, 0, %config%, SelectBootle, Bottle4-5
	}
else
	{
	IniWrite, 0, %config%, SelectBootle, Bottle1-5
	}
return

Bottle25:
ControlGet, Bottle25, Checked , , Button2,
if (Bottle25 != 0)
	{
	IniWrite, 0, %config%, SelectBootle, Bottle1-5
	IniWrite, 1, %config%, SelectBootle, Bottle2-5
	IniWrite, 0, %config%, SelectBootle, Bottle3-5
	IniWrite, 0, %config%, SelectBootle, Bottle4-5
	}
else
	{
	IniWrite, 0, %config%, SelectBootle, Bottle2-5
	}
return

Bottle35:
ControlGet, Bottle35, Checked , , Button3,
if (Bottle35 != 0)
	{
	IniWrite, 0, %config%, SelectBootle, Bottle1-5
	IniWrite, 0, %config%, SelectBootle, Bottle2-5
	IniWrite, 1, %config%, SelectBootle, Bottle3-5
	IniWrite, 0, %config%, SelectBootle, Bottle4-5
	}
else
	{
	IniWrite, 0, %config%, SelectBootle, Bottle3-5
	}
return

Bottle45:
ControlGet, Bottle45, Checked , , Button4,
if (Bottle45 != 0)
	{
	IniWrite, 0, %config%, SelectBootle, Bottle1-5
	IniWrite, 0, %config%, SelectBootle, Bottle2-5
	IniWrite, 0, %config%, SelectBootle, Bottle3-5
	IniWrite, 1, %config%, SelectBootle, Bottle4-5
	}
else
	{
	IniWrite, 0, %config%, SelectBootle, Bottle4-5
	}
return

;---------------------------------------- CHECK HP ----------------------------------------

CheckHP70:
ControlGet, CheckHP70, Checked , , Button1,
if (CheckHP70 != 0)
	{
	IniWrite, 1, %config%, SelectCheckHP, CheckHP70
	IniWrite, 0, %config%, SelectCheckHP, CheckHP48
	IniWrite, 0, %config%, SelectCheckHP, CheckHP30
	}
else
	{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP70
	}
return

CheckHP48:
ControlGet, CheckHP48, Checked , , Button2,
if (CheckHP48 != 0)
	{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP70
	IniWrite, 1, %config%, SelectCheckHP, CheckHP48
	IniWrite, 0, %config%, SelectCheckHP, CheckHP30
	}
else
	{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP48
	}
return

CheckHP30:
ControlGet, CheckHP30, Checked , , Button3,
if (CheckHP30 != 0)
	{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP70
	IniWrite, 0, %config%, SelectCheckHP, CheckHP48
	IniWrite, 1, %config%, SelectCheckHP, CheckHP30
	}
else
	{
	IniWrite, 0, %config%, SelectCheckHP, CheckHP30
	}
return

;

SmokeMine:
ControlGet, SmokeMine, Checked , , Button4,
if (SmokeMine != 0)
	{
	IniWrite, 1, %config%, Main, SmokeMine
	}
else
	{
	IniWrite, 0, %config%, Main, SmokeMine
	}
return

DefaultMine:
ControlGet, DefaultMine, Checked , , Button5,
if (DefaultMine != 0)
	{
	IniWrite, 1, %config%, Main, DefaultMine
	}
else
	{
	IniWrite, 0, %config%, Main, DefaultMine
	}
return

2GuiClose:
Gui 2:hide
Gui 1:show
return

3GuiClose:
Gui 3:hide
Gui 2:show
return

4GuiClose:
Gui 4:hide
Gui 2:show
return

5GuiClose:
Gui 5:hide
Gui 2:show
return

GuiClose:
gosub, ExitMacros
ExitApp

F4::
	reload