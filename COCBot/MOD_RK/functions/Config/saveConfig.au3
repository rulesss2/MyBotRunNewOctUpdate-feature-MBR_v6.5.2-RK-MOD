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
	IniWriteS($g_sProfileConfigPath, "TransLevel", "Level", $iSldTransLevel)

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

	 ; Android Settings
	 IniWrite($g_sProfileConfigPath, "Android", "Emulator", GUICtrlRead($CmbAndroid))
    IniWrite($g_sProfileConfigPath, "Android", "Instance", GUICtrlRead($TxtAndroidInstance))
	 
EndFunc   ;==>SaveConfig_RK_MOD