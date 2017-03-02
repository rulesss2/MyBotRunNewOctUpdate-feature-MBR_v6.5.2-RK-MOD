; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GkevinOD (2014)
; Modified ......: Hervidero (2015), kaganus (08-2015), CodeSlinger69 (01-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

#include "functions\Other\GUICtrlGetBkColor.au3" ; Included here to use on GUI Control

Global $g_bRedrawBotWindow[3] = [True, False, False] ; [0] = window redraw enabled, [1] = window redraw required, [2] = window redraw requird by some controls, see CheckRedrawControls()


Global $g_hFrmBot_WNDPROC = 0
Global $g_hFrmBot_WNDPROC_ptr = 0

;~ ------------------------------------------------------
;~ Control Tab Files
;~ ------------------------------------------------------
;~ #include "GUI\InitializeVariables.au3"
#include "MBR GUI Control Variables.au3"
#include "GUI\MBR GUI Control Bottom.au3"
#include "GUI\MBR GUI Control Tab General.au3"
#include "GUI\MBR GUI Control Child Army.au3"
#include "GUI\MBR GUI Control Tab Village.au3"
#include "GUI\MBR GUI Control Tab Search.au3"
#include "GUI\MBR GUI Control Child Attack.au3"
#include "GUI\MBR GUI Control Tab EndBattle.au3"
#include "GUI\MBR GUI Control Tab SmartZap.au3"
#include "GUI\MBR GUI Control Tab Stats.au3"
#include "GUI\MBR GUI Control Collectors.au3"
#include "GUI\MBR GUI Control Milking.au3"
#include "GUI\MBR GUI Control Attack Standard.au3"
#include "GUI\MBR GUI Control Attack Scripted.au3"
#include "GUI\MBR GUI Control Achievements.au3"
#include "GUI\MBR GUI Control Notify.au3"
#include "GUI\MBR GUI Control Child Upgrade.au3"
#include "GUI\MBR GUI Control Donate.au3"
#include "GUI\MBR GUI Control Bot Options.au3"
#include "GUI\MBR GUI Control Preset.au3"
#include "GUI\MBR GUI Control Child Misc.au3"
#include "GUI\MBR GUI Control Android.au3"
#include "MBR GUI Action.au3"

; MOD DOC OC
#include "MOD_DocOc\GUI\MOD TAB Control.au3"

Func InitializeMainGUI()
	InitializeControlVariables()

	; Initialize attack log
	AtkLogHead()

	; Show Default Tab
	tabMain()

	; Load profile
	If FileExists($g_sProfileConfigPath) = 0 And $g_asCmdLine[0] > 0 Then
		; create new profile when doesn't exist but specified via command line
		createProfile()
		saveConfig()
		;applyConfig()
		setupProfileComboBox()
	EndIf

	selectProfile() ; Choose the profile

	; Read saved settings
	If FileExists($g_sProfileConfigPath) Or FileExists($g_sProfileBuildingPath) Then
		readConfig()
		applyConfig()
	EndIf

	; Developer mode controls
	If $g_bDevMode = True Then
		GUICtrlSetState($g_hChkDebugSetlog, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkDebugDisableZoomout, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkDebugDisableVillageCentering, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkDebugDeadbaseImage, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkDebugOCR, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkDebugImageSave, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkdebugBuildingPos, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkdebugTrain, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkDebugOCRDonate, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkMakeIMGCSV, $GUI_SHOW + $GUI_ENABLE)
		GUICtrlSetState($g_hChkdebugAttackCSV, $GUI_SHOW + $GUI_ENABLE)
	EndIf

	; GUI events and messages
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUIEvents", $g_hFrmBot)
	GUISetOnEvent($GUI_EVENT_MINIMIZE, "GUIEvents", $g_hFrmBot)
	GUISetOnEvent($GUI_EVENT_RESTORE, "GUIEvents", $g_hFrmBot)

	GUIRegisterMsg($WM_COMMAND, "GUIControl_WM_COMMAND")
	GUIRegisterMsg($WM_NOTIFY, "GUIControl_WM_NOTIFY")
	For $i = $WM_MOUSEMOVE To $WM_MBUTTONDBLCLK
		GUIRegisterMsg($i, "GUIControl_WM_MOUSE")
	Next
	GUIRegisterMsg($WM_CLOSE, "GUIControl_WM_CLOSE")
	GUIRegisterMsg($WM_NCACTIVATE, "GUIControl_WM_NCACTIVATE")
	GUIRegisterMsg($WM_SETFOCUS, "GUIControl_WM_FOCUS")
	GUIRegisterMsg($WM_KILLFOCUS, "GUIControl_WM_FOCUS")
	GUIRegisterMsg($WM_MOVE, "GUIControl_WM_MOVE")

	#cs
		Local $events = [$WM_KEYDOWN, $WM_KEYUP, $WM_SYSKEYDOWN, $WM_SYSKEYUP, $WM_MOUSEWHEEL, $WM_MOUSEHWHEEL]
		For $event in $events
		GUIRegisterMsg($event, "GUIControl_AndroidEmbedded")
		Next
	#ce

	; Register Windows Procedure to support Mouse and Keyboard in docked mode
	$g_hFrmBot_WNDPROC_ptr = DllCallbackGetPtr(DllCallbackRegister("frmBot_WNDPROC", "ptr", "hwnd;uint;long;ptr"))


	cmbDBAlgorithm()
	cmbABAlgorithm()
	SetAccelerators()

EndFunc   ;==>InitializeMainGUI

Func SetCriticalMessageProcessing($bEnterCritical = Default)
	If $bEnterCritical = Default Then Return $g_bCriticalMessageProcessing
	Local $wasCritical = $g_bCriticalMessageProcessing
	$g_bCriticalMessageProcessing = $bEnterCritical
	Return $wasCritical
EndFunc   ;==>SetCriticalMessageProcessing

Func UpdateFrmBotStyle()
	#cs Works but causes bot window not to get activated anymore
		Local $ShowMinimize = $g_bAndroidBackgroundLaunched = True Or $g_bAndroidEmbedded = False Or ($g_bAndroidEmbedded = True And $g_bAndroidAdbScreencap = True And $g_bChkBackgroundMode = True)
		WindowSystemMenu($g_hFrmBot, $SC_MINIMIZE, $ShowMinimize, "Minimize")
		Return
	#ce
	;Local $ShowMinimize = $g_bAndroidBackgroundLaunched = True Or $g_bAndroidEmbedded = False Or ($g_bAndroidEmbedded = True And $g_bAndroidAdbScreencap = True And $g_bChkBackgroundMode = True)
	Local $ShowMinimize = $g_bAndroidBackgroundLaunched = True Or $g_bAndroidEmbedded = False Or ($g_bAndroidEmbedded = True And $g_bChkBackgroundMode = True) ; now bot is not really minimized anymore
	Local $lStyle = $WS_MINIMIZEBOX
	Local $lNewStyle = ($ShowMinimize ? $lStyle : 0)
	Local $lCurStyle = _WinAPI_GetWindowLong($g_hFrmBot, $GWL_STYLE)
	If BitAND($lCurStyle, $lStyle) <> $lNewStyle Then
		If $ShowMinimize Then
			$lNewStyle = BitOR($lCurStyle, $lStyle)
			SetDebugLog("Show Bot Minimize Button")
		Else
			$lNewStyle = BitAND($lCurStyle, BitNOT($lStyle))
			SetDebugLog("Hide Bot Minimize Button")
		EndIf
		_WinAPI_SetWindowLong($g_hFrmBot, $GWL_STYLE, $lNewStyle)
		Return True
	EndIf
	Return False
EndFunc   ;==>UpdateFrmBotStyle

Func IsAlwaysEnabledControl($controlID)
	; Scripting.Dictionary is faster than array search!
	Local $bAlwaysEnabled = (($oAlwaysEnabledControls.Item($controlID)) ? (True) : (False))
	Return $bAlwaysEnabled
EndFunc   ;==>IsAlwaysEnabledControl

; Accelerator Key, more responsive than buttons in run-mode
Func SetAccelerators($bDockedUnshieledFocus = False)
	Local $aAccelKeys[2][2] = [["{ESC}", $g_hBtnStop], ["{PAUSE}", $g_hBtnPause]]
	Local $aAccelKeys_DockedUnshieldedFocus[3][2] = [["{ESC}", $g_hFrmBotEmbeddedShieldInput], ["{ENTER}", $g_hFrmBotEmbeddedShieldInput], ["{PAUSE}", $g_hBtnPause]] ; used in docked mode when android has focus to support ESC for android

	GUISetAccelerators(0, $g_hFrmBot) ; Remove all accelerators

	If $bDockedUnshieledFocus = False Then
		GUISetAccelerators($aAccelKeys, $g_hFrmBot)
	Else
		GUISetAccelerators($aAccelKeys_DockedUnshieldedFocus, $g_hFrmBot)
	EndIf
EndFunc   ;==>SetAccelerators

Func AndroidToFront()
	;SetDebugLog("BotToFront")
	WinMove2(GetAndroidDisplayHWnD(), "", -1, -1, -1, -1, $HWND_TOPMOST, 0, False)
	WinMove2(GetAndroidDisplayHWnD(), "", -1, -1, -1, -1, $HWND_NOTOPMOST, 0, False)
EndFunc   ;==>AndroidToFront

Func DisableProcessWindowsGhosting()
	DllCall($g_hLibUser32DLL, "none", "DisableProcessWindowsGhosting")
EndFunc   ;==>DisableProcessWindowsGhosting

Func GUIControl_WM_NCACTIVATE($hWin, $iMsg, $wParam, $lParam)
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	If $g_iDebugWindowMessages Then SetDebugLog("GUIControl_WM_NCACTIVATE: $hWin=" & $hWin & ", $iMsg=" & Hex($iMsg, 8) & ", $wParam=" & $wParam & ", $lParam=" & $lParam, Default, True)
	Local $iActive = BitAND($wParam, 0x0000FFFF)
	If $hWin = $g_hFrmBot Then
		If $g_bAndroidEmbedded And AndroidShieldActiveDelay() = False Then
			If $iActive = 0 Then
				AndroidShield("GUIControl_WM_NCACTIVATE not active", Default, False, 0, False, False)
			Else
				AndroidShield("GUIControl_WM_NCACTIVATE active", Default, False)
			EndIf
		EndIf
		If $iActive = 0 Then
			; bot deactivated
			SetDebugLog("GUIControl_WM_NCACTIVATE: Deactivate Bot", Default, True)
			_WinAPI_SetFocus(0)
		Else
			If $iHideWhenMinimized = 0 Then BotRestore("GUIControl_WM_NCACTIVATE")
			SetDebugLog("GUIControl_WM_NCACTIVATE: Activate Bot", Default, True)
		EndIf
		If $g_bAndroidEmbedded And $g_iAndroidEmbedMode = 1 And AndroidShieldActiveDelay() = False Then
			AndroidEmbedCheck(False, $iActive <> 0, 1) ; Always update z-order
			AndroidShield("GUIControl_WM_NCACTIVATE", Default, False)
		EndIf
	EndIf
	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_NCACTIVATE

Func GUIControl_WM_FOCUS($hWin, $iMsg, $wParam, $lParam)
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	If $g_iDebugWindowMessages Then SetDebugLog("GUIControl_WM_FOCUS: $hWin=" & $hWin & ", $iMsg=" & Hex($iMsg, 8) & ", $wParam=" & $wParam & ", $lParam=" & $lParam, Default, True)
	Local $iActive = BitAND($wParam, 0x0000FFFF)
	Switch $hWin
		Case $g_hFrmBot
			If $g_bAndroidEmbedded And AndroidShieldActiveDelay() = False Then
				AndroidShield("GUIControl_WM_FOCUS", Default, False)
				If $g_iAndroidEmbedMode = 1 Then
					AndroidEmbedCheck(False, Default, 1) ; Always update z-order
				EndIf
			EndIf
			#cs
				Case $g_hFrmBotEmbeddedShield
				If $lParam = $g_hFrmBotEmbeddedShieldInput Then
				Local $hInput = GUICtrlGetHandle($g_hFrmBotEmbeddedShieldInput)
				If _WinAPI_GetFocus() <> $hInput Then
				;_SendMessage($g_hFrmBotEmbeddedShield, $WM_SETFOCUS, 1, $g_hFrmBotEmbeddedShieldInput)
				;_WinAPI_SetFocus($hInput)
				EndIf
				EndIf
			#ce
	EndSwitch
	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_FOCUS

; Please don't use anywhere else... it's only used for GUIControl_WM_MOUSE to show color where Mouse is in docked Android screen
Func GetPixelFromWindow($x, $y, $hWin)
	Local $hDC = _WinAPI_GetWindowDC($hWin)
	Local $Result = DllCall("gdi32.dll", "int", "GetPixel", "int", $hDC, "int", $x, "int", $y)
	_WinAPI_ReleaseDC($hWin, $hDC)
	If UBound($Result) > 0 Then Return Hex($Result[0], 6)
	Return ""
EndFunc   ;==>GetPixelFromWindow

Func GUIControl_WM_MOUSE($hWin, $iMsg, $wParam, $lParam)
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	Local $hWinMouse = $g_hFrmBotEmbeddedMouse
	If $g_hFrmBotEmbeddedMouse = 0 Then $hWinMouse = (($g_iAndroidEmbedMode = 0) ? $g_hFrmBotEmbeddedShield : $g_hFrmBot)
	If $g_iDebugWindowMessages > 1 Then SetDebugLog("GUIControl_WM_MOUSE: $hWin=" & $hWin & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam & ",$hWinMouse=" & $hWinMouse, Default, True)
	If $hWin <> $hWinMouse Or $g_bAndroidEmbedded = False Or $g_avAndroidShieldStatus[0] = True Then
		$g_bTogglePauseAllowed = $wasAllowed
		SetCriticalMessageProcessing($wasCritical)
		Return $GUI_RUNDEFMSG
	EndIf

	Switch $iMsg
		Case $WM_LBUTTONDOWN, $WM_LBUTTONUP, $WM_RBUTTONDOWN, $WM_RBUTTONUP
			; ensure text box still has focus
			Local $hInput = GUICtrlGetHandle($g_hFrmBotEmbeddedShieldInput)
			_WinAPI_SetFocus($hInput)
	EndSwitch

	Switch $iMsg
		Case $WM_MOUSEMOVE
			If $g_iDebugClick And AndroidShieldHasFocus() Then
				Local $x = BitAND($lParam, 0xFFFF)
				Local $y = BitAND($lParam, 0xFFFF0000) / 0x10000
				Local $c = GetPixelFromWindow($x, $y, $HWnDCtrl)
				_GUICtrlStatusBar_SetText($g_hStatusBar, StringFormat("Mouse %03i,%03i Color %s", $x, $y, $c))
			EndIf
		Case $WM_LBUTTONDOWN
			If $g_iDebugClick And AndroidShieldHasFocus() Then
				Local $x = BitAND($lParam, 0xFFFF)
				Local $y = BitAND($lParam, 0xFFFF0000) / 0x10000
				Local $c = GetPixelFromWindow($x, $y, $HWnDCtrl)
				SetLog(StringFormat("Mouse LBUTTONDOWN %03i,%03i Color %s", $x, $y, $c), $COLOR_DEBUG)
			EndIf
		Case $WM_LBUTTONUP, $WM_RBUTTONUP
			If $g_iDebugWindowMessages Then
				Local $x = BitAND($lParam, 0xFFFF)
				Local $y = BitAND($lParam, 0xFFFF0000) / 0x10000
				SetDebugLog("GUIControl_WM_MOUSE: " & ($iMsg = $WM_LBUTTONUP ? "$WM_LBUTTONUP" : "$WM_RBUTTONUP") & " $hWin=" & $hWin & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam & ", X=" & $x & ", Y=" & $y, Default, True)
			EndIf
			If AndroidShieldHasFocus() = False Then
				; set focus to text box
				Local $hInput = GUICtrlGetHandle($g_hFrmBotEmbeddedShieldInput)
				_WinAPI_SetFocus($hInput)
				AndroidShield("GUIControl_WM_MOUSE", Default, False, 0, True)
				$g_bTogglePauseAllowed = $wasAllowed
				SetCriticalMessageProcessing($wasCritical)
				Return $GUI_RUNDEFMSG
			EndIf
			#cs
				Case $WM_LBUTTONDOWN, $WM_RBUTTONDOWN
				If AndroidShieldHasFocus() = True Then
				Local $hCtrlTarget = $g_aiAndroidEmbeddedCtrlTarget[0]
				_SendMessage($hCtrlTarget, $iMsg, $wParam, $lParam)
				EndIf
			#ce
	EndSwitch
	;#cs
	If AndroidShieldHasFocus() = False Then
		$g_bTogglePauseAllowed = $wasAllowed
		SetCriticalMessageProcessing($wasCritical)
		Return $GUI_RUNDEFMSG
	EndIf
	Local $hCtrlTarget = $g_aiAndroidEmbeddedCtrlTarget[0]
	If $iMsg <> $WM_MOUSEMOVE Or $g_iAndroidEmbedMode <> 0 Then
		Local $Result = _WinAPI_PostMessage($hCtrlTarget, $iMsg, $wParam, $lParam)
	EndIf
	;Local $Result = _SendMessage($hCtrlTarget, $iMsg, $wParam, $lParam)
	;#ce
	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_MOUSE

Global $GUIControl_AndroidEmbedded_Call = [0, 0, 0, 0]
Func GUIControl_AndroidEmbedded($hWin, $iMsg, $wParam, $lParam)
	If $g_bAndroidEmbedded = False Or $g_avAndroidShieldStatus[0] = True Then
		Return $GUI_RUNDEFMSG
	EndIf
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	Switch $iMsg
		Case $WM_KEYDOWN, $WM_KEYUP, $WM_SYSKEYDOWN, $WM_SYSKEYUP, $WM_MOUSEWHEEL ; $WM_KEYFIRST To $WM_KEYLAST
			If $iMsg = $WM_KEYUP And $wParam = 27 Then
				; send ESC as ADB back
				Local $wasSilentSetLog = $g_bSilentSetLog
				$g_bSilentSetLog = True
				AndroidBackButton(False)
				$g_bSilentSetLog = $wasSilentSetLog
				;_WinAPI_SetFocus(GUICtrlGetHandle($g_hFrmBotEmbeddedShieldInput))
				;If $g_iDebugAndroidEmbedded Then AndroidShield("GUIControl_AndroidEmbedded WM_SETFOCUS", Default, False, 0, True)
				;AndroidShield(Default, False, 10, AndroidShieldHasFocus())
			Else
				Local $hCtrlTarget = $g_aiAndroidEmbeddedCtrlTarget[0]
				If $GUIControl_AndroidEmbedded_Call[0] <> $hCtrlTarget Or $GUIControl_AndroidEmbedded_Call[1] <> $iMsg Or $GUIControl_AndroidEmbedded_Call[2] <> $wParam Or $GUIControl_AndroidEmbedded_Call[3] <> $lParam Then
					; protect against strange infinite loops with BS1/2 when using Ctrl-MouseWheel
					If $g_iDebugAndroidEmbedded Then SetDebugLog("GUIControl_AndroidEmbedded: FORWARD $hWin=" & $hWin & ", $iMsg=" & Hex($iMsg) & ", $wParam=" & $wParam & ", $lParam=" & $lParam & ", $hCtrlTarget=" & $hCtrlTarget, Default, True)
					_WinAPI_PostMessage($hCtrlTarget, $iMsg, $wParam, $lParam)
					Global $GUIControl_AndroidEmbedded_Call = [$hCtrlTarget, $iMsg, $wParam, $lParam]
				EndIf
			EndIf
	EndSwitch
	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_AndroidEmbedded

Func GUIControl_WM_COMMAND($hWind, $iMsg, $wParam, $lParam)
	If $GUIControl_Disabled = True Then Return $GUI_RUNDEFMSG
	;Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	If $g_iDebugWindowMessages > 1 Then SetDebugLog("GUIControl_WM_COMMAND: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
	;#forceref $hWind, $iMsg, $wParam, $lParam
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	;If $__TEST_ERROR = True Then ConsoleWrite("GUIControl: $hWind=" & $hWind & ", $iMsg=" & $iMsg & ", $wParam=" & $wParam & ", $lParam=" & $lParam & ", $nNotifyCode=" & $nNotifyCode & ", $nID=" & $nID & ", $hCtrl=" & $hCtrl & ", $g_hFrmBot=" & $g_hFrmBot & @CRLF)

	; check shield status
	If $hWind <> $g_hFrmBotEmbeddedShield And $hWind <> $g_hFrmBotEmbeddedGraphics And $hWind <> $g_hFrmBotEmbeddedMouse And $nID <> $g_hFrmBotEmbeddedShieldInput Then
		If AndroidShieldHasFocus() = True Then
			; update shield with inactive state
			If $g_iDebugWindowMessages Then SetDebugLog("GUIControl_WM_COMMAND: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
			AndroidShield("GUIControl_WM_COMMAND", Default, False, 150, False)
		EndIf
	EndIf

	; WM_SYSCOMAND msdn: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646360(v=vs.85).aspx
	CheckRedrawBotWindow(Default, Default, "GUIControl_WM_COMMAND")
	Switch $nID
		Case $g_hDivider
			;MoveDivider()
			$g_bMoveDivider = True
			SetDebugLog("MoveDivider active", Default, True)
		Case $GUI_EVENT_CLOSE
			; Clean up resources
			BotCloseRequest()
		Case $g_hLblCreditsBckGrnd, $g_hLblUnbreakableHelp
			; Handle open URL clicks when label of link is over another background label
			Local $CursorInfo = GUIGetCursorInfo($g_hFrmBot)
			If IsArray($CursorInfo) = 1 Then
				Switch $CursorInfo[4]
					Case $g_hLblMyBotURL, $g_hLblForumURL, $g_hLblUnbreakableLink
						OpenURL_Label($CursorInfo[4])
				EndSwitch
			EndIf
		Case $g_hLblMyBotURL, $g_hLblForumURL, $g_hLblUnbreakableLink
			; Handle open URL when label fires the event normally
			OpenURL_Label($nID)
		Case $g_hFrmBot_URL_PIC
			OpenURL_Label($g_hLblMyBotURL)
		Case $g_hLblDonate
			; Donate URL is not in text nor tooltip
			ShellExecute("https://mybot.run/forums/index.php?/donate/make-donation/")
		Case $g_hBtnStop
			btnStop()
		Case $g_hBtnPause
			btnPause()
		Case $g_hBtnResume
			btnResume()
		Case $g_hBtnHide
			btnHide()
		Case $g_hBtnEmbed
			btnEmbed()
		Case $btnResetStats
			btnResetStats()
		Case $g_hBtnAttackNowDB
			btnAttackNowDB()
		Case $g_hBtnAttackNowLB
			btnAttackNowLB()
		Case $g_hBtnAttackNowTS
			btnAttackNowTS()
			;Case $idMENU_DONATE_SUPPORT
			;	ShellExecute("https://mybot.run/forums/index.php?/donate/make-donation/")
		Case $g_hBtnNotifyDeleteMessages
			If $g_bRunState Then
				btnDeletePBMessages() ; call with flag when bot is running to execute on _sleep() idle
			Else
				PushMsg("DeleteAllPBMessages") ; call directly when bot is stopped
			EndIf
		Case $g_hBtnMakeScreenshot
			If $g_bRunState Then
				; call with flag when bot is running to execute on _sleep() idle
				btnMakeScreenshot()
			Else
				; call directly when bot is stopped
				If $iScreenshotType = 0 Then
					MakeScreenshot($g_sProfileTempPath, "jpg")
				Else
					MakeScreenshot($g_sProfileTempPath, "png")
				EndIf
			EndIf
		Case $g_hPicTwoArrowShield
			btnVillageStat()
		Case $g_hPicArrowLeft, $g_hPicArrowRight
			btnVillageStat()

			; debug checkboxes and buttons
		Case $g_hChkDebugClick
			chkDebugClick()
		Case $g_hChkDebugSetlog
			chkDebugSetlog()
		Case $g_hChkDebugDisableZoomout
			chkDebugDisableZoomout()
		Case $g_hChkDebugDisableVillageCentering
			chkDebugDisableVillageCentering()
		Case $g_hChkDebugDeadbaseImage
			chkDebugDeadbaseImage()
		Case $g_hChkDebugOCR
			chkDebugOcr()
		Case $g_hChkDebugImageSave
			chkDebugImageSave()
		Case $g_hChkdebugBuildingPos
			chkDebugBuildingPos()
		Case $g_hChkdebugTrain
			chkDebugTrain()
		Case $g_hChkDebugOCRDonate
			chkdebugOCRDonate()
		Case $g_hChkdebugAttackCSV
			chkdebugAttackCSV()
		Case $g_hChkMakeIMGCSV
			chkmakeIMGCSV()
		Case $g_hBtnTestTrain
			btnTestTrain()
		Case $g_hBtnTestDonateCC
			btnTestDonateCC()
		Case $g_hBtnTestRequestCC
			btnTestRequestCC()
		Case $g_hBtnTestAttackBar
			btnTestAttackBar()
		Case $g_hBtnTestClickDrag
			btnTestClickDrag()
		Case $g_hBtnTestImage
			btnTestImage()
		Case $g_hBtnTestVillageSize
			btnTestVillageSize()
		Case $g_hBtnTestDeadBase
			btnTestDeadBase()
		Case $g_hBtnTestDeadBaseFolder
			btnTestDeadBaseFolder()
		Case $g_hBtnTestTHimgloc
			imglocTHSearch()
		Case $g_hBtnTestQuickTrainsimgloc
			imglocTestQuickTrain(1)
		Case $g_hBtnTestimglocTroopBar
			TestImglocTroopBar()
		Case $g_hBtnTestAttackCSV
			btnTestAttackCSV()
		Case $g_hBtnTestFindButton
			btnTestFindButton()
		Case $g_hBtnTestCleanYard
			btnTestCleanYard()
		Case $g_hBtnTestConfigSave
			saveConfig()
		Case $g_hBtnTestConfigRead
			readConfig()
		Case $g_hBtnTestConfigApply
			applyConfig()
	EndSwitch

	If $lParam = $g_hCmbGUILanguage Then
		If $nNotifyCode = $CBN_SELCHANGE Then cmbLanguage()
	EndIf

	$g_bTogglePauseAllowed = $wasAllowed
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_COMMAND

Func GUIControl_WM_MOVE($hWind, $iMsg, $wParam, $lParam)
	;If $GUIControl_Disabled = True Then Return $GUI_RUNDEFMSG
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	If $g_iDebugWindowMessages Then SetDebugLog("GUIControl_WM_MOVE: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
	If $hWind = $g_hFrmBot Then
		If $iUpdatingWhenMinimized = 1 And BotWindowCheck() = False And _WinAPI_IsIconic($g_hFrmBot) Then
			; ensure bot is not really minimized (e.g. when you minimize all windows)
			BotMinimize("GUIControl_WM_MOVE")
			$g_bTogglePauseAllowed = $wasAllowed
			SetCriticalMessageProcessing($wasCritical)
			Return $GUI_RUNDEFMSG
		EndIf

		; update bot pos variables
		Local $frmBotPos = WinGetPos($g_hFrmBot)
		If $g_bAndroidEmbedded = False Then
			$frmBotPosX = ($frmBotPos[0] > -30000 ? $frmBotPos[0] : $frmBotPosX)
			$frmBotPosY = ($frmBotPos[1] > -30000 ? $frmBotPos[1] : $frmBotPosY)
		Else
			$frmBotDockedPosX = ($frmBotPos[0] > -30000 ? $frmBotPos[0] : $frmBotDockedPosX)
			$frmBotDockedPosY = ($frmBotPos[1] > -30000 ? $frmBotPos[1] : $frmBotDockedPosY)
		EndIf

		; required for screen change
		If $g_bAndroidEmbedded And AndroidEmbedArrangeActive() = False Then
			Local $iAction = AndroidEmbedCheck(True)
			If $iAction > 0 Then
				; reposition docked android
				AndroidEmbedCheck(False, Default, $iAction)
				; redraw bot also
				;temp;_WinAPI_RedrawWindow($g_hFrmBotEx, 0, 0, $RDW_INVALIDATE)
				;temp;_WinAPI_RedrawWindow($frmBotBottom, 0, 0, $RDW_INVALIDATE)
			EndIf
			If $g_iDebugWindowMessages Then
				Local $a = $frmBotPos
				SetDebugLog("Bot Position: " & $a[0] & "," & $a[1] & " " & $a[2] & "x" & $a[3])
				$a = WinGetPos($HWnD)
				SetDebugLog("Android Position: " & $a[0] & "," & $a[1] & " " & $a[2] & "x" & $a[3])
				If $g_hFrmBotEmbeddedMouse <> 0 Then
					$a = WinGetPos($g_hFrmBotEmbeddedMouse)
					SetDebugLog("Mouse Window Position: " & $a[0] & "," & $a[1] & " " & $a[2] & "x" & $a[3])
				EndIf
			EndIf
		EndIf
	EndIf

	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_MOVE

Func GUIControl_WM_SYSCOMMAND($hWind, $iMsg, $wParam, $lParam)
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	If $g_iDebugWindowMessages Then SetDebugLog("GUIControl_WM_SYSCOMMAND: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
	;If $__TEST_ERROR = True Then SetDebugLog("Bot WM_SYSCOMMAND: " & Hex($wParam, 4))
	If $hWind = $g_hFrmBot Then ; Only close Bot when Bot Window sends Close Message
		Switch $wParam
			Case $SC_MINIMIZE
				BotMinimize("GUIControl_WM_SYSCOMMAND")
			Case $SC_RESTORE ; 0xf120
				; set redraw controls flag to check if after restore visibile controls require redraw
				BotRestore("GUIControl_WM_SYSCOMMAND")
			Case $SC_CLOSE ; 0xf060
				BotCloseRequest()
		EndSwitch
	EndIf
	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_SYSCOMMAND

Func GUIControl_WM_NOTIFY($hWind, $iMsg, $wParam, $lParam)
	;If $GUIControl_Disabled = True Then Return $GUI_RUNDEFMSG
	Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	If $g_iDebugWindowMessages > 1 Then SetDebugLog("GUIControl_WM_NOTIFY: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam

	;If $__TEST_ERROR = True Then ConsoleWrite("GUIControl: $hWind=" & $hWind & ", $iMsg=" & $iMsg & ", $wParam=" & $wParam & ", $lParam=" & $lParam & ", $nNotifyCode=" & $nNotifyCode & ", $nID=" & $nID & ", $hCtrl=" & $hCtrl & ", $g_hFrmBot=" & $g_hFrmBot & @CRLF)
	;GUIControl_WM_NOTIFY: $hWind=0x0055A084,$iMsg=78,$wParam=0x00000008,$lParam=0x0108BB30
	; WM_SYSCOMAND msdn: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646360(v=vs.85).aspx

	Local $bCheckEmbeddedShield = True

	Switch $nID
		Case $g_hTabMain
			; Handle RichText controls
			tabMain()
		Case $g_hGUI_VILLAGE_TAB
			tabVillage()
		Case $g_hGUI_DONATE_TAB
			tabDONATE()
		Case $g_hGUI_ATTACK_TAB
			tabAttack()
		Case $g_hGUI_SEARCH_TAB
			tabSEARCH()
		Case $g_hGUI_DEADBASE_TAB
			tabDeadbase()
		Case $g_hGUI_ACTIVEBASE_TAB
			tabActivebase()
		Case $g_hGUI_THSNIPE_TAB
			tabTHSnipe()
		Case $g_hGUI_BOT_TAB
			tabBot()
		Case Else
			$bCheckEmbeddedShield = False
	EndSwitch

	If $bCheckEmbeddedShield Then
		; check shield status
		If $hWind <> $g_hFrmBotEmbeddedShield And $hWind <> $g_hFrmBotEmbeddedGraphics And $hWind <> $g_hFrmBotEmbeddedMouse Then
			If AndroidShieldHasFocus() = True Then
				; update shield with inactive state
				If $g_iDebugWindowMessages Then SetDebugLog("GUIControl_WM_NOTIFY: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
				AndroidShield("GUIControl_WM_NOTIFY", Default, False, 150, False)
			EndIf
		EndIf
	EndIf

	$g_bTogglePauseAllowed = $wasAllowed
	SetCriticalMessageProcessing($wasCritical)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl_WM_NOTIFY

Func GUIControl_WM_CLOSE($hWind, $iMsg, $wParam, $lParam)
	;Local $wasCritical = SetCriticalMessageProcessing(True)
	If $g_iDebugWindowMessages > 0 Then SetDebugLog("GUIControl_WM_CLOSE: $hWind=" & $hWind & ",$iMsg=" & $iMsg & ",$wParam=" & $wParam & ",$lParam=" & $lParam, Default, True)
	If $hWind = $g_hFrmBot Then
		BotCloseRequest()
	EndIf
EndFunc   ;==>GUIControl_WM_CLOSE

Func GUIEvents()
	;@GUI_WinHandle
	;Local $wasCritical = SetCriticalMessageProcessing(True)
	Local $wasAllowed = $g_bTogglePauseAllowed
	$g_bTogglePauseAllowed = False
	Local $GUI_CtrlId = @GUI_CtrlId
	If $g_bFrmBotMinimized And $GUI_CtrlId = $GUI_EVENT_MINIMIZE Then
		; restore
		If $g_iDebugWindowMessages Then SetDebugLog("$GUI_EVENT_MINIMIZE changed to $GUI_EVENT_RESTORE", Default, True)
		$GUI_CtrlId = $GUI_EVENT_RESTORE
	EndIf
	Switch $GUI_CtrlId
		Case $GUI_EVENT_CLOSE
			If $g_iDebugWindowMessages Then SetDebugLog("$GUI_EVENT_CLOSE", Default, True)
			BotCloseRequest()

		Case $GUI_EVENT_MINIMIZE
			If $g_iDebugWindowMessages Then SetDebugLog("$GUI_EVENT_MINIMIZE", Default, True)
			BotMinimize("GUIEvents")
			;Return 0

		Case $GUI_EVENT_RESTORE
			If $g_iDebugWindowMessages Then SetDebugLog("$GUI_EVENT_RESTORE", Default, True)
			BotRestore("GUIEvents")

		Case Else
			If $g_iDebugWindowMessages Then SetDebugLog("$GUI_EVENT: " & @GUI_CtrlId, Default, True)
	EndSwitch
	$g_bTogglePauseAllowed = $wasAllowed
EndFunc   ;==>GUIEvents

; Open URL in default browser using ShellExecute
; URL is retrieved from label text or an existing ToolTip Control
Func OpenURL_Label($LabelCtrlID)
	Local $url = GUICtrlRead($LabelCtrlID)
	If StringInStr($url, "http") <> 1 Then
		$url = _GUIToolTip_GetText($hToolTip, 0, GUICtrlGetHandle($LabelCtrlID))
	EndIf
	If StringInStr($url, "http") = 1 Then
		SetDebugLog("Open URL: " & $url)
		ShellExecute($url) ;open web site when clicking label
	Else
		SetDebugLog("Cannot open URL for Control ID " & $LabelCtrlID, $COLOR_ERROR)
	EndIf
EndFunc   ;==>OpenURL_Label

Func BotCloseRequest()
	If $g_iBotAction = $eBotClose Then
		; already requested to close, but user is impatient, so close now
		BotClose()
	Else
		SetLog("Closing " & $g_sBotTitle & ", please wait ...")
	EndIf
	$g_bRunState = False
	$g_bBotPaused = False
	$g_iBotAction = $eBotClose
EndFunc   ;==>BotCloseRequest

Func BotClose($SaveConfig = Default, $bExit = True)
	If $SaveConfig = Default Then $SaveConfig = $g_iBotLaunchTime > 0
	$g_bRunState = False
	$g_bBotPaused = False
	ResumeAndroid()
	SetLog("Closing " & $g_sBotTitle & " now ...")
	AndroidEmbed(False) ; detach Android Window
	AndroidShieldDestroy() ; destroy Shield Hooks
	AndroidBotStopEvent() ; signal android that bot is now stoppting

	If $SaveConfig = True Then
		setupProfile()
		SaveConfig()
	EndIf
	AndroidAdbTerminateShellInstance()
	; Close Mutexes
	If $g_hMutex_BotTitle <> 0 Then _WinAPI_CloseHandle($g_hMutex_BotTitle)
	If $g_hMutex_Profile <> 0 Then _WinAPI_CloseHandle($g_hMutex_Profile)
	If $g_hMutex_MyBot <> 0 Then _WinAPI_CloseHandle($g_hMutex_MyBot)
	; Clean up resources
	__GDIPlus_Shutdown()
	MBRFunc(False) ; close MBRFunctions dll
	_GUICtrlRichEdit_Destroy($g_hTxtLog)
	_GUICtrlRichEdit_Destroy($g_hTxtAtkLog)
	DllCall("comctl32.dll", "int", "ImageList_Destroy", "hwnd", $hImageList)
	If $HWnD <> 0 Then ControlFocus($HWnD, "", $HWnD) ; show bot in taskbar again
	GUIDelete($g_hFrmBot)

	; Global DllStuctCreate
	$g_aiAndroidAdbScreencapBuffer = 0 ; Allocated in MBR Global Variables.au3
	$hStruct_SleepMicro = 0 ; Allocated in MBR Global Variables.au3, used in _Sleep.au3

	; Unregister managing hosts
	UnregisterManagedMyBotHost()

	If $bExit = True Then Exit
EndFunc   ;==>BotClose

Func BotMinimize($sCaller, $iForceUpdatingWhenMinimized = False)
	Local $hMutex = AcquireMutex("MinimizeRestore")
	SetDebugLog("Minimize bot window, caller: " & $sCaller, Default, True)
	$g_bFrmBotMinimized = True
	If $iUpdatingWhenMinimized = 1 Or $iForceUpdatingWhenMinimized = True Then
		If $iHideWhenMinimized = 1 Then
			WinMove2($g_hFrmBot, "", -32000, -32000, -1, -1, 0, $SWP_HIDEWINDOW, False)
			_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitOR(_WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE), $WS_EX_TOOLWINDOW))
		EndIf
		If _WinAPI_IsIconic($g_hFrmBot) Then WinSetState($g_hFrmBot, "", @SW_RESTORE)
		If _WinAPI_IsIconic($HWnD) Then WinSetState($HWnD, "", @SW_RESTORE)
		WinMove2($g_hFrmBot, "", -32000, -32000, -1, -1, 0, $SWP_SHOWWINDOW, False)
	Else
		If $iHideWhenMinimized = 1 Then
			WinMove2($g_hFrmBot, "", -1, -1, -1, -1, 0, $SWP_HIDEWINDOW, False)
			_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitOR(_WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE), $WS_EX_TOOLWINDOW))
		EndIf
		WinSetState($g_hFrmBot, "", @SW_MINIMIZE)
		;WinSetState($HWnD, "", @SW_MINIMIZE)
	EndIf
	ReleaseMutex($hMutex)
EndFunc   ;==>BotMinimize

Func BotRestore($sCaller)
	Local $hMutex = AcquireMutex("MinimizeRestore")
	$g_bFrmBotMinimized = False
	Local $botPosX = ($g_bAndroidEmbedded = False ? $frmBotPosX : $frmBotDockedPosX)
	Local $botPosY = ($g_bAndroidEmbedded = False ? $frmBotPosY : $frmBotDockedPosY)
	Local $aPos = [$botPosX, $botPosY]
	SetDebugLog("Restore bot window to " & $botPosX & ", " & $botPosY & ", caller: " & $sCaller, Default, True)
	Local $iExStyle = _WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE)
	If BitAND($iExStyle, $WS_EX_TOOLWINDOW) Then
		WinMove2($g_hFrmBot, "", -1, -1, -1, -1, 0, $SWP_HIDEWINDOW, False)
		_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitAND($iExStyle, BitNOT($WS_EX_TOOLWINDOW)))
	EndIf
	If _WinAPI_IsIconic($g_hFrmBot) Then WinSetState($g_hFrmBot, "", @SW_RESTORE)
	If $g_bAndroidAdbScreencap = False And $g_bRunState = True And $g_bBotPaused = False And _WinAPI_IsIconic($HWnD) Then WinSetState($HWnD, "", @SW_RESTORE)
	WinMove2($g_hFrmBot, "", $botPosX, $botPosY, -1, -1, $HWND_TOP, $SWP_SHOWWINDOW)
	_WinAPI_SetActiveWindow($g_hFrmBot)
	_WinAPI_SetFocus($g_hFrmBot)
	If _CheckWindowVisibility($g_hFrmBot, $aPos) Then
		SetDebugLog("Bot Window '" & $Title & "' not visible, moving to position: " & $aPos[0] & ", " & $aPos[1])
		WinMove2($g_hFrmBot, "", $aPos[0], $aPos[1])
	EndIf
	WinSetTrans($g_hFrmBot, "", 255) ; is set to 1 when "Hide when minimized" is enabled after some time, so restore it
	ReleaseMutex($hMutex)
EndFunc   ;==>BotRestore

; Ensure bot window state (fix minimize not working sometimes)
Func BotWindowCheck()
	If $g_bFrmBotMinimized Then
		Local $aPos = WinGetPos($g_hFrmBot)
		If IsArray($aPos) And $aPos[0] > -30000 Or $aPos[0] > -30000 Then
			BotMinimize("BotWindowCheck")
			Return True
		EndIf
	EndIf
	Return False
EndFunc   ;==>BotWindowCheck

;---------------------------------------------------
; Tray Item Functions
;---------------------------------------------------
Func tiShow()
	BotRestore("tiShow")
EndFunc   ;==>tiShow

Func tiHide()
	$iHideWhenMinimized = ($iHideWhenMinimized = 1 ? 0 : 1)
	TrayItemSetState($g_hTiHide, ($iHideWhenMinimized = 1 ? $TRAY_CHECKED : $TRAY_UNCHECKED))
	GUICtrlSetState($g_hChkHideWhenMinimized, ($iHideWhenMinimized = 1 ? $GUI_CHECKED : $GUI_UNCHECKED))
	If $g_bFrmBotMinimized = True Then
		If $iHideWhenMinimized = 0 Then
			BotRestore("tiHide")
		Else
			BotMinimize("tiHide")
		EndIf
	EndIf
EndFunc   ;==>tiHide

Func tiAbout()
	Local $sMsg = "Clash of Clans Bot" & @CRLF & @CRLF & _
			"Version: " & $g_sBotVersion & @CRLF & _
			"Released under the GNU GPLv3 license." & @CRLF & _
			"Visit www.MyBot.run"
	MsgBox(64 + $MB_APPLMODAL + $MB_TOPMOST, $g_sBotTitle, $sMsg, 0, $g_hFrmBot)
EndFunc   ;==>tiAbout

Func tiDonate()
	ShellExecute("https://mybot.run/forums/index.php?/donate/make-donation/")
EndFunc   ;==>tiDonate

Func tiExit()
	BotCloseRequest()
EndFunc   ;==>tiExit

; #FUNCTION# ====================================================================================================================
; Name ..........: SetRedrawBotWindow
; Description ...: Enables and disables bot window automatic redraw on GUI changes
; Syntax ........:
; Parameters ....: $bEnableRedraw : Boolean enables/disables
;                  $bCheckRedrawBotWindow : Boolean to check when redraw gets enabled if bot window needs to be redrawn
;                  $bForceRedraw : Boolean to always redraw bot window when redraw is enabled again
; Return values .: Boolean of former redraw state
; Author ........: Cosote (2015)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: Local $bWasRedraw = SetRedrawBotWindow(False)
;                  [...]
;                  SetRedrawBotWindow($bWasRedraw)
; ===============================================================================================================================
Func SetRedrawBotWindow($bEnableRedraw, $bCheckRedrawBotWindow = Default, $bForceRedraw = Default, $RedrawControlIDs = Default, $sSource = "")
	If $g_iRedrawBotWindowMode = 0 Then Return False ; disabled
	If $g_iRedrawBotWindowMode = 1 Then $RedrawControlIDs = Default ; always redraw entire bot window
	If $bCheckRedrawBotWindow = Default Then $bCheckRedrawBotWindow = True
	If $bForceRedraw = Default Then $bForceRedraw = False
	; speed up GUI changes by disabling window redraw
	Local $bWasRedraw = $g_bRedrawBotWindow[0]
	If $g_bRedrawBotWindow[0] = $bEnableRedraw Then
		; nothing to do
		Return $bWasRedraw
	EndIf
	; enable logging to debug GUI redraw
	;SetDebugLog(($bEnableRedraw ? "Enable" : "Disable") & " MyBot Window Redraw")
	_SendMessage($g_hFrmBotEx, $WM_SETREDRAW, $bEnableRedraw, 0)
	$g_bRedrawBotWindow[0] = $bEnableRedraw
	If $bEnableRedraw Then
		If $bCheckRedrawBotWindow Then
			CheckRedrawBotWindow($bForceRedraw, $RedrawControlIDs, $sSource)
		EndIf
	Else
		SetDebugLog("Disable MyBot Window Redraw" & (($sSource <> "") ? (": " & $sSource) : ("")))
		; set dirty redraw flag
		$g_bRedrawBotWindow[1] = True
	EndIf
	Return $bWasRedraw
EndFunc   ;==>SetRedrawBotWindow


Func SetRedrawBotWindowControls($bEnableRedraw, $RedrawControlIDs, $sSource = "")
	Return SetRedrawBotWindow($bEnableRedraw, True, False, $RedrawControlIDs, $sSource)
EndFunc   ;==>SetRedrawBotWindowControls

Func CheckRedrawBotWindow($bForceRedraw = Default, $RedrawControlIDs = Default, $sSource = "")
	If $g_iRedrawBotWindowMode = 0 Then Return False ; disabled
	If $bForceRedraw = Default Then $bForceRedraw = False
	If $g_iRedrawBotWindowMode = 1 Then $RedrawControlIDs = Default ; always redraw entire bot window
	; check if bot window redraw is enabled and required
	If Not $g_bRedrawBotWindow[0] Then Return False
	If $g_bRedrawBotWindow[1] Or $bForceRedraw Then
		; enable logging to debug GUI redraw
		$g_bRedrawBotWindow[1] = False
		$g_bRedrawBotWindow[2] = False
		; Redraw bot window
		If $RedrawControlIDs = Default Then
			; redraw entire window
			SetDebugLog("Redraw MyBot Window" & ($bForceRedraw ? " (forced)" : "") & (($sSource <> "") ? (": " & $sSource) : (""))) ; enable logging to debug GUI redraw
			_WinAPI_RedrawWindow($g_hFrmBotEx, 0, 0, BitOR($RDW_INVALIDATE, $RDW_ALLCHILDREN, $RDW_ERASE))
		Else
			; redraw only specified control(s)
			If IsArray($RedrawControlIDs) Then
				SetDebugLog("Redraw MyBot ControlIds" & ($bForceRedraw ? " (forced)" : "") & ": " & _ArrayToString($RedrawControlIDs, ", "))
				Local $c
				For $c In $RedrawControlIDs
					If ControlRedraw($g_hFrmBot, $c) = 0 Then
						_WinAPI_RedrawWindow($g_hFrmBotEx, 0, 0, BitOR($RDW_INVALIDATE, $RDW_ALLCHILDREN, $RDW_ERASE))
						ExitLoop
					EndIf
				Next
			Else
				SetDebugLog("Redraw MyBot ControlId" & ($bForceRedraw ? " (forced)" : "") & ": " & $RedrawControlIDs)
				If ControlRedraw($g_hFrmBot, $RedrawControlIDs) = 0 Then
					_WinAPI_RedrawWindow($g_hFrmBotEx, 0, 0, BitOR($RDW_INVALIDATE, $RDW_ALLCHILDREN, $RDW_ERASE))
				EndIf
			EndIf
		EndIf
		_WinAPI_UpdateWindow($g_hFrmBotEx)
		; check if android need redraw as well
		Return True
	Else
		Return CheckRedrawControls(Default, $sSource)
	EndIf
	Return False
EndFunc   ;==>CheckRedrawBotWindow

Func CheckRedrawControls($ForceCheck = Default, $sSource = "") ; ... that require additional redraw is executed like restore from minimized state
	If $g_iRedrawBotWindowMode = 0 Then Return False ; disabled
	If $ForceCheck = Default Then $ForceCheck = False
	If Not $g_bRedrawBotWindow[2] And Not $ForceCheck Then Return False
	If GUICtrlRead($g_hTabMain, 1) = $g_hTabLog Then
		Local $a = [$g_hTxtLog, $g_hTxtAtkLog]
		Return CheckRedrawBotWindow(True, $a, $sSource)
	EndIf
	$g_bRedrawBotWindow[2] = False
	Return False
EndFunc   ;==>CheckRedrawControls

; Just redraw the bot window with using any dedicated global variables... Use it only in special cases!
Func RedrawBotWindowNow()
	SetDebugLog("Redraw MyBot Window Now")
	_WinAPI_RedrawWindow($g_hFrmBot, 0, 0, BitOR($RDW_INVALIDATE, $RDW_ALLCHILDREN, $RDW_ERASE))
	_WinAPI_UpdateWindow($g_hFrmBot)
EndFunc   ;==>RedrawBotWindowNow

; Redraw only specified control
Func ControlRedraw($hWin, $ConrolId)
	Local $a = ControlGetPos($hWin, "", $ConrolId)
	If IsArray($a) = 0 Then
		SetDebugLog("ControlRedraw: Invalid ControlId: " & $ConrolId)
		Return 0
	EndIf
	Local $hCtrl = (IsHWnd($ConrolId) ? $ConrolId : GUICtrlGetHandle($ConrolId))
	Local $hWinParent = _WinAPI_GetParent($hCtrl)
	SetDebugLog("Control ID " & $ConrolId & " handle: " & $hCtrl & " parent: " & $hWinParent & " $g_hFrmBot: " & $g_hFrmBot & " $g_hFrmBotEx: " & $g_hFrmBotEx & " Pos: " & $a[0] & ", " & $a[1] & ", " & $a[2] & ", " & $a[3], Default, True)
	Local $left = $a[0]
	Local $top = $a[1]
	Local $width = $a[2]
	Local $height = $a[3]
	Local $tRECT = DllStructCreate($tagRECT)
	DllStructSetData($tRECT, "Left", $left)
	DllStructSetData($tRECT, "Top", $top)
	DllStructSetData($tRECT, "Right", $left + $width)
	DllStructSetData($tRECT, "Bottom", $top + $height)
	SetDebugLog("Control ID " & $ConrolId & " RedrawWindow Pos: " & $left & ", " & $top & ", " & $left + $width & ", " & $top + $height, Default, True)
	_WinAPI_RedrawWindow($hWin, $tRECT, 0, BitOR($RDW_INVALIDATE, $RDW_ALLCHILDREN))
	$tRECT = 0
	Return 1
EndFunc   ;==>ControlRedraw



;============================================================================
;    \/=============Func SetTime Mod'ed for Switch Accounts =======\/


Func SetTime($bForceUpdate = False)
	If $g_hTimerSinceStarted = 0 Then Return ; GIGO, no setTime when timer hasn't started yet
	Local $day = 0, $hour = 0, $min = 0, $sec = 0
	Local Static $DisplayLoop = 0
	;Local $TimerDiffStart, $TimerDiffEnd, $AllAccountsWaitTimeDiff

	If GUICtrlRead($g_hGUI_STATS_TAB, 1) = $g_hGUI_STATS_TAB_ITEM2 Or $bForceUpdate = True Then
		_TicksToDay(Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed), $day, $hour, $min, $sec)
		GUICtrlSetData($g_hLblResultRuntime, $day > 0 ? StringFormat("%2u Day(s) %02i:%02i:%02i", $day, $hour, $min, $sec) : StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	EndIf
	If GUICtrlGetState($g_hLblResultGoldNow) <> $GUI_ENABLE + $GUI_SHOW Or $bForceUpdate = True Then
		_TicksToTime(Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed), $hour, $min, $sec)
		GUICtrlSetData($g_hLblResultRuntimeNow, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	EndIf

	If $DisplayLoop >= 10 Then ; Conserve Clock Cycles on Updating times
		$DisplayLoop = 0
		;Update Multi Stat Page
		If GUICtrlRead($g_hGUI_MOD_TAB, 1) = $g_hGUI_MOD_TAB_ITEM5 And $CurrentAccount <> 0 Then
			For $i = 1 To 8 ; Update time for all Accounts
				If $ichkCanUse[$i] = 1 And _
						$ichkDonateAccount[$i] <> 1 And _
						$i <> $CurrentAccount And _
						$TimerDiffStart[$i] <> 0 And _
						(GUICtrlRead($g_lblTimeNowSW[$i]) <> "No Data" Or GUICtrlRead($g_lblTimeNowSW[$i]) <> "Looting") Then ; Only update labels that need a time

					$TimerDiffEnd[$i] = TimerDiff($TimerDiffStart[$i])
					$AllAccountsWaitTimeDiff[$i] = Round($AllAccountsWaitTime[$i] * 60 * 1000 - $TimerDiffEnd[$i], 2)
					If $AllAccountsWaitTimeDiff[$i] < 0 Then
						GUICtrlSetData($g_lblTimeNowSW[$i], Round($AllAccountsWaitTimeDiff[$i] / 60 / 1000, 2))
						GUICtrlSetBkColor($g_lblTimeNowSW[$i], $COLOR_RED)
						GUICtrlSetColor($g_lblTimeNowSW[$i], $COLOR_BLACK)
					Else
						GUICtrlSetData($g_lblTimeNowSW[$i], Round($AllAccountsWaitTimeDiff[$i] / 60 / 1000, 2))
						GUICtrlSetBkColor($g_lblTimeNowSW[$i], $COLOR_YELLOW)
						GUICtrlSetColor($g_lblTimeNowSW[$i], $COLOR_BLACK)
					EndIf

					GUICtrlSetData($g_lblHrStatsGoldSW[$i], _NumberFormat(Round($g_iStatsTotalGain[$i][$eLootGold] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)))
					GUICtrlSetData($g_lblHrStatsElixirSW[$i], _NumberFormat(Round($g_iStatsTotalGain[$i][$eLootElixir] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)))
					If $g_iStatsStartedWith[$CurrentAccount][$eLootDarkElixir] <> "" Then
						GUICtrlSetData($g_lblHrStatsDarkSW[$i], _NumberFormat(Round($g_iStatsTotalGain[$i][$eLootDarkElixir] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)))
					EndIf
				EndIf
			Next
		EndIf
		;Update PopOut's
		For $i = 1 To 8
			If WinGetState(Eval($hGuiPopOut & $i)) <> -1 Then
				If $ichkCanUse[$i] = 1 And _
						$ichkDonateAccount[$i] <> 1 And _
						$i <> $CurrentAccount And _
						$TimerDiffStart[$i] <> 0 And _
						(GUICtrlRead($g_lblTimeNowPO[$i]) <> "No Data" Or GUICtrlRead($g_lblTimeNowPO[$i]) <> "Looting") Then ; Only update labels that need a time

					$TimerDiffEnd[$i] = TimerDiff($TimerDiffStart[$i])
					$AllAccountsWaitTimeDiff[$i] = Round($AllAccountsWaitTime[$i] * 60 * 1000 - $TimerDiffEnd[$i], 2)
					If $AllAccountsWaitTimeDiff[$i] < 0 Then
						GUICtrlSetData($g_lblTimeNowPO[$i], Round($AllAccountsWaitTimeDiff[$i] / 60 / 1000, 2))
						GUICtrlSetBkColor($g_lblTimeNowPO[$i], $COLOR_RED)
						GUICtrlSetColor($g_lblTimeNowPO[$i], $COLOR_BLACK)
					Else
						GUICtrlSetData($g_lblTimeNowPO[$i], Round($AllAccountsWaitTimeDiff[$i] / 60 / 1000, 2))
						GUICtrlSetBkColor($g_lblTimeNowPO[$i], $COLOR_YELLOW)
						GUICtrlSetColor($g_lblTimeNowPO[$i], $COLOR_BLACK)
					EndIf

					GUICtrlSetData($g_lblHrStatsGoldPO[$i], _NumberFormat(Round($g_iStatsTotalGain[$i][$eLootGold] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)))
					GUICtrlSetData($g_lblHrStatsElixirPO[$i], _NumberFormat(Round($g_iStatsTotalGain[$i][$eLootElixir] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)))
					If $g_iStatsStartedWith[$CurrentAccount][$eLootDarkElixir] <> "" Then
						GUICtrlSetData($g_lblHrStatsDarkPO[$i], _NumberFormat(Round($g_iStatsTotalGain[$i][$eLootDarkElixir] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)))
					EndIf
				EndIf
			EndIf
		Next
	EndIf
	If $CurrentAccount = 0 And WinGetState(Eval($hGuiPopOut0)) <> -1 Then
		GUICtrlSetData($g_lblTimeNowPO[$CurrentAccount], "Looting")
		GUICtrlSetBkColor($g_lblTimeNowPO[$CurrentAccount], $COLOR_GREEN)
		GUICtrlSetColor($g_lblTimeNowPO[$CurrentAccount], $COLOR_BLACK)

		GUICtrlSetData($g_lblHrStatsGoldPO[$CurrentAccount], _NumberFormat(Round($g_iStatsTotalGain[$CurrentAccount][$eLootGold] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)))
		GUICtrlSetData($g_lblHrStatsElixirPO[$CurrentAccount], _NumberFormat(Round($g_iStatsTotalGain[$CurrentAccount][$eLootElixir] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)))
		If $g_iStatsStartedWith[$CurrentAccount][$eLootDarkElixir] <> "" Then
			GUICtrlSetData($g_lblHrStatsDarkPO[$CurrentAccount], _NumberFormat(Round($g_iStatsTotalGain[$CurrentAccount][$eLootDarkElixir] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)))
		EndIf
	EndIf
	$DisplayLoop += 1
EndFunc   ;==>SetTime
;    /\=============Func SetTime Mod'ed for Switch Accounts =======/\

#CS ; \/===============Orginal SetTime Function==================\/
	Func SetTime($bForceUpdate = False)
	If $g_hTimerSinceStarted = 0 Then Return ; GIGO, no setTime when timer hasn't started yet
	Local $day = 0, $hour = 0, $min = 0, $sec = 0
	If GUICtrlRead($g_hGUI_STATS_TAB, 1) = $g_hGUI_STATS_TAB_ITEM2 Or $bForceUpdate = True Then
	_TicksToDay(Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed), $day, $hour, $min, $sec)
	GUICtrlSetData($g_hLblResultRuntime, $day > 0 ? StringFormat("%2u Day(s) %02i:%02i:%02i", $day, $hour, $min, $sec) : StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	EndIf
	If GUICtrlGetState($g_hLblResultGoldNow) <> $GUI_ENABLE + $GUI_SHOW Or $bForceUpdate = True Then
	_TicksToTime(Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed), $hour, $min, $sec)
	GUICtrlSetData($g_hLblResultRuntimeNow, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	EndIf
	EndFunc   ;==>SetTime
#CE ; /\===============Orginal SetTime Function==================/\

Func tabMain()
	Local $tabidx = GUICtrlRead($g_hTabMain)
	Select
		Case $tabidx = 0 ; Log
			GUISetState(@SW_HIDE, $g_hGUI_VILLAGE)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACK)
			GUISetState(@SW_HIDE, $g_hGUI_BOT)
			GUISetState(@SW_HIDE, $g_hGUI_ABOUT)
			GUISetState(@SW_HIDE, $g_hGUI_MOD)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_LOG)

		Case $tabidx = 1 ; Village
			GUISetState(@SW_HIDE, $g_hGUI_LOG)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACK)
			GUISetState(@SW_HIDE, $g_hGUI_BOT)
			GUISetState(@SW_HIDE, $g_hGUI_ABOUT)
			GUISetState(@SW_HIDE, $g_hGUI_MOD)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_VILLAGE)
			tabVillage()

		Case $tabidx = 2 ; Attack
			GUISetState(@SW_HIDE, $g_hGUI_LOG)
			GUISetState(@SW_HIDE, $g_hGUI_VILLAGE)
			GUISetState(@SW_HIDE, $g_hGUI_BOT)
			GUISetState(@SW_HIDE, $g_hGUI_ABOUT)
			GUISetState(@SW_HIDE, $g_hGUI_MOD)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_ATTACK)
			tabAttack()

		Case $tabidx = 3 ; Options
			GUISetState(@SW_HIDE, $g_hGUI_LOG)
			GUISetState(@SW_HIDE, $g_hGUI_VILLAGE)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACK)
			GUISetState(@SW_HIDE, $g_hGUI_ABOUT)
			GUISetState(@SW_HIDE, $g_hGUI_MOD)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_BOT)
			tabBot()

		Case $tabidx = 4 ; MOD
			GUISetState(@SW_HIDE, $g_hGUI_LOG)
			GUISetState(@SW_HIDE, $g_hGUI_VILLAGE)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACK)
			GUISetState(@SW_HIDE, $g_hGUI_BOT)
			GUISetState(@SW_HIDE, $g_hGUI_ABOUT)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_MOD)

		Case $tabidx = 5 ; About
			GUISetState(@SW_HIDE, $g_hGUI_LOG)
			GUISetState(@SW_HIDE, $g_hGUI_VILLAGE)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACK)
			GUISetState(@SW_HIDE, $g_hGUI_BOT)
			GUISetState(@SW_HIDE, $g_hGUI_MOD)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_ABOUT)

		Case Else
			GUISetState(@SW_HIDE, $g_hGUI_LOG)
			GUISetState(@SW_HIDE, $g_hGUI_VILLAGE)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACK)
			GUISetState(@SW_HIDE, $g_hGUI_BOT)
	EndSelect

