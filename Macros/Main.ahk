#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, SmokeMine, %config%, Main, SmokeMine
IniRead, DefaultMine, %config%, Main, DefaultMine
IniRead, The_VersionName, %config%, Main, Version
IniRead, CheckforUpdates, %config%, Main, CheckforUpdates

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, Main, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, Main, CheckforUpdates
}

if (CheckforUpdates != 0)
{
	MainVersion := CheckVersion("Main")
	if (MainVersion != "") 
	{
		if (The_VersionName != MainVersion) 
		{
			Msgbox, 4, Update, Found a new version: %MainVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Macros\Main.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/Main.ahk, Macros\Main.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Macros\Main.ahk") ) 
				{
					msgbox, Main.ahk Download failed!
					ExitApp
				}
				IniWrite, %MainVersion%, %config%, Main, Version
				Msgbox, Updating to latest version: %MainVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Macros\Main.ahk
			}
		}
	}
}

blightINV_x := 72
blightINV_y := 563
chaosrec := 0

send, {LCtrl down}
send, {LCtrl up}

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

WinActive() 
{
	Suspend Off
	IniRead, SmokeMine, %A_WorkingDir%\Data\Settings.ini, Main, SmokeMine
	IniRead, DefaultMine, %A_WorkingDir%\Data\Settings.ini, Main, DefaultMine
	;msgbox, %SmokeMine%
	if (SmokeMine = 1)
	{
		Hotkey, $q, SmokeMineKey
	}
	if (DefaultMine = 1)
	{
		Hotkey, $r, AnyMine
	}	
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() 
{
	;send, {numpad9}
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

Blight() 
{
	mousemove, blightINV_x, blightINV_y, 0
	sleep, 150
	Click, {LButton}
	sleep, 15
	mousemove, 302, 406, 0
	sleep, 150
	Click, {LButton}
	sleep, 150
	mousemove, 1, 1, 0									; в угол экрана
	sleep, 50
	PixelGetColor, WindowWithMaps, 392, 415
	if (WindowWithMaps = 0x0C0C0B)
	{
		send, {LCtrl down}
		mousemove, 469, 220, 0							; Azure
	;	mousemove, 399, 218, 0							; Teal
		sleep, 150
		Click, {LButton}
		sleep, 15
		mousemove, 469, 220, 0							; Azure
	;	mousemove, 126, 281, 0							; Voilet
		sleep, 150
		Click, {LButton}
		sleep, 15
		mousemove, 197, 278, 0							; Crimson
	;	mousemove, 264, 278, 0							; Black
		sleep, 150
		Click, {LButton}
		sleep, 15
		mousemove, 333, 512, 0
		sleep, 150
		Click, {LButton}
		sleep, 150
		PixelSearch, PxBMA, PyBMA, 671, 461, 1248, 610, 0x0E1215, 0, Fast
		PixelGetColor, ColorBlightMapAccept, %PxBMA%, %PyBMA%
		if (ColorBlightMapAccept = 0x0E1215)
		{
			mousemove, 1132, 578, 0
			sleep, 150
			Click, {LButton}
			sleep, 150
		}
		PixelGetColor, ColorBlightMapAnoint, 291, 513
		if (ColorBlightMapAnoint = 0x171717)
		{
			mousemove, 299, 404, 0
			sleep, 150
			Click, {LButton}
			sleep, 25
			mousemove, 71, 563, 0
			sleep, 150
			Click, {LButton}
			sleep, 25
		}
		send, {LCtrl up}
	}
}

ChaosRecipes() 
{
	loop,
	{
		if (t >= 11)
		{
			Return
		}
		ImageSearch, XChaosRecipes, YChaosRecipes, 12, 130, 650, 770, *165 %A_ScriptDir%\Icon\AutoPickUp.png
		if ( ErrorLevel > 0 )
		{
			Return
		}
		Else	
		{
			t += 1
			mousemove XChaosRecipes, YChaosRecipes,
			send <^{LButton}
		}
		sleep, 100
	}
}

;F6::
 MouseGetPos, MouseX, MouseY
 PixelGetColor, color, %MouseX%,%MouseY%
 Clipboard := color
 ;msgbox color , %MouseX%,%MouseY%
return

;F7::
 MouseGetPos, MouseX, MouseY
 PixelGetColor, color, %MouseX%,%MouseY%
 Clipboard = %MouseX%, %MouseY%
 ;msgbox color , %MouseX%,%MouseY%
return

;F8::
PixelGetColor, test, 325, 1056
Clipboard := test
return

;F9::
{
	PixelSearch, Px2, Py2, 355, 1065, 395, 1075, 0x99D7F9, 0, Fast
	if (ErrorLevel != 0)
	{
		ifWinNotActive ahk_group POE
		{
			;SetTimer, Blessing, off
			Return
		}
		PixelSearch, Px1, Py1, 316, 1055, 340, 1058, 0x0D195A, 5, Fast
		if (ErrorLevel = 0)
		{
			send {1}
		}
	}
}
return

SellingChaosRecipe() 
{
	mousemove, 1293, 607, 0
	send ^{LButton}
	mousemove, 1295, 664, 0
	send ^{LButton}
	mousemove, 1294, 715, 0
	send ^{LButton}
	mousemove, 1293, 766, 0
	send ^{LButton}
	mousemove, 1340, 600, 0
	send ^{LButton}
	mousemove, 1339, 716, 0
	send ^{LButton}
	mousemove, 1397, 767, 0
	send ^{LButton}
	mousemove, 1446, 605, 0
	send ^{LButton}
	mousemove, 1557, 608, 0
	send ^{LButton}
	mousemove, 410, 864, 0
}

TakingItem()
{
	sleep, 25
	send ^{LButton}
	sleep, 25
	send ^{F}
	sleep, 25
	send {del}
	sleep, 25
	mousemove, 67, 108, 0
	send, {LButton}
	sleep, 25
	mousemove, 13, 8, 0
	sleep, 25
}

UpdateFilter() 
{
	clipboardBuffer = %clipboard%
	clipboard = /itemfilter chaos
	send, ^{v}
	send, {Enter}
	clipboard = %clipboardBuffer%
}

RemoveToolTip:
	ToolTip
return

;Capslock:: 																					;#Selling Chaos Sets																		
	mousegetpos, XSaveMouse, YSaveMouse
	
	PixelGetColor, Selling, 660, 125
	if (Selling = 0x4D88BE)
	{
		PixelSearch, PxSelling, PySelling, 1266, 580, 1907, 852, 0x01012A, 0, Fast
		if ( ErrorLevel > 0 )
		{
			ToolTip, Dont have items for sell
			SetTimer, RemoveToolTip, -2000
			mousemove, %XSaveMouse%, %YSaveMouse%, 0
			sleep, 100
			return
		}
		else
		{
			SellingChaosRecipe()
			ToolTip, Selling 1 Chaos Recipes.
			SetTimer, RemoveToolTip, -2000
			sleep, 100
		}
	}

	PixelGetColor, Stash, 376, 65
	if (Stash = 0x417999)
	{
		ImageSearch, , , 261, 67, 650, 93, *100 %A_ScriptDir%\Icon\Edit.png
		if ( ErrorLevel > 0 )
		{
			ToolTip, Chaos Recipes Out Stock.
			SetTimer, RemoveToolTip, -2000
			mousemove, %XSaveMouse%, %YSaveMouse%, 0
			sleep, 100
			Return
		}
		else
		{
			mousemove, 1296, 615
			send <^{LButton}
			ChaosRecipes()
			ToolTip, Took 1 Chaos Recipes.
			SetTimer, RemoveToolTip, -2000
			mousemove, %XSaveMouse%, %YSaveMouse%, 0
			sleep, 100
		}
	}
Return

SmokeMineKey:
	ifWinNotActive ahk_group POE
	{
		Return
	}
	Send, {q}
	Send, {q}
	sleep, 250
	Send, {d}
Return

AnyMine:
	ifWinNotActive ahk_group POE
	{
		return
	}
	Send, {r}
	Send, {r}
	sleep, 50
	Send, {d}
	sleep, 50
return
	
;F1::
SellingChaosRecipe()		
return

capslock:: 
	chaosrec := 1
	chaosset := 0
	
; ------------------------------------ CHAOS SET SLOT ITEM ------------------------------------
	
	if (chaosrec = 99)
	{
		send, ^{f}
		clipboard = "rare"|"item level: ([6][0-9]|[7][0-4])"
		send, ^{v}
		sleep, 125
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 25
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				tooltip, Chaos Item lvl 60-74 not found
				SetTimer, RemoveToolTip, -2500
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				return
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			return
		}
	}
	
; ------------------------------------ RING ------------------------------------

	if (chaosset = 0)
	{
		if (chaosrec = 1)
		{
			clipboard = "class: ring" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 25
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	tooltip, Chaos set Ring not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send, {LButton}
					anysetrec := 1
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 2
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 2
				chaosset := 1
			}
		}
	}

	
	if (anysetrec = 1)
	{
		clipboard = "class: ring"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Ring not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 2
				}
				else
				{
					chaosrec := 2 
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 2
			}
			else
			{
				chaosrec := 2
			}
		}
	}

