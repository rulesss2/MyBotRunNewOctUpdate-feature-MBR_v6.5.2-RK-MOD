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

	; Check Collectors Outside - Added by rulesss
   IniWriteS($g_sProfileConfigPath, "search", "DBMeetCollOutside", $g_iChkDBMeetCollOutside ? 1 : 0)
   IniWriteS($g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", GUICtrlRead($g_hTxtDBMinCollOutsidePercent))

EndFunc   ;==>SaveConfig_RK_MOD