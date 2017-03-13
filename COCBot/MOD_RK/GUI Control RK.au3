#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
; Switch Profile by rulesss
Func btnRecycle()
	FileDelete($config)
	SaveConfig()
	SetLog(GetTranslated(637, 20, "Profile ") & $sCurrProfile & GetTranslated(637, 21, " was recycled with success"), $COLOR_GREEN)
	SetLog(GetTranslated(637, 22, "All unused settings were removed"), $COLOR_GREEN)
EndFunc   ;==>btnRecycle
; Script Start - Add your code below here
Func setupProfileComboBoxswitch()
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbGoldMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbGoldMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbGoldMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbGoldMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbElixirMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbElixirMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbElixirMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbElixirMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbDEMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbDEMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbDEMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbDEMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbTrophyMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbTrophyMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbTrophyMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBox

; SwitchAcc_Demen_Style
Func RdoSwitchAcc_Style()
	If GUICtrlRead($g_hRdoSwitchAcc_DocOc) = $GUI_CHECKED Then
		GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
		For $i = $g_StartHideSwitchAcc_Demen To $g_EndHideSwitchAcc_Demen
			GUICtrlSetState($i,$GUI_HIDE)
		Next
		For $i = $aStartHide[0] To $aEndHide[7]
			GUICtrlSetState($i,$GUI_HIDE)
		Next
		For $i = $g_StartHideSwitchAcc_DocOc To $g_EndHideSwitchAcc_DocOc
			GUICtrlSetState($i,$GUI_SHOW)
		Next
		GUICtrlSetState($g_icnPopOutSW[0], $GUI_SHOW)
		chkSwitchAccount()
	Else
		GUICtrlSetState($chkEnableSwitchAccount, $GUI_UNCHECKED)
		chkSwitchAccount()
		For $i = $g_StartHideSwitchAcc_DocOc To $g_EndHideSwitchAcc_DocOc
			GUICtrlSetState($i,$GUI_HIDE)
		Next
		For $i = $g_StartHideSwitchAcc_Demen To $g_SecondHideSwitchAcc_Demen
			GUICtrlSetState($i,$GUI_SHOW)
		Next
		chkSwitchAcc()
		HideShowMultiStat("HIDE")
		GUICtrlSetState($g_icnPopOutSW[0], $GUI_HIDE)
	EndIf
EndFunc

Func AddProfileToList()
	Switch @GUI_CtrlId
		Case $g_hBtnAddProfile
			SaveConfig_SwitchAcc()

		Case $g_hBtnConfirmAddProfile
			Local $iNewProfile = _GUICtrlCombobox_GetCurSel($g_hCmbProfile)
			Local $UpdatedProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
			Local $nUpdatedTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)
			If $iNewProfile <= 7 Then
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$iNewProfile], -1)		; clear config of new profile
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$iNewProfile], -1)
				For $i = 7 To $iNewProfile+1  Step -1
					_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i-1]-1)	; push config up 1 level. -1 because $aMatchProfileAcc is saved from 1 to 8
					_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], $aProfileType[$i-1]-1)
				Next
			EndIf
			btnUpdateProfile()
	EndSwitch
EndFunc

Func RemoveProfileFromList($iDeleteProfile)
	Local $UpdatedProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	Local $nUpdatedTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)
	If $iDeleteProfile <= 7 Then
		For $i = $iDeleteProfile To 7
			If $i <=6 Then
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i+1]-1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], $aProfileType[$i+1]-1)
			Else
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
			EndIf
		Next
	EndIf
	btnUpdateProfile()
EndFunc

Func g_btnUpdateProfile()
	btnUpdateProfile()
EndFunc

