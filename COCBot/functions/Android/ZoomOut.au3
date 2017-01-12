; #FUNCTION# ====================================================================================================================
; Name ..........: ZoomOut
; Description ...: Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.
; Syntax ........: ZoomOut()
; Parameters ....:
; Return values .: None
; Author ........: Code Gorilla #94
; Modified ......: KnowJack (July 2015) stop endless loop
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ZoomOut() ;Zooms out
	$SearchZoomOutCounter[0] = 0
	$SearchZoomOutCounter[1] = 1
    ResumeAndroid()
    WinGetAndroidHandle()
	getBSPos() ; Update $HWnd and Android Window Positions
	If Not $RunState Then Return
	Local $Result
	If $AndroidEmbedded = False Or $AndroidEmbedMode = 1 Then
		; default zoomout
		$Result = Execute("ZoomOut" & $Android & "()")
		If $Result = "" And @error <> 0 Then
			; Not implemented or other error
			$Result = AndroidOnlyZoomOut()
		EndIf
		$SkipFirstZoomout = True
		Return $Result
	EndIf

	; Android embedded, only use Android zoomout
	AndroidOnlyZoomOut()
	$SkipFirstZoomout = True
EndFunc   ;==>ZoomOut

Func ZoomOutBlueStacks() ;Zooms out
	; ctrl click is best and most stable for BlueStacks
	Return ZoomOutCtrlClick(False, False, False, False)
   ;Return DefaultZoomOut("{DOWN}", 0)
   ; ZoomOutCtrlClick doesn't cause moving buildings, but uses global Ctrl-Key and has taking focus problems
   ;Return ZoomOutCtrlClick(True, False, False, False)
EndFunc

Func ZoomOutBlueStacks2()
	If $__BlueStacks2Version_2_5_or_later = False Then
		; ctrl click is best and most stable for BlueStacks, but not working after 2.5.55.6279 version
		Return ZoomOutCtrlClick(False, False, False, False)
	Else
		; newer BlueStacks versions don't work with Ctrl-Click, so fall back to original arraw key
		Return DefaultZoomOut("{DOWN}", 0)
	EndIf
   ;Return DefaultZoomOut("{DOWN}", 0)
   ; ZoomOutCtrlClick doesn't cause moving buildings, but uses global Ctrl-Key and has taking focus problems
   ;Return ZoomOutCtrlClick(True, False, False, False)
EndFunc

Func ZoomOutMEmu()
   ;ClickP($aAway) ; activate window first with Click Away (when not clicked zoom might not work)
   Return DefaultZoomOut("{F3}", 0)
EndFunc

#cs
Func ZoomOutLeapDroid()
	Return ZoomOutCtrlWheelScroll(True, True, True, False)
EndFunc

Func ZoomOutKOPLAYER()
   Return ZoomOutCtrlWheelScroll(False, False, False, True, -70, 15)
EndFunc
#ce

Func ZoomOutDroid4X()
   Return ZoomOutCtrlWheelScroll(True, True, True)
EndFunc

Func ZoomOutNox()
   Return ZoomOutCtrlWheelScroll(True, True, True)
   ;Return DefaultZoomOut("{CTRLDOWN}{DOWN}{CTRLUP}", 0)
EndFunc

Func DefaultZoomOut($ZoomOutKey = "{DOWN}", $tryCtrlWheelScrollAfterCycles = 40, $AndroidZoomOut = True) ;Zooms out
	Local $result0, $result1, $i = 0
	Local $exitCount = 80
	Local $delayCount = 20
	ForceCaptureRegion()
	Local $aPicture = SearchZoomOut()

	If StringInStr($aPicture[0], "zoomou") = 0 Then
		SetLog("Zooming Out", $COLOR_BLUE)
		If _Sleep($iDelayZoomOut1) Then Return
		If $AndroidZoomOut = True Then
			AndroidZoomOut(False) ; use new ADB zoom-out
			ForceCaptureRegion()
			$aPicture = SearchZoomOut()
		EndIf
	    Local $tryCtrlWheelScroll = False
		While StringInStr($aPicture[0], "zoomou") = 0 and Not $tryCtrlWheelScroll

			AndroidShield("DefaultZoomOut") ; Update shield status
			If $AndroidZoomOut = True Then
			   AndroidZoomOut(False, $i) ; use new ADB zoom-out
			   If @error <> 0 Then $AndroidZoomOut = False
			EndIf
			If $AndroidZoomOut = False Then
			   ; original windows based zoom-out
			   If $debugsetlog = 1 Then Setlog("Index = "&$i, $COLOR_DEBUG) ; Index=2X loop count if success, will be increment by 1 if controlsend fail
			   If _Sleep($iDelayZoomOut2) Then Return
			   If $ichkBackground = 0 And $NoFocusTampering = False Then
				  $Result0 = ControlFocus($HWnD, "", "")
			   Else
				  $Result0 = 1
			   EndIf
			   $Result1 = ControlSend($HWnD, "", "", $ZoomOutKey)
			   If $debugsetlog = 1 Then Setlog("ControlFocus Result = "&$Result0 & ", ControlSend Result = "&$Result1& "|" & "@error= " & @error, $COLOR_DEBUG)
			   If $Result1 = 1 Then
				   $i += 1
			   Else
				   Setlog("Warning ControlSend $Result = "&$Result1, $COLOR_DEBUG)
			   EndIf
			EndIF

			If $i > $delayCount Then
				If _Sleep($iDelayZoomOut3) Then Return
			EndIf
			If $tryCtrlWheelScrollAfterCycles > 0 And $i > $tryCtrlWheelScrollAfterCycles Then $tryCtrlWheelScroll = True
			If $i > $exitCount Then Return
			If $RunState = False Then ExitLoop
			If IsProblemAffect(True) Then  ; added to catch errors during Zoomout
				Setlog($Android & " Error window detected", $COLOR_ERROR)
				If checkObstacles() = True Then Setlog("Error window cleared, continue Zoom out", $COLOR_INFO)  ; call to clear normal errors
			EndIf
			$i += 1  ; add one to index value to prevent endless loop if controlsend fails
			ForceCaptureRegion()
			$aPicture = SearchZoomOut()
		WEnd
		If $tryCtrlWheelScroll Then
		    Setlog($Android & " zoom-out with key " & $ZoomOutKey & " didn't work, try now Ctrl+MouseWheel...", $COLOR_INFO)
			Return ZoomOutCtrlWheelScroll(False, False, False, False)
	    EndIf
		Return True
	EndIf
	Return False
EndFunc   ;==>ZoomOut

;Func ZoomOutCtrlWheelScroll($CenterMouseWhileZooming = True, $GlobalMouseWheel = True, $AlwaysControlFocus = False, $AndroidZoomOut = True, $WheelRotation = -5, $WheelRotationCount = 1)
Func ZoomOutCtrlWheelScroll($CenterMouseWhileZooming = True, $GlobalMouseWheel = True, $AlwaysControlFocus = False, $AndroidZoomOut = True, $hWin = Default, $ScrollSteps = -5, $ClickDelay = 250)
   ;AutoItSetOption ( "SendKeyDownDelay", 3000)
	Local $exitCount = 80
	Local $delayCount = 20
	Local $result[4], $i = 0, $j
	Local $ZoomActions[4] = ["ControlFocus", "Ctrl Down", "Mouse Wheel Scroll Down", "Ctrl Up"]
	If $hWin = Default Then $hWin = ($AndroidEmbedded = False ? $HWnD : $AndroidEmbeddedCtrlTarget[1])
	ForceCaptureRegion()
	Local $aPicture = SearchZoomOut()

	If StringInStr($aPicture[0], "zoomou") = 0 Then

	    SetLog("Zooming Out", $COLOR_BLUE)

		AndroidShield("ZoomOutCtrlWheelScroll") ; Update shield status
		If _Sleep($iDelayZoomOut1) Then Return
		If $AndroidZoomOut = True Then
			AndroidZoomOut(False) ; use new ADB zoom-out
			ForceCaptureRegion()
			$aPicture = SearchZoomOut()
		EndIf
		Local $aMousePos = MouseGetPos()

		While StringInStr($aPicture[0], "zoomou") = 0

			If $AndroidZoomOut = True Then
			   AndroidZoomOut(False, $i) ; use new ADB zoom-out
			   If @error <> 0 Then $AndroidZoomOut = False
			EndIf
			If $AndroidZoomOut = False Then
			   ; original windows based zoom-out
			   If $debugsetlog = 1 Then Setlog("Index = " & $i, $COLOR_DEBUG) ; Index=2X loop count if success, will be increment by 1 if controlsend fail
			   If _Sleep($iDelayZoomOut2) Then ExitLoop
			   If ($ichkBackground = 0 And $NoFocusTampering = False) Or $AlwaysControlFocus Then
				  $Result[0] = ControlFocus($hWin, "", "")
			   Else
				  $Result[0] = 1
			   EndIf

			   $Result[1] = ControlSend($hWin, "", "", "{CTRLDOWN}")
			   If $CenterMouseWhileZooming Then MouseMove($BSpos[0] + Int($DEFAULT_WIDTH / 2), $BSpos[1] + Int($DEFAULT_HEIGHT / 2), 0)
			   If $GlobalMouseWheel Then
                  $Result[2] = MouseWheel(($ScrollSteps < 0 ? "down" : "up"), Abs($ScrollSteps)) ; can't find $MOUSE_WHEEL_DOWN constant, couldn't include AutoItConstants.au3 either
			   Else
				  Local $WM_WHEELMOUSE = 0x020A, $MK_CONTROL = 0x0008
				  ;Local $wParam = BitOR(BitShift($WheelRotation, -16), BitAND($MK_CONTROL, 0xFFFF)) ; HiWord = -120 WheelScrollDown, LoWord = $MK_CONTROL
				  Local $wParam = BitOR($ScrollSteps * 0x10000, BitAND($MK_CONTROL, 0xFFFF)) ; HiWord = -120 WheelScrollDown, LoWord = $MK_CONTROL
				  Local $lParam =  BitOR(($BSpos[1] + Int($DEFAULT_HEIGHT / 2)) * 0x10000, BitAND(($BSpos[0] + Int($DEFAULT_WIDTH / 2)), 0xFFFF)) ; ; HiWord = y-coordinate, LoWord = x-coordinate
				  ;For $k = 1 To $WheelRotationCount
					 _WinAPI_PostMessage($hWin, $WM_WHEELMOUSE, $wParam, $lParam)
				  ;Next
				  $Result[2] = (@error = 0 ? 1 : 0)
			   EndIf
			   If _Sleep($ClickDelay) Then ExitLoop
			   $Result[3] = ControlSend($hWin, "", "", "{CTRLUP}{SPACE}")

			   If $debugsetlog = 1 Then Setlog("ControlFocus Result = " & $Result[0] & _
					  ", " & $ZoomActions[1] & " = " & $Result[1] & _
					  ", " & $ZoomActions[2] & " = " & $Result[2] & _
					  ", " & $ZoomActions[3] & " = " & $Result[3] & _
					  " | " & "@error= " & @error, $COLOR_DEBUG)
			   For $j = 1 To 3
				  If $Result[$j] = 1 Then
					  $i += 1
					  ExitLoop
				  EndIf
			   Next
			   For $j = 1 To 3
				  If $Result[$j] = 0 Then
					  Setlog("Warning " & $ZoomActions[$j] & " = " & $Result[1], $COLOR_DEBUG)
				  EndIf
			   Next
			EndIf

			If $i > $delayCount Then
				If _Sleep($iDelayZoomOut3) Then ExitLoop
			EndIf
			If $i > $exitCount Then ExitLoop
			If $RunState = False Then ExitLoop
			If IsProblemAffect(True) Then  ; added to catch errors during Zoomout
				Setlog($Android & " Error window detected", $COLOR_ERROR)
				If checkObstacles() = True Then Setlog("Error window cleared, continue Zoom out", $COLOR_INFO)  ; call to clear normal errors
			EndIf
			$i += 1  ; add one to index value to prevent endless loop if controlsend fails
			ForceCaptureRegion()
			$aPicture = SearchZoomOut()
		 WEnd

		 If $CenterMouseWhileZooming And $AndroidZoomOut = False Then MouseMove($aMousePos[0], $aMousePos[1], 0)
		Return True

	EndIf
	Return False
 EndFunc

Func ZoomOutCtrlClick($ZoomOutOverWaters = False, $CenterMouseWhileZooming = False, $AlwaysControlFocus = False, $AndroidZoomOut = True, $ClickDelay = 250)
   ;AutoItSetOption ( "SendKeyDownDelay", 3000)
	Local $exitCount = 80
	Local $delayCount = 20
	Local $result[4], $i, $j
	Local $SendCtrlUp = False
	Local $ZoomActions[4] = ["ControlFocus", "Ctrl Down", "Click", "Ctrl Up"]
	ForceCaptureRegion()
	Local $aPicture = SearchZoomOut()

	If StringInStr($aPicture[0], "zoomou") = 0 Then

	    SetLog("Zooming Out", $COLOR_INFO)

		AndroidShield("ZoomOutCtrlClick") ; Update shield status

		If $ZoomOutOverWaters = True Then
			; zoom out over waters
			If $AndroidZoomOut = True Then
				AndroidZoomOut(False) ; use new ADB zoom-out
				ForceCaptureRegion()
				$aPicture = SearchZoomOut()
			Else
				For $i = 1 To 3
				   ; scroll to waters
				   _PostMessage_ClickDrag(100, 600, 600, 100, "left")
				Next
			EndIf
		EndIf

		If _Sleep($iDelayZoomOut1) Then Return
		Local $aMousePos = MouseGetPos()

		$i = 0
		While StringInStr($aPicture[0], "zoomou") = 0

			If $AndroidZoomOut = True Then
			   AndroidZoomOut(False, $i) ; use new ADB zoom-out
			   If @error <> 0 Then $AndroidZoomOut = False
			EndIf
			If $AndroidZoomOut = False Then
			   ; original windows based zoom-out
			   If $debugsetlog = 1 Then Setlog("Index = " & $i, $COLOR_DEBUG) ; Index=2X loop count if success, will be increment by 1 if controlsend fail
			   If _Sleep($iDelayZoomOut2) Then ExitLoop
			   If ($ichkBackground = 0 And $NoFocusTampering = False) Or $AlwaysControlFocus Then
				  $Result[0] = ControlFocus($HWnD, "", "")
			   Else
				  $Result[0] = 1
			   EndIf

			   $Result[1] = ControlSend($HWnD, "", "", "{CTRLDOWN}")
			   $SendCtrlUp = True
			   If $CenterMouseWhileZooming Then MouseMove($BSpos[0] + Int($DEFAULT_WIDTH / 2), $BSpos[1] + Int($DEFAULT_HEIGHT / 2), 0)
			   $Result[2] = _ControlClick(Int($DEFAULT_WIDTH / 2), 600)
			   If _Sleep($ClickDelay) Then ExitLoop
			   $Result[3] = ControlSend($HWnD, "", "", "{CTRLUP}{SPACE}")
			   $SendCtrlUp = False

			   If $debugsetlog = 1 Then Setlog("ControlFocus Result = " & $Result[0] & _
					  ", " & $ZoomActions[1] & " = " & $Result[1] & _
					  ", " & $ZoomActions[2] & " = " & $Result[2] & _
					  ", " & $ZoomActions[3] & " = " & $Result[3] & _
					  " | " & "@error= " & @error, $COLOR_DEBUG)
			   For $j = 1 To 3
				  If $Result[$j] = 1 Then
					  ExitLoop
				  EndIf
			   Next
			   For $j = 1 To 3
				  If $Result[$j] = 0 Then
					  Setlog("Warning " & $ZoomActions[$j] & " = " & $Result[1], $COLOR_DEBUG)
				  EndIf
			   Next
			EndIf

			If $i > $delayCount Then
				If _Sleep($iDelayZoomOut3) Then ExitLoop
			EndIf
			If $i > $exitCount Then ExitLoop
			If $RunState = False Then ExitLoop
			If IsProblemAffect(True) Then  ; added to catch errors during Zoomout
				Setlog($Android & " Error window detected", $COLOR_RED)
				If checkObstacles() = True Then Setlog("Error window cleared, continue Zoom out", $COLOR_BLUE)  ; call to clear normal errors
			EndIf
			$i += 1  ; add one to index value to prevent endless loop if controlsend fails
			ForceCaptureRegion()
			$aPicture = SearchZoomOut()
		 WEnd

		 If $SendCtrlUp Then ControlSend($HWnD, "", "", "{CTRLUP}{SPACE}")

		 If $CenterMouseWhileZooming Then MouseMove($aMousePos[0], $aMousePos[1], 0)

		Return True
	EndIf
	Return False
 EndFunc

Func AndroidOnlyZoomOut() ;Zooms out
	Local $i = 0
	Local $exitCount = 80
	ForceCaptureRegion()
	Local $aPicture = SearchZoomOut()

	If StringInStr($aPicture[0], "zoomou") = 0 Then

		SetLog("Zooming Out", $COLOR_BLUE)
		AndroidZoomOut(False) ; use new ADB zoom-out
		ForceCaptureRegion()
		$aPicture = SearchZoomOut()
		While StringInStr($aPicture[0], "zoomou") = 0

			AndroidShield("AndroidOnlyZoomOut") ; Update shield status
			AndroidZoomOut(False, $i) ; use new ADB zoom-out
			If $i > $exitCount Then Return
			If $RunState = False Then ExitLoop
			If IsProblemAffect(True) Then  ; added to catch errors during Zoomout
				Setlog($Android & " Error window detected", $COLOR_ERROR)
				If checkObstacles() = True Then Setlog("Error window cleared, continue Zoom out", $COLOR_INFO)  ; call to clear normal errors
			EndIf
			$i += 1  ; add one to index value to prevent endless loop if controlsend fails
			ForceCaptureRegion()
			$aPicture = SearchZoomOut()
		WEnd
		Return True
	EndIf
	Return False
EndFunc   ;==>AndroidOnlyZoomOut

; SearchZoomOut returns always an Array.
; If village can be measured and villages size < 500 pixel then it returns in idx 0 a String starting with "zoomout:" and tries to center base
; Return Array:
; 0 = Empty string if village cannot be measured (e.g. window blocks village or not zoomed out)
; 1 = Current Village X Offset (after centering village)
; 2 = Current Village Y Offset (after centering village)
; 3 = Difference of previous Village X Offset and current (after centering village)
; 4 = Difference of previous Village Y Offset and current (after centering village)
Func SearchZoomOut($CenterVillageBoolOrScrollPos = $aCenterHomeVillageClickDrag, $UpdateMyVillage = True, $sSource = "", $CaptureRegion = True, $DebugLog = True)
	If $sSource <> "" Then $sSource = " (" & $sSource & ")"
	Local $bCenterVillage = $CenterVillageBoolOrScrollPos
	If $bCenterVillage = Default Or $debugDisableVillageCentering = 1 Then $bCenterVillage = ($debugDisableVillageCentering = 0)
	Local $aScrollPos[2] = [0, 0]
	If UBound($CenterVillageBoolOrScrollPos) >= 2 Then
		$aScrollPos[0] = $CenterVillageBoolOrScrollPos[0]
		$aScrollPos[1] = $CenterVillageBoolOrScrollPos[1]
		$bCenterVillage = ($debugDisableVillageCentering = 0)
	EndIf
	; Setup arrays, including default return values for $return
	Local $x, $y, $z, $stone[2]
	Local $villageSize = 0

	If $CaptureRegion = True Then _CaptureRegion2()

	Local $aResult = ["", 0, 0, 0, 0] ; expected dummy value

	Local $village = GetVillageSize($DebugLog)

	If $SearchZoomOutCounter[0] > 0 Then
		If _Sleep(1000) Then Return $aResult
	EndIf

	If IsArray($village) = 1 Then
		$villageSize = $village[0]
		If $villageSize < 500 Or $debugDisableZoomout = 1 Then
			$z = $village[1]
			$x = $village[2]
			$y = $village[3]
			$stone[0] = $village[4]
			$stone[1] = $village[5]
			$aResult[0] = "zoomout:" & $village[6]
			$aResult[1] = $x
			$aResult[2] = $y

			If $bCenterVillage = True And ($x <> 0 Or $y <> 0) And ($UpdateMyVillage = False Or $x <> $VILLAGE_OFFSET[0] Or $y <> $VILLAGE_OFFSET[1]) Then
				If $DebugLog Then SetDebugLog("Center Village" & $sSource & " by: " & $x & ", " & $y)
				If $aScrollPos[0] = 0 And $aScrollPos[1] = 0 Then
					$aScrollPos[0] = $stone[0]
					$aScrollPos[1] = $stone[1]
				EndIf
				ClickDrag($aScrollPos[0], $aScrollPos[1], $aScrollPos[0] - $x, $aScrollPos[1] - $y)
				If _Sleep(250) Then Return $aResult
				Local $aResult2 = SearchZoomOut(False, $UpdateMyVillage)
				; update difference in offset
				$aResult2[3] = $aResult2[1] - $aResult[1]
				$aResult2[4] = $aResult2[2] - $aResult[2]
				If $DebugLog Then SetDebugLog("Centered Village Offset" & $sSource & ": " & $aResult2[1] & ", " & $aResult2[2] & ", change: " & $aResult2[3] & ", " & $aResult2[4])
				Return $aResult2
			EndIf

			If $UpdateMyVillage = True Then
				If $x <> $VILLAGE_OFFSET[0] Or $y <> $VILLAGE_OFFSET[1] Or $z <> $VILLAGE_OFFSET[2] Then
					If $DebugLog Then SetDebugLog("Village Offset" & $sSource & " updated to " & $x & ", " & $y & ", " & $z)
				EndIf
				setVillageOffset($x, $y, $z)
				ConvertInternalExternArea() ; generate correct internal/external diamond measures
			EndIf
		EndIf
	EndIf

	If $UpdateMyVillage = True Then
		If $aResult[0] = "" Then
			If $SearchZoomOutCounter[0] > 20 Then
				$SearchZoomOutCounter[0] = 0
				;CloseCoC(True)
				SetLog("Restart CoC to reset zoom" & $sSource & "...", $COLOR_INFO)
				PoliteCloseCoC("Zoomout" & $sSource)
				If _Sleep(1000) Then Return $aResult
				CloseCoC() ; ensure CoC is gone
				OpenCoC()
				Return SearchZoomOut()
			Else
				$SearchZoomOutCounter[0] += 1
			EndIf
		Else
			If $debugDisableZoomout = 0 And $villageSize > 480 Then
				If $SkipFirstZoomout = False Then
					; force additional zoom-out
					$aResult[0] = ""
				ElseIf $SearchZoomOutCounter[1] > 0 And $SearchZoomOutCounter[0] > 0  Then
					; force additional zoom-out
					$SearchZoomOutCounter[1] -= 1
					$aResult[0] = ""
				EndIf
			EndIf
		EndIf
		$SkipFirstZoomout = True
	EndIf

	Return $aResult
EndFunc   ;==>SearchZoomOut