#SingleInstance Force
DetectHiddenWindows, On
#Include lib\WebIniParse.ahk
global AutoBottle := 0
global CheckHP := 0
global Main := 0
global CloseGuiAutoBottle := 0
global CloseGuiAutoBottle2k := 0
global CloseGuiBottle := 1
global CloseGuiCheckHP := 0
global CloseGuiMain := 0
global ActivityCWDT := 0

config = %A_WorkingDir%\Data\Settings.ini

IniRead, AutoBottle1, %config%, SelectAutoBootle, Bottle1
IniRead, IsProgenesisAutoBottle1, %config%, SelectAutoBootle, ProgenesisBottle1
IniRead, AutoBottle2, %config%, SelectAutoBootle, Bottle2
IniRead, IsManaAutoBottle2, %config%, SelectAutoBootle, ManaBottle2
IniRead, AutoBottle3, %config%, SelectAutoBootle, Bottle3
IniRead, AutoBottle4, %config%, SelectAutoBootle, Bottle4
IniRead, IsTinctureAutoBottle4, %config%, SelectAutoBootle, TinctureBottle4
IniRead, AutoBottle5, %config%, SelectAutoBootle, Bottle5
IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
IniRead, CWDT70, %config%, SelectCheckHP, CWDT70
IniRead, CWDT48, %config%, SelectCheckHP, CWDT48
IniRead, CWDT30, %config%, SelectCheckHP, CWDT30
IniRead, IsEnableBlessing, %config%, Blessing, Enable
IniRead, CDBlessing, %config%, Blessing, CD
IniRead, SmokeMine, %config%, Main, SmokeMine
IniRead, DefaultMine, %config%, Main, DefaultMine
IniRead, AutoBottleKey, %config%, AutoBottle, Key
IniRead, CheckHPKey, %config%, CheckHP, Key
IniRead, CWDTKey, %config%, CheckHP, CWDTKey
IniRead, BottleKey, %config%, Bottle, Key
IniRead, BlessingKey, %config%, Blessing, Key
IniRead, BlessingKeyInGame, %config%, Blessing, KeyInGame
IniRead, ActivityCWDT, %config%, CheckHP, ActivityCWDT
IniRead, The_VersionName, %config%, Control, Version
IniRead, CheckforUpdates, %config%, Control, CheckforUpdates
IniRead, Debug, %config%, Control, Debug

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
if (IsProgenesisAutoBottle1 == "ERROR" or IsProgenesisAutoBottle1 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, ProgenesisBottle1
}
if (IsManaAutoBottle2 == "ERROR" or IsManaAutoBottle2 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, ManaBottle2
}
if (IsTinctureAutoBottle4 == "ERROR" or IsTinctureAutoBottle4 == "")
{
	IniWrite, 0, %config%, SelectAutoBootle, TinctureBottle4
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
if (CWDT70 == "ERROR" or CWDT70 == "")
{
	IniWrite, 0, %config%, SelectCheckHP, CWDT70
}
if (CWDT48 == "ERROR" or CWDT48 == "")
{
	IniWrite, 0, %config%, SelectCheckHP, CWDT48
}
if (CWDT30 == "ERROR" or CWDT30 == "")
{
	IniWrite, 0, %config%, SelectCheckHP, CWDT30
}


if (IsEnableBlessing == "ERROR" or IsEnableBlessing == "")
	{
		IniWrite, 0, %config%, Blessing, Enable
	}
if (CDBlessing == "ERROR" or CDBlessing == "")
{
	IniWrite, 0, %config%, Blessing, CD
}


if (SmokeMine == "ERROR" or SmokeMine == "")
{
	IniWrite, 0, %config%, Main, SmokeMine
}
if (DefaultMine == "ERROR" or DefaultMine == "")
{
	IniWrite, 0, %config%, Main, DefaultMine
}


if (BottleKey == "ERROR"  or BottleKey == "")
{
	IniWrite, % "", %config%, Bottle, Key
}
if (AutoBottleKey == "ERROR"  or AutoBottleKey == "")
{
	IniWrite, % "", %config%, AutoBottle, Key
}
if (CheckHPKey == "ERROR"  or CheckHPKey == "")
{
	IniWrite, % "", %config%, CheckHP, Key
}
if (CWDTKey == "ERROR"  or CWDTKey == "")
{
	IniWrite, % "", %config%, CheckHP, CWDTKey
}
if (BlessingKey == "ERROR"  or BlessingKey == "")
{
	IniWrite, % "", %config%, Blessing, Key
}
if (BlessingKeyInGame == "ERROR"  or BlessingKeyInGame == "")
{
	IniWrite, % "", %config%, Blessing, KeyInGame
}


if (ActivityCWDT == "ERROR" or ActivityCWDT == "")
{
	IniWrite, 0, %config%, CheckHP, ActivityCWDT
}


if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, Control, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, Control, CheckforUpdates
}
if (Debug == "ERROR" or Debug == "")
{
	IniWrite, 0, %config%, Control, Debug
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
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Control.ahk, Control.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Control.ahk") ) 
				{
					msgbox, Control.ahk Download failed!
					ExitApp
				}
				IniWrite, %ControlVersion%, %config%, Control, Version
				Msgbox, Updating to latest version: %ControlVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Control.ahk
			}
		}
	}
}

MW = %A_ScreenWidth%
MH = %A_ScreenHeight%
CheckDebugHotkeys()

