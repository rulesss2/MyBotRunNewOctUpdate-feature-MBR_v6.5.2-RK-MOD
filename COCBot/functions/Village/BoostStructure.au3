; #FUNCTION# ====================================================================================================================
; Name ..........: Boost any sstructure (King, Queen, Warden, Barracks, Spell Factory)
; Description ...:
; Syntax ........: BoostStructure($sName, $sOcrName, $aPos, ByRef $icmbBoostValue, $cmbBoostCtrl)
; Parameters ....:
; Return values .: True if boosted, False if not
; Author ........: Cosote Oct. 2016
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func BoostStructure($sName, $sOcrName, $aPos, ByRef $icmbBoostValue, $cmbBoostCtrl)
	Local $boosted = False
	Local $ok = False

	If UBound($aPos) > 1 And $aPos[0] > 0 And $aPos[1] > 0 Then
		BuildingClickP($aPos, "#0462")
		If _Sleep($iDelayBoostHeroes2) Then Return
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $bottomOffsetY)
		If $aResult[0] > 1 Then
			Local $sN = $aResult[1] ; Store bldg name
			Local $sL = $aResult[2] ; Sotre bdlg level
			If $sOcrName = "" Or StringInStr($sN, $sOcrName, $STR_NOCASESENSEBASIC) > 0 Then
				; Structure located
				SetLog("Boosting " & $sN & " (Level " & $sL & ") located at " & $aPos[0] & ", " & $aPos[1])
				$ok = True
			Else
				SetLog("Cannot boost " & $sN & " (Level " & $sL & ") located at " & $aPos[0] & ", " & $aPos[1], $COLOR_ERROR)
			EndIf
		EndIf
	EndIf

	If $ok = True Then
		$Boost = findButton("BoostOne")
		If IsArray($Boost) Then
			If $DebugSetlog = 1 Then Setlog("Boost Button X|Y = " & $Boost[0] & "|" & $Boost[1], $COLOR_DEBUG)
			Click($Boost[0], $Boost[1], 1, 0, "#0463")
			If _Sleep($iDelayBoostHeroes1) Then Return
			$Boost = findButton("GEM")
			If IsArray($Boost) Then
				Click($Boost[0], $Boost[1], 1, 0, "#0464")
				If _Sleep($iDelayBoostHeroes4) Then Return
				If IsArray(findButton("EnterShop")) Then
					SetLog("Not enough gems to boost " & $sName, $COLOR_ERROR)
				Else
					$icmbBoostValue -= 1
					SetLog($sName & ' Boost completed. Remaining iterations: ' & $icmbBoostValue, $COLOR_SUCCESS)
					_GUICtrlComboBox_SetCurSel($cmbBoostCtrl, $icmbBoostValue)
					$boosted = True
				EndIf
			Else
				SetLog($sName & " is already Boosted", $COLOR_ERROR)
			EndIf
			If _Sleep($iDelayBoostHeroes3) Then Return
			ClickP($aAway, 1, 0, "#0465")
		Else
			SetLog($sName & " Boost Button not found", $COLOR_ERROR)
			If _Sleep($iDelayBoostHeroes4) Then Return
		EndIf
	Else
		SetLog("Abort boosting " & $sName & ", bad location", $COLOR_ERROR)
	EndIf

	Return $boosted
EndFunc   ;==>BoostHero

Func AllowBoosting($sName, $icmbBoost)

	If ($bTrainEnabled = True And $boostsEnabled = 1 And $icmbBoost > 0) = False Then Return False

	Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)
	If $iPlannedBoostBarracksHours[$hour[0]] = 0 Then
		SetLog("Boosting " & $sName & " is not planned and skipped...", $COLOR_SUCCESS)
		Return False
	EndIf

	Return True

EndFunc   ;==>AllowBoosting

