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

	;request  russian
	_Ini_Add("Lang", "chkRusLang2", $ichkRusLang2 ? 1 : 0)

	; Move the Request CC Troops
	_Ini_Add("planned", "ReqCCFirst", $g_bReqCCFirst ? 1 : 0)

	; Misc Battle Settings
	_Ini_Add("Fast Clicks", "UseADBFastClicks", $g_bAndroidAdbClicksEnabled ? 1 : 0)

	;Notify alert bot sleep
	 _Ini_Add("notify", "AlertConnect", $iNotifyAlertConnect ? 1 : 0)
	 _Ini_Add("notify", "AlertPBVMFound", $iNotifyAlertBOTSleep ? 1 : 0)

	 ; Android Settings
	 _Ini_Add("Android", "Emulator", GUICtrlRead($CmbAndroid))
    _Ini_Add("Android", "Instance", GUICtrlRead($TxtAndroidInstance))

EndFunc   ;==>SaveConfig_RK_MOD