#SingleInstance Force

Suspend On
GroupAdd POE, % "Path of Exile"
WinNotActive()
Return

WinActive() {
	Suspend Off
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() {
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

XButton1::
ifWinNotActive ahk_group POE
  BlockInput On
  SendInput, {3}
  sleep, 20
  SendInput, {4}
  sleep, 20
  SendInput, {5}
  BlockInput Off
return