; ------------------------------------ AMULET ------------------------------------
	if (chaosset = 0)
	{
		if (chaosrec = 2)
		{
			clipboard = "class: amulet" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	tooltip, Chaos set Amulet not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 2
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 3
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 3
				chaosset := 1
			}
		}
	}
	
	
	if (anysetrec = 2)
	{
		clipboard = "class: amulet"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Amulet not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 3
				}
				else
				{
					chaosrec := 3
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 3
			}
			else
			{
				chaosrec := 3
			}
		}
	}
	
; ------------------------------------ SECOND RING ------------------------------------
	
	if (chaosset = 0)
	{
		if (chaosrec = 3)
		{
			clipboard = "class: ring" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	msgbox, Second Chaos set Ring not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 3
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 4
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 4
				chaosset := 1
			}
		}
	}
	
	
	if (anysetrec = 3)
	{
		clipboard = "class: ring"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Second Ring not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 4
				}
				else
				{
					chaosrec := 4
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 4
			}
			else
			{
				chaosrec := 4
			}
		}
	}
		
; ------------------------------------ GLOVES ------------------------------------
	
	if (chaosset = 0)
	{
		if (chaosrec = 4)
		{
			clipboard = "class: gloves" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	msgbox, Gloves not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 4
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 5
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 5
				chaosset := 1
			}
		}
	}
	
	
	if (anysetrec = 4)
	{
		clipboard = "class: gloves"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Gloves not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 5
				}
				else
				{
					chaosrec := 5
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 5
			}
			else
			{
				chaosrec := 5
			}
		}
	}
	
