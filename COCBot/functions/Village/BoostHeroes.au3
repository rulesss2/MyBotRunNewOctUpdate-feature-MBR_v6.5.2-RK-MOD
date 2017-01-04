
; #FUNCTION# ====================================================================================================================
; Name ..........: BoostKing & BoostQueen
; Description ...:
; Syntax ........: BoostKing() & BoostQueen()
; Parameters ....:
; Return values .: None
; Author ........: ProMac 2015
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func BoostKing()
	; Verifying existent Variables to run this routine
	If AllowBoosting("Barbarian King", $icmbBoostBarbarianKing) = False Then Return
    If $iChkForecastBoost = 1 And $currentForecast <= Number($iTxtForecastBoost, 3) Then Return

	SetLog("Boost Barbarian King...", $COLOR_INFO)
	If $KingAltarPos[0] = "" Or $KingAltarPos[0] = -1 Then
		LocateKingAltar()
		SaveConfig()
		If _Sleep($iDelayBoostHeroes4) Then Return
	EndIf

	BoostStructure("Barbarian King", "King", $KingAltarPos, $icmbBoostBarbarianKing, $cmbBoostBarbarianKing)

	If _Sleep($iDelayBoostBarracks5) Then Return
	checkMainScreen(False) ; Check for errors during function
EndFunc   ;==>BoostKing


Func BoostQueen()
	; Verifying existent Variables to run this routine
	If AllowBoosting("Archer Queen", $icmbBoostArcherQueen) = False Then Return
    If $iChkForecastBoost = 1 And $currentForecast <= Number($iTxtForecastBoost, 3) Then Return

	SetLog("Boost Archer Queen...", $COLOR_INFO)
	If $QueenAltarPos[0] = "" Or $QueenAltarPos[0] = -1 Then
		LocateQueenAltar()
		SaveConfig()
		If _Sleep($iDelayBoostHeroes4) Then Return
	EndIf

	BoostStructure("Archer Queen", "Quee", $QueenAltarPos, $icmbBoostArcherQueen, $cmbBoostArcherQueen)

	If _Sleep($iDelayBoostBarracks5) Then Return
	checkMainScreen(False) ; Check for errors during function
EndFunc   ;==>BoostQueen

Func BoostWarden()
	; Verifying existent Variables to run this routine
	If AllowBoosting("Grand Warden", $icmbBoostWarden) = False Then Return
    If $iChkForecastBoost = 1 And $currentForecast <= Number($iTxtForecastBoost, 3) Then Return

	SetLog("Boost Grand Warden...", $COLOR_INFO)
	If $WardenAltarPos[0] = "" Or $WardenAltarPos[0] = -1 Then
		LocateWardenAltar()
		SaveConfig()
		If _Sleep($iDelayBoostHeroes4) Then Return
	EndIf

	BoostStructure("Grand Warden", "Warden", $WardenAltarPos, $icmbBoostWarden, $cmbBoostWarden)

	If _Sleep($iDelayBoostBarracks5) Then Return
	checkMainScreen(False) ; Check for errors during function
EndFunc   ;==>BoostWarden