Start:
if (MW = 1920 and MH = 1080)
{
	Gui, 1:Add, Checkbox,		x10 y10	 				gAutoBottle vAutoBottle Checked%CloseGuiAutoBottle%, 		Auto Bottle
}
if (MW = 2560 and MH = 1440)
{
	Gui, 1:Add, Checkbox,		x10 y10 				gAutoBottle2k vAutoBottle2k Checked%CloseGuiAutoBottle2k%, 	Auto Bottle
}
	Gui, 1:Add, Checkbox,		x140 y10 				gCheckHP vCheckHP Checked%CloseGuiCheckHP%,  				Check HP
	Gui, 1:Add, Checkbox, 		x10 y40					gMain vMain Checked%CloseGuiMain%, 	 						Main
	
	Gui, 1:Add, Text,			x270 y10, 																			Бутылки по кнопке
	Gui, 1:Add, DropDownList,	x270 y30				gListOfBottle vChoice Choose%CloseGuiBottle%,  				Disable|Bottle

	Gui, 1:Add, Button, 		x10 y360 w150 h30 		gSettings Center, 											Настройки
	Gui, 1:Add, Button, 		x240 y360 w150 h30 		gExitMacros Center, 										Выключить все макросы
	Gui, 1:show, w400 h400
return

Settings:
	Gui, 1:Destroy
	Gui, 2:Add, Text,			x10 y10, 														Выберите что хотите настроить
	Gui, 2:Add, Button,			x10 y30 w100			gSettingsAutoBottle, 					AutoBottle
	Gui, 2:Add, Button,			x120 y30 w100			gSettingsCheckHP, 						CheckHP %A_Space% CWDT
	Gui, 2:Add, Button,			x230 y30 w120			gSettingsBottle, 						Бутылки по кнопке
	Gui, 2:Add, Button,			x10 y70 w100			gSettingsBlessing, 						Blessing
	Gui, 2:Add, Text,			x10 y320, 				Mines
	Gui, 2:Add, Checkbox,		x10 y340 				gSmokeMine Checked%SmokeMine%, 			Smoke Mine Setup on Q
	Gui, 2:Add, Checkbox,		x10 y360				gDefaultMine Checked%DefaultMine%, 		Any Mines on R
	
	Gui, 2:Add, Checkbox,		x240 y340 				gDebugMode Checked%Debug%, 				Debug Mode

	Gui, 2:Add, Button, 		x240 y360 w150 h30  	gBackToStart Center, 					Назад
	Gui, 2:Show, w400 h400,
return

BackToStart:
	Gui, 2:Destroy
	goto, Start
return

;--------------------------------------- BLESSING ---------------------------------------

SettingsBlessing:
	IniRead, CDBlessing, %config%, Blessing, CD
	IniRead, IsEnableBlessing, %config%, Blessing, Enable
	IniRead, BlessingKey, %config%, Blessing, Key
	IniRead, BlessingKeyInGame, %config%, Blessing, KeyInGame
	Gui, 2:Destroy
	Gui, Blessing:Add, Checkbox,		x10 y10 			gBlessing Checked%IsEnableBlessing%, 	Включить Blessing?
	Gui, Blessing:Add, Text,			x10 y50 w150		vBlessingUnFocus, 						Сколько Длительность у Blessing? (Вводить в секундах)
	Gui, Blessing:Add, Edit, 			x10 y80 w100 h20 	vInputCDBlessing gCDBlessing, %CDBlessing%		

	Gui, Blessing:Add, Text, 			x10 y110 w150 h30 vErrorText cRed, 							В поле ввода содержатся недопустимые символы.
    GuiControl, Blessing: Hide,	ErrorText	

	Gui, Blessing:Add, Text,			x200 y140, 													На какой клавише Blessing в игре?
	Gui, Blessing:Add, Button, 			x226 y160	w120    gKeyBindBlessingInGame, 				Назначить
	Gui, Blessing:Add, Text,			x200 y90, 													Клавиша: %BlessingKeyInGame%
	
	Gui, Blessing:Add, Text,			x205 y10, 													Привязка к Клавиатура/Мышь
	Gui, Blessing:Add, Button, 			x226 y30	w120    gKeyBindBlessing, 						Клавиатура
	Gui, Blessing:Add, Button, 			x226 y60    w120	gMouseBindBlessing, 					Мышь
	Gui, Blessing:Add, Text,			x200 y90, 													Макрос активируется на: %BlessingKey%
	
	Gui, Blessing:Add, Button, 			x240 y360 w150 h30  gBackToSettings Center, 				Назад
	Gui, Blessing:Show, w400 h400,
	GuiControl, Blessing: Focus, BlessingUnFocus
return

KeyBindBlessingInGame:
	Gui, Blessing:Destroy
	Gui, BindBlessing:Add, Text,		x08 y30         vKeyBindUnFocus, 							Клавиша: 
	Gui, BindBlessing:Add, Hotkey, 		x63 y27 w120	gBlessingBindInGame	vBlessingBindInGame, 	%BlessingKeyInGame%
	Gui, BindBlessing:Show, w200 h100
	GuiControl, BindBlessing: Focus, KeyBindUnFocus
return

KeyBindBlessing:
	Gui, Blessing:Destroy
	Gui, BindBlessing:Add, Text,		x08 y30         vKeyBindUnFocus, 							Клавиша: 
	Gui, BindBlessing:Add, Hotkey, 		x63 y27 w120	gBlessingBind	vBlessingBind, %BlessingKey%
	Gui, BindBlessing:Show, w200 h100
	GuiControl, BindBlessing: Focus, KeyBindUnFocus
return

