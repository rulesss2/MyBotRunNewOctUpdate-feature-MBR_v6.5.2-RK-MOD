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
	   GUICtrlSetState($radNormalSwitch, $GUI_UNCHECKED)
 	Else
	   GUICtrlSetState($radNormalSwitch, $GUI_CHECKED)
	   GUICtrlSetState($radSmartSwitch, $GUI_UNCHECKED)
	EndIf

	radNormalSwitch()

;~ 	chkSwitchAcc()

	_GUICtrlCombobox_SetCurSel($cmbTotalAccount, $icmbTotalCoCAcc - 1)

	If $ichkCloseTraining >= 1 Then
		GUICtrlSetState($chkUseTrainingClose, $GUI_CHECKED)
		If $ichkCloseTraining = 1 Then
			GUICtrlSetState($radCloseCoC, $GUI_CHECKED)
			GUICtrlSetState($radCloseAndroid, $GUI_UNCHECKED)
		Else
			GUICtrlSetState($radCloseAndroid, $GUI_CHECKED)
			GUICtrlSetState($radCloseCoC, $GUI_UNCHECKED)
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
;cmbDBMultiFinger()

cmbDeployAB()
;cmbDeployDB()
Bridge()
; Unit Wave Factor Added by rulesss
If $ichkUnitFactor = 1 Then
	GUICtrlSetState($chkUnitFactor, $GUI_CHECKED)
Else
	GUICtrlSetState($chkUnitFactor, $GUI_UNCHECKED)
EndIf
GUICtrlSetData($txtUnitFactor, $itxtUnitFactor)

If $ichkWaveFactor = 1 Then
	GUICtrlSetState($chkWaveFactor, $GUI_CHECKED)
Else
	GUICtrlSetState($chkWaveFactor, $GUI_UNCHECKED)
EndIf
GUICtrlSetData($txtWaveFactor, $itxtWaveFactor)

chkUnitFactor()
chkWaveFactor()

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

	; Clan Hop Setting - Added by rulesss
    If $ichkClanHop = 1 Then
	    GUICtrlSetState($chkClanHop, $GUI_CHECKED)
    Else
	    GUICtrlSetState($chkClanHop, $GUI_UNCHECKED)
    EndIf

    ; CoCStats by rulesss
	If $ichkCoCStats = 1 Then
		GUICtrlSetState($chkCoCStats, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkCoCStats, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtAPIKey, $MyApiKey)
	chkCoCStats()

	; Profile Switch by rulesss
	If $ichkGoldSwitchMax = 1 Then
		GUICtrlSetState($chkGoldSwitchMax, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkGoldSwitchMax, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbGoldMaxProfile, $icmbGoldMaxProfile)
	GUICtrlSetData($txtMaxGoldAmount, $itxtMaxGoldAmount)
	If $ichkGoldSwitchMin = 1 Then
		GUICtrlSetState($chkGoldSwitchMin, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkGoldSwitchMin, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbGoldMinProfile, $icmbGoldMinProfile)
	GUICtrlSetData($txtMinGoldAmount, $itxtMinGoldAmount)

	If $ichkElixirSwitchMax = 1 Then
		GUICtrlSetState($chkElixirSwitchMax, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkElixirSwitchMax, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbElixirMaxProfile, $icmbElixirMaxProfile)
	GUICtrlSetData($txtMaxElixirAmount, $itxtMaxElixirAmount)
	If $ichkElixirSwitchMin = 1 Then
		GUICtrlSetState($chkElixirSwitchMin, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkElixirSwitchMin, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbElixirMinProfile, $icmbElixirMinProfile)
	GUICtrlSetData($txtMinElixirAmount, $itxtMinElixirAmount)

	If $ichkDESwitchMax = 1 Then
		GUICtrlSetState($chkDESwitchMax, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDESwitchMax, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbDEMaxProfile, $icmbDEMaxProfile)
	GUICtrlSetData($txtMaxDEAmount, $itxtMaxDEAmount)
	If $ichkDESwitchMin = 1 Then
		GUICtrlSetState($chkDESwitchMin, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDESwitchMin, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbDEMinProfile, $icmbDEMinProfile)
	GUICtrlSetData($txtMinDEAmount, $itxtMinDEAmount)

	If $ichkTrophySwitchMax = 1 Then
		GUICtrlSetState($chkTrophySwitchMax, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrophySwitchMax, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbTrophyMaxProfile, $icmbTrophyMaxProfile)
	GUICtrlSetData($txtMaxTrophyAmount, $itxtMaxTrophyAmount)
	If $ichkTrophySwitchMin = 1 Then
		GUICtrlSetState($chkTrophySwitchMin, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrophySwitchMin, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbTrophyMinProfile, $icmbTrophyMinProfile)
	GUICtrlSetData($txtMinTrophyAmount, $itxtMinTrophyAmount)

	;Background by Kychera
	;=========================================
    _GUICtrlComboBox_SetCurSel($BackGr, $iBackGr)
	$iBackGr = _GUICtrlComboBox_GetCurSel($BackGr)
	 BackGr()
	If $ichkPic = 1 Then
		GUICtrlSetState($chkPic, $GUI_CHECKED)

	ElseIf $ichkPic = 0 Then
		GUICtrlSetState($chkPic, $GUI_UNCHECKED)

	EndIf
	chkPic()