EndFunc   ;==>tabMain

Func tabVillage()
	Local $tabidx = GUICtrlRead($g_hGUI_VILLAGE_TAB)
	Select
		Case $tabidx = 1 ; Donate tab
			GUISetState(@SW_HIDE, $g_hGUI_UPGRADE)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_DONATE)
			GUISetState(@SW_HIDE, $g_hGUI_NOTIFY)
		Case $tabidx = 2 ; NOTIFY tab
			GUISetState(@SW_HIDE, $g_hGUI_DONATE)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_UPGRADE)
			GUISetState(@SW_HIDE, $g_hGUI_NOTIFY)
		Case $tabidx = 4 ; Upgrade tab
			GUISetState(@SW_HIDE, $g_hGUI_DONATE)
			GUISetState(@SW_HIDE, $g_hGUI_UPGRADE)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_NOTIFY)
		Case Else
			GUISetState(@SW_HIDE, $g_hGUI_DONATE)
			GUISetState(@SW_HIDE, $g_hGUI_UPGRADE)
			GUISetState(@SW_HIDE, $g_hGUI_NOTIFY)
	EndSelect

EndFunc   ;==>tabVillage

Func tabAttack()
	Local $tabidx = GUICtrlRead($g_hGUI_ATTACK_TAB)
	Select
		Case $tabidx = 0 ; ARMY tab
			GUISetState(@SW_HIDE, $g_hGUI_STRATEGIES)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_TRAINARMY)
			GUISetState(@SW_HIDE, $g_hGUI_SEARCH)
		Case $tabidx = 1 ; SEARCH tab
			GUISetState(@SW_HIDE, $g_hGUI_STRATEGIES)
			GUISetState(@SW_HIDE, $g_hGUI_TRAINARMY)
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_SEARCH)
			tabSEARCH()
		Case $tabidx = 2 ; NewSmartZap tab
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_STRATEGIES)
			GUISetState(@SW_HIDE, $g_hGUI_TRAINARMY)
			GUISetState(@SW_HIDE, $g_hGUI_SEARCH)
	EndSelect
