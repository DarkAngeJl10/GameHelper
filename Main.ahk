Version - 0.1

blightINV_x := 72
blightINV_y := 563
chaosrec := 0

send, {LCtrl down}
send, {LCtrl up}

Suspend On
GroupAdd POE, % "Path of Exile"
WinActive()
return

WinActive() {
	Suspend Off
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() {
	;send, {numpad9}
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

Blight() {
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

ChaosRecipes() {
loop,
{
if (t >= 11)
	{
	return
	}
		{
		ImageSearch, XChaosRecipes, YChaosRecipes, 12, 130, 650, 770, *165 %A_ScriptDir%\Icon\AutoPickUp.png
		if ( ErrorLevel > 0 )
			{
			return
			}
		else	
			{
			t += 1
			mousemove XChaosRecipes, YChaosRecipes,
			send <^{LButton}
			}
		sleep, 100
		}
	}
}

SellingChaosRecipe() {
loop,
{
if (t >= 1)
	{
	return
	}
	mousemove, 1321, 664
	send <^{LButton}
	mousemove, 1400, 665
	send <^{LButton}
	mousemove, 1454, 668
	send <^{LButton}
	mousemove, 1530, 640
	send <^{LButton}
	mousemove, 1528, 719
	send <^{LButton}
	mousemove, 1559, 772
	send <^{LButton}
	mousemove, 1506, 764
	send <^{LButton}
	mousemove, 1508, 829
	send <^{LButton}
	mousemove, 1431, 800
	send <^{LButton}
	mousemove, 1324, 795
	send <^{LButton}
	mousemove, 381, 821
	t += 1	
	}
}

UpdateFilter() {
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
			return
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
return

$e::
	ifWinNotActive ahk_group POE
;	Send, {1}
;	Send, {1}
;	sleep, 50
	Send, {e}
	Send, {e}
	sleep, 50
	Send, {r}
	sleep, 50
	Send, {t}
	sleep, 50
	return
	
	

capslock:: 
	chaosrec += 1
	if (chaosrec = 1)
	{
		send, ^f
		clipboard = amulet
		sleep, 50
		send, ^v
	}
	if (chaosrec = 2)
	{
		send, ^f
		clipboard = ring
		sleep, 50
		send, ^v
	}
	if (chaosrec = 3)
	{
		send, ^f
		clipboard = gloves
		sleep, 50
		send, ^v
	}
	if (chaosrec = 4)
	{
		send, ^f
		clipboard = boots
		sleep, 50
		send, ^v
	}
	if (chaosrec = 5)
	{
		send, ^f
		clipboard = belt
		sleep, 50
		send, ^v
	}
	if (chaosrec = 6)
	{
		send, ^f
		clipboard = helmet
		sleep, 50
		send, ^v
	}
	if (chaosrec = 7)
	{
		mousegetpos, Xm, Ym
		sleep, 50
		mousemove, 192, 110, 0
		sleep, 50
		send, {LButton}
		mousemove, %Xm%, %Ym%, 0
		send, ^f
		clipboard = weapon
		sleep, 50
		send, ^v
	}
	if (chaosrec = 8)
	{
		mousegetpos, Xm, Ym
		sleep, 50
		mousemove, 290, 111, 0
		sleep, 50
		send, {LButton}
		mousemove, %Xm%, %Ym%, 0
		send, ^f
		clipboard = body
		sleep, 50
		send, ^v
	}
	if (chaosrec = 9)
	{
		mousegetpos, Xm, Ym
		sleep, 50
		mousemove, 83, 110, 0
		sleep, 50
		send, {LButton}
		mousemove, %Xm%, %Ym%, 0
		send, ^f
		send, ^a
		send, {Backspace}
		tooltip, Хаус сет собран
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
	Else
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

NumpadSub:: 
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

	
NumpadAdd::						;Спам CTRL+Numpad + для быстрого перемещения контрактов
<^NumpadAdd::					;Спам CTRL+Numpad + для быстрого перемещения контрактов
	С := !С
	contract := 0
	send, {LCtrl down}
LoopContract: 
 	{
	ifWinActive ahk_group POE
		{
		}
	Else
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
	
F7::							;Отладка всего макроса (по дефолту выключено)
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
	
F8::							;Отладка всего макроса (по дефолту выключено)
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
	
;F9::
	PixelGetColor, color, 403, 795
	clipboard := color
	return
	
;f10::
mousemove, 634, 791
return
	
NumpadMult::					;Включение аур (ток для моего ауработа)
	MouseGetPos, MouseX, MouseY
	send, {LCtrl down}
	sleep, 30
	send, {q}
	sleep, 30
	send, {w}
	sleep, 30
	send, {e}
	sleep, 30
	send, {r}
	sleep, 30
	send, {t}
	sleep, 30

	;первая полоска первый скилл
;	mousemove, 1438, 1045, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1439, 507, 0	;выбор скилла
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30
	
	;первая полоска второй скилл
	mousemove, 1438, 1045, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1512, 835, 0	;выбор скилла
	sleep, 30
	Click
	sleep, 50
	send, {q}
	sleep, 30	

	;первая полоска третий скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1575, 513, 0	;выбор скилла
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;вторая полоска первый скилл	
	mousemove, 1440, 1050, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1509, 771, 0	;выбор скилла
	sleep, 30
	Click
	sleep, 50
	send, {q}
	sleep, 30		
	
;	;вторая полоска второй скилл
;	mousemove, 1440, 1050	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1506, 510, 0	;выбор скилла
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;вторая полоска третий скилл
;	mousemove, 1440, 1050	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1573, 513, 0	;выбор скилла
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;третья полоска первый скилл
;	mousemove, 1440, 1050	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1446, 576, 0	;выбор скилла
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;третья полоска второй скилл
;	mousemove, 1440, 1050	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1507, 577, 0	;выбор скилла
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;третья полоска третий скилл
	mousemove, 1440, 1050, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1572, 705, 0	;выбор скилла
	sleep, 30
	Click
	sleep, 50
	send, {q}
	sleep, 30	

	;четвертая полоска первый скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1444, 709, 0	;выбор скилла (четвертая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;четвертая полоска второй скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1509, 710, 0	;выбор скилла (четвертая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	

	;четвертая полоска третий скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1573, 640, 0	;выбор скилла (четвертая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;пятая полоска первый скилл
	mousemove, 1440, 1050, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1444, 576, 0	;выбор скилла (четвертая полоска первый скилл)
	sleep, 30
	Click
	sleep, 50
	send, {q}
	sleep, 30	

	;пятая полоска второй скилл
	mousemove, 1440, 1050, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1510, 574, 0	;выбор скилла (четвертая полоска второй скилл)
	sleep, 30
	Click
	sleep, 50
	send, {q}
	sleep, 30	
	
	;пятая полоска третий скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1510, 574, 0	;выбор скилла (четвертая полоска третий скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;шестая полоска первый скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1444, 512, 0	;выбор скилла (шестая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30	
	
	;шестая полоска второй скилл
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1444, 512, 0	;выбор скилла (шестая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30
	


	;выбор hatred
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1506, 448, 0	;выбор скилла (шестая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30

	;выбор malevpolence
	mousemove, 1440, 1050, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1572, 637, 0	;выбор скилла (шестая полоска первый скилл)
	sleep, 30
	Click
	sleep, 50
	send, {q}
	sleep, 30

	;выбор zealotry
;	mousemove, 1440, 1050, 0	;меню
;	sleep, 30
;	Click
;	sleep, 30
;	mousemove, 1443, 770, 0	;выбор скилла (шестая полоска первый скилл)
;	sleep, 30
;	Click
;	sleep, 50
;	send, {q}
;	sleep, 30

	;первоначальный скилл который стоит на q
	mousemove, 1440, 1050, 0	;меню
	sleep, 30
	Click
	sleep, 30
	mousemove, 1574, 512, 0	;выбор скилла (;пятая полоска второй скилл)
	sleep, 30
	Click
	sleep, 30
	send, {LCtrl up}
	Mousemove, %MouseX%, %MouseY%
	return

numpad6::
<^numpad6::
	send, {LCtrl up}
	SetTimer, VaalClarity, 	Off
	Reload