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
            
			; SimpleTrain 
			GUICtrlSetState($g_hchkSimpleTrain, $ichkSimpleTrain = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hchkPreciseTroops, $ichkPreciseTroops = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hchkFillArcher, $ichkFillArcher = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_htxtFillArcher, $iFillArcher)
			GUICtrlSetState($g_hchkFillEQ, $ichkFillEQ = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSimpleTrain()
			
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
			
			;SimpleTrain 
			$ichkSimpleTrain = GUICtrlRead($g_hchkSimpleTrain) = $GUI_CHECKED ? 1 : 0
			$ichkPreciseTroops = GUICtrlRead($g_hchkPreciseTroops) = $GUI_CHECKED ? 1 : 0
			$ichkFillArcher = GUICtrlRead($g_hchkFillArcher) = $GUI_CHECKED ? 1 : 0
			$iFillArcher = GUICtrlRead($g_htxtFillArcher)
			$ichkFillEQ = GUICtrlRead($g_hchkFillEQ) = $GUI_CHECKED ? 1 : 0
			
	EndSwitch
	;ApplyConfig_RK_Forecast($TypeReadSave)
	;ApplyConfig_RK_Switch_Profiles($TypeReadSave)	
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

Func ApplyConfig_SwitchAcc($TypeReadSave, $SwitchAcc_Style = False)
	; <><><> SwitchAcc_Demen_Style <><><>
	Switch $TypeReadSave
		Case "Read"
			If $SwitchAcc_Style = True Then
				GUICtrlSetState($g_hRdoSwitchAcc_DocOc, $iSwitchAccStyle = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_hRdoSwitchAcc_Demen, $iSwitchAccStyle = 2 ? $GUI_CHECKED : $GUI_UNCHECKED)
				RdoSwitchAcc_Style()
			EndIf
			GUICtrlSetState($chkSwitchAcc, $ichkSwitchAcc = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSwitchAcc()
			GUICtrlSetState($chkTrain, $ichkTrain = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			If $ichkSmartSwitch = 1 Then
			   GUICtrlSetState($radSmartSwitch, $GUI_CHECKED)
			Else
			   GUICtrlSetState($radNormalSwitch, $GUI_CHECKED)
			EndIf
			If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then radNormalSwitch()
			_GUICtrlCombobox_SetCurSel($cmbTotalAccount, $icmbTotalCoCAcc - 1)
			GUICtrlSetState($g_hChkForceSwitch, $ichkForceSwitch = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_txtForceSwitch, $iForceSwitch)
			If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then chkForceSwitch()
			GUICtrlSetState($g_hChkForceStayDonate, $ichkForceStayDonate = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
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

		Case "Save"
			If $SwitchAcc_Style = True Then
				If GUICtrlRead($g_hRdoSwitchAcc_DocOc) = $GUI_CHECKED Then
					$iSwitchAccStyle = 1
				ElseIf GUICtrlRead($g_hRdoSwitchAcc_Demen) = $GUI_CHECKED Then
					$iSwitchAccStyle = 2
				EndIf
			EndIf
			$ichkSwitchAcc = GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED ? 1 : 0
			$ichkTrain = GUICtrlRead($chkTrain) = $GUI_CHECKED ? 1 : 0
			$icmbTotalCoCAcc = _GUICtrlCombobox_GetCurSel($cmbTotalAccount)+1
			$ichkSmartSwitch = GUICtrlRead($radSmartSwitch) = $GUI_CHECKED ? 1 : 0
			$ichkForceSwitch = GUICtrlRead($g_hChkForceSwitch) = $GUI_CHECKED ? 1 : 0
			$ichkForceStayDonate = GUICtrlRead($g_hChkForceStayDonate) = $GUI_CHECKED ? 1 : 0
			$iForceSwitch = GUICtrlRead($g_txtForceSwitch)
			$ichkCloseTraining = GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED ? 1 : 0
			If $ichkCloseTraining = 1 Then
				$ichkCloseTraining = GUICtrlRead($radCloseCoC) = $GUI_CHECKED ? 1 : 2
			EndIf
	EndSwitch
EndFunc

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

;Func ApplyConfig_RK_MOD_ruRequest($TypeReadSave)
;	Switch $TypeReadSave
;		Case "Read"
 ;         GUICtrlSetState($chkRusLang2, $ichkRusLang2 = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
 ;           
;		Case "Save"
;		   $ichkRusLang2 = GUICtrlRead($chkRusLang2) = $GUI_CHECKED ? 1 : 0
;		    
;	EndSwitch
;EndFunc   ;==>ApplyConfig_RK_ruRequest