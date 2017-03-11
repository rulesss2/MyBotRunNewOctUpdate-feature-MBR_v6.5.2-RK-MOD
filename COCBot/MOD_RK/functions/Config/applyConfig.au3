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
        ; CSV Deploy Speed 
		_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$DB], $g_iCmbCSVSpeed[$DB])
		_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$LB], $g_iCmbCSVSpeed[$LB])
		
		    ; Smart Upgarde 
			GUICtrlSetState($g_hChkSmartUpgrade, $ichkSmartUpgrade = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartUpgrade()

			GUICtrlSetData($SmartMinGold, $iSmartMinGold)
			GUICtrlSetData($SmartMinElixir, $iSmartMinElixir)
			GUICtrlSetData($SmartMinDark, $iSmartMinDark)

			GUICtrlSetState($g_hChkIgnoreTH, $ichkIgnoreTH = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreKing, $ichkIgnoreKing = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreQueen, $ichkIgnoreQueen = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreWarden, $ichkIgnoreWarden = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreCC, $ichkIgnoreCC = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreLab, $ichkIgnoreLab = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreBarrack, $ichkIgnoreBarrack = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreDBarrack, $ichkIgnoreDBarrack = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreFactory, $ichkIgnoreFactory = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreDFactory, $ichkIgnoreDFactory = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreGColl, $ichkIgnoreGColl = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreEColl, $ichkIgnoreEColl = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreDColl, $ichkIgnoreDColl = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartUpgrade()

		Case "Save"
        $iChkUnitFactor = (GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED)
		$iChkWaveFactor = (GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED)
		$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
		$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
		$ichkPic = (GUICtrlRead($chkPic) = $GUI_CHECKED)
        $iSldTransLevel = GUICtrlRead($SldTransLevel)
		
        ; CSV Deploy Speed 
		$g_iCmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB])
		$g_iCmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB])
		
		    ; Smart Upgarde 
			$ichkSmartUpgrade = GUICtrlRead($g_hChkSmartUpgrade) = $GUI_CHECKED ? 1 : 0

			$iSmartMinGold = GUICtrlRead($SmartMinGold)
			$iSmartMinElixir = GUICtrlRead($SmartMinElixir)
			$iSmartMinDark = GUICtrlRead($SmartMinDark)

			$ichkIgnoreTH = GUICtrlRead($g_hChkIgnoreTH) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreKing = GUICtrlRead($g_hChkIgnoreKing) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreQueen = GUICtrlRead($g_hChkIgnoreQueen) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreWarden = GUICtrlRead($g_hChkIgnoreWarden) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreCC = GUICtrlRead($g_hChkIgnoreCC) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreLab = GUICtrlRead($g_hChkIgnoreLab) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreBarrack = GUICtrlRead($g_hChkIgnoreBarrack) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreDBarrack = GUICtrlRead($g_hChkIgnoreDBarrack) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreFactory = GUICtrlRead($g_hChkIgnoreFactory) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreDFactory = GUICtrlRead($g_hChkIgnoreDFactory) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreGColl = GUICtrlRead($g_hChkIgnoreGColl) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreEColl = GUICtrlRead($g_hChkIgnoreEColl) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreDColl = GUICtrlRead($g_hChkIgnoreDColl) = $GUI_CHECKED ? 1 : 0
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
	GUICtrlSetState($g_hChkDBMeetCollOutside, $ichkDBMeetCollOutside = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
	GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $iDBMinCollOutsidePercent)
	chkDBMeetCollOutside()
    Case "Save"
	$ichkDBMeetCollOutside = GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_CHECKED ? 1 : 0
	$iDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent) 
    EndSwitch
EndFunc   ;==>ApplyConfig_RK_CollOutside