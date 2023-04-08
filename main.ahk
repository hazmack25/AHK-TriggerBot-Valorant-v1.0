init:
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127

if (FileExist("config.ini")) 
{
}
Else
{
IniWrite, 0xA5A528, config.ini, main, EMCol
IniWrite, 20, config.ini, main, ColVn
}

IniRead, EMCol, config.ini, main, EMCol
IniRead, ColVn, config.ini, main, ColVn


toggle = 1
toggle2 = 1


AntiShakeX := (A_ScreenHeight // 160)
AntiShakeY := (A_ScreenHeight // 128)
ZeroX := (A_ScreenWidth // 2) ;dont touch?
ZeroY := (A_ScreenHeight // 2) 
CFovX := (A_ScreenWidth // 40)  ;configure for FOV up = smaller lower= bigger current boxes right fov
CFovY := (A_ScreenHeight // 64)
ScanL := ZeroX - CFovX
ScanT := ZeroY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY


Gui Add, GroupBox, x10 y10 w200 h50, Color Changer
Gui Add, Progress, x0 y50 w50 h10 c0xA5A528, 100
Gui Add, Progress, x50 y50 w50 h10 c87BBFF, 100
Gui Add, Progress, x100 y50 w55 h10 c00B050, 100
Gui Add, Progress, x155 y50 w55 h10 c00B050, 100
Gui Add, Button, x0 y30 w50 h20 gRedButton, Red
Gui Add, Button, x50 y30 w50 h20 gPurpleButton, Purple
Gui Add, Button, x100 y30 w55 h20 gYellowDueButton, YellowDue
Gui Add, Button, x155 y30 w55 h20 gYellowProButton, YellowPro
Gui Add, Text, x0 y70 w60 h15 c0xA5A528, --------------
Gui Add, Text, x0 y80 w90 h15 c0xA5A528, Baseult Recode
Gui Add, Text, x0 y95 w90 h15 c0xA5A528, Press F2 to activate
Gui Add, Text, x0 y110 w90 h15 c0xA5A528, Created by Wiraa#0723
Gui Show, , GUI Section Header
Return

RedButton:
  MsgBox, Color change to Red!
Return

PurpleButton:
  MsgBox, Color change to Purple!
Return

YellowDueButton:
  MsgBox, Color change to YellowDeuteranopia!
Return

YellowProButton:
  MsgBox, Color change to YellowProtanopia!
Return



Gui 2: Color, EEAA99
Gui 2: Font, S72, Arial Black

Gui 2: Add, GroupBox, w100 h250 cFFB10F BackgroundTrans,
Gui 2: +LastFound +AlwaysOnTop +ToolWindow
WinSet, TransColor, EEAA99
Gui 2: -Caption




~F2::

SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SendMode, InputThenPlay
SetBatchLines,-1
SetWinDelay,-1
ListLines, Off
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High

Loop{
 
PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB	
 
		if GetKeyState("Alt"){
		if (ErrorLevel=0) {
		PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
		loop , 1{
		send {Lbutton down}
		sleep, 10
		send {lbutton up}
						}
					}
				}
						

		if GetKeyState("LButton") {
		if (ErrorLevel=0) {
		if _recoil
			{
			mouseXY(0, 1)
			DllCall("mouse_event", uint, 1, int, x, int, y, uint, 0, int, 0)
			}
			}
		}
						
						
		if GetKeyState("LButton") {
		if (!ErrorLevel=0) {
		loop, 10 {
			PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
			AimX := AimPixelX - ZeroX
			AimY := AimPixelY - ZeroY
			DirX := -1
			DirY := -1
			If ( AimX > 0 ) {
				DirX := 1
			}
			If ( AimY > 0 ) {
				DirY := 1
			}
			AimOffsetX := AimX * DirX
			AimOffsetY := AimY * DirY
			MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
			MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
			DllCall("mouse_event", uint, 1, int, MoveX * 0.7, int, MoveY, uint, 0, int, 0) ;turing mouse to color were it says * is the speed of the aimbot turn up for unhuman reactions lower for human
			if _recoil
			{
			mouseXY(0, 1)
			DllCall("mouse_event", uint, 1, int, x, int, y, uint, 0, int, 0)
			}
			}
			}
			}
		}
	
	

~\::
if toggle2 = 0
{
	toggle2 = 1
	Gui Hide
}
Else
{
	toggle2 = 0
	Gui Show
}


action1:
if toggle = 0
{
	toggle = 1
	Gui 2: Hide
}
Else
{
	toggle = 0
	Gui 2: Show
}
return

end::
exitapp
return

Quitter:
ExitApp

GuiClose:
ExitApp
