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

        ; CSV Deploy Speed
		_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$DB], $g_iCmbCSVSpeed[$DB])
		_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$LB], $g_iCmbCSVSpeed[$LB])
			; Upgrade Management
			GUICtrlSetState($g_hChkUpdateNewUpgradesOnly, $g_ibUpdateNewUpgradesOnly ? $GUI_CHECKED : $GUI_UNCHECKED)

			;Move the Request CC Troops
			GUICtrlSetState($chkReqCCFirst, $bReqCCFirst = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Clan Hop Setting
			GUICtrlSetState($g_hChkClanHop, $ichkClanHop = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

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

        ; CSV Deploy Speed
		$g_iCmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB])
		$g_iCmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB])
		    
			; Upgrade Management
			$g_ibUpdateNewUpgradesOnly = (GUICtrlRead($g_hChkUpdateNewUpgradesOnly) = $GUI_CHECKED)

			;Move the Request CC Troops
			$bReqCCFirst = GUICtrlRead($chkReqCCFirst) = $GUI_CHECKED ? 1 : 0

			; Clan Hop Setting
			$ichkClanHop = GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED ? 1 : 0

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

Func ApplyConfig_RK_Switch_Profiles($TypeReadSave)
    Switch $TypeReadSave
		Case "Read"
		GUICtrlSetState($chkGoldSwitchMax, $ichkGoldSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($cmbGoldMaxProfile, $icmbGoldMaxProfile)
		GUICtrlSetData($txtMaxGoldAmount, $itxtMaxGoldAmount)

		GUICtrlSetState($chkGoldSwitchMin, $ichkGoldSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($cmbGoldMinProfile, $icmbGoldMinProfile)
		GUICtrlSetData($txtMinGoldAmount, $itxtMinGoldAmount)

		GUICtrlSetState($chkElixirSwitchMax, $ichkElixirSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		_GUICtrlComboBox_SetCurSel($cmbElixirMaxProfile, $icmbElixirMaxProfile)
	     GUICtrlSetData($txtMaxElixirAmount, $itxtMaxElixirAmount)

		 GUICtrlSetState($chkElixirSwitchMin, $ichkElixirSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		 _GUICtrlComboBox_SetCurSel($cmbElixirMinProfile, $icmbElixirMinProfile)
	     GUICtrlSetData($txtMinElixirAmount, $itxtMinElixirAmount)

		 GUICtrlSetState($chkDESwitchMax, $ichkDESwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		 _GUICtrlComboBox_SetCurSel($cmbDEMaxProfile, $icmbDEMaxProfile)
	     GUICtrlSetData($txtMaxDEAmount, $itxtMaxDEAmount)

		 GUICtrlSetState($chkDESwitchMin, $ichkDESwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		 _GUICtrlComboBox_SetCurSel($cmbDEMinProfile, $icmbDEMinProfile)
	     GUICtrlSetData($txtMinDEAmount, $itxtMinDEAmount)

		 GUICtrlSetState($chkTrophySwitchMax, $ichkTrophySwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		 _GUICtrlComboBox_SetCurSel($cmbTrophyMaxProfile, $icmbTrophyMaxProfile)
	     GUICtrlSetData($txtMaxTrophyAmount, $itxtMaxTrophyAmount)

		 GUICtrlSetState($chkTrophySwitchMin, $ichkTrophySwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		 _GUICtrlComboBox_SetCurSel($cmbTrophyMinProfile, $icmbTrophyMinProfile)
	     GUICtrlSetData($txtMinTrophyAmount, $itxtMinTrophyAmount)
		 ProfileSwitchCheck()
		Case "Save"
		$ichkGoldSwitchMax = GUICtrlRead($chkGoldSwitchMax) = $GUI_CHECKED ? 1 : 0
		$icmbGoldMaxProfile = _GUICtrlComboBox_GetCurSel($cmbGoldMaxProfile)
		$itxtMaxGoldAmount = GUICtrlRead($txtMaxGoldAmount)

		$ichkGoldSwitchMin = GUICtrlRead($chkGoldSwitchMin) = $GUI_CHECKED ? 1 : 0
		$icmbGoldMinProfile = _GUICtrlComboBox_GetCurSel($cmbGoldMinProfile)
		$itxtMinGoldAmount = GUICtrlRead($txtMinGoldAmount)

		$ichkElixirSwitchMax = GUICtrlRead($chkElixirSwitchMax) = $GUI_CHECKED ? 1 : 0
		$icmbElixirMaxProfile = _GUICtrlComboBox_GetCurSel($cmbElixirMaxProfile)
		$itxtMaxElixirAmount = GUICtrlRead($txtMaxElixirAmount)

		$ichkElixirSwitchMin = GUICtrlRead($chkElixirSwitchMin) = $GUI_CHECKED ? 1 : 0
		$icmbElixirMinProfile = _GUICtrlComboBox_GetCurSel($cmbElixirMinProfile)
		$itxtMinElixirAmount = GUICtrlRead($txtMinElixirAmount)

		$ichkDESwitchMax = GUICtrlRead($chkDESwitchMax) = $GUI_CHECKED ? 1 : 0
		$icmbDEMinProfile = _GUICtrlComboBox_GetCurSel($cmbDEMinProfile)
		$itxtMaxDEAmount = GUICtrlRead($txtMaxDEAmount)

		$ichkDESwitchMin = GUICtrlRead($chkDESwitchMin) = $GUI_CHECKED ? 1 : 0
		$icmbDEMaxProfile = _GUICtrlComboBox_GetCurSel($cmbDEMaxProfile)
		$itxtMinDEAmount = GUICtrlRead($txtMinDEAmount)

		$ichkTrophySwitchMax = GUICtrlRead($chkTrophySwitchMax) = $GUI_CHECKED ? 1 : 0
		$icmbTrophyMaxProfile = _GUICtrlComboBox_GetCurSel($cmbTrophyMaxProfile)
		$itxtMaxTrophyAmount = GUICtrlRead($txtMaxTrophyAmount)

		$ichkTrophySwitchMin = GUICtrlRead($chkTrophySwitchMin) = $GUI_CHECKED ? 1 : 0
		$icmbTrophyMinProfile = _GUICtrlComboBox_GetCurSel($cmbTrophyMinProfile)
		$itxtMinTrophyAmount = GUICtrlRead($txtMinTrophyAmount)

	EndSwitch
EndFunc  ;==> ApplyConfig_RK_Switch_Profiles

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