EndFunc   ;==>tabAttack

Func tabSEARCH()
	Local $tabidx = GUICtrlRead($g_hGUI_SEARCH_TAB)
	Local $tabdbx = _GUICtrlTab_GetItemRect($g_hGUI_SEARCH_TAB, 0) ;get array of deadbase Tabitem rectangle coordinates, index 2,3 will be lower right X,Y coordinates (not needed: 0,1 = top left x,y)
	Local $tababx = _GUICtrlTab_GetItemRect($g_hGUI_SEARCH_TAB, 1) ;idem for activebase
	Local $tabtsx = _GUICtrlTab_GetItemRect($g_hGUI_SEARCH_TAB, 2) ;idem for thsnipe
	Local $tabblx = _GUICtrlTab_GetItemRect($g_hGUI_SEARCH_TAB, 3) ;idem for bully

	Select
		Case $tabidx = 0 ; Deadbase tab
			GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE)
			GUISetState(@SW_HIDE, $g_hGUI_THSNIPE)
			GUISetState(@SW_HIDE, $g_hGUI_BULLY)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACKOPTION)

			If GUICtrlRead($g_hChkDeadbase) = $GUI_CHECKED Then
				GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_DEADBASE)
				GUICtrlSetState($g_hLblDeadbaseDisabled, $GUI_HIDE)
			Else
				GUISetState(@SW_HIDE, $g_hGUI_DEADBASE)
				GUICtrlSetState($g_hLblDeadbaseDisabled, $GUI_SHOW)
			EndIf

			GUICtrlSetPos($g_hChkActivebase, $tababx[2] - 15, $tababx[3] - 15) ; use x,y coordinate of tabitem rectangle bottom right corner to dynamically reposition the checkbox control (for translated tabnames)
			GUICtrlSetPos($g_hChkTHSnipe, $tabtsx[2] - 15, $tabtsx[3] - 15)
			GUICtrlSetPos($g_hChkBully, $tabblx[2] - 15, $tabblx[3] - 15)

			GUICtrlSetPos($g_hChkDeadbase, $tabdbx[2] - 15, $tabdbx[3] - 17)
			tabDeadbase()
		Case $tabidx = 1 ; Activebase tab
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE)
			GUISetState(@SW_HIDE, $g_hGUI_THSNIPE)
			GUISetState(@SW_HIDE, $g_hGUI_BULLY)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACKOPTION)

			If GUICtrlRead($g_hChkActivebase) = $GUI_CHECKED Then
				GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_ACTIVEBASE)
				GUICtrlSetState($g_hLblActivebaseDisabled, $GUI_HIDE)
			Else
				GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE)
				GUICtrlSetState($g_hLblActivebaseDisabled, $GUI_SHOW)
			EndIf

			GUICtrlSetPos($g_hChkDeadbase, $tabdbx[2] - 15, $tabdbx[3] - 15)
			GUICtrlSetPos($g_hChkTHSnipe, $tabtsx[2] - 15, $tabtsx[3] - 15)
			GUICtrlSetPos($g_hChkBully, $tabblx[2] - 15, $tabblx[3] - 15)

			GUICtrlSetPos($g_hChkActivebase, $tababx[2] - 15, $tababx[3] - 17)
			tabActivebase()
		Case $tabidx = 2 ; THSnipe tab
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE)
			GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE)
			GUISetState(@SW_HIDE, $g_hGUI_BULLY)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACKOPTION)

			If GUICtrlRead($g_hChkTHSnipe) = $GUI_CHECKED Then
				GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_THSNIPE)
				GUICtrlSetState($g_hLblTHSnipeDisabled, $GUI_HIDE)
			Else
				GUISetState(@SW_HIDE, $g_hGUI_THSNIPE)
				GUICtrlSetState($g_hLblTHSnipeDisabled, $GUI_SHOW)
			EndIf

			GUICtrlSetPos($g_hChkDeadbase, $tabdbx[2] - 15, $tabdbx[3] - 15)
			GUICtrlSetPos($g_hChkActivebase, $tababx[2] - 15, $tababx[3] - 15)
			GUICtrlSetPos($g_hChkBully, $tabblx[2] - 15, $tabblx[3] - 15)

			GUICtrlSetPos($g_hChkTHSnipe, $tabtsx[2] - 15, $tabtsx[3] - 17)
			tabTHSnipe()
		Case $tabidx = 3 ; Bully tab
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE)
			GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE)
			GUISetState(@SW_HIDE, $g_hGUI_THSNIPE)
			GUISetState(@SW_HIDE, $g_hGUI_ATTACKOPTION)

			If GUICtrlRead($g_hChkBully) = $GUI_CHECKED Then
				GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_BULLY)
				GUICtrlSetState($g_hLblBullyDisabled, $GUI_HIDE)
			Else
				GUISetState(@SW_HIDE, $g_hGUI_BULLY)
				GUICtrlSetState($g_hLblBullyDisabled, $GUI_SHOW)
			EndIf

			GUICtrlSetPos($g_hChkDeadbase, $tabdbx[2] - 15, $tabdbx[3] - 15)
			GUICtrlSetPos($g_hChkActivebase, $tababx[2] - 15, $tababx[3] - 15)
			GUICtrlSetPos($g_hChkTHSnipe, $tabtsx[2] - 15, $tabtsx[3] - 15)

			GUICtrlSetPos($g_hChkBully, $tabblx[2] - 15, $tabblx[3] - 17)
			; Bully has no tabs
		Case $tabidx = 4 ; Options
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE)
			GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE)
			GUISetState(@SW_HIDE, $g_hGUI_THSNIPE)
			GUISetState(@SW_HIDE, $g_hGUI_BULLY)

			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_ATTACKOPTION)

			GUICtrlSetPos($g_hChkDeadbase, $tabdbx[2] - 15, $tabdbx[3] - 15)
			GUICtrlSetPos($g_hChkActivebase, $tababx[2] - 15, $tababx[3] - 15)
			GUICtrlSetPos($g_hChkTHSnipe, $tabtsx[2] - 15, $tabtsx[3] - 15)
			GUICtrlSetPos($g_hChkBully, $tabblx[2] - 15, $tabblx[3] - 15)
	EndSelect

