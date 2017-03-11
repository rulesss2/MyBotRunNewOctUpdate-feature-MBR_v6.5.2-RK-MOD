; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
; Return values .: NA
; Author ........:
; Modified ......: ProMac (2017), RoroTiti (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
;------------  Multi Finger ----------- (LunaEclipse)
Func ApplyConfig_RK_MOD_multifinger($TypeReadSave)
	Switch $TypeReadSave
		Case "Read"

            _GUICtrlComboBox_SetCurSel($cmbDBMultiFinger,$iMultiFingerStyle)
		Case "Save"
		; Multi Finger
		    $iMultiFingerStyle = _GUICtrlComboBox_GetCurSel($CmbDBMultiFinger)
	EndSwitch
EndFunc   ;==>ApplyConfig_RK_MOD_multifinger
;---------------------------------------------------

Func ApplyConfig_RK_MOD($TypeReadSave)
	Switch $TypeReadSave
		Case "Read"
		; unit wave factor mod
		GUICtrlSetState($ChkUnitFactor, $iChkUnitFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
		GUICtrlSetData($TxtUnitFactor, $iTxtUnitFactor)
		chkUnitFactor()
		GUICtrlSetState($ChkWaveFactor, $iChkWaveFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
		GUICtrlSetData($TxtWaveFactor, $iTxtWaveFactor)
		chkWaveFactor()
		;Disable background
		GUICtrlSetState($chkPic, $ichkPic = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		chkPic()
		;Transparent Gui (Modified Kychera)
	    GUICtrlSetData($SldTransLevel, $iSldTransLevel)


		Case "Save"
        $iChkUnitFactor = (GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED)
		$iChkWaveFactor = (GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED)
		$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
		$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
		$ichkPic = (GUICtrlRead($chkPic) = $GUI_CHECKED)
        $iSldTransLevel = GUICtrlRead($SldTransLevel)

	EndSwitch
	ApplyConfig_RK_Forecast($TypeReadSave)
EndFunc   ;==>ApplyConfig_RK_MOD
;----------------- Background  -------------
Func ApplyConfig_decor_RK($TypeReadSave)
  Switch $TypeReadSave
		Case "Read"
            _GUICtrlComboBox_SetCurSel($BackGr, $iBackGr)
			BackGr()
			GUICtrlSetState($ChkLaunchWatchdog, $iChkLaunchWatchdog = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkLaunchWatchdog()
		Case "Save"
			$iBackGr = _GUICtrlComboBox_GetCurSel($BackGr)
			$iChkLaunchWatchdog = (GUICtrlRead($ChkLaunchWatchdog) = $GUI_CHECKED)
	EndSwitch
EndFunc  ;==> ApplyConfig_decor_RK
;--------------------------------------------------
Func ApplyConfig_RK_Forecast($TypeReadSave)
    Switch $TypeReadSave
		Case "Read"
		GUICtrlSetState($chkForecastBoost, $iChkForecastBoost ? $GUI_CHECKED : $GUI_UNCHECKED)
		GUICtrlSetData($txtForecastBoost, $iTxtForecastBoost)
		chkForecastBoost()
		GUICtrlSetState($chkForecastHopingSwitchMax, $ichkForecastHopingSwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMax, $icmbForecastHopingSwitchMax)
		GUICtrlSetData($txtForecastHopingSwitchMax, $itxtForecastHopingSwitchMax)
		chkForecastHopingSwitchMax()
		GUICtrlSetState($chkForecastHopingSwitchMin, $ichkForecastHopingSwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMin, $icmbForecastHopingSwitchMin)
		GUICtrlSetData($txtForecastHopingSwitchMin, $itxtForecastHopingSwitchMin)
		chkForecastHopingSwitchMin()
		_GUICtrlComboBox_SetCurSel($cmbSwLang, $icmbSwLang)
		;cmbSwLang()
		Case "Save"
		$iChkForecastBoost = (GUICtrlRead($chkForecastBoost) = $GUI_UNCHECKED)
		$iTxtForecastBoost = GUICtrlRead($txtForecastBoost)
		$ichkForecastHopingSwitchMax = (GUICtrlRead($chkForecastHopingSwitchMax) = $GUI_UNCHECKED)
		$icmbForecastHopingSwitchMax = _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax)
		$itxtForecastHopingSwitchMax = GUICtrlRead($txtForecastHopingSwitchMax)
		$ichkForecastHopingSwitchMin = (GUICtrlRead($chkForecastHopingSwitchMin) = $GUI_UNCHECKED)
		$icmbForecastHopingSwitchMin = _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin)
		$itxtForecastHopingSwitchMin = GUICtrlRead($txtForecastHopingSwitchMin)
		$icmbSwLang = _GUICtrlComboBox_GetCurSel($cmbSwLang)
	EndSwitch
EndFunc   ;==>ApplyConfig_RK_Forecast

Func ApplyConfig_RK_CollOutside($TypeReadSave)
    Switch $TypeReadSave
	Case "Read"
	GUICtrlSetState($g_hChkDBMeetCollOutside, $g_iChkDBMeetCollOutside = 0 ? $GUI_CHECKED : $GUI_UNCHECKED)
	chkDBMeetCollOutside()
	GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $g_iDBMinCollOutsidePercent)
    Case "Save"
	$g_iChkDBMeetCollOutside = (GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_UNCHECKED)
	$g_iDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent) 
    EndSwitch
EndFunc   ;==>ApplyConfig_RK_CollOutside