MouseBindBlessing:
	BreakLoopBlessing := 0
	Gui, Blessing:Destroy
	Gui, BindBlessing:Add, Text,		x15 y30, 													Мышь: 
	Gui, BindBlessing:Add, Edit, 		x60 y27 w120   vBlessingMouseBind Disabled, %BlessingKey%
	Gui, BindBlessing:Show, w200 h100
	MouseKeyArray := ["MButton", "XButton1", "XButton2"]
	Loop
	{
		for i, MouseKey in MouseKeyArray
		{
			GetKeyState, state, %MouseKey%
			if (state == "D")
			{
				if (MouseKey = AutoBottleKey)
				{
					IniWrite, % "", %config%, AutoBottle, Key
				}
				if (MouseKey = BottleKey)
				{
					IniWrite, % "", %config%, Bottle, Key
				}
				if (MouseKey = CheckHPKey)
				{
					IniWrite, % "", %config%, CheckHP, Key
				}
				if (MouseKey = CWDTKey)
				{
					IniWrite, % "", %config%, CheckHP, CWDTKey
				}
				GuiControl, BindBlessing: Text, BlessingMouseBind, %MouseKey%
				IniWrite, %MouseKey%, %config%, Blessing, Key
			}
		}
		if (BreakLoopBlessing = 1)
		{
			Break
		}
	}
return

BlessingBindInGame:
	GuiControl, BindBlessing: Focus, KeyBindUnFocus
	;W.I.P.
	;TODO
	;Add check for all Key Binds
	IniWrite, %BlessingBindInGame%, %config%, Blessing, KeyInGame
return

BlessingBind:
	GuiControl, BindBlessing: Focus, KeyBindUnFocus
	if (BlessingBind = AutoBottleKey)
	{
		IniWrite, % "", %config%, AutoBottle, Key
	}
	if (BlessingBind = BottleKey)
	{
		IniWrite, % "", %config%, Bottle, Key
	}
	if (BlessingBind = CheckHPKey)
	{
		IniWrite, % "", %config%, CheckHP, Key
	}
	if (BlessingBind = CWDTKey)
	{
		IniWrite, % "", %config%, CheckHP, CWDTKey
	}
	IniWrite, %BlessingBind%, %config%, Blessing, Key
return

Blessing:
	ControlGet, IsEnableBlessing, Checked , , Button1,
	if (IsEnableBlessing != 0)
	{
		IniWrite, 1, %config%, Blessing, Enable
	}
	else
	{
		IniWrite, 0, %config%, Blessing, Enable
	}
return