EndFunc   ;==>tabSEARCH

Func tabDONATE()
	Local $tabidx = GUICtrlRead($g_hGUI_DONATE_TAB)
	Local $tabdonx = _GUICtrlTab_GetItemRect($g_hGUI_DONATE_TAB, 1)

	Select
		Case $tabidx = 0 ; RequestCC
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_RequestCC)
			GUISetState(@SW_HIDE, $g_hGUI_DONATECC)
			GUISetState(@SW_HIDE, $g_hGUI_ScheduleCC)
			GUICtrlSetPos($g_hChkDonate, $tabdonx[2] - 15, $tabdonx[3] - 15)

		Case $tabidx = 1 ; Donate CC
			GUISetState(@SW_HIDE, $g_hGUI_RequestCC)
			GUISetState(@SW_HIDE, $g_hGUI_ScheduleCC)
			If GUICtrlRead($g_hChkDonate) = $GUI_CHECKED Then
				GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_DONATECC)
				GUICtrlSetState($g_hLblDonateDisabled, $GUI_HIDE)
			Else
				GUISetState(@SW_HIDE, $g_hGUI_DONATECC)
				GUICtrlSetState($g_hLblDonateDisabled, $GUI_SHOW)
			EndIf
			GUICtrlSetPos($g_hChkDonate, $tabdonx[2] - 15, $tabdonx[3] - 15)

		Case $tabidx = 2 ; Schedule
			GUISetState(@SW_HIDE, $g_hGUI_RequestCC)
			GUISetState(@SW_HIDE, $g_hGUI_DONATECC)
			If GUICtrlRead($g_hChkDonate) = $GUI_CHECKED Then
				GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_ScheduleCC)
				GUICtrlSetState($g_hLblScheduleDisabled, $GUI_HIDE)
			Else
				GUISetState(@SW_HIDE, $g_hGUI_ScheduleCC)
				GUICtrlSetState($g_hLblScheduleDisabled, $GUI_SHOW)
			EndIf
			GUICtrlSetPos($g_hChkDonate, $tabdonx[2] - 15, $tabdonx[3] - 15)

	EndSelect

