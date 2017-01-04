; #FUNCTION# ====================================================================================================================
; Name ..........: LocateBarrack
; Description ...:
; Syntax ........: LocateBarrack([$ArmyCamp = False])
; Parameters ....: $ArmyCamp            - [optional] Flag to set if locating army camp and not barrack Default is False.
; Return values .: None
; Author ........: Code Monkey #19
; Modified ......: KnowJack (June 2015) Sardo 2015-08
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func LocateBarrack($ArmyCamp = False)
	Local $choice = GetTranslated(640,23,"Barrack")
	Local $stext, $MsgBox, $iCount, $iStupid = 0, $iSilly = 0, $sErrorText = "", $sLocMsg = "", $sInfo, $sArmyInfo
	Local $aGetArmySize[3] = ["", "", ""]
	Local $sArmyInfo = ""

	If $ArmyCamp Then $choice = GetTranslated(640,24,"Army Camp")
	SetLog("Locating " & $choice & "...", $COLOR_INFO)

	AndroidShield("LocateBarrack") ; Update shield status due to manual $RunState

	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1], True) <> Hex($aTopLeftClient[2], 6) Or _GetPixelColor($aTopRightClient[0], $aTopRightClient[1], True) <> Hex($aTopRightClient[2], 6) Then
		Zoomout()
		Collect()
	EndIf

	While 1
		ClickP($aAway, 1, 0, "#0361")
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = $sErrorText & @CRLF & GetTranslated(640,25,"Click OK then click on one of your") & " " & $choice & "'s." & @CRLF & @CRLF & _
				GetTranslated(640,26,"Do not move mouse quickly after clicking location") & @CRLF & @CRLF & GetTranslated(640,27,"Make sure the building name is visible for me!") & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslated(640,1,"Ok|Cancel"), GetTranslated(640,28,"Locate") & " " & $choice, $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			If $ArmyCamp Then
				Local $aPos = FindPos()
				$ArmyPos[0] = $aPos[0]
				$ArmyPos[1] = $aPos[1]
				_Sleep($iDelayLocateBarrack1)
				If isInsideDiamond($ArmyPos) = False Then
					$iStupid += 1
					Select
						Case $iStupid = 1
							$sErrorText = $choice & " Location Not Valid!" & @CRLF
							SetLog("Location not valid, try again", $COLOR_ERROR)
							ContinueLoop
						Case $iStupid = 2
							$sErrorText = "Please try to click inside the grass field!" & @CRLF
							ContinueLoop
						Case $iStupid = 3
							$sErrorText = "This is not funny, why did you click @ (" & $ArmyPos[0] & "," & $ArmyPos[1] & ")?" & @CRLF & "  Please stop!" & @CRLF
							ContinueLoop
						Case $iStupid = 4
							$sErrorText = "Last Chance, DO NOT MAKE ME ANGRY, or" & @CRLF & "I will give ALL of your gold to Barbarian King," & @CRLF & "And ALL of your Gems to the Archer Queen!" & @CRLF
							ContinueLoop
						Case $iStupid > 4
							SetLog(" Operator Error - Bad " & $choice & " Location: " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_ERROR)
							ClickP($aAway, 1, 0, "#0362")
							Return False
						Case Else
							SetLog(" Operator Error - Bad " & $choice & " Location: " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_ERROR)
							$ArmyPos[0] = -1
							$ArmyPos[1] = -1
							ClickP($aAway, 1, 0, "#0363")
							Return False
					EndSelect
				EndIf
				$sArmyInfo = BuildingInfo(242, 520 + $bottomOffsetY) ; 860x780
				If $sArmyInfo[0] > 1 Or $sArmyInfo[0] = "" Then
					If StringInStr($sArmyInfo[1], "Army") = 0 Then
						If $sArmyInfo[0] = "" Then
							$sLocMsg = "Nothing"
						Else
							$sLocMsg = $sArmyInfo[1]
						EndIf
						$iSilly += 1
						Select
							Case $iSilly = 1
								$sErrorText = "Wait, That is not a Army Camp?, It was a " & $sLocMsg & @CRLF
								ContinueLoop
							Case $iSilly = 2
								$sErrorText = "Quit joking, That was " & $sLocMsg & @CRLF
								ContinueLoop
							Case $iSilly = 3
								$sErrorText = "This is not funny, why did you click " & $sLocMsg & "? Please stop!" & @CRLF
								ContinueLoop
							Case $iSilly = 4
								$sErrorText = $sLocMsg & " ?!?!?!" & @CRLF & @CRLF & "Last Chance, DO NOT MAKE ME ANGRY, or" & @CRLF & "I will give ALL of your gold to Barbarian King," & @CRLF & "And ALL of your Gems to the Archer Queen!" & @CRLF
								ContinueLoop
							Case $iSilly > 4
								SetLog("Quit joking, Click the Army Camp, or restart bot and try again", $COLOR_ERROR)
								$ArmyPos[0] = -1
								$ArmyPos[1] = -1
								ClickP($aAway, 1, 0, "#0364")
								Return False
						EndSelect
					EndIf
				Else
					SetLog(" Operator Error - Bad " & $choice & " Location: " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_ERROR)
					$ArmyPos[0] = -1
					$ArmyPos[1] = -1
					ClickP($aAway, 1, 0, "#0365")
					Return False
				EndIf
				SetLog($choice & ": " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_SUCCESS)
			Else
				$sInputbox = InputBox($sBotTitle & ": " & GetTranslated(640,29,"Question"), GetTranslated(640,30,"How many barracks you have?"), "4", "", 400, Default, Default, Default, 240, (AndroidEmbedded() ? Default : $frmBot))
				Local $numBarracksAvaiables = Number($sInputbox)
				Local $TEMPbarrackPos[4][2]
				For $i = 0 To ($numBarracksAvaiables - 1)
					Setlog("Click in Barrack n� " & $i + 1 & " and wait please...")
					Local $aPos = FindPos()
					$TEMPbarrackPos[$i][0] = $aPos[0]
					$TEMPbarrackPos[$i][1] = $aPos[1]
					If isInsideDiamondXY($TEMPbarrackPos[$i][0], $TEMPbarrackPos[$i][1]) Then
						If _Sleep($iDelayLocateBarrack2) Then Return
						Local $TrainPos = _PixelSearch(512, 585 + $bottomOffsetY, 641, 588 + $bottomOffsetY, Hex(0x7088AC, 6), 10) ;Finds Train Troops button
						If IsArray($TrainPos) Then
							Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
							If WaitforPixel(715, 124 + $midOffsetY, 718, 125 + $midOffsetY, Hex(0xD80408, 6), 5, 10) Then ;wait until finds red Cross button in new Training popup window, max of 5 senconds / return True
								For $x = 0 To 3
									If _Sleep($iDelayLocateBarrack2) Then Return
									If _ColorCheck(_GetPixelColor(254 + (60 * $x), 540 + $midOffsetY, True), Hex(0xE8E8E0, 6), 20) Then ; slot position 60 * $x
										$barrackPos[$x][0] = $TEMPbarrackPos[$i][0]
										$barrackPos[$x][1] = $TEMPbarrackPos[$i][1]
										SetLog("- Barrack " & $x + 1 & ": (" & $barrackPos[$x][0] & "," & $barrackPos[$x][1] & ")", $COLOR_DEBUG)
										;Else
										;SetLog("- Barrack " & $i + 1 & " error , position: (" & $TEMPbarrackPos[$i][0] & "," & $TEMPbarrackPos[$i][1] & ")", $COLOR_DEBUG)
									EndIf
								Next
							Else
								SetLog("- Barrack " & $i + 1 & " Error open the ArmyOverView Window!", $COLOR_DEBUG)
								Local $wasDown = AndroidShieldForceDown(True, True)
								$sInputbox = InputBox($sBotTitle & ": " & GetTranslated(640,29,"Question"), "Enter the ArmyOverView Tab Position of this Barrack [1|2|3|4] :", "1", "", 400, Default, Default, Default, 240, (AndroidEmbedded() ? Default : $frmBot))
								AndroidShieldForceDown($wasDown, True)
								Local $BarrackTabPosition = Number($sInputbox)
								$barrackPos[$BarrackTabPosition - 1][0] = $TEMPbarrackPos[$i][0]
								$barrackPos[$BarrackTabPosition - 1][1] = $TEMPbarrackPos[$i][1]
								SetLog("- Barrack " & $i + 1 & ": (" & $barrackPos[$BarrackTabPosition - 1][0] & "," & $barrackPos[$BarrackTabPosition - 1][1] & ")", $COLOR_DEBUG)
							EndIf
						Else
							SetLog("- Barrack " & $i + 1 & " Don�t exist the Button to train!", $COLOR_DEBUG)
							Local $wasDown = AndroidShieldForceDown(True, True)
							$sInputbox = InputBox($sBotTitle & ": " & GetTranslated(640,29,"Question"), "Enter the ArmyOverView Tab Position of this Barrack [1|2|3|4] :", "1", " M1", 400, Default, Default, Default, 240, (AndroidEmbedded() ? Default : $frmBot))
							AndroidShieldForceDown($wasDown, True)
							Local $BarrackTabPosition = Number($sInputbox)
							If $BarrackTabPosition >= 1 And $BarrackTabPosition <= 4 Then
							   $barrackPos[$BarrackTabPosition - 1][0] = $TEMPbarrackPos[$i][0]
							   $barrackPos[$BarrackTabPosition - 1][1] = $TEMPbarrackPos[$i][1]
							   SetLog("- Barrack " & $i + 1 & ": (" & $barrackPos[$BarrackTabPosition - 1][0] & "," & $barrackPos[$BarrackTabPosition - 1][1] & ")", $COLOR_DEBUG)
							Else
							   ; cancel so do again
							   $i -= 1
							EndIf
						EndIf
					Else
						SetLog("Quit joking, Click the Barracks, or restart bot and try again", $COLOR_ERROR)
					EndIf
					_Sleep(1000)
					ClickP($aAway, 1, 0, "#0206")
				Next

			EndIf
		Else
			SetLog("Locate " & $choice & " Cancelled", $COLOR_INFO)
			ClickP($aAway, 1, 0, "#0370")
			Return
		EndIf
		ExitLoop
	WEnd

	If $ArmyCamp Then
		$TotalCamp = 0 ; reset total camp number to get it updated
		If AndroidShielded() = False Then
			_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
			$stext = "Keep Mouse OUT of Android Emulator Window While I Update Army Camp Number, Thanks!!"
			$MsgBox = _ExtMsgBox(48, "OK", "Notice!", $stext, 15, $frmBot)
		EndIf

		If _Sleep($iDelayLocateBarrack1) Then Return
		ClickP($aAway, 1, 0, "#0371") ;Click Away
		If _Sleep($iDelayLocateBarrack3) Then Return

		If $iUseRandomClick = 0 then
			Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0372") ;Click Army Camp
		Else
			ClickR($aArmyTrainButtonRND, $aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0)
		EndIF
		If _Sleep($iDelayLocateBarrack1) Then Return

		$iCount = 0 ; reset loop counter
		$sArmyInfo =  getArmyCampCap($aArmyCampSize[0], $aArmyCampSize[1]) ; OCR read army trained and total
		If $debugSetlog = 1 Then Setlog("$sArmyInfo = " & $sArmyInfo, $COLOR_DEBUG)
		While $sArmyInfo = "" ; In case the CC donations recieved msg are blocking, need to keep checking numbers for 10 seconds
			If _Sleep($iDelayLocateBarrack2) Then Return
			$sArmyInfo =  getArmyCampCap($aArmyCampSize[0], $aArmyCampSize[1]) ; OCR read army trained and total
			If $debugSetlog = 1 Then Setlog(" $sArmyInfo = " & $sArmyInfo, $COLOR_DEBUG)
			$iCount += 1
			If $iCount > 4 Then ExitLoop
		WEnd

		$aGetArmySize = StringSplit($sArmyInfo, "#") ; split the trained troop number from the total troop number
		If $debugSetlog = 1 Then Setlog("$aGetArmySize[0]= " & $aGetArmySize[0] & "$aGetArmySize[1]= " & $aGetArmySize[1] & "$aGetArmySize[2]= " & $aGetArmySize[2], $COLOR_DEBUG)
		If $aGetArmySize[0] > 1 Then ; check if the OCR was valid and returned both values
			$TotalCamp = Number($aGetArmySize[2])
			Setlog("$TotalCamp = " & $TotalCamp, $COLOR_SUCCESS)
		Else
			Setlog("Army size read error", $COLOR_ERROR) ; log if there is read error
		EndIf

		If $TotalCamp = 0 Then ; if Total camp size is still not set
			If $ichkTotalCampForced = 0 Then ; check if forced camp size set in expert tab
				$sInputbox = InputBox($sBotTitle & ": " & GetTranslated(640,29,"Question"), "Enter your total Army Camp capacity", "200", "", 400, Default, Default, Default, 0, (AndroidEmbedded() ? Default : $frmBot))
				$TotalCamp = Number($sInputbox)
				Setlog("Army Camp User input = " & $TotalCamp, $COLOR_ERROR) ; log if there is read error AND we ask the user to tell us.
			Else
				$TotalCamp = Number($iValueTotalCampForced)
			EndIf
		EndIf
	EndIf
	ClickP($aAway, 1, 0, "#0206")