CDBlessing:
	GuiControlGet, InputCDBlessing,, InputCDBlessing
	If (RegExMatch(InputCDBlessing, "[^\d,.]"))
	{
		GuiControl, Show, ErrorText
	}
	else 
	{
		GuiControl, Hide, ErrorText
		StringReplace, InputCDBlessing, InputCDBlessing, `,, .
		IniWrite, %InputCDBlessing%, %config%, Blessing, CD
	}
return

BindBlessingGuiClose:
	BreakLoopBlessing := 1
	Gui, BindBlessing:Destroy
	Goto, SettingsBlessing
return


;--------------------------------------- AUTO BOTTLE ---------------------------------------

SettingsAutoBottle:
	IniRead, AutoBottle1, %config%, SelectAutoBootle, Bottle1
	IniRead, IsProgenesisAutoBottle1, %config%, SelectAutoBootle, ProgenesisBottle1
	IniRead, AutoBottle2, %config%, SelectAutoBootle, Bottle2
	IniRead, IsManaAutoBottle2, %config%, SelectAutoBootle, ManaBottle2
	IniRead, AutoBottle3, %config%, SelectAutoBootle, Bottle3
	IniRead, AutoBottle4, %config%, SelectAutoBootle, Bottle4
	IniRead, IsTinctureAutoBottle4, %config%, SelectAutoBootle, TinctureBottle4
	IniRead, AutoBottle5, %config%, SelectAutoBootle, Bottle5
	IniRead, AutoBottleKey, %config%, AutoBottle, Key
	Gui, 2:Destroy
	Gui, 3:Add, Text,			x10 y10, 	Выберите какие бутылки
	Gui, 3:Add, Text,			x10 y25, 	будут активны
	
	Gui, 3:Add, Checkbox,		x10 y40 	gAutoBottle1 Checked%AutoBottle1%, 	1 Бутылка
	Gui, 3:Add, Checkbox,		x90 y40 	gIsProgenesisAutoBottle1 Checked%IsProgenesisAutoBottle1%, 	Progenesis?
	Gui, 3:Add, Checkbox,		x10 y70 	gAutoBottle2 Checked%AutoBottle2%, 	2 Бутылка
	Gui, 3:Add, Checkbox,		x90 y70 	gIsManaAutoBottle2 Checked%IsManaAutoBottle2%, 	Мана Бутылка?
	Gui, 3:Add, Checkbox,		x10 y100 	gAutoBottle3 Checked%AutoBottle3%, 	3 Бутылка
	Gui, 3:Add, Checkbox,		x10 y130 	gAutoBottle4 Checked%AutoBottle4%, 	4 Бутылка
	Gui, 3:Add, Checkbox,		x90 y130 	gIsTinctureAutoBottle4 Checked%IsTinctureAutoBottle4%, 	Tincture?
	Gui, 3:Add, Checkbox,		x10 y160 	gAutoBottle5 Checked%AutoBottle5%, 	5 Бутылка
	
	Gui, 3:Add, Text,			x205 y10, 	Привязка к Клавиатура/Мышь
	Gui, 3:Add, Button, 		x226 y30	w120    gKeyBindAutoBottle, 	Клавиатура
	Gui, 3:Add, Button, 		x226 y60    w120	gMouseBindAutoBottle, 	Мышь
	Gui, 3:Add, Text,			x200 y90, 	Макрос активируется на: %AutoBottleKey%
	
	Gui, 3:Add, Button, 		x240 y360 	w150 h30 	gBackToSettings Center, 	Назад
	Gui, 3:Show, w400 h400,
return

KeyBindAutoBottle:
	Gui, 3:Destroy
	Gui, BindAutoBottle:Add, Text,		x08 y30         vKeyBindUnFocus, 	Клавиша: 
	Gui, BindAutoBottle:Add, Hotkey, 		x63 y27 w120	gAutoBottleBind	vAutoBottleBind, %AutoBottleKey%
	Gui, BindAutoBottle:Show, w200 h100
	GuiControl, BindAutoBottle: Focus, KeyBindUnFocus
return

MouseBindAutoBottle:
	BreakLoopAutoBottle := 0
	Gui, 3:Destroy
	Gui, BindAutoBottle:Add, Text,		x15 y30, 	Мышь: 
	Gui, BindAutoBottle:Add, Edit, 		x60 y27 w120   vAutoBottleMouseBind Disabled, %AutoBottleKey%
	Gui, BindAutoBottle:Show, w200 h100
	MouseKeyArray := ["MButton", "XButton1", "XButton2"]
	Loop
	{
		for i, MouseKey in MouseKeyArray
		{
			GetKeyState, state, %MouseKey%
			if (state == "D")
			{
				if (MouseKey = BottleKey)
				{
					IniWrite, % "", %config%, Bottle, Key
				}
				if (MouseKey = CheckHPKey)
				{
					IniWrite, % "", %config%, CheckHP, Key
				}
				if (MouseKey = CWDTKey)
				{
					IniWrite, % "", %config%, CheckHP, CWDTKey
				}
				if (MouseKey = BlessingKey)
				{
					IniWrite, % "", %config%, Blessing, Key
				}
				GuiControl, BindAutoBottle: Text, AutoBottleMouseBind, %MouseKey%
				IniWrite, %MouseKey%, %config%, AutoBottle, Key
			}
		}
		if (BreakLoopAutoBottle = 1)
		{
			Break
		}
	}
return

AutoBottleBind:
	GuiControl, BindAutoBottle: Focus, KeyBindUnFocus
	if (AutoBottleBind = BottleKey)
	{
		IniWrite, % "", %config%, Bottle, Key
	}
	if (AutoBottleBind = CheckHPKey)
	{
		IniWrite, % "", %config%, CheckHP, Key
	}
	if (AutoBottleBind = CWDTKey)
	{
		IniWrite, % "", %config%, CheckHP, CWDTKey
	}
	if (AutoBottleBind = BlessingKey)
	{
		IniWrite, % "", %config%, Blessing, Key
	}
	IniWrite, %AutoBottleBind%, %config%, AutoBottle, Key
return

BindAutoBottleGuiClose:
	BreakLoopAutoBottle := 1
	Gui, BindAutoBottle:Destroy
	Goto, SettingsAutoBottle
return

BackToSettings:
	Gui, 3:Destroy
	Gui, 4:Destroy
	Gui, 5:Destroy
	Gui, Blessing:Destroy
	goto, Settings
return

;--------------------------------------- BOTTLE ---------------------------------------

SettingsBottle:
	IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
	IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
	IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
	IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
	IniRead, BottleKey, %config%, Bottle, Key
	Gui, 2:Destroy
	Gui, 4:Add, Text,			x10 y10, 	Выберите какие бутылки
	Gui, 4:Add, Text,			x10 y25, 	будут активны
	
	Gui, 4:Add, radio,			x10 y50 	gBottle15 Checked%Bottle15%, 	1-5 Бутылки
	Gui, 4:Add, radio,			x10 y80 	gBottle25 Checked%Bottle25%, 	2-5 Бутылки
	Gui, 4:Add, radio,			x10 y110 	gBottle35 Checked%Bottle35%, 	3-5 Бутылки
	Gui, 4:Add, radio,			x10 y140 	gBottle45 Checked%Bottle45%, 	4-5 Бутылки
	
	Gui, 4:Add, Text,			x205 y10, 	Привязка к Клавиатура/Мышь
	Gui, 4:Add, Button, 		x226 y30	w120    gKeyBindBottle, 	Клавиатура
	Gui, 4:Add, Button, 		x226 y60    w120	gMouseBindBottle, 	Мышь
	Gui, 4:Add, Text,			x200 y90, 	Макрос активируется на: %BottleKey%

	Gui, 4:Add, Button, 		x240 y360 	w150 h30 	gBackToSettings Center, 	Назад
	Gui, 4:Show, 				w400 h400
return

KeyBindBottle:
	Gui, 4:Destroy
	Gui, BindBottle:Add, Text,		x08 y30         vKeyBindUnFocus, 	Клавиша: 
	Gui, BindBottle:Add, Hotkey, 	x63 y27 w120	gBottleBind	vBottleBind, %BottleKey%
	Gui, BindBottle:Show, w200 h100
	GuiControl, BindBottle: Focus, KeyBindUnFocus
return

MouseBindBottle:
	BreakLoopBottle := 0
	Gui, 4:Destroy
	Gui, BindBottle:Add, Text,		x15 y30, 	Мышь: 
	Gui, BindBottle:Add, Edit, 		x60 y27 w120   vBottleMouseBind Disabled, %BottleKey%
	Gui, BindBottle:Show, w200 h100
	MouseKeyArray := ["MButton", "XButton1", "XButton2"]
	Loop
	{
		for i, MouseKey in MouseKeyArray
		{
			GetKeyState, state, %MouseKey%
			if (state == "D")
			{
				if (MouseKey = AutoBottleKey)
				{
					IniWrite, % "", %config%, AutoBottle, Key
				}
				if (MouseKey = CheckHPKey)
				{
					IniWrite, % "", %config%, CheckHP, Key
				}
				if (MouseKey = CWDTKey)
				{
					IniWrite, % "", %config%, CheckHP, CWDTKey
				}
				if (MouseKey = BlessingKey)
				{
					IniWrite, % "", %config%, Blessing, Key
				}
				GuiControl, BindBottle: Text, BottleMouseBind, %MouseKey%
				IniWrite, %MouseKey%, %config%, Bottle, Key
			}
		}
		if (BreakLoopBottle = 1)
		{
			Break
		}
	}
return
	
BottleBind:
	GuiControl, BindBottle: Focus, KeyBindUnFocus
	if (BottleBind = AutoBottleKey)
	{
		IniWrite, % "", %config%, AutoBottle, Key
	}
	if (BottleBind = CheckHPKey)
	{
		IniWrite, % "", %config%, CheckHP, Key
	}
	if (BottleBind = CWDTKey)
	{
		IniWrite, % "", %config%, CheckHP, CWDTKey
	}
	if (BottleBind = BlessingKey)
	{
		IniWrite, % "", %config%, Blessing, Key
	}
	IniWrite, %BottleBind%, %config%, Bottle, Key
return

BindBottleGuiClose:
	BreakLoopBottle := 1
	Gui, BindBottle:Destroy
	Goto, SettingsBottle
return

;--------------------------------------- CHECK HP ---------------------------------------

SettingsCheckHP:
{
	IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
	IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
	IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
	IniRead, CheckHPKey, %config%, CheckHP, Key
	
	IniRead, CWDT70, %config%, SelectCheckHP, CWDT70
	IniRead, CWDT48, %config%, SelectCheckHP, CWDT48
	IniRead, CWDT30, %config%, SelectCheckHP, CWDT30
	IniRead, CWDTKey, %config%, CheckHP, CWDTKey
	
	IniRead, ActivityCWDT, %config%, CheckHP, ActivityCWDT
	
	Gui, 2:Destroy
	Gui, 5:Add, Text,			x10 y10, 	Процент срабатывания CheckHP
	
	Gui, 5:Add, radio,			x10 y40 	gCheckHP70 Checked%CheckHP70%, 	70 Процентов ХП
	Gui, 5:Add, radio,			x10 y70 	gCheckHP48 Checked%CheckHP48%, 	48 Процентов ХП
	Gui, 5:Add, radio,			x10 y100 	gCheckHP30 Checked%CheckHP30%, 	30 Процентов ХП
	
	Gui, 5:Add, Text,			x205 y10, 	Привязка к Клавиатура/Мышь
	Gui, 5:Add, Button, 		x226 y30	w120    gKeyBindCheckHP, 	Клавиатура
	Gui, 5:Add, Button, 		x226 y60    w120	gMouseBindCheckHP, 	Мышь
	Gui, 5:Add, Text,			x200 y90, 	Макрос активируется на: %CheckHPKey%
	
	Gui, 5:Add, Button, 		x240 y360 	w150 h30 	gBackToSettings Center, 	Назад
	
;											CWDT

	Gui, 5:Add, Button, 		x127 y150	w120    gActivityCWDT, 	Активация CWDT
	
	Gui, 5:Add, Text,			x10 y200							vActivityCWDT1, 	Процент срабатывания CWDT
	Gui, 5:Add, radio,			x10 y230 			gCWDT70 		vActivityCWDT2 Checked%CWDT70%, 	70 Процентов CWDT
	Gui, 5:Add, radio,			x10 y260 			gCWDT48 		vActivityCWDT3 Checked%CWDT48%, 	48 Процентов CWDT
	Gui, 5:Add, radio,			x10 y290 			gCWDT30 		vActivityCWDT4 Checked%CWDT30%, 	30 Процентов CWDT
	
	Gui, 5:Add, Text,			x205 y200							vActivityCWDT5, 	Привязка к Клавиатура/Мышь
	Gui, 5:Add, Button, 		x226 y220	w120    gKeyBindCWDT 	vActivityCWDT6, 	Клавиатура
	Gui, 5:Add, Button, 		x226 y250   w120	gMouseBindCWDT 	vActivityCWDT7, 	Мышь
	Gui, 5:Add, Text,			x200 y280							vActivityCWDT8, 	Макрос активируется на: %CWDTKey%
	
	if (ActivityCWDT = 0)
	{
		GuiControl, 5: Disable, ActivityCWDT1
		GuiControl, 5: Disable, ActivityCWDT2
		GuiControl, 5: Disable, ActivityCWDT3
		GuiControl, 5: Disable, ActivityCWDT4
		GuiControl, 5: Disable, ActivityCWDT5
		GuiControl, 5: Disable, ActivityCWDT6
		GuiControl, 5: Disable, ActivityCWDT7
		GuiControl, 5: Disable, ActivityCWDT8
	}
	
	Gui, 5:Show, w400 h400,
}
return

ActivityCWDT:
	ActivityCWDT := !ActivityCWDT
	IniWrite, %ActivityCWDT%, %config%, CheckHP, ActivityCWDT
	
	if (ActivityCWDT = 1)
	{
		GuiControl, 5: Enable, ActivityCWDT1
		GuiControl, 5: Enable, ActivityCWDT2
		GuiControl, 5: Enable, ActivityCWDT3
		GuiControl, 5: Enable, ActivityCWDT4
		GuiControl, 5: Enable, ActivityCWDT5
		GuiControl, 5: Enable, ActivityCWDT6
		GuiControl, 5: Enable, ActivityCWDT7
		GuiControl, 5: Enable, ActivityCWDT8
	}
	
	if (ActivityCWDT = 0)
	{
		GuiControl, 5: Disable, ActivityCWDT1
		GuiControl, 5: Disable, ActivityCWDT2
		GuiControl, 5: Disable, ActivityCWDT3
		GuiControl, 5: Disable, ActivityCWDT4
		GuiControl, 5: Disable, ActivityCWDT5
		GuiControl, 5: Disable, ActivityCWDT6
		GuiControl, 5: Disable, ActivityCWDT7
		GuiControl, 5: Disable, ActivityCWDT8
	}
return

KeyBindCheckHP:
	Gui, 5:Destroy
	Gui, BindCheckHP:Add, Text,			x08 y30         vKeyBindUnFocus, 	Клавиша: 
	Gui, BindCheckHP:Add, Hotkey, 		x63 y27 w120	gCheckHPBind	vCheckHPBind, %CheckHPKey%
	Gui, BindCheckHP:Show, w200 h100
	GuiControl, BindCheckHP: Focus, KeyBindUnFocus
return

MouseBindCheckHP:
	BreakLoopCheckHP := 0
	Gui, 5:Destroy
	Gui, BindCheckHP:Add, Text,		x15 y30, 		Мышь: 
	Gui, BindCheckHP:Add, Edit, 	x60 y27 w120   vCheckHPMouseBind Disabled, %CheckHPKey%
	Gui, BindCheckHP:Show, w200 h100
	MouseKeyArray := ["MButton", "XButton1", "XButton2"]
	Loop
	{
		for i, MouseKey in MouseKeyArray
		{
			GetKeyState, state, %MouseKey%
			if (state == "D")
			{
				if (MouseKey = AutoBottleKey)
				{
					IniWrite, % "", %config%, AutoBottle, Key
				}
				if (MouseKey = BottleKey)
				{
					IniWrite, % "", %config%, Bottle, Key
				}
				if (MouseKey = CWDTKey)
				{
					IniWrite, % "", %config%, CheckHP, CWDTKey
				}
				if (MouseKey = BlessingKey)
				{
					IniWrite, % "", %config%, Blessing, Key
				}
				GuiControl, BindCheckHP: Text, CheckHPMouseBind, %MouseKey%
				IniWrite, %MouseKey%, %config%, CheckHP, Key
			}
		}
		if (BreakLoopCheckHP = 1)
		{
			Break
		}
	}
return

CheckHPBind:
	GuiControl, BindCheckHP: Focus, KeyBindUnFocus
	if (CheckHPBind = AutoBottleKey)
	{
		IniWrite, % "", %config%, AutoBottle, Key
	}
	if (CheckHPBind = BottleKey)
	{
		IniWrite, % "", %config%, Bottle, Key
	}
	if (CheckHPBind = CWDTKey)
	{
		IniWrite, % "", %config%, CheckHP, CWDTKey
	}
	if (MouseKey = BlessingKey)
	{
		IniWrite, % "", %config%, Blessing, Key
	}
	IniWrite, %CheckHPBind%, %config%, CheckHP, Key
return

BindCheckHPGuiClose:
	BreakLoopCheckHP := 1
	Gui, BindCheckHP:Destroy
	Goto, SettingsCheckHP
return

;-------------------------------------------- CWDT --------------------------------------------

KeyBindCWDT:
	Gui, 5:Destroy
	Gui, BindCWDT:Add, Text,		x08 y30         vKeyBindUnFocus, 	Клавиша: 
	Gui, BindCWDT:Add, Hotkey, 		x63 y27 w120	gCWDTBind	vCWDTBind, %CWDTKey%
	Gui, BindCWDT:Show, w200 h100
	GuiControl, BindCWDT: Focus, KeyBindUnFocus
return

MouseBindCWDT:
	BreakLoopCWDT := 0
	IniRead, CheckHPKey, %config%, CheckHP, Key
	Gui, 5:Destroy
	Gui, BindCWDT:Add, Text,	x15 y30, 		Мышь: 
	Gui, BindCWDT:Add, Edit, 	x60 y27 w120   vCWDTMouseBind Disabled, %CWDTKey%
	Gui, BindCWDT:Show, w200 h100
	MouseKeyArray := ["MButton", "XButton1", "XButton2"]
	Loop
	{
		for i, MouseKey in MouseKeyArray
		{
			GetKeyState, state, %MouseKey%
			if (state == "D")
			{
				if (MouseKey = AutoBottleKey)
				{
					IniWrite, % "", %config%, AutoBottle, Key
				}
				if (MouseKey = BottleKey)
				{
					IniWrite, % "", %config%, Bottle, Key
				}
				if (MouseKey = CheckHPKey)
				{
					IniWrite, % "", %config%, CheckHP, Key
				}
				if (MouseKey = BlessingKey)
				{
					IniWrite, % "", %config%, Blessing, Key
				}
				GuiControl, BindCWDT: Text, CWDTMouseBind, %MouseKey%
				IniWrite, %MouseKey%, %config%, CheckHP, CWDTKey
			}
		}
		if (BreakLoopCWDT = 1)
		{
			Break
		}
	}
return

CWDTBind:
	GuiControl, BindCWDT: Focus, KeyBindUnFocus
	if (CWDTBind = AutoBottleKey)
	{
		IniWrite, % "", %config%, AutoBottle, Key
	}
	if (CWDTBind = BottleKey)
	{
		IniWrite, % "", %config%, Bottle, Key
	}
	if (CWDTBind = CheckHPKey)
	{
		IniWrite, % "", %config%, CheckHP, Key
	}
	if (MouseKey = BlessingKey)
	{
		IniWrite, % "", %config%, Blessing, Key
	}
	IniWrite, %CWDTBind%, %config%, CheckHP, CWDTKey
return

BindCWDTGuiClose:
	BreakLoopCWDT := 1
	Gui, BindCWDT:Destroy
	Goto, SettingsCheckHP
return

;--------------------------------------- STARTUP MACROS ---------------------------------------

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
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/Bottle.ahk, Macros\Bottle.ahk
		if(ErrorLevel || !FileExist("Macros\Bottle.ahk") ) 
		{
			msgbox, Bottle.ahk Download failed!
			return
		}
		IniWrite, %Version%, %config%, Bottle, Version
	}
	if !WinExist("ahk_pid" BottlePID)
	{
		Run, Macros\Bottle.ahk,,, BottlePID
		Process, Wait, %BottlePID%
		GroupAdd, CloseBottle, ahk_pid %BottlePID%
		CABottle := 1
		CloseGuiBottle := 2
	}
}
else
{
	CABottle := 0
	CloseGuiBottle := 1
	SetTimer, ListOfBottle, off
	WinClose, ahk_group CloseBottle
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
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/AutoBottle.ahk, Macros\AutoBottle.ahk
		if(ErrorLevel || !FileExist("Macros\AutoBottle.ahk") ) 
		{
			msgbox, AutoBottle.ahk Download failed!
			return
		}
		IniWrite, %Version%, %config%, AutoBottle, Version
	}
	if !WinExist("ahk_pid" AutoBottlePID)
	{
		Run, Macros\AutoBottle.ahk,,, AutoBottlePID
		Process, Wait, %AutoBottlePID%
		GroupAdd, CloseAutoBottle, ahk_pid %AutoBottlePID%
		CAAutoBottle := 1
		CloseGuiAutoBottle := 1
	}
}
else
{
	CAAutoBottle := 0
	CloseGuiAutoBottle := 0
	SetTimer, AutoBottle, off
	WinClose, ahk_group CloseAutoBottle
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
	if !FileExist("Macros\AutoBottle 2k.ahk")
	{
		Version := CheckVersion("AutoBottle")
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/AutoBottle2k.ahk, Macros\AutoBottle 2k.ahk
		if(ErrorLevel || !FileExist("Macros\AutoBottle 2k.ahk") ) 
		{
			msgbox, AutoBottle 2k.ahk Download failed!
			return
		}
		IniWrite, %Version%, %config%, AutoBottle, Version
	}
	if !WinExist("ahk_pid" AutoBottle2kPID)
	{
		Run, Macros\AutoBottle 2k.ahk,,, AutoBottle2kPID
		Process, Wait, %AutoBottle2kPID%
		GroupAdd, CloseAutoBottle2k, ahk_pid %AutoBottle2kPID%
		CAAutoBottle2k := 1
		CloseGuiAutoBottle2k := 1
	}
}
else
{
	CAAutoBottle2k := 0
	CloseGuiAutoBottle2k := 0
	SetTimer, AutoBottle2k, off
	WinClose, ahk_group CloseAutoBottle2k
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
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/CheckHP.ahk, Macros\CheckHP.ahk
		if(ErrorLevel || !FileExist("Macros\CheckHP.ahk") ) 
		{
			msgbox, CheckHP.ahk Download failed!
			return
		}
		IniWrite, %Version%, %config%, CheckHP, Version
	}
	if !WinExist("ahk_pid" CheckHPPID)
	{
		Run, Macros\CheckHP.ahk,,, CheckHPPID
		Process, Wait, %CheckHPPID%
		GroupAdd, CloseCheckHP, ahk_pid %CheckHPPID%
		CACheckHP := 1
		CloseGuiCheckHP := 1
	}
}
else
{
	CACheckHP := 0
	CloseGuiCheckHP := 0
	SetTimer, CheckHP, off
	WinClose, ahk_group CloseCheckHP
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
		UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/Main.ahk, Macros\Main.ahk
		if(ErrorLevel || !FileExist("Macros\Main.ahk") ) 
		{
			msgbox, Main.ahk Download failed!
			return
		}
		IniWrite, %Version%, %config%, Main, Version
	}
	if !WinExist("ahk_pid" MainPID)
	{
		Run, Macros\Main.ahk,,, MainPID
		Process, Wait, %MainPID%
		GroupAdd, CloseMain, ahk_pid %MainPID%
		CAMain := 1
		CloseGuiMain := 1
	}
}
else
{
	CAMain := 0
	CloseGuiMain := 0
	SetTimer, Main, off
	WinClose, ahk_group CloseMain
}
if (CAMain = 1)
{
	SetTimer, Main, 1000
}
return


ExitMacros:
	GroupAdd, ClosePID, ahk_pid %AutoBottlePID%
	SetTimer, AutoBottle, off
	GuiControl,,AutoBottle,0
	;WinClose, ahk_pid %AutoBottlePID%
	
	GroupAdd, ClosePID, ahk_pid %AutoBottle2kPID%
	SetTimer, AutoBottle2k, off
	GuiControl,,AutoBottle2k,0
	;WinClose, ahk_pid %AutoBottle2kPID%
	
	GroupAdd, ClosePID, ahk_pid %CheckHPPID%
	SetTimer, CheckHP, off
	GuiControl,,CheckHP,0
	;WinClose, ahk_pid %CheckHPPID%
	
	GroupAdd, ClosePID, ahk_pid %MainPID%
	SetTimer, Main, off
	GuiControl,,Main,0
	;WinClose, ahk_pid %MainPID%
	
	GroupAdd, ClosePID, ahk_pid %BottlePID%
	SetTimer, ListOfBottle, off
	GuiControl, Choose, Choice, 1
	;WinClose, ahk_pid %BottlePID%
	
	WinClose, ahk_group ClosePID
	
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

IsProgenesisAutoBottle1:
ControlGet, IsProgenesisAutoBottle1, Checked , , Button2,
if (IsProgenesisAutoBottle1 != 0)
{
	IniWrite, 1, %config%, SelectAutoBootle, ProgenesisBottle1
}
else
{
	IniWrite, 0, %config%, SelectAutoBootle, ProgenesisBottle1
}
return

AutoBottle2:
ControlGet, AutoBottle2, Checked , , Button3,
if (AutoBottle2 != 0)
{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle2
}
else
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle2
}
return

IsManaAutoBottle2:
ControlGet, IsManaAutoBottle2, Checked , , Button4,
if (IsManaAutoBottle2 != 0)
{
	IniWrite, 1, %config%, SelectAutoBootle, ManaBottle2
}
else
{
	IniWrite, 0, %config%, SelectAutoBootle, ManaBottle2
}
return

AutoBottle3:
ControlGet, AutoBottle3, Checked , , Button5,
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
ControlGet, AutoBottle4, Checked , , Button6,
if (AutoBottle4 != 0)
{
	IniWrite, 1, %config%, SelectAutoBootle, Bottle4
}
else
{
	IniWrite, 0, %config%, SelectAutoBootle, Bottle4
}
return

IsTinctureAutoBottle4:
ControlGet, IsTinctureAutoBottle4, Checked , , Button7,
if (IsTinctureAutoBottle4 != 0)
{
	IniWrite, 1, %config%, SelectAutoBootle, TinctureBottle4
}
else
{
	IniWrite, 0, %config%, SelectAutoBootle, TinctureBottle4
}
return

AutoBottle5:
ControlGet, AutoBottle5, Checked , , Button8,
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

;-------------------------------------------- CWDT --------------------------------------------

CWDT70:
	ControlGet, CWDT70, Checked , , Button6,
	if (CWDT70 != 0)
	{
		IniWrite, 1, %config%, SelectCheckHP, CWDT70
		IniWrite, 0, %config%, SelectCheckHP, CWDT48
		IniWrite, 0, %config%, SelectCheckHP, CWDT30
	}
	else
	{
		IniWrite, 0, %config%, SelectCheckHP, CWDT70
	}
return

CWDT48:
	ControlGet, CWDT48, Checked , , Button7,
	if (CWDT48 != 0)
	{
		IniWrite, 0, %config%, SelectCheckHP, CWDT70
		IniWrite, 1, %config%, SelectCheckHP, CWDT48
		IniWrite, 0, %config%, SelectCheckHP, CWDT30
	}
	else
	{
		IniWrite, 0, %config%, SelectCheckHP, CWDT48
	}
return

CWDT30:
	ControlGet, CWDT30, Checked , , Button8,
	if (CWDT30 != 0)
	{
		IniWrite, 0, %config%, SelectCheckHP, CWDT70
		IniWrite, 0, %config%, SelectCheckHP, CWDT48
		IniWrite, 1, %config%, SelectCheckHP, CWDT30
	}
	else
	{
		IniWrite, 0, %config%, SelectCheckHP, CWDT30
	}
return

;

SmokeMine:
ControlGet, SmokeMine, Checked , , Button5,
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
ControlGet, DefaultMine, Checked , , Button6,
if (DefaultMine != 0)
{
	IniWrite, 1, %config%, Main, DefaultMine
}
else
{
	IniWrite, 0, %config%, Main, DefaultMine
}
return

DebugMode:
ControlGet, Debug, Checked , , Button7,
if (Debug != 0)
{
	IniWrite, 1, %config%, Control, Debug
	CheckDebugHotkeys()
}
else
{
	IniWrite, 0, %config%, Control, Debug
	CheckDebugHotkeys()
}
return

2GuiClose:
Gui, 2:Destroy
Goto, Start
return

3GuiClose:
Gui, 3:Destroy
Goto, Settings
return

4GuiClose:
Gui, 4:Destroy
Goto, Settings
return

5GuiClose:
Gui, 5:Destroy
Goto, Settings
return

GuiClose:
gosub, ExitMacros
ExitApp


CheckDebugHotkeys() {
    global Debug
    if (Debug = 1) {
        Hotkey, F6, HandleF6, On
        Hotkey, F7, HandleF7, On
        Hotkey, F8, HandleF8, On
    } else {
        Hotkey, F6, HandleF6, Off
        Hotkey, F7, HandleF7, Off
        Hotkey, F8, HandleF8, Off
    }
}

HandleF6:
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%
    Clipboard := color
    ;msgbox color , %MouseX%, %MouseY%
    return

HandleF7:
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%
    Clipboard = %MouseX%, %MouseY%
    ;msgbox color , %MouseX%, %MouseY%
    return

HandleF8:
    PixelGetColor, test, 378, 1051
    Clipboard := test
    return