EndFunc   ;==>tabDONATE

Func tabBot()
	Local $tabidx = GUICtrlRead($g_hGUI_BOT_TAB)
	Select
		Case $tabidx = 0 ; Options tab
			GUISetState(@SW_HIDE, $g_hGUI_STATS)
			ControlShow("", "", $g_hCmbGUILanguage)
		Case $tabidx = 1 ; Debug tab
			GUISetState(@SW_HIDE, $g_hGUI_STATS)
			ControlHide("", "", $g_hCmbGUILanguage)
			;			Case $tabidx = 2 ; Profiles tab
			;				GUISetState(@SW_HIDE, $g_hGUI_STATS)
			;				ControlHide("","",$g_hCmbGUILanguage)
		Case $tabidx = 2 ; Android tab
			GUISetState(@SW_HIDE, $g_hGUI_STATS)
			ControlHide("", "", $g_hCmbGUILanguage)
		Case $tabidx = 3 ; Stats tab
			GUISetState(@SW_SHOWNOACTIVATE, $g_hGUI_STATS)
			ControlHide("", "", $g_hCmbGUILanguage)
	EndSelect
EndFunc   ;==>tabBot

Func tabDeadbase()
	Local $tabidx = GUICtrlRead($g_hGUI_DEADBASE_TAB)
	Select
		;			Case $tabidx = 0 ; Search tab

		Case $tabidx = 1 ; Attack tab
			cmbDBAlgorithm()

			;			Case $tabidx = 2 ; End Battle tab

		Case Else
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE_ATTACK_STANDARD)
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE_ATTACK_SCRIPTED)
			GUISetState(@SW_HIDE, $g_hGUI_DEADBASE_ATTACK_MILKING)
	EndSelect

