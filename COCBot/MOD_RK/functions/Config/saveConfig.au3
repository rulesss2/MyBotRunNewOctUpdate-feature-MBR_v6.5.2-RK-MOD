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
	
	IniWriteS($g_sProfileConfigPath, "SetSleep", "EnableGiantSlot", $iChkGiantSlot ? 1 : 0)	
	IniWriteS($g_sProfileConfigPath, "SetSleep", "CmbGiantSlot", _GUICtrlComboBox_GetCurSel($CmbGiantSlot))
	;Background by Kychera
	IniWriteS($g_sProfileConfigPath, "background", "chkPic", $ichkPic ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "background", "BackGr", $iBackGr)
	
    ;Transparent Gui (Modified Kychera)
	IniWrites($g_sProfileConfigPath, "TransLevel", "Level", $iSldTransLevel)

	IniWriteS($g_sProfileConfigPath, "TransLevel", "Level", $iSldTransLevel)
	
	;forecast
	IniWriteS($g_sProfileConfigPath, "forecast", "txtForecastBoost", GUICtrlRead($txtForecastBoost))	 
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMax", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMax", GUICtrlRead($txtForecastHopingSwitchMax))
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMin", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin))	
	IniWriteS($g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMin", GUICtrlRead($txtForecastHopingSwitchMin))
	IniWriteS($g_sProfileConfigPath, "forecast", "chkForecastBoost", $iChkForecastBoost ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMax", $ichkForecastHopingSwitchMax ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMin", $ichkForecastHopingSwitchMin ? 1 : 0)
	;Added Multi Switch Language by rulesss and Kychera
	IniWriteS($g_sProfileConfigPath, "Lang", "cmbSwLang", _GUICtrlComboBox_GetCurSel($cmbSwLang))

    ;Watchdog disable
	IniWriteS($g_sProfileConfigPath, "Other", "chkLaunchWatchdog", $iChkLaunchWatchdog ? 1 : 0)

	; Check Collectors Outside 
    IniWriteS($g_sProfileConfigPath, "search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)
	
	; CSV Deploy Speed 
	IniWriteS($g_sProfileConfigPath, "DeploymentSpeed", "DB", _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB]))
	IniWriteS($g_sProfileConfigPath, "DeploymentSpeed", "LB", _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB]))
	
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
	IniWriteS($g_sProfileConfigPath, "upgrade", "SmartMinGold", GUICtrlRead($SmartMinGold))
	IniWriteS($g_sProfileConfigPath, "upgrade", "SmartMinElixir", GUICtrlRead($SmartMinElixir))
	IniWriteS($g_sProfileConfigPath, "upgrade", "SmartMinDark", GUICtrlRead($SmartMinDark))
    
	; SimpleTrain 
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "Enable", $ichkSimpleTrain)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "PreciseTroops", $ichkPreciseTroops)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "ChkFillArcher", $ichkFillArcher)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "FillArcher", $iFillArcher)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "FillEQ", $ichkFillEQ)
	
	; Profile Switch
	IniWriteS($g_sProfileConfigPath, "profiles", "chkGoldSwitchMax", $ichkGoldSwitchMax ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbGoldMaxProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMaxProfile))
	
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMaxGoldAmount", GUICtrlRead($txtMaxGoldAmount))	
	
	IniWriteS($g_sProfileConfigPath, "profiles", "chkGoldSwitchMin", $ichkGoldSwitchMin ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbGoldMinProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMinProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMinGoldAmount", GUICtrlRead($txtMinGoldAmount))
    
	IniWriteS($g_sProfileConfigPath, "profiles", "chkElixirSwitchMax", $ichkElixirSwitchMax ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbElixirMaxProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMaxProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMaxElixirAmount", GUICtrlRead($txtMaxElixirAmount))
	
	IniWriteS($g_sProfileConfigPath, "profiles", "chkElixirSwitchMin", $ichkElixirSwitchMin ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbElixirMinProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMinProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMinElixirAmount", GUICtrlRead($txtMinElixirAmount))
	
	IniWriteS($g_sProfileConfigPath, "profiles", "chkDESwitchMax", $ichkDESwitchMax ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbDEMaxProfile", _GUICtrlComboBox_GetCurSel($cmbDEMaxProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMaxDEAmount", GUICtrlRead($txtMaxDEAmount))
	
	IniWriteS($g_sProfileConfigPath, "profiles", "chkDESwitchMin", $ichkDESwitchMin ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbDEMinProfile", _GUICtrlComboBox_GetCurSel($cmbDEMinProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMinDEAmount", GUICtrlRead($txtMinDEAmount))
	
	IniWriteS($g_sProfileConfigPath, "profiles", "chkTrophySwitchMax", $ichkTrophySwitchMax ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbTrophyMaxProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMaxProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMaxTrophyAmount", GUICtrlRead($txtMaxTrophyAmount))
	
	IniWriteS($g_sProfileConfigPath, "profiles", "chkTrophySwitchMin", $ichkTrophySwitchMin ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "profiles", "cmbTrophyMinProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMinProfile))
	IniWriteS($g_sProfileConfigPath, "profiles", "txtMinTrophyAmount", GUICtrlRead($txtMinTrophyAmount))
	
	;request  russian
	IniWriteS($g_sProfileConfigPath, "Lang", "chkRusLang2", $ichkRusLang2 ? 1 : 0)
	
	; CoC Stats
	IniWriteS($g_sProfileConfigPath, "Stats", "chkCoCStats", $ichkCoCStats ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "Stats", "txtAPIKey", $MyApiKey)
	
	; Upgrade Management 
	IniWriteS($g_sProfileConfigPath, "upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly ? 1 : 0)
	
	; Move the Request CC Troops 
	IniWriteS($g_sProfileConfigPath, "planned", "ReqCCFirst", $bReqCCFirst ? 1 : 0)
    
	; Clan Hop Setting 
	IniWriteS($g_sProfileConfigPath, "Others", "ClanHop", $ichkClanHop ? 1 : 0)
    
	; Misc Battle Settings 
	IniWriteS($g_sProfileConfigPath, "Fast Clicks", "UseADBFastClicks", $g_bAndroidAdbClicksEnabled ? 1 : 0)
	;Notify alert bot sleep	 
	 IniWriteS($g_sProfileConfigPath, "notify", "AlertPBVMFound", $iNotifyAlertBOTSleep ? 1 : 0)
EndFunc   ;==>SaveConfig_RK_MOD

Func SaveConfig_SwitchAcc($SwitchAcc_Style = False)
	; <><><> SwitchAcc_Demen_Style <><><>
	ApplyConfig_SwitchAcc("Save", $SwitchAcc_Style)
	If $SwitchAcc_Style = True Then IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "SwitchType", $iSwitchAccStyle)	; 1 = DocOc Style, 2 = Demen Style

	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Enable", $ichkSwitchAcc ? 1 : 0)
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Pre-train", $ichkTrain ? 1 : 0)
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Total Coc Account", $icmbTotalCoCAcc)		; 1 = 1 Acc, 2 = 2 Acc, etc.
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Smart Switch", $ichkSmartSwitch ? 1 : 0)
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Force Switch", $ichkForceSwitch ? 1 : 0)
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Force Switch Search", $iForceSwitch)
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Force Stay Donate", $ichkForceStayDonate? 1 : 0)
	IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "Sleep Combo", $ichkCloseTraining)			; 0 = No Sleep, 1 = Close CoC, 2 = Close Android
	For $i = 1 to 8
		IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "MatchProfileAcc." & $i, _GUICtrlCombobox_GetCurSel($cmbAccountNo[$i-1])+1)		; 1 = Acc 1, 2 = Acc 2, etc.
		IniWriteS($SSAConfig, "SwitchAcc_Demen_Style", "ProfileType." & $i, _GUICtrlCombobox_GetCurSel($cmbProfileType[$i-1])+1)			; 1 = Active, 2 = Donate, 3 = Idle
	Next
EndFunc   ;==>SaveConfig_RK_MOD