; #FUNCTION# ====================================================================================================================
; Name ..........: CheckBaseQuick
; Description ...: Performs a quick check of base; requestCC, DonateCC, Train if required, collect resources, and pick up healed heroes.
;                : Used for prep before take a break & Personal Break exit, or during long trophy drops
; Syntax ........: CheckBaseQuick([$bStopRecursion = False[, $sReturnHome = ""]])
; Parameters ....: $bStopRecursion    - [optional] a boolean value. Default is False. Used when function is called during PB event.
;                  $sReturnHome       - [optional] a string value to support return home button press when needed. Default is "".
; Return values .: None
; Author ........: MonkeyHunter (12-2015, 09-2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func CheckBaseQuick($bStopRecursion = False, $sReturnHome = "")

	If $bStopRecursion = True Then $bDisableBreakCheck = True ; Set flag to stop checking for attackdisable messages, stop recursion

	Switch $sReturnHome
		Case "cloud" ; PB found while in clouds searching for base, must press return home and wait for main base
			If _CheckPixel($aRtnHomeCloud1, $bCapturePixel, Default, "Return Home Btn chk1", $COLOR_DEBUG) And _
					_CheckPixel($aRtnHomeCloud2, $bCapturePixel, Default, "Return Home Btn chk2", $COLOR_DEBUG) Then ; verify return home button
				ClickP($aRtnHomeCloud1, 1, 0, "#0513") ; click return home button, return to main screen for base check before log off
				Local $wCount = 0
				While IsMainPage() = False ; wait for main screen
					If _Sleep($iDelayGetResources1) Then Return ; wait 250ms
					$wCount += 1
					If $wCount > 40 Then ; wait up to 40*250ms = 10 seconds for main page then exit
						Setlog("Warning, Main page not found", $COLOR_WARNING)
						ExitLoop
					EndIf
				WEnd
			EndIf
	EndSwitch

	If IsMainPage() Then ; check for main page

		If $Debugsetlog = 1 Then Setlog("CheckBaseQuick now...", $COLOR_DEBUG)

		RequestCC() ; fill CC
		If _Sleep($iDelayRunBot1) Then Return
		checkMainScreen(False) ; required here due to many possible exits
		If $Restart = True Then
			If $bStopRecursion = True Then $bDisableBreakCheck = False
			Return
		EndIf

		DonateCC() ; donate troops
		If _Sleep($iDelayRunBot1) Then Return
		checkMainScreen(False) ; required here due to many possible function exits
		If $Restart = True Then
			If $bStopRecursion = True Then $bDisableBreakCheck = False
			Return
		EndIf

		CheckOverviewFullArmy(True) ; Check if army needs to be trained due donations
		If Not ($FullArmy) And $bTrainEnabled = True Then
			If $troops_maked_after_fullarmy = False And $actual_train_skip < $max_train_skip Then
				$troops_maked_after_fullarmy = False
				; Train()
				TrainRevamp()
				If $Restart = True Then Return
			Else
				If $debugsetlogTrain = 1 Then Setlog("skip train. " & $actual_train_skip + 1 & "/" & $max_train_skip, $color_purple)
				$actual_train_skip = $actual_train_skip + 1
				CheckOverviewFullArmy(True, False) ; use true parameter to open train overview window
				getArmyHeroCount(False, False)
				getArmySpellCount(False, True) ; use true parameter to close train overview window
				If $actual_train_skip >= $max_train_skip Then
					$actual_train_skip = 0
					$troops_maked_after_fullarmy = False
				EndIf
				If $bStopRecursion = True Then $bDisableBreakCheck = False
				Return
			EndIf
		EndIf

		Collect() ; Empty Collectors
		If _Sleep($iDelayRunBot1) Then Return

	Else
		If $Debugsetlog = 1 Then Setlog("Not on main page, CheckBaseQuick skipped", $COLOR_WARNING)
	EndIf

	If $bStopRecursion = True Then $bDisableBreakCheck = False ; reset flag to stop checking for attackdisable messages, stop recursion

EndFunc   ;==>CheckBaseQuick