EndFunc   ;==>tabDeadbase

Func tabActivebase()
	Local $tabidx = GUICtrlRead($g_hGUI_ACTIVEBASE_TAB)
	Select
		;			Case $tabidx = 0 ; Search tab

		Case $tabidx = 1 ; Attack tab
			cmbABAlgorithm()

			;			Case $tabidx = 2 ; End Battle tab

		Case Else
			GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE_ATTACK_STANDARD)
			GUISetState(@SW_HIDE, $g_hGUI_ACTIVEBASE_ATTACK_SCRIPTED)

	EndSelect

EndFunc   ;==>tabActivebase

Func tabTHSnipe()
	Local $tabidx = GUICtrlRead($g_hGUI_THSNIPE_TAB)
	Select
		;			Case $tabidx = 0 ; Search tab

		Case $tabidx = 1 ; Attack tab
			;				cmbTHAlgorithm()

			;			Case $tabidx = 2 ; End Battle tab

		Case Else

	EndSelect

EndFunc   ;==>tabTHSnipe

Func Doncheck()
	tabDONATE() ; just call tabDONATE()
EndFunc   ;==>Doncheck

Func dbCheck()
	$g_abAttackTypeEnable[$DB] = (GUICtrlRead($g_hChkDeadbase) = $GUI_CHECKED)

	If $g_iBotLaunchTime > 0 Then _GUICtrlTab_SetCurFocus($g_hGUI_SEARCH_TAB, 0) ; activate deadbase tab
	If BitAND(GUICtrlRead($g_hChkDBActivateSearches), GUICtrlRead($g_hChkDBActivateTropies), GUICtrlRead($g_hChkDBActivateCamps), GUICtrlRead($g_hChkDBSpellsWait)) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkDBActivateSearches, $GUI_CHECKED)
		chkDBActivateSearches() ; this includes a call to dbCheckall() -> tabSEARCH()
	Else
		tabSEARCH() ; just call tabSEARCH()
	EndIf
EndFunc   ;==>dbCheck

Func dbCheckAll()
	If BitAND(GUICtrlRead($g_hChkDBActivateSearches), GUICtrlRead($g_hChkDBActivateTropies), GUICtrlRead($g_hChkDBActivateCamps), GUICtrlRead($g_hChkDBSpellsWait)) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkDeadbase, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($g_hChkDeadbase, $GUI_CHECKED)
	EndIf
	tabSEARCH()
EndFunc   ;==>dbCheckAll

Func abCheck()
	$g_abAttackTypeEnable[$LB] = (GUICtrlRead($g_hChkActivebase) = $GUI_CHECKED)

	If $g_iBotLaunchTime > 0 Then _GUICtrlTab_SetCurFocus($g_hGUI_SEARCH_TAB, 1)
	If BitAND(GUICtrlRead($g_hChkABActivateSearches), GUICtrlRead($g_hChkABActivateTropies), GUICtrlRead($g_hChkABActivateCamps), GUICtrlRead($g_hChkABSpellsWait)) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkABActivateSearches, $GUI_CHECKED)
		chkABActivateSearches() ; this includes a call to abCheckall() -> tabSEARCH()
	Else
		tabSEARCH() ; just call tabSEARCH()
	EndIf
EndFunc   ;==>abCheck

Func abCheckAll()
	If BitAND(GUICtrlRead($g_hChkABActivateSearches), GUICtrlRead($g_hChkABActivateTropies), GUICtrlRead($g_hChkABActivateCamps), GUICtrlRead($g_hChkABSpellsWait)) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkActivebase, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($g_hChkActivebase, $GUI_CHECKED)
	EndIf
	tabSEARCH()
EndFunc   ;==>abCheckAll

Func tsCheck()
	$g_abAttackTypeEnable[$TS] = (GUICtrlRead($g_hChkTHSnipe) = $GUI_CHECKED)

	If $g_iBotLaunchTime > 0 Then _GUICtrlTab_SetCurFocus($g_hGUI_SEARCH_TAB, 2)
	If BitAND(GUICtrlRead($g_hChkTSActivateSearches), GUICtrlRead($g_hChkTSActivateTropies), GUICtrlRead($g_hChkTSActivateCamps)) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkTSActivateSearches, $GUI_CHECKED)
		chkTSActivateSearches() ; this includes a call to tsCheckall() -> tabSEARCH()
	Else
		tabSEARCH() ; just call tabSEARCH()
	EndIf
EndFunc   ;==>tsCheck

Func tsCheckAll()
	If BitAND(GUICtrlRead($g_hChkTSActivateSearches), GUICtrlRead($g_hChkTSActivateTropies), GUICtrlRead($g_hChkTSActivateCamps)) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_hChkTHSnipe, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($g_hChkTHSnipe, $GUI_CHECKED)
	EndIf
	tabSEARCH()
EndFunc   ;==>tsCheckAll

Func bullyCheck()
	$g_abAttackTypeEnable[$TB] = (GUICtrlRead($g_hChkBully) = $GUI_CHECKED)

	If $g_iBotLaunchTime > 0 Then _GUICtrlTab_SetCurFocus($g_hGUI_SEARCH_TAB, 3)
	tabSEARCH()
EndFunc   ;==>bullyCheck


;---------------------------------------------------
; Extra Functions used on GUI Control
;---------------------------------------------------

Func ImageList_Create()
	$hImageList = DllCall("comctl32.dll", "hwnd", "ImageList_Create", "int", 16, "int", 16, "int", 0x0021, "int", 0, "int", 1)
	$hImageList = $hImageList[0]
	Return $hImageList
EndFunc   ;==>ImageList_Create

Func Bind_ImageList($nCtrl)
	Local $aIconIndex = 0

	$hImageList = ImageList_Create()
	GUICtrlSendMsg($nCtrl, $TCM_SETIMAGELIST, 0, $hImageList)

	Local $tTcItem = DllStructCreate("uint;dword;dword;ptr;int;int;int")
	DllStructSetData($tTcItem, 1, 0x0002)
	Switch $nCtrl
		Case $g_hTabMain
			; the icons for main tab
			Local $aIconIndex[6] = [$eIcnHourGlass, $eIcnTH11, $eIcnAttack, $eIcnGUI, $eModIcon, $eIcnInfo]

		Case $g_hGUI_VILLAGE_TAB
			; the icons for village tab
			Local $aIconIndex[5] = [$eIcnTH1, $eIcnCC, $eIcnLaboratory, $eIcnAchievements, $eIcnPBNotify]

		Case $g_hGUI_TRAINARMY_TAB
			; the icons for army tab
			Local $aIconIndex[4] = [$eIcnTrain, $eIcnGem, $eIcnReOrder, $eIcnOptions]

		Case $g_hGUI_DONATE_TAB
			; the icons for donate tab
			Local $aIconIndex[3] = [$eIcnCCRequest, $eIcnCCDonate, $eIcnHourGlass]

		Case $g_hGUI_UPGRADE_TAB
			; the icons for upgrade tab
			Local $aIconIndex[4] = [$eIcnLaboratory, $eIcnHeroes, $eIcnMortar, $eIcnWall]

		Case $g_hGUI_NOTIFY_TAB
			; the icons for NOTIFY tab
			Local $aIconIndex[2] = [$eIcnPBNotify, $eIcnHourGlass]

		Case $g_hGUI_ATTACK_TAB
			; the icons for attack tab
			Local $aIconIndex[3] = [$eIcnTrain, $eIcnMagnifier, $eIcnStrategies]

		Case $g_hGUI_SEARCH_TAB
			; the icons for SEARCH tab
			Local $aIconIndex[5] = [$eIcnCollector, $eIcnCC, $eIcnTH10, $eIcnTH1, $eIcnOptions]

		Case $g_hGUI_DEADBASE_TAB
			; the icons for deadbase tab
			Local $aIconIndex[4] = [$eIcnMagnifier, $eIcnCamp, $eIcnSilverStar, $eIcnCollector]

		Case $g_hGUI_ACTIVEBASE_TAB
			; the icons for activebase tab
			Local $aIconIndex[3] = [$eIcnMagnifier, $eIcnCamp, $eIcnSilverStar]

		Case $g_hGUI_THSNIPE_TAB
			; the icons for thsnipe tab
			Local $aIconIndex[3] = [$eIcnMagnifier, $eIcnCamp, $eIcnSilverStar]

		Case $g_hGUI_ATTACKOPTION_TAB
			; the icons for Attack Options tab
			Local $aIconIndex[5] = [$eIcnMagnifier, $eIcnCamp, $eIcnLightSpell, $eIcnSilverStar, $eIcnTrophy]

		Case $g_hGUI_BOT_TAB
			; the icons for Bot tab
			Local $aIconIndex[4] = [$eIcnOptions, $eIcnAndroid, $eIcnBug, $eIcnStats]
			; The Android Robot is a Google Trademark and follows Creative Common Attribution 3.0

		Case $g_hGUI_STRATEGIES_TAB
			; the icons for strategies tab
			Local $aIconIndex[2] = [$eIcnReload, $eIcnCopy]

		Case $g_hGUI_STATS_TAB
			; the icons for stats tab
			Local $aIconIndex[4] = [$eIcnGoldElixir, $eIcnOptions, $eIcnCamp, $eIcnCCRequest]

		Case $g_hGUI_MOD_TAB
			; the icons for stats tab
			Local $aIconIndex[5] = [$eIcnInfo, $eIcnBrain, $eIcnOptions, $eIcnProfile, $eIcnMultiStat]

		Case Else
			;do nothing
	EndSwitch

	If IsArray($aIconIndex) Then ; if array is filled then $nCtrl was a valid control
		For $i = 0 To UBound($aIconIndex) - 1
			DllStructSetData($tTcItem, 6, $i)
			AddImageToTab($nCtrl, $i, $tTcItem, $g_sLibIconPath, $aIconIndex[$i] - 1)
		Next
		$aIconIndex = 0 ; empty array
	EndIf

	$tTcItem = 0 ; empty Stucture

EndFunc   ;==>Bind_ImageList

Func AddImageToTab($nCtrl, $nTabIndex, $nItem, $g_sLibIconPath, $nIconID)
	Local $hIcon = DllStructCreate("int")
	Local $Result = DllCall("shell32.dll", "int", "ExtractIconEx", "str", $g_sLibIconPath, "int", $nIconID, "hwnd", 0, "ptr", DllStructGetPtr($hIcon), "int", 1)
	$Result = $Result[0]
	If $Result > 0 Then
		DllCall("comctl32.dll", "int", "ImageList_AddIcon", "hwnd", $hImageList, "hwnd", DllStructGetData($hIcon, 1))
		DllCall("user32.dll", "int", "SendMessage", "hwnd", ControlGetHandle($g_hFrmBot, "", $nCtrl), "int", $TCM_SETITEM, "int", $nTabIndex, "ptr", DllStructGetPtr($nItem))
		DllCall("user32.dll", "int", "DestroyIcon", "hwnd", $hIcon)
	EndIf

	$hIcon = 0
EndFunc   ;==>AddImageToTab



Func _GUICtrlListView_SetItemHeightByFont($hListView, $iHeight)
	; Get font of ListView control
	; Copied from _GUICtrlGetFont example by KaFu
	; See https://www.autoitscript.com/forum/index.php?showtopic=124526
	Local $hDC = _WinAPI_GetDC($hListView), $hFont = _SendMessage($hListView, $WM_GETFONT)
	Local $hObject = _WinAPI_SelectObject($hDC, $hFont), $lvLOGFONT = DllStructCreate($tagLOGFONT)
	_WinAPI_GetObject($hFont, DllStructGetSize($lvLOGFONT), DllStructGetPtr($lvLOGFONT))
	Local $hLVfont = _WinAPI_CreateFontIndirect($lvLOGFONT) ; Original ListView font
	_WinAPI_SelectObject($hDC, $hObject)
	_WinAPI_ReleaseDC($hListView, $hDC)
	_WinAPI_DeleteObject($hFont)

	; Set height of ListView items by applying text font with suitable height
	$hFont = _WinAPI_CreateFont($iHeight, 0)
	_WinAPI_SetFont($hListView, $hFont)
	_WinAPI_DeleteObject($hFont)

	; Restore font of Header control
	Local $hHeader = _GUICtrlListView_GetHeader($hListView)
	If $hHeader Then _WinAPI_SetFont($hHeader, $hLVfont)

	; release memory
	$lvLOGFONT = 0

	; Return original ListView font
	Return $hLVfont
EndFunc   ;==>_GUICtrlListView_SetItemHeightByFont

Func _GUICtrlListView_GetHeightToFitRows($hListView, $iRows)
	; Get height of Header control
	Local $tRECT = _WinAPI_GetClientRect($hListView)
	Local $hHeader = _GUICtrlListView_GetHeader($hListView)
	Local $tWindowPos = _GUICtrlHeader_Layout($hHeader, $tRECT)
	Local $iHdrHeight = DllStructGetData($tWindowPos, "CY")
	; Get height of ListView item 0 (item 0 must exist)
	Local $aItemRect = _GUICtrlListView_GetItemRect($hListView, 0, 0)
	; Return height of ListView to fit $iRows items
	; Including Header height and 8 pixels of additional room
	Return ($aItemRect[3] - $aItemRect[1]) * $iRows + $iHdrHeight + 8
EndFunc   ;==>_GUICtrlListView_GetHeightToFitRows

Func EnableControls($hWin, $Enable, ByRef $avArr, $bGUIControl_Disabled = True, $i = 0)
	Local $initalCall = $i = 0
	If UBound($avArr, 0) <> 2 Then
		Local $avTmp[1][2] = [[0]]
		$avArr = $avTmp
	EndIf
	If $initalCall And $bGUIControl_Disabled Then
		_SendMessage($hWin, $WM_SETREDRAW, False, 0)
		Local $GUIControl_Disabled_ = $GUIControl_Disabled
		$GUIControl_Disabled = True
	EndIf
	Local $hChild = _WinAPI_GetWindow($hWin, $GW_CHILD)
	While $hChild
		$i += 1
		If $avArr[0][0] + 1 > UBound($avArr, 1) - 1 Then
			ReDim $avArr[$avArr[0][0] + 2][2]
			$avArr[$avArr[0][0] + 1][0] = $hChild
			$avArr[$avArr[0][0] + 1][1] = BitAND(WinGetState($hChild), 4) > 0
		EndIf
		If $Enable = Default Then
			WinSetState($hChild, "", ($avArr[$i][1] = True ? @SW_ENABLE : @SW_DISABLE))
		Else
			WinSetState($hChild, "", ($Enable ? @SW_ENABLE : @SW_DISABLE))
		EndIf
		$avArr[0][0] += 1
		$i = EnableControls($hChild, $Enable, $avArr, $bGUIControl_Disabled, $i)
		$hChild = _WinAPI_GetWindow($hChild, $GW_HWNDNEXT)
	WEnd

	If $initalCall And $Enable = Default Then $avArr = 0

	If $initalCall And $bGUIControl_Disabled Then
		_SendMessage($hWin, $WM_SETREDRAW, True, 0)
		_WinAPI_RedrawWindow($hWin, 0, 0, BitOR($RDW_INVALIDATE, $RDW_ALLCHILDREN))
		$GUIControl_Disabled = $GUIControl_Disabled_
	EndIf

	Return $i
EndFunc   ;==>EnableControls

Func frmBot_WNDPROC($hWin, $iMsg, $wParam, $lParam)
	Local $wasCritical = SetCriticalMessageProcessing(True)
	If $g_iDebugWindowMessages > 0 Then SetDebugLog("frmBot_WNDPROC: FORWARD $hWin=" & $hWin & ", $iMsg=" & Hex($iMsg) & ", $wParam=" & Hex($wParam) & ", $lParam=" & $lParam, Default, True)

	Switch $iMsg
		#cs
			Case $WM_NCACTIVATE
			GUIControl_WM_NCACTIVATE($hWin, $iMsg, $wParam, $lParam)
			Case $WM_SETFOCUS, $WM_KILLFOCUS
			GUIControl_WM_FOCUS($hWin, $iMsg, $wParam, $lParam)
			Case $WM_MOVE
			GUIControl_WM_MOVE($hWin, $iMsg, $wParam, $lParam)
		#ce
		Case $WM_KEYDOWN, $WM_KEYUP, $WM_SYSKEYDOWN, $WM_SYSKEYUP, $WM_MOUSEWHEEL, $WM_MOUSEHWHEEL
			GUIControl_AndroidEmbedded($hWin, $iMsg, $wParam, $lParam)
	EndSwitch

	Local $wndproc = $g_hFrmBot_WNDPROC
	Local $Return = 1
	If $wndproc <> 0 Then
		_WinAPI_CallWindowProc($wndproc, $hWin, $iMsg, $wParam, $lParam)
		$Return = 0
	EndIf
	SetCriticalMessageProcessing($wasCritical)
	Return $Return
EndFunc   ;==>frmBot_WNDPROC

Func HandleWndProc($Enable = True)
	If $g_hFrmBot_WNDPROC = 0 And $Enable = True Then
		$g_hFrmBot_WNDPROC = _WinAPI_SetWindowLong(ControlGetHandle($g_hFrmBot, "", $g_hFrmBotEmbeddedShieldInput), $GWL_WNDPROC, $g_hFrmBot_WNDPROC_ptr)
	ElseIf $g_hFrmBot_WNDPROC <> 0 And $Enable = False Then
		_WinAPI_SetWindowLong(ControlGetHandle($g_hFrmBot, "", $g_hFrmBotEmbeddedShieldInput), $GWL_WNDPROC, $g_hFrmBot_WNDPROC)
		$g_hFrmBot_WNDPROC = 0
	EndIf
EndFunc   ;==>HandleWndProc

Func IsGUICtrlHidden($hGUICtrl)
	If BitAND(WinGetState(GUICtrlGetHandle($hGUICtrl), ""), 2) = 0 Then Return True
	Return False
EndFunc   ;==>IsGUICtrlHidden