Func btnUpdateProfile($Config = True)

	If $Config = True Then
		SaveConfig_SwitchAcc()
		ReadConfig_SwitchAcc()
		ApplyConfig_SwitchAcc("Read")
	EndIf

	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)

	For $i = 0 To 7
		If $i <= $nTotalProfile - 1 Then
			GUICtrlSetData($lblProfileName[$i], $ProfileList[$i+1])
			If GUICtrlRead($g_hRdoSwitchAcc_Demen) = $GUI_CHECKED Then
				For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
					GUICtrlSetState($j, $GUI_SHOW)
				Next
			EndIf
		; Update stats GUI
			For $j = $aStartHide[$i] To $aEndHide[$i]
			   GUICtrlSetState($j, $GUI_SHOW)
			Next
			Switch $aProfileType[$i]
				Case 1
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i+1] & " (Active)")
				Case 2
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i+1] & " (Donate)")
					For $j = $aSecondHide[$i] To $aEndHide[$i]
					  GUICtrlSetState($j, $GUI_HIDE)
					Next
				Case Else
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i+1] & " (Idle)")
					For $j = $aSecondHide[$i] To $aEndHide[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
			EndSwitch
		Else
			GUICtrlSetData($lblProfileName[$i], "")
			_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
			_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
			For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next
		; Update stats GUI
			For $j = $aStartHide[$i] To $aEndHide[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next
		EndIf
	Next
EndFunc

Func btnClearProfile()
	For $i = 0 To 7
		_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
		_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
	Next
EndFunc

Func chkSwitchAcc()
	If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then
		If _GUICtrlComboBox_GetCount($g_hCmbProfile) <= 1 Then
			GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
			MsgBox($MB_OK, GetTranslated(109,42, "SwitchAcc Mode"), GetTranslated(109,43, "Cannot enable SwitchAcc Mode") & @CRLF & GetTranslated(109,44, "You have only ") & _GUICtrlComboBox_GetCount($g_hCmbProfile) & " Profile", 30, $g_hGUI_BOT)
		Else
			For $i = $chkTrain To $g_EndHideSwitchAcc_Demen
				GUICtrlSetState($i, $GUI_ENABLE)
			Next
			radNormalSwitch()
			btnUpdateProfile(False)
		EndIf
	Else
		For $i = $chkTrain To $g_EndHideSwitchAcc_Demen
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		For $j = $aStartHide[0] To $aEndHide[7]
			GUICtrlSetState($j, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkSwitchAcc

Func radNormalSwitch()
	If GUICtrlRead($radNormalSwitch) = $GUI_CHECKED Then
		GUICtrlSetState($chkUseTrainingClose, $GUI_UNCHECKED)
		GUICtrlSetState($chkUseTrainingClose, $GUI_DISABLE)
		For $i = $radCloseCoC To $radCloseAndroid
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	Else
		GUICtrlSetState($chkUseTrainingClose, $GUI_ENABLE)
		For $i = $radCloseCoC To $radCloseAndroid
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
	EndIf
EndFunc   ;==>radNormalSwitch  - Normal Switch is not on the same boat with Sleep Combo

Func cmbMatchProfileAcc1()
	MatchProfileAcc(0)
EndFunc
Func cmbMatchProfileAcc2()
	MatchProfileAcc(1)
EndFunc
Func cmbMatchProfileAcc3()
	MatchProfileAcc(2)
EndFunc
Func cmbMatchProfileAcc4()
	MatchProfileAcc(3)
EndFunc
Func cmbMatchProfileAcc5()
	MatchProfileAcc(4)
EndFunc
Func cmbMatchProfileAcc6()
	MatchProfileAcc(5)
EndFunc
Func cmbMatchProfileAcc7()
	MatchProfileAcc(6)
EndFunc
Func cmbMatchProfileAcc8()
	MatchProfileAcc(7)
EndFunc

Func MatchProfileAcc($Num)
    If _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) > _GUICtrlComboBox_GetCurSel($cmbTotalAccount) Then
	   MsgBox($MB_OK, GetTranslated(109,42, "SwitchAcc Mode"), GetTranslated(109,45, "Account [") & _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) & GetTranslated(109,46, "] exceeds Total Account declared") ,30, $g_hGUI_BOT)
	   _GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
	   _GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
	   btnUpdateProfile()
	EndIf

	Local $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num])
	If $AccSelected >= 0 Then
		For $i = 0 to 7
			If $i = $Num Then ContinueLoop
			If $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$i]) Then
				MsgBox($MB_OK, GetTranslated(109,42, "SwitchAcc Mode"), GetTranslated(109,45, "Account [") & $AccSelected+1 & GetTranslated(109,47, "] has been assigned to Profile [") & $i+1 & "]" ,30, $g_hGUI_BOT)
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
				btnUpdateProfile()
				ExitLoop
			EndIf
		Next

		If _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) >= 0 Then
			_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], 0)
			btnUpdateProfile()
		EndIf
	EndIf
EndFunc ;===> MatchProfileAcc

Func btnLocateAcc()
	Local $AccNo = _GUICtrlComboBox_GetCurSel($cmbLocateAcc) + 1
	Local $stext, $MsgBox

	Local $wasRunState = $g_bRunState
	$g_bRunState = True

	SetLog(GetTranslated(109,48, "Locating Y-Coordinate of CoC Account No. ") & $AccNo & GetTranslated(109,49, ", please wait..."), $COLOR_BLUE)
	WinGetAndroidHandle()

	Zoomout()

	Click(820, 585, 1, 0, "Click Setting")      ;Click setting
	Sleep(500)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
		$stext = GetTranslated(109,50, "Click Connect/Disconnect on emulator to show the accout list") & @CRLF & @CRLF & _
				 GetTranslated(109,51, "Click OK then click on your Account No. ") & $AccNo & @CRLF & @CRLF & _
				 GetTranslated(109,52, "Do not move mouse quickly after clicking location") & @CRLF & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslated(109,53, "Ok|Cancel"), GetTranslated(109,54, "Locate CoC Account No. ") & $AccNo, $stext, 60, $g_hFrmBot)
		If $MsgBox = 1 Then
			WinGetAndroidHandle()
			Local $aPos = FindPos()
			$aLocateAccConfig[$AccNo-1] = Int($aPos[1])
			ClickP($aAway, 1, 0, "#0379")
		Else
			SetLog(GetTranslated(109,55, "Locate CoC Account Cancelled"), $COLOR_BLUE)
			ClickP($aAway, 1, 0, "#0382")
			Return
		EndIf
		SetLog(GetTranslated(109,56, "Locate CoC Account Success: ") & "(383, " & $aLocateAccConfig[$AccNo-1] & ")", $COLOR_GREEN)

		ExitLoop
	WEnd
	Clickp($aAway, 2, 0, "#0207")
	IniWriteS($profile, "Switch Account", "AccLocation." & $AccNo, $aLocateAccConfig[$AccNo-1])
    $g_bRunState = $wasRunState
	AndroidShield("LocateAcc") ; Update shield status due to manual $RunState

EndFunc   ;==>LocateAcc

Func btnClearAccLocation()
	For $i = 1 to 8
		$aLocateAccConfig[$i-1] = -1
		$aAccPosY[$i-1] = -1
	Next
	Setlog(GetTranslated(109,57, "Position of all accounts cleared"))
	SaveConfig_SwitchAcc()
EndFunc