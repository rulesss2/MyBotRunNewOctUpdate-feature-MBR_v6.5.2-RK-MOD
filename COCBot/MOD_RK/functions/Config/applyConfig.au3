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
		GUICtrlSetState($ChkGiantSlot, $iChkGiantSlot ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($CmbGiantSlot,$iCmbGiantSlot)
		ChkGiantSlot()
		;Disable background
		GUICtrlSetState($chkPic, $ichkPic = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		chkPic()
		;Transparent Gui (Modified Kychera)
	    GUICtrlSetData($SldTransLevel, $iSldTransLevel)        

			;Move the Request CC Troops
			GUICtrlSetState($chkReqCCFirst, $g_bReqCCFirst = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Misc Battle Settings
			GUICtrlSetState($chkFastADBClicks, $g_bAndroidAdbClicksEnabled = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
            chkFastADBClicks()

		Case "Save"

        $iChkUnitFactor = (GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED)
		$iChkWaveFactor = (GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED)
		$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
		$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
		$iChkGiantSlot = (GUICtrlRead($ChkGiantSlot) = $GUI_CHECKED)
		$iCmbGiantSlot = _GUICtrlComboBox_GetCurSel($CmbGiantSlot)
		$ichkPic = (GUICtrlRead($chkPic) = $GUI_CHECKED)
        $iSldTransLevel = GUICtrlRead($SldTransLevel)

			;Move the Request CC Troops
			$g_bReqCCFirst = GUICtrlRead($chkReqCCFirst) = $GUI_CHECKED ? 1 : 0

			; Misc Battle Settings
			$g_bAndroidAdbClicksEnabled = GUICtrlRead($chkFastADBClicks) = $GUI_CHECKED ? 1 : 0

	EndSwitch
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
		GUICtrlSetState($chkForecastBoost, $iChkForecastBoost = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		GUICtrlSetData($txtForecastBoost, $iTxtForecastBoost)
		chkForecastBoost()
		GUICtrlSetState($chkForecastHopingSwitchMax, $ichkForecastHopingSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMax, $icmbForecastHopingSwitchMax)
		GUICtrlSetData($txtForecastHopingSwitchMax, $itxtForecastHopingSwitchMax)
		chkForecastHopingSwitchMax()
		GUICtrlSetState($chkForecastHopingSwitchMin, $ichkForecastHopingSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
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


Func ApplyConfig_RK_MOD_ruRequest($TypeReadSave)
	Switch $TypeReadSave
		Case "Read"
          GUICtrlSetState($chkRusLang2, $ichkRusLang2 = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
           chkRusLang2()
		Case "Save"
		   $ichkRusLang2 = GUICtrlRead($chkRusLang2) = $GUI_CHECKED ? 1 : 0

	EndSwitch
EndFunc   ;==>ApplyConfig_RK_ruRequest

Func ApplyConfig_RK_MOD_NotifyBotSleep($TypeReadSave)
	Switch $TypeReadSave
		Case "Read"
		  GUICtrlSetState($ChkNotifyAlertBOTSleep, $iNotifyAlertBOTSleep = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
          ChkNotifyAlertBOTSleep()
		Case "Save"
		   $iNotifyAlertBOTSleep = GUICtrlRead($ChkNotifyAlertBOTSleep) = $GUI_CHECKED ? 1 : 0
	EndSwitch
EndFunc   ;==>ApplyConfig_RK_ruRequest

Func ApplyConfig_RK_MOD_AndroidSettings($TypeReadSave)
	Switch $TypeReadSave
		Case "Read"
		If _GUICtrlComboBox_FindStringExact($CmbAndroid, String($sAndroid)) <> -1 Then
		_GUICtrlComboBox_SelectString($CmbAndroid, String($sAndroid))
	    Else		  
		_GUICtrlComboBox_SetCurSel($CmbAndroid, 0)
		EndIf		
	      modifyAndroid()
sleep(300)		  
		  GUICtrlSetData($TxtAndroidInstance, $sAndroidInstance)		 
         
		Case "Save"
		$sAndroid = _GUICtrlComboBox_GetCurSel($CmbAndroid)     
		   
		   $sAndroidInstance = GUICtrlRead($TxtAndroidInstance)
		   
	EndSwitch
EndFunc   ;==>ApplyConfig_RK_ruRequest