;=========================================

; Smart Upgarde Added by rulesss
If $ichkSmartUpgrade = 1 Then
	GUICtrlSetState($chkSmartUpgrade, $GUI_CHECKED)
Else
	GUICtrlSetState($chkSmartUpgrade, $GUI_UNCHECKED)
EndIf
chkSmartUpgrade()

GUICtrlSetData($SmartMinGold, $iSmartMinGold)
GUICtrlSetData($SmartMinElixir, $iSmartMinElixir)
GUICtrlSetData($SmartMinDark, $iSmartMinDark)

If $ichkIgnoreTH = 1 Then
	GUICtrlSetState($chkIgnoreTH, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreTH, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreKing = 1 Then
	GUICtrlSetState($chkIgnoreKing, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreKing, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreQueen = 1 Then
	GUICtrlSetState($chkIgnoreQueen, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreQueen, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreWarden = 1 Then
	GUICtrlSetState($chkIgnoreWarden, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreWarden, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreCC = 1 Then
	GUICtrlSetState($chkIgnoreCC, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreCC, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreLab = 1 Then
	GUICtrlSetState($chkIgnoreLab, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreLab, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreBarrack = 1 Then
	GUICtrlSetState($chkIgnoreBarrack, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreBarrack, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreDBarrack = 1 Then
	GUICtrlSetState($chkIgnoreDBarrack, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreDBarrack, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreFactory = 1 Then
	GUICtrlSetState($chkIgnoreFactory, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreFactory, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreDFactory = 1 Then
	GUICtrlSetState($chkIgnoreDFactory, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreDFactory, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreGColl = 1 Then
	GUICtrlSetState($chkIgnoreGColl, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreGColl, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreEColl = 1 Then
	GUICtrlSetState($chkIgnoreEColl, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreEColl, $GUI_UNCHECKED)
EndIf

If $ichkIgnoreDColl = 1 Then
	GUICtrlSetState($chkIgnoreDColl, $GUI_CHECKED)
Else
	GUICtrlSetState($chkIgnoreDColl, $GUI_UNCHECKED)
EndIf
chkSmartUpgrade()

; Move the Request CC Troops Added by rulesss
If ($bReqCCFirst) Then
	GUICtrlSetState($chkReqCCFirst, $GUI_CHECKED)
Else
	GUICtrlSetState($chkReqCCFirst, $GUI_UNCHECKED)
EndIf

; Upgrade Management Added by rulesss
If $bUpdateNewUpgradesOnly = 1 Then
	GUICtrlSetState($chkUpdateNewUpgradesOnly, $GUI_CHECKED)
Else
	GUICtrlSetState($chkUpdateNewUpgradesOnly, $GUI_UNCHECKED)
EndIf