; ------------------------------------ BOOTS ------------------------------------
	
	if (chaosset = 0)
	{
		if (chaosrec = 5)
		{
			clipboard = "class: boots" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	msgbox, Boots not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 5
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 6
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 6
				chaosset := 1
			}
		}
	}
	
	
	
	
	if (anysetrec = 5)
	{
		clipboard = "class: boots"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Boots not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 6
				}
				else
				{
					chaosrec := 6
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 6
			}
			else
			{
				chaosrec := 6
			}
		}
	}
	
; ------------------------------------ BELT ------------------------------------
	
	if (chaosset = 0)
	{
		if (chaosrec = 6)
		{
			clipboard = "class: belt" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	msgbox, Belt not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 6
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 7
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 7
				chaosset := 1
			}
		}
	}
	
	
	if (anysetrec = 6)
	{
		clipboard = "class: belt"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Belt not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 7
				}
				else
				{
					chaosrec := 7
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 7
			}
			else
			{
				chaosrec := 7
			}
		}
	}
	
; ------------------------------------ HELMET ------------------------------------
	
	if (chaosset = 0)
	{
		if (chaosrec = 7)
		{
			clipboard = "class: helmet" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	msgbox, Helmet not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 7
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					anysetrec := 8
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				anysetrec := 8
				chaosset := 1
			}
		}
	}
	
	
	if (anysetrec = 7)
	{
		clipboard = "class: helmet"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Helmet not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				if (chaosset = 1)
				{
					anysetrec := 8
				}
				else
				{
					chaosrec := 8
				}
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			{
				anysetrec := 8
			}
			else
			{
				chaosrec := 8
			}
		}
	}
	
; ------------------------------------ BODY ------------------------------------
	
	if (chaosset = 0)
	{
		if (chaosrec = 8)
		{
			clipboard = "class: body" "item level: ([6][0-9]|[7][0-4])"
			send, ^{f}
			sleep, 50
			send, ^{v}
			sleep, 350
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				mousemove, 127, 109, 0
				send {LButton}
				sleep, 100
				PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
				if ( ErrorLevel > 0 )
				{
				;	msgbox, Body Armor not found, 248, 60
					SetTimer, RemoveToolTip, -5000
					mousemove, 67, 108, 0
					send {LButton}
					anysetrec := 8
				}
				else
				{
					PxItem += 10
					PyItem += 10
					mousemove, %PxItem%, %PyItem%, 0
					TakingItem()
					chaosrec := 9
					chaosset := 1
				}
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				chaosrec := 9
				chaosset := 1
			}
		}
	}
	
	
	if (anysetrec = 8)
	{
		clipboard = "class: body"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
				msgbox, Body Armor not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				chaosrec := 9
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			if (chaosset = 1)
			chaosrec := 9
		}
	}
	
; ------------------------------------ TWO HAND ------------------------------------
	
	if (chaosrec = 9)
	{
		clipboard = "class: Two Hand|Bow|Warstaff|Staff"
		send, ^{f}
		sleep, 50
		send, ^{v}
		sleep, 350
		PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
		if ( ErrorLevel > 0 )
		{
			mousemove, 127, 109, 0
			send {LButton}
			sleep, 100
			PixelSearch, PxItem, PyItem, 15, 125, 649, 759, 0x77B4E7, 5, Fast
			if ( ErrorLevel > 0 )
			{
			;	msgbox, Two Hand Weapon not found, 248, 60
				SetTimer, RemoveToolTip, -5000
				mousemove, 67, 108, 0
				send {LButton}
				return
			}
			else
			{
				PxItem += 10
				PyItem += 10
				mousemove, %PxItem%, %PyItem%, 0
				TakingItem()
				chaosrec := 10
			}
		}
		else
		{
			PxItem += 10
			PyItem += 10
			mousemove, %PxItem%, %PyItem%, 0
			TakingItem()
			chaosrec := 10
		}
	}

; ------------------------------------ CHAOS SET COMPLETE ------------------------------------
	
	if (chaosrec = 10)
	{
	;	mousegetpos, Xm, Ym
	;	sleep, 50
	;	mousemove, 83, 110, 0
	;	sleep, 50
	;	send, {LButton}
	;	mousemove, %Xm%, %Ym%, 0
		send, ^{f}
		send, ^a
		send, {Backspace}
		tooltip, Chaos Set Taken
		chaosrec := 0
		SetTimer, RemoveToolTip, -2500
		return
	}
return

;F5::																						;#Reload Filter when chat
	PixelGetColor, ColorChat, 399, 793
	if (ColorChat = 0x000000)
	{
		UpdateFilter()
		return
	}
	PixelGetColor, ColorChat, 1043, 792
	if (ColorChat = 0x000000)
	{
		UpdateFilter()
		return
	}
	send, {Enter}
	UpdateFilter()
return

lWin::						;Спам CTRL+LMouseClick для быстрого перемещения валюты/вещей
<^lWin::					;Спам CTRL+LMouseClick для быстрого перемещения валюты/вещей
	S := !S
	send, {LCtrl down}
LoopSpam: 
{
	ifWinActive ahk_group POE
	{
	}
	ifWinNotActive ahk_group POE
	{
		send, {LCtrl up}
		Return
	}	
	Click, {LButton}
}
If !S
{
	send, {LCtrl up}
	Return
}
SetTimer, LoopSpam, -1
Return

;NumpadSub:: 
	loop, 5
	{
		loop, 12
		{
			mousemove, blightINV_x, blightINV_y, 0
			sleep, 50
			Blight()
			blightINV_x += 47.4
		}
		blightINV_x := 72
		blightINV_y += 47.4
	}
return

	
;NumpadAdd::						;Спам CTRL+Numpad + для быстрого перемещения контрактов
;<^NumpadAdd::						;Спам CTRL+Numpad + для быстрого перемещения контрактов
	РЎ := !РЎ
	contract := 0
	send, {LCtrl down}
LoopContract: 
 	{
	ifWinActive ahk_group POE
	{
	}
	ifWinNotActive ahk_group POE
	{
		send, {LCtrl up}
		Return
	}	
	PixelSearch, PxC, PyC, 14, 132, 649, 767, 0x77B4E7, 0, Fast
	PixelGetColor, ColorContract, %PxC%, %PyC%
	if (ColorContract = 0x77B4E7)
	{
	;	PxC += 15							;;Сдвиг мышки в центр
	;	PyC += 15		
		PxC += 5							;;Сдвиг мышки в центр
		PyC += 5
		mousemove, %PxC%, %PyC%, 0
		sleep, 5
		Click, {LButton}
		sleep, 10
		contract := 0
	}
	else
	{
		contract += 1
		if (contract = 11)					;;Отключение макроса в простое больше 1-2 секунды
		{
			send, {LCtrl up}
			sleep, 10
			tooltip
			С := !С
			Return
		}
	}
}
If !С
{
	send, {LCtrl up}
	sleep, 10
	contract := 0
	tooltip
       Return
}
SetTimer, LoopContract, -1
Return
	
;space::								;Ваал Бутылки 
	B := !B
VaalClarity:
	ifWinNotActive ahk_group POE
	{
		Return
	}	
If B
{
	send, {w}
}

If !B
{
	SetTimer, VaalClarity, 	Off
	Return
}
SetTimer, VaalClarity, 22000
Return
	

;F2::
	clipboardBuffer = %clipboard%
	clipboard = Take only my trade, watch who you pay for the service
	send, {Enter}
	send, ^{v}
	send, {Enter}
	clipboard = %clipboardBuffer%
	return
	
;F3::
	clipboardBuffer = %clipboard%
	clipboard = Go in and stand together, if someone dies dont be respawn
	send, {Enter}
	send, ^{v}
	send, {Enter}
	clipboard = %clipboardBuffer%
	return
	
;F4::
	clipboardBuffer = %clipboard%
	clipboard = IF YOURE DIE, DONT BE RESPAWN, YOURE BREAKING 5WAY FOR EVERYONE
	send, {Enter}
	send, ^{v}
	send, {Enter}
	clipboard = %clipboardBuffer%
	return
	
;F5::
	clipboardBuffer = %clipboard%
	clipboard = Please give vouche in services-vouches | Tag @DarkZiga
	send, {Enter}
	send, ^{v}
	send, {Enter}
	clipboard = %clipboardBuffer%
	return

