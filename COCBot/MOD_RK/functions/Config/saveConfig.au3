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
	_Ini_Add("MultiFinger", "Select", $iMultiFingerStyle)

	; Unit Wave Factor
	_Ini_Add("SetSleep", "EnableUnitFactor", $iChkUnitFactor ? 1 : 0)
	_Ini_Add("SetSleep", "EnableWaveFactor", $iChkWaveFactor ? 1 : 0)

    _Ini_Add("SetSleep", "UnitFactor", GUICtrlRead($TxtUnitFactor))
	_Ini_Add("SetSleep", "WaveFactor", GUICtrlRead($TxtWaveFactor))

	_Ini_Add("SetSleep", "EnableGiantSlot", $iChkGiantSlot ? 1 : 0)
	_Ini_Add("SetSleep", "CmbGiantSlot", _GUICtrlComboBox_GetCurSel($CmbGiantSlot))
	;Background by Kychera
	_Ini_Add("background", "chkPic", $ichkPic ? 1 : 0)
	_Ini_Add("background", "BackGr", $iBackGr)

    ;Transparent Gui (Modified Kychera)
	_Ini_Add("TransLevel", "Level", $iSldTransLevel)

	_Ini_Add("TransLevel", "Level", $iSldTransLevel)

	;forecast
	_Ini_Add("forecast", "txtForecastBoost", GUICtrlRead($txtForecastBoost))
	_Ini_Add("profiles", "cmbForecastHopingSwitchMax", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax))
	_Ini_Add("profiles", "txtForecastHopingSwitchMax", GUICtrlRead($txtForecastHopingSwitchMax))
	_Ini_Add("profiles", "cmbForecastHopingSwitchMin", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin))
	_Ini_Add("profiles", "txtForecastHopingSwitchMin", GUICtrlRead($txtForecastHopingSwitchMin))
	_Ini_Add("forecast", "chkForecastBoost", $iChkForecastBoost ? 1 : 0)
	_Ini_Add("profiles", "chkForecastHopingSwitchMax", $ichkForecastHopingSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "chkForecastHopingSwitchMin", $ichkForecastHopingSwitchMin ? 1 : 0)
	;Added Multi Switch Language by rulesss and Kychera
	_Ini_Add("Lang", "cmbSwLang", _GUICtrlComboBox_GetCurSel($cmbSwLang))

    ;Watchdog disable
	_Ini_Add("Other", "chkLaunchWatchdog", $iChkLaunchWatchdog ? 1 : 0)

	; Check Collectors Outside
    _Ini_Add("search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	_Ini_Add("search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)

	; CSV Deploy Speed
	_Ini_Add("DeploymentSpeed", "DB", _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB]))
	_Ini_Add("DeploymentSpeed", "LB", _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB]))
#cs
	; Profile Switch
	_Ini_Add("profiles", "chkGoldSwitchMax", $ichkGoldSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMaxProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMaxProfile))

	_Ini_Add("profiles", "txtMaxGoldAmount", GUICtrlRead($txtMaxGoldAmount))

	_Ini_Add("profiles", "chkGoldSwitchMin", $ichkGoldSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMinProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMinProfile))
	_Ini_Add("profiles", "txtMinGoldAmount", GUICtrlRead($txtMinGoldAmount))

	_Ini_Add("profiles", "chkElixirSwitchMax", $ichkElixirSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMaxProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMaxProfile))
	_Ini_Add("profiles", "txtMaxElixirAmount", GUICtrlRead($txtMaxElixirAmount))

	_Ini_Add("profiles", "chkElixirSwitchMin", $ichkElixirSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMinProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMinProfile))
	_Ini_Add("profiles", "txtMinElixirAmount", GUICtrlRead($txtMinElixirAmount))

	_Ini_Add("profiles", "chkDESwitchMax", $ichkDESwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMaxProfile", _GUICtrlComboBox_GetCurSel($cmbDEMaxProfile))
	_Ini_Add("profiles", "txtMaxDEAmount", GUICtrlRead($txtMaxDEAmount))

	_Ini_Add("profiles", "chkDESwitchMin", $ichkDESwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMinProfile", _GUICtrlComboBox_GetCurSel($cmbDEMinProfile))
	_Ini_Add("profiles", "txtMinDEAmount", GUICtrlRead($txtMinDEAmount))

	_Ini_Add("profiles", "chkTrophySwitchMax", $ichkTrophySwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMaxProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMaxProfile))
	_Ini_Add("profiles", "txtMaxTrophyAmount", GUICtrlRead($txtMaxTrophyAmount))

	_Ini_Add("profiles", "chkTrophySwitchMin", $ichkTrophySwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMinProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMinProfile))
	_Ini_Add("profiles", "txtMinTrophyAmount", GUICtrlRead($txtMinTrophyAmount))
#ce
	;request  russian
	_Ini_Add("Lang", "chkRusLang2", $ichkRusLang2 ? 1 : 0)
	

	; Upgrade Management
	_Ini_Add("upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly ? 1 : 0)


	; Move the Request CC Troops
	_Ini_Add("planned", "ReqCCFirst", $bReqCCFirst ? 1 : 0)


	; Clan Hop Setting
	_Ini_Add("Others", "ClanHop", $ichkClanHop ? 1 : 0)



	; Misc Battle Settings
	_Ini_Add("Fast Clicks", "UseADBFastClicks", $g_bAndroidAdbClicksEnabled ? 1 : 0)

	;Notify alert bot sleep
	 _Ini_Add("notify", "AlertPBVMFound", $iNotifyAlertBOTSleep ? 1 : 0)

	 ; Android Settings
	 _Ini_Add("Android", "Emulator", GUICtrlRead($CmbAndroid))
    _Ini_Add("Android", "Instance", GUICtrlRead($TxtAndroidInstance))
	 
EndFunc   ;==>SaveConfig_RK_MOD