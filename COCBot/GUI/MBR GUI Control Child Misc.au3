; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control Misc
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: MyBot.run team
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func cmbProfile()
	saveConfig()

	If $g_hLogFile <> 0 Then
	   FileClose($g_hLogFile)
	   $g_hLogFile = 0
    EndIf

	If $g_hAttackLogFile <> 0 Then
	   FileClose($g_hAttackLogFile)
	   $g_hAttackLogFile = 0
    EndIf

	; Setup the profile in case it doesn't exist.
	setupProfile()

	readConfig()
	applyConfig()
	saveConfig()

	SetLog("Profile " & $g_sProfileCurrentName & " loaded from " & $g_sProfileConfigPath, $COLOR_SUCCESS)
EndFunc   ;==>cmbProfile

Func btnAddConfirm()
	Switch @GUI_CtrlId
		Case $g_hBtnAddProfile
			GUICtrlSetState($g_hCmbProfile, $GUI_HIDE)
			GUICtrlSetState($g_hTxtVillageName, $GUI_SHOW)
			GUICtrlSetState($g_hBtnAddProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnConfirmAddProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnDeleteProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnCancelProfileChange, $GUI_SHOW)
			GUICtrlSetState($g_hBtnConfirmRenameProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnRenameProfile, $GUI_HIDE)
			; IceCube (Misc v1.0)
			GUICtrlSetState($g_hBtnRecycle, $GUI_HIDE)
			; IceCube (Misc v1.0)

		Case $g_hBtnConfirmAddProfile
			Local $newProfileName = StringRegExpReplace(GUICtrlRead($g_hTxtVillageName), '[/:*?"<>|]', '_')
			If FileExists($g_sProfilePath & "\" & $newProfileName) Then
				MsgBox($MB_ICONWARNING, GetTranslated(637, 11, "Profile Already Exists"), GetTranslated(637, 12, "%s already exists.\r\nPlease choose another name for your profile.", $newProfileName))
				Return
			EndIf

			$g_sProfileCurrentName = $newProfileName
			; Setup the profile if it doesn't exist.
			createProfile()
			setupProfileComboBox()
			setupProfileComboBoxswitch()
			selectProfile()
			GUICtrlSetState($g_hTxtVillageName, $GUI_HIDE)
			GUICtrlSetState($g_hCmbProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnAddProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnConfirmAddProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnDeleteProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnCancelProfileChange, $GUI_HIDE)
			GUICtrlSetState($g_hBtnConfirmRenameProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnRenameProfile, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($g_hBtnRecycle, $GUI_SHOW)
			; IceCube (Misc v1.0)

			If GUICtrlGetState($g_hBtnDeleteProfile) <> $GUI_ENABLE Then GUICtrlSetState($g_hBtnDeleteProfile, $GUI_ENABLE)
			If GUICtrlGetState($g_hBtnRenameProfile) <> $GUI_ENABLE Then GUICtrlSetState($g_hBtnRenameProfile, $GUI_ENABLE)
			; IceCube (Misc v1.0)
			If GUICtrlGetState($g_hBtnRecycle) <> $GUI_ENABLE Then GUICtrlSetState($g_hBtnRecycle, $GUI_ENABLE)
			; IceCube (Misc v1.0)

		Case Else
			SetLog("If you are seeing this log message there is something wrong.", $COLOR_ERROR)
	EndSwitch
	AddProfileToList()	; SwitchAcc Demen
EndFunc   ;==>btnAddConfirm

Func btnDeleteCancel()
	Switch @GUI_CtrlId
		Case $g_hBtnDeleteProfile

			SaveConfig_SwitchAcc()													; SwitchAcc - Demen
			Local $iDeleteProfile = _GUICtrlCombobox_GetCurSel($g_hCmbProfile)		; SwitchAcc - Demen

			Local $msgboxAnswer = MsgBox($MB_ICONWARNING + $MB_OKCANCEL, GetTranslated(637, 8, "Delete Profile"), GetTranslated(637, 14, "Are you sure you really want to delete the profile?\r\nThis action can not be undone."))
			If $msgboxAnswer = $IDOK Then
				; Confirmed profile deletion so delete it.
				deleteProfile()
				; reset inputtext
				GUICtrlSetData($g_hTxtVillageName, GetTranslated(637,4, "MyVillage"))
				If _GUICtrlComboBox_GetCount($g_hCmbProfile) > 1 Then
					; select existing profile
					setupProfileComboBox()
					selectProfile()
				Else
					; create new default profile
					createProfile(True)
				EndIf

				RemoveProfileFromList($iDeleteProfile)								; SwitchAcc_Demen_Style

			EndIf
		Case $g_hBtnCancelProfileChange
			GUICtrlSetState($g_hTxtVillageName, $GUI_HIDE)
			GUICtrlSetState($g_hCmbProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnConfirmAddProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnAddProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnCancelProfileChange, $GUI_HIDE)
			GUICtrlSetState($g_hBtnDeleteProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnConfirmRenameProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnRenameProfile, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($g_hBtnRecycle, $GUI_SHOW)
			; IceCube (Misc v1.0)

		Case Else
			SetLog("If you are seeing this log message there is something wrong.", $COLOR_ERROR)
	EndSwitch

	If GUICtrlRead($g_hCmbProfile) = "<No Profiles>" Then
		GUICtrlSetState($g_hBtnDeleteProfile, $GUI_DISABLE)
		GUICtrlSetState($g_hBtnRenameProfile, $GUI_DISABLE)
		; IceCube (Misc v1.0)
		GUICtrlSetState($g_hBtnRecycle, $GUI_DISABLE)
		; IceCube (Misc v1.0)

	EndIf
EndFunc   ;==>btnDeleteCancel

Func btnRenameConfirm()
	Switch @GUI_CtrlId
		Case $g_hBtnRenameProfile
			GUICtrlSetData($g_hTxtVillageName, GUICtrlRead($g_hCmbProfile))
			GUICtrlSetState($g_hCmbProfile, $GUI_HIDE)
			GUICtrlSetState($g_hTxtVillageName, $GUI_SHOW)
			GUICtrlSetState($g_hBtnAddProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnConfirmAddProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnDeleteProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnCancelProfileChange, $GUI_SHOW)
			GUICtrlSetState($g_hBtnRenameProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnConfirmRenameProfile, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($g_hBtnRecycle, $GUI_HIDE)
			; IceCube (Misc v1.0)

		Case $g_hBtnConfirmRenameProfile
			Local $newProfileName = StringRegExpReplace(GUICtrlRead($g_hTxtVillageName), '[/:*?"<>|]', '_')
			If FileExists($g_sProfilePath & "\" & $newProfileName) Then
				MsgBox($MB_ICONWARNING, GetTranslated(7, 108, "Profile Already Exists"), $newProfileName & " " & GetTranslated(7, 109, "already exists.") & @CRLF & GetTranslated(7, 110, "Please choose another name for your profile"))
				Return
			EndIf

			$g_sProfileCurrentName = $newProfileName
			; Rename the profile.
			renameProfile()
			setupProfileComboBox()
			setupProfileComboBoxswitch()
			selectProfile()

			GUICtrlSetState($g_hTxtVillageName, $GUI_HIDE)
			GUICtrlSetState($g_hCmbProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnConfirmAddProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnAddProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnCancelProfileChange, $GUI_HIDE)
			GUICtrlSetState($g_hBtnDeleteProfile, $GUI_SHOW)
			GUICtrlSetState($g_hBtnConfirmRenameProfile, $GUI_HIDE)
			GUICtrlSetState($g_hBtnRenameProfile, $GUI_SHOW)
			; IceCube (Misc v1.0)
			GUICtrlSetState($g_hBtnRecycle, $GUI_SHOW)
			; IceCube (Misc v1.0)

		Case Else
			SetLog("If you are seeing this log message there is something wrong.", $COLOR_ERROR)
	EndSwitch
EndFunc   ;==>btnRenameConfirm
Func cmbBotCond()
	If _GUICtrlComboBox_GetCurSel($g_hCmbBotCond) = 15 Then
		If _GUICtrlComboBox_GetCurSel($g_hCmbHoursStop) = 0 Then _GUICtrlComboBox_SetCurSel($g_hCmbHoursStop, 1)
		GUICtrlSetState($g_hCmbHoursStop, $GUI_ENABLE)
	Else
		_GUICtrlComboBox_SetCurSel($g_hCmbHoursStop, 0)
		GUICtrlSetState($g_hCmbHoursStop, $GUI_DISABLE)
	EndIf
EndFunc   ;==>cmbBotCond

Func chkBotStop()
	If GUICtrlRead($g_hChkBotStop) = $GUI_CHECKED Then
		GUICtrlSetState($g_hCmbBotCommand, $GUI_ENABLE)
		GUICtrlSetState($g_hCmbBotCond, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hCmbBotCommand, $GUI_DISABLE)
		GUICtrlSetState($g_hCmbBotCond, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBotStop

;~ Func btnLocateBarracks()
;~ 	Local $wasRunState = $g_bRunState
;~ 	$g_bRunState = True
;~ 	ZoomOut()
;~ 	;LocateOneBarrack()
;~ 	$g_bRunState = $wasRunState
;~ 	AndroidShield("btnLocateBarracks") ; Update shield status due to manual $g_bRunState
;~ EndFunc   ;==>btnLocateBarracks

;~ Func btnLocateArmyCamp()
;~ 	Local $wasRunState = $g_bRunState
;~ 	$g_bRunState = True
;~ 	ZoomOut()
;~ 	;LocateBarrack(True)
;~ 	$g_bRunState = $wasRunState
;~ 	AndroidShield("btnLocateArmyCamp") ; Update shield status due to manual $g_bRunState
;~ EndFunc   ;==>btnLocateArmyCamp

Func btnLocateClanCastle()
	Local $wasRunState = $g_bRunState
	$g_bRunState = True
	ZoomOut()
	LocateClanCastle()
	$g_bRunState = $wasRunState
	AndroidShield("btnLocateClanCastle") ; Update shield status due to manual $g_bRunState
EndFunc   ;==>btnLocateClanCastle

;~ Func btnLocateSpellfactory()
;~ 	Local $wasRunState = $g_bRunState
;~ 	$g_bRunState = True
;~ 	ZoomOut()
;~ 	LocateSpellFactory()
;~ 	$g_bRunState = $wasRunState
;~ 	AndroidShield("btnLocateSpellfactory") ; Update shield status due to manual $g_bRunState
;~ EndFunc   ;==>btnLocateSpellfactory

;~ Func btnLocateDarkSpellfactory()
;~ 	Local $wasRunState = $g_bRunState
;~ 	$g_bRunState = True
;~ 	ZoomOut()
;~ 	LocateDarkSpellFactory()
;~ 	$g_bRunState = $wasRunState
;~ 	AndroidShield("btnLocateDarkSpellfactory") ; Update shield status due to manual $g_bRunState
;~ EndFunc   ;==>btnLocateDarkSpellfactory

Func btnLocateKingAltar()
	LocateKingAltar()
EndFunc   ;==>btnLocateKingAltar


Func btnLocateQueenAltar()
	LocateQueenAltar()
EndFunc   ;==>btnLocateQueenAltar

Func btnLocateWardenAltar()
	LocateWardenAltar()
EndFunc   ;==>btnLocateWardenAltar

Func btnLocateTownHall()
	Local $wasRunState = $g_bRunState
	$g_bRunState = True
	ZoomOut()
	LocateTownHall()
	_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
	Local $stext = @CRLF & GetTranslated(640, 72, "If you locating your TH because you upgraded,") & @CRLF & _
			GetTranslated(640, 73, "then you must restart bot!!!") & @CRLF & @CRLF & _
			GetTranslated(640, 74, "Click OK to restart bot, ") & @CRLF & @CRLF & GetTranslated(640, 65, "Or Click Cancel to exit") & @CRLF
	Local $MsgBox = _ExtMsgBox(0, GetTranslated(640, 1, "Ok|Cancel"), GetTranslated(640, 76, "Close Bot Please!"), $stext, 120)
	If $g_iDebugSetlog = 1 Then Setlog("$MsgBox= " & $MsgBox, $COLOR_DEBUG)
	If $MsgBox = 1 Then
		#cs
		Local $stext = @CRLF & GetTranslated(640, 77, "Are you 100% sure you want to restart bot ?") & @CRLF & @CRLF & _
				GetTranslated(640, 78, "Click OK to close bot and then restart the bot (manually)") & @CRLF & @CRLF & GetTranslated(640, 65, -1) & @CRLF
		Local $MsgBox = _ExtMsgBox(0, GetTranslated(640, 1, -1), GetTranslated(640, 76, -1), $stext, 120)
		If $g_iDebugSetlog = 1 Then Setlog("$MsgBox= " & $MsgBox, $COLOR_DEBUG)
		If $MsgBox = 1 Then BotClose(False)
		#ce
		RestartBot(False, $wasRunState)
	EndIf
	$g_bRunState = $wasRunState
	AndroidShield("btnLocateTownHall") ; Update shield status due to manual $g_bRunState
EndFunc   ;==>btnLocateTownHall



Func btnResetBuilding()
	Local $wasRunState = $g_bRunState
	$g_bRunState = True
	While 1
		If _Sleep(500) Then Return ; add small delay before display message window
		If FileExists($g_sProfileBuildingPath) Then ; Check for building.ini file first
			_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
			Local $stext = @CRLF & GetTranslated(640, 63, "Click OK to Delete and Reset all Building info,") & @CRLF & @CRLF & _
					GetTranslated(640, 64, "NOTE =>> Bot will exit and need to be restarted when complete") & @CRLF & @CRLF & GetTranslated(640, 65, "Or Click Cancel to exit") & @CRLF
			Local $MsgBox = _ExtMsgBox(0, GetTranslated(640, 1, "Ok|Cancel"), GetTranslated(640, 67, "Delete Building Infomation ?"), $stext, 120)
			If $g_iDebugSetlog = 1 Then Setlog("$MsgBox= " & $MsgBox, $COLOR_DEBUG)
			If $MsgBox = 1 Then
				Local $stext = @CRLF & GetTranslated(640, 68, "Are you 100% sure you want to delete Building information ?") & @CRLF & @CRLF & _
						GetTranslated(640, 69, "Click OK to Delete and then restart the bot (manually)") & @CRLF & @CRLF & GetTranslated(640, 65, -1) & @CRLF
				Local $MsgBox = _ExtMsgBox(0, GetTranslated(640, 1, -1), GetTranslated(640, 67, -1), $stext, 120)
				If $g_iDebugSetlog = 1 Then Setlog("$MsgBox= " & $MsgBox, $COLOR_DEBUG)
				If $MsgBox = 1 Then
					Local $Result = FileDelete($g_sProfileBuildingPath)
					If $Result = 0 Then
						Setlog("Unable to remove building.ini file, please use manual method", $COLOR_ERROR)
					Else
						BotClose(False)
					EndIf
				EndIf
			EndIf
		Else
			Setlog("Building.ini file does not exist", $COLOR_INFO)
		EndIf
		ExitLoop
	WEnd
	$g_bRunState = $wasRunState
	AndroidShield("btnResetBuilding") ; Update shield status due to manual $g_bRunState
EndFunc   ;==>btnResetBuilding

Func btnLab()
	Local $wasRunState = $g_bRunState
	$g_bRunState = True
	ZoomOut()
	LocateLab()
	$g_bRunState = $wasRunState
	AndroidShield("btnLab") ; Update shield status due to manual $g_bRunState
EndFunc   ;==>btnLab

Func chkTrophyAtkDead()
	If GUICtrlRead($g_hChkTrophyAtkDead) = $GUI_CHECKED Then
		$g_bDropTrophyAtkDead = True
		GUICtrlSetState($g_hTxtDropTrophyArmyMin, $GUI_ENABLE)
		GUICtrlSetState($g_hLblDropTrophyArmyMin, $GUI_ENABLE)
		GUICtrlSetState($g_hLblDropTrophyArmyPercent, $GUI_ENABLE)
	Else
		$g_bDropTrophyAtkDead = False
		GUICtrlSetState($g_hTxtDropTrophyArmyMin, $GUI_DISABLE)
		GUICtrlSetState($g_hLblDropTrophyArmyMin, $GUI_DISABLE)
		GUICtrlSetState($g_hLblDropTrophyArmyPercent, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkTrophyAtkDead

Func chkTrophyRange()
	If GUICtrlRead($g_hChkTrophyRange) = $GUI_CHECKED Then
		GUICtrlSetState($g_hTxtDropTrophy, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtMaxTrophy, $GUI_ENABLE)
		GUICtrlSetState($g_hChkTrophyHeroes, $GUI_ENABLE)
		GUICtrlSetState($g_hChkTrophyAtkDead, $GUI_ENABLE)
		chkTrophyAtkDead()
		chkTrophyHeroes()
	Else
		GUICtrlSetState($g_hTxtDropTrophy, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtMaxTrophy, $GUI_DISABLE)
		GUICtrlSetState($g_hChkTrophyHeroes, $GUI_DISABLE)
		GUICtrlSetState($g_hChkTrophyAtkDead, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtDropTrophyArmyMin, $GUI_DISABLE)
		GUICtrlSetState($g_hLblDropTrophyArmyMin, $GUI_DISABLE)
		GUICtrlSetState($g_hLblDropTrophyArmyPercent, $GUI_DISABLE)
	    GUICtrlSetState($g_hLblTrophyHeroesPriority, $GUI_DISABLE)
	    GUICtrlSetState($g_hCmbTrophyHeroesPriority, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkTrophyRange

Func TxtDropTrophy()
	If Number(GUICtrlRead($g_hTxtDropTrophy)) > Number(GUICtrlRead($g_hTxtMaxTrophy)) Then
		GUICtrlSetData($g_hTxtMaxTrophy, GUICtrlRead($g_hTxtDropTrophy))
		TxtMaxTrophy()
	EndIf
	_GUI_Value_STATE("HIDE", $g_aGroupListPicMinTrophy)
	If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[21][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueLegend], $GUI_SHOW)
		GUICtrlSetData($g_hLblMinTrophies, "")
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[18][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueTitan], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[20][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[19][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[18][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[15][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueChampion], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[17][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[16][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[15][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[12][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueMaster], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[14][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[13][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[12][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[9][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueCrystal], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[11][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[10][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[9][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[6][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueGold], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[8][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[7][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[6][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[3][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueSilver], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[5][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[4][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[3][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[0][4]) Then
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueBronze], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[2][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[1][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtDropTrophy)) >= Number($g_asLeagueDetails[0][4]) Then
			GUICtrlSetData($g_hLblMinTrophies, "3")
		EndIf
	Else
		GUICtrlSetState($g_hPicMinTrophies[$eLeagueUnranked], $GUI_SHOW)
		GUICtrlSetData($g_hLblMinTrophies, "")
	EndIf
EndFunc   ;==>TxtDropTrophy

Func TxtMaxTrophy()
	If Number(GUICtrlRead($g_hTxtDropTrophy)) > Number(GUICtrlRead($g_hTxtMaxTrophy)) Then
		GUICtrlSetData($g_hTxtMaxTrophy, GUICtrlRead($g_hTxtDropTrophy))
	EndIf
	_GUI_Value_STATE("HIDE", $g_aGroupListPicMaxTrophy)
	If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[21][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueLegend], $GUI_SHOW)
		GUICtrlSetData($g_hLblMaxTrophies, "")
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[18][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueTitan], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[20][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[19][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[18][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[15][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueChampion], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[17][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[16][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[15][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[12][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueMaster], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[14][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[13][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[12][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[9][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueCrystal], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[11][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[10][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[9][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[6][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueGold], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[8][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[7][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[6][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[3][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueSilver], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[5][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[4][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[3][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[0][4]) Then
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueBronze], $GUI_SHOW)
		If Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[2][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "1")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[1][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "2")
		ElseIf Number(GUICtrlRead($g_hTxtMaxTrophy)) >= Number($g_asLeagueDetails[0][4]) Then
			GUICtrlSetData($g_hLblMaxTrophies, "3")
		EndIf
	Else
		GUICtrlSetState($g_hPicMaxTrophies[$eLeagueUnranked], $GUI_SHOW)
		GUICtrlSetData($g_hLblMaxTrophies, "")
	EndIf
EndFunc   ;==>TxtMaxTrophy

 Func chkTrophyHeroes()
	If  GUICtrlRead($g_hChkTrophyHeroes) = $GUI_CHECKED  Then
	   GUICtrlSetState($g_hLblTrophyHeroesPriority, $GUI_ENABLE)
	   GUICtrlSetState($g_hCmbTrophyHeroesPriority, $GUI_ENABLE)
	Else
	   GUICtrlSetState($g_hLblTrophyHeroesPriority, $GUI_DISABLE)
	   GUICtrlSetState($g_hCmbTrophyHeroesPriority, $GUI_DISABLE)
	EndIf

 EndFunc   ;==>chkTrophyHeroes

Func ChkCollect()
	If  GUICtrlRead($g_hChkCollect) = $GUI_CHECKED  Then
		GUICtrlSetState($g_hChkTreasuryCollect, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hChkTreasuryCollect, $GUI_DISABLE)
	EndIf
EndFunc		;==> ChkCollect

Func ChkTreasuryCollect()
	If  GUICtrlRead($g_hChkTreasuryCollect) = $GUI_CHECKED  Then
		GUICtrlSetState($g_hTxtTreasuryGold, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtTreasuryElixir, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtTreasuryDark, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hTxtTreasuryGold, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtTreasuryElixir, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtTreasuryDark, $GUI_DISABLE)
	EndIf
EndFunc		;==> ChkTreasuryCollect