EndFunc   ;==>LocateBarrack

Func LocateOneBarrack()

	WinGetAndroidHandle()

	If $HWnD <> 0 And $AndroidBackgroundLaunched = True Then ; Android is running in background mode, so restart Android
		Setlog("Reboot " & $Android & " for Window access", $COLOR_ERROR)
		RebootAndroid(True)
	EndIf

	If $HWnD = 0 Then ; If not found, Android is not open so exit politely
		Setlog($Android & " is not open", $COLOR_ERROR)
		SetError(1)
		Return
	EndIf

	AndroidToFront()
	AndroidShield("LocateUpgrades") ; Update shield status due to manual $RunState
	Local $wasDown = AndroidShieldForcedDown()

	Local $choice = GetTranslated(640,23,"Barrack")
	Local $MsgBox, $stext, $iStupid = 0, $iSilly = 0, $sErrorText = "", $sLocMsg = ""

	While 1
		ZoomOut()
		AndroidShieldForceDown(True, True)
		ClickP($aAway, 1, 0, "#0361")
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = $sErrorText & @CRLF & GetTranslated(640,25,"Click OK then click on one of your") & " " & $choice & "'s." & @CRLF & @CRLF & _
				GetTranslated(640,26,"Do not move mouse quickly after clicking location") & @CRLF & @CRLF & GetTranslated(640,27,"Make sure the building name is visible for me!") & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslated(640,1,"Ok|Cancel"), GetTranslated(640,28,"Locate") & " " & $choice, $stext, 15, $frmBot)
		$sLocMsg = ""
		If $MsgBox = 1 Then
			Setlog("Select a Barrack and wait please...")
			Local $aPos = FindPos()
			If isInsideDiamondXY($aPos[0], $aPos[1]) Then
				If _Sleep($iDelayLocateBarrack2) Then Return
				_Sleep($iDelayLocateBarrack1)
				If isInsideDiamond($aPos) = False Then
					$iStupid += 1
					Select
						Case $iStupid = 1
							$sErrorText = $choice & " Location Not Valid!" & @CRLF
							SetLog("Location not valid, try again", $COLOR_ERROR)
							ContinueLoop
						Case $iStupid = 2
							$sErrorText = "Please try to click inside the grass field!" & @CRLF
							ContinueLoop
						Case $iStupid = 3
							$sErrorText = "This is not funny, why did you click @ (" & $aPos[0] & "," & $aPos[1] & ")?" & @CRLF & "  Please stop!" & @CRLF
							ContinueLoop
						Case $iStupid = 4
							$sErrorText = "Last Chance, DO NOT MAKE ME ANGRY, or" & @CRLF & "I will give ALL of your gold to Barbarian King," & @CRLF & "And ALL of your Gems to the Archer Queen!" & @CRLF
							ContinueLoop
						Case $iStupid > 4
							SetLog(" Operator Error - Bad " & $choice & " Location: " & "(" & $aPos[0] & "," & $aPos[1] & ")", $COLOR_ERROR)
							ClickP($aAway, 1, 0, "#0362")
							ExitLoop
						Case Else
							SetLog(" Operator Error - Bad " & $choice & " Location: " & "(" & $aPos[0] & "," & $aPos[1] & ")", $COLOR_ERROR)
							$aPos[0] = -1
							$aPos[1] = -1
							ClickP($aAway, 1, 0, "#0363")
							ExitLoop
					EndSelect
				EndIf

				Local $aResult = BuildingInfo(242, 520 + $bottomOffsetY)
				If $aResult[0] > 1 Or $aResult[0] = "" Then
					If StringInStr($aResult[1], "Barracks") = 0 Then
						If $aResult[0] = "" Then
							$sLocMsg = "Nothing"
						Else
							$sLocMsg = $aResult[1]
						EndIf
						$iSilly += 1
						Select
							Case $iSilly = 1
								$sErrorText = "Wait, That is not a Barrack?, It was a " & $sLocMsg & @CRLF
								ContinueLoop
							Case $iSilly = 2
								$sErrorText = "Quit joking, That was " & $sLocMsg & @CRLF
								ContinueLoop
							Case $iSilly = 3
								$sErrorText = "This is not funny, why did you click " & $sLocMsg & "? Please stop!" & @CRLF
								ContinueLoop
							Case $iSilly = 4
								$sErrorText = $sLocMsg & " ?!?!?!" & @CRLF & @CRLF & "Last Chance, DO NOT MAKE ME ANGRY, or" & @CRLF & "I will give ALL of your gold to Barbarian King," & @CRLF & "And ALL of your Gems to the Archer Queen!" & @CRLF
								ContinueLoop
							Case $iSilly > 4
								SetLog("Quit joking, Click the Army Camp, or restart bot and try again", $COLOR_ERROR)
								ClickP($aAway, 1, 0, "#0364")
								ExitLoop
						EndSelect
					EndIf
				Else
					SetLog(" Operator Error - Bad " & $choice & " Location: " & "(" & $aPos[0] & "," & $aPos[1] & ")", $COLOR_ERROR)
					ClickP($aAway, 1, 0, "#0365")
					ExitLoop
				EndIf
				SetLog($choice & ": " & "(" & $aPos[0] & "," & $aPos[1] & ")", $COLOR_SUCCESS)
				; Barrack located
				$barrackPos[0][0] = $aPos[0]
				$barrackPos[0][1] = $aPos[1]
				ExitLoop
			Else
				Setlog("Bad location for Barrack, try again...", $COLOR_ERROR)
			EndIf
		Else
			SetLog("Locate Barrack cancelled")
			ExitLoop
		EndIf
	WEnd

	AndroidShieldForceDown($wasDown)

EndFunc   ;==>LocateOneBarrack