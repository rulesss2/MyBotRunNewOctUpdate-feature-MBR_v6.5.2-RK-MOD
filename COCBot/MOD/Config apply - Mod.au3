; #FUNCTION# ====================================================================================================================
; Name ..........: Config apply - Mod.au3
; Description ...: Extension of applyConfig() for Mod
; Syntax ........: applyConfig()
; Parameters ....:
; Return values .:
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Config Apply for SwitchAcc Mode - DEMEN

 	If $ichkSwitchAcc = 1 Then
 		GUICtrlSetState($chkSwitchAcc, $GUI_CHECKED)
 	Else
 		GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
 	EndIf

	If $ichkSmartSwitch = 1 Then
	   GUICtrlSetState($radSmartSwitch, $GUI_CHECKED)
 	Else
	   GUICtrlSetState($radNormalSwitch, $GUI_CHECKED)
	EndIf

	radNormalSwitch()

;~ 	chkSwitchAcc()

	_GUICtrlCombobox_SetCurSel($cmbTotalAccount, $icmbTotalCoCAcc - 1)

	If $ichkCloseTraining >= 1 Then
		GUICtrlSetState($chkUseTrainingClose, $GUI_CHECKED)
		If $ichkCloseTraining = 1 Then
			GUICtrlSetState($radCloseCoC, $GUI_CHECKED)
		Else
			GUICtrlSetState($radCloseAndroid, $GUI_CHECKED)
		EndIf
	Else
		GUICtrlSetState($chkUseTrainingClose, $GUI_UNCHECKED)
	EndIf

	For $i = 0 to 7
		_GUICtrlCombobox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i]-1)
		_GUICtrlCombobox_SetCurSel($cmbProfileType[$i], $aProfileType[$i]-1)
	Next

	;=========== Adding QuicktrainCombo - DEMEN
	If $iRadio_Army12 = 1 Then
		GUICtrlSetState($hRadio_Army12, $GUI_CHECKED)
	Else
		GUICtrlSetState($hRadio_Army12, $GUI_UNCHECKED)
	EndIf

	If $iRadio_Army123 = 1 Then
		GUICtrlSetState($hRadio_Army123, $GUI_CHECKED)
	Else
		GUICtrlSetState($hRadio_Army123, $GUI_UNCHECKED)
	EndIf

; Multi Finger (LunaEclipse)
_GUICtrlComboBox_SetCurSel($cmbDBMultiFinger,$iMultiFingerStyle)
cmbDBMultiFinger()

cmbDeployAB()
cmbDeployDB()

; CSV Deployment Speed Mod
GUICtrlSetData($sldSelectedSpeedDB, $isldSelectedCSVSpeed[$DB])
GUICtrlSetData($sldSelectedSpeedAB, $isldSelectedCSVSpeed[$LB])
sldSelectedSpeedDB()
sldSelectedSpeedAB()

;modification Chat by rulesss
GUICtrlSetData($chkchatdelay, $ichkchatdelay)

;==========;Russian Languages by Kychera==========
	If $ichkRusLang = 1 Then
		GUICtrlSetState($chkRusLang, $GUI_CHECKED)

	ElseIf $ichkRusLang = 0 Then
		GUICtrlSetState($chkRusLang, $GUI_UNCHECKED)

	EndIf

	If $ichkRusLang2 = 1 Then
		GUICtrlSetState($chkRusLang2, $GUI_CHECKED)

	ElseIf $ichkRusLang2 = 0 Then
		GUICtrlSetState($chkRusLang2, $GUI_UNCHECKED)

	EndIf

	_GUICtrlComboBox_SetCurSel($cmbLang, $icmbLang)
	$icmbLang = _GUICtrlComboBox_GetCurSel($cmbLang)
;==========;Russian Languages by Kychera==========

    ; Android Settings
	If _GUICtrlComboBox_FindStringExact($cmbAndroid, String($sAndroid)) <> -1 Then
		_GUICtrlComboBox_SelectString($cmbAndroid, String($sAndroid))
	Else
		_GUICtrlComboBox_SetCurSel($cmbAndroid, 0)
	EndIf
	GUICtrlSetData($txtAndroidInstance, $sAndroidInstance)
	modifyAndroid()

	; Misc Battle Settings - Added by LunaEclipse
	If $AndroidAdbClicksEnabled = 1 Then
		GUICtrlSetState($chkFastADBClicks, $GUI_CHECKED)
		$AndroidAdbClicksEnabled = True
	Else
		GUICtrlSetState($chkFastADBClicks, $GUI_UNCHECKED)
		$AndroidAdbClicksEnabled = False
    EndIf

	;Forecast Added by rulesss
	GUICtrlSetData($txtForecastBoost, $iTxtForecastBoost)
	If $iChkForecastBoost = 1 Then
		GUICtrlSetState($chkForecastBoost, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkForecastBoost, $GUI_UNCHECKED)
	EndIf
	chkForecastBoost()

	If $ichkForecastHopingSwitchMax = 1 Then
		GUICtrlSetState($chkForecastHopingSwitchMax, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkForecastHopingSwitchMax, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMax, $icmbForecastHopingSwitchMax)
	GUICtrlSetData($txtForecastHopingSwitchMax, $itxtForecastHopingSwitchMax)
	chkForecastHopingSwitchMax()

	If $ichkForecastHopingSwitchMin = 1 Then
		GUICtrlSetState($chkForecastHopingSwitchMin, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkForecastHopingSwitchMin, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMin, $icmbForecastHopingSwitchMin)
	GUICtrlSetData($txtForecastHopingSwitchMin, $itxtForecastHopingSwitchMin)
	chkForecastHopingSwitchMin()
	;Added Multi Switch Language by rulesss and Kychera
	_GUICtrlComboBox_SetCurSel($cmbSwLang, $icmbSwLang)
	$icmbSwLang = _GUICtrlComboBox_GetCurSel($cmbSwLang)

    If $ichkLaunchWatchdog = 1 Then
         GUICtrlSetState($chkLaunchWatchdog, $GUI_CHECKED)
    Else
         GUICtrlSetState($chkLaunchWatchdog, $GUI_UNCHECKED)
    EndIf

	; Check Collectors Outside - Added By rulesss
	If $ichkDBMeetCollOutside = 1 Then
		GUICtrlSetState($chkDBMeetCollOutside, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDBMeetCollOutside, $GUI_UNCHECKED)
	EndIf
	chkDBMeetCollOutside()
	GUICtrlSetData($txtDBMinCollOutsidePercent, $iDBMinCollOutsidePercent)
	;Transparent Gui (Modified Kychera)
	GUICtrlSetData($SldTransLevel, $iSldTransLevel)	
	Slider() 