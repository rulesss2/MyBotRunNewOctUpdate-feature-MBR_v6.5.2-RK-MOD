; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........:
; Modified ......: ProMac (2017), RoroTiti (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_RK_MOD()
    ; Multi Finger
	IniWriteS($g_sProfileConfigPath, "MultiFinger", "Select", $iMultiFingerStyle)

	; Unit Wave Factor
	IniWriteS($g_sProfileConfigPath, "SetSleep", "EnableUnitFactor", $iChkUnitFactor ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "SetSleep", "EnableWaveFactor", $iChkWaveFactor ? 1 : 0)

    IniWriteS($g_sProfileConfigPath, "SetSleep", "UnitFactor", GUICtrlRead($TxtUnitFactor))
	IniWriteS($g_sProfileConfigPath, "SetSleep", "WaveFactor", GUICtrlRead($TxtWaveFactor))
	;Background by Kychera
	IniWriteS($g_sProfileConfigPath, "background", "chkPic", $ichkPic ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "background", "BackGr", $iBackGr)
    ;Transparent Gui (Modified Kychera)
	IniWrites($g_sProfileConfigPath, "TransLevel", "Level", $iSldTransLevel)

	IniWriteS($g_sProfileConfigPath, "TransLevel", "Level", $iSldTransLevel)
	 ;forecast
	 IniWriteS($g_sProfileConfigPath, "forecast", "txtForecastBoost", GUICtrlRead($txtForecastBoost))
	 IniWriteS($g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMax", $icmbForecastHopingSwitchMax)
	IniWriteS($g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMax", GUICtrlRead($txtForecastHopingSwitchMax))
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMin", $icmbForecastHopingSwitchMin)
	IniWriteS($g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMin", GUICtrlRead($txtForecastHopingSwitchMin))
	IniWriteS($g_sProfileConfigPath, "forecast", "chkForecastBoost", $iChkForecastBoost ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMax", $ichkForecastHopingSwitchMax ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMin", $ichkForecastHopingSwitchMin ? 1 : 0)
	;Added Multi Switch Language by rulesss and Kychera
	IniWriteS($g_sProfileConfigPath, "Lang", "cmbSwLang", _GUICtrlComboBox_GetCurSel($cmbSwLang))


	IniWriteS($g_sProfileConfigPath, "Other", "chkLaunchWatchdog", $iChkLaunchWatchdog ? 1 : 0)

	; Check Collectors Outside 
    IniWriteS($g_sProfileConfigPath, "search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)
	
	; CSV Deploy Speed 
	IniWriteS($g_sProfileConfigPath, "DeploymentSpeed", "DB", $g_iCmbCSVSpeed[$DB])
	IniWriteS($g_sProfileConfigPath, "DeploymentSpeed", "LB", $g_iCmbCSVSpeed[$LB])
	
	; Smart Upgrade 
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkSmartUpgrade", $ichkSmartUpgrade ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreTH", $ichkIgnoreTH ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreKing", $ichkIgnoreKing ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreQueen", $ichkIgnoreQueen ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreWarden", $ichkIgnoreWarden ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreCC", $ichkIgnoreCC ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreLab", $ichkIgnoreLab ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreBarrack", $ichkIgnoreBarrack ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreDBarrack", $ichkIgnoreDBarrack ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreFactory", $ichkIgnoreFactory ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreDFactory", $ichkIgnoreDFactory ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreGColl", $ichkIgnoreGColl ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreEColl", $ichkIgnoreEColl ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "chkIgnoreDColl", $ichkIgnoreDColl ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "upgrade", "SmartMinGold", $iSmartMinGold)
	IniWriteS($g_sProfileConfigPath, "upgrade", "SmartMinElixir", $iSmartMinElixir)
	IniWriteS($g_sProfileConfigPath, "upgrade", "SmartMinDark", $iSmartMinDark)

EndFunc   ;==>SaveConfig_RK_MOD

Func SaveConfig_SwitchAcc($SwitchAcc_Style = False)
	; <><><> SwitchAcc_Demen_Style <><><>
	ApplyConfig_SwitchAcc("Save", $SwitchAcc_Style)
	If $SwitchAcc_Style = True Then IniWriteS($profile, "SwitchAcc_Demen_Style", "SwitchType", $iSwitchAccStyle)	; 1 = DocOc Style, 2 = Demen Style

	IniWriteS($profile, "SwitchAcc_Demen_Style", "Enable", $ichkSwitchAcc ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Pre-train", $ichkTrain ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Total Coc Account", $icmbTotalCoCAcc)		; 1 = 1 Acc, 2 = 2 Acc, etc.
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Smart Switch", $ichkSmartSwitch ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Sleep Combo", $ichkCloseTraining)			; 0 = No Sleep, 1 = Close CoC, 2 = Close Android
	For $i = 1 to 8
		IniWriteS($profile, "SwitchAcc_Demen_Style", "MatchProfileAcc." & $i, _GUICtrlCombobox_GetCurSel($cmbAccountNo[$i-1])+1)		; 1 = Acc 1, 2 = Acc 2, etc.
		IniWriteS($profile, "SwitchAcc_Demen_Style", "ProfileType." & $i, _GUICtrlCombobox_GetCurSel($cmbProfileType[$i-1])+1)			; 1 = Active, 2 = Donate, 3 = Idle
	Next
EndFunc