
; #FUNCTION# ====================================================================================================================
; Name ..........: TrainClick
; Description ...: Clicks in troop training window with special checks for Barracks Full, and If not enough elxir to train troops or to close the gem window if opened.
; Syntax ........: TrainClick($x, $y, $iTimes, $iSpeed, $aWatchSpot, $aLootSpot, $debugtxt = "")
; Parameters ....: $x                   - X location to click
;                  $y                   - Y location to click
;                  $iTimes              - Number fo times to cliok
;                  $iSpeed              - Wait time after click
;                  $aWatchSpot          - [in/out] an array of [X location, Y location, Hex Color, Tolerance] to check after click if full
;                  $aLootSpot           - [in/out] an array of [X location, Y location, Hex Color, Tolerance] to check after click, color used to see if out of Elixir for more troops
;						 $sdebugtxt				 - String with click debug text
; Return values .: None
; Author ........: KnowJack (July 2015)
; Modified ......: Sardo 2015-08, Boju 2016-06
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func TrainClick($x, $y, $iTimes, $iSpeed, $aWatchSpot, $sdebugtxt, $TypeTroops)

	If $debugsetlogTrain = 1 Then SetLog("TrainClick " & $x & "," & $y & "," & $iTimes)

	If IsTrainPage() Then
		If $debugClick = 1 Then
			Local $txt = _DecodeDebug($sdebugtxt)
			SetLog("TrainClick " & $x & "," & $y & "," & $iTimes & "," & $iSpeed & " " & $sdebugtxt & $txt, $COLOR_ACTION, "Verdana", "7.5", 0)
		EndIf

		If $iTimes <> 1 Then
			If FastCaptureRegion() = True Then
				If $debugsetlogTrain = 1 Then SetLog("TrainClick FastCaptureRegion")
				For $i = 0 To ($iTimes - 1)
					If isProblemAffect(True) Then checkMainScreen(False) ; Check for BS/CoC errors
					Local $sLogText = Default
					If $debugsetlogTrain = 1 Then $sLogText = "TrainClick " & $x & "," & $y & "," & $iTimes
					If _CheckPixel($aWatchSpot, True, Default, $sLogText) = True Then ; Check to see if barrack full
						If $debugsetlogTrain Then SetLog("Camp is FULL after " & $i & " clicks", $COLOR_DEBUG)
						ExitLoop
					EndIf
					If $iUseRandomClick = 0 Then
						PureClick($x, $y) ;Click once.
					Else
						PureClickR($TypeTroops, $x, $y) ;Click once.
					EndIf
					If _Sleep($iSpeed, False) Then ExitLoop
				Next
			Else
				If isProblemAffect(True) Then checkMainScreen(False) ; Check for BS/CoC errors
				Local $sLogText = Default
				If $debugsetlogTrain = 1 Then $sLogText = "TrainClick " & $x & "," & $y & "," & $iTimes
				If _CheckPixel($aWatchSpot, True, Default, $sLogText) = True Then ; Check to see if barrack full
					If $debugsetlogTrain Then SetLog("Camp is FULL", $COLOR_DEBUG)
					Return ; Check to see if barrack full
				EndIf
				If $iUseRandomClick = 0 Then
					PureClick($x, $y, $iTimes, $iSpeed) ;Click $iTimes.
				Else
					PureClickR($TypeTroops, $x, $y, $iTimes, $iSpeed) ;Click $iTimes.
				EndIf
				If _Sleep($iSpeed, False) Then Return
			EndIf
		Else
			Local $sLogText = Default
			If $debugsetlogTrain = 1 Then $sLogText = "TrainClick " & $x & "," & $y & "," & $iTimes
			If isProblemAffect(True) Then checkMainScreen(False) ; Check for BS/CoC errors
			If $debugsetlogTrain = 1 Then SetLog("Full Check=" & _GetPixelColor($aWatchSpot[0], $aWatchSpot[1], False), $COLOR_DEBUG)
			If _CheckPixel($aWatchSpot, True, Default, $sLogText) = True Then
				If $debugsetlogTrain Then SetLog("Camp is FULL", $COLOR_DEBUG)
				Return ; Check to see if barrack full
			EndIf

			If $iUseRandomClick = 0 Then
				PureClick($x, $y)
			Else
				PureClickR($TypeTroops, $x, $y)
			EndIf

			If _Sleep($iSpeed, False) Then Return
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>TrainClick

Func TrainClickP($point, $howMany, $speed, $aWatchSpot, $debugtxt, $TypeTroops)
	Return TrainClick($point[0], $point[1], $howMany, $speed, $aWatchSpot, $debugtxt, $TypeTroops)
EndFunc   ;==>TrainClickP
