; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
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

Func ReadConfig_RK_MOD()
   ;  Multi Finger - Added by
	IniReadS($iMultiFingerStyle, $g_sProfileConfigPath, "MultiFinger", "Select", 2, "int")
   ; Unit Wave Factor Added by rulesss
   IniReadS($iChkUnitFactor, $g_sProfileConfigPath, "SetSleep", "EnableUnitFactor", 0, "Int")
   IniReadS($iTxtUnitFactor, $g_sProfileConfigPath, "SetSleep", "UnitFactor", 10 ,"Int")

   IniReadS($iChkWaveFactor, $g_sProfileConfigPath, "SetSleep", "EnableWaveFactor", 0, "Int")
   IniReadS($iTxtWaveFactor, $g_sProfileConfigPath, "SetSleep", "WaveFactor", 100 ,"Int")
   ;Background by Kychera
   IniReadS($iBackGr, $g_sProfileConfigPath, "background", "BackGr", 1, "Int")
   IniReadS($ichkPic, $g_sProfileConfigPath, "background", "chkPic", 1, "Int")
   ;Transparent Gui by Kychera
   IniReadS($iSldTransLevel, $g_sProfileConfigPath, "TransLevel", "Level", 0, "Int")

   ;Forecast
 IniReadS($iChkForecastBoost, $g_sProfileConfigPath, "forecast", "chkForecastBoost", 0, "Int")
 IniReadS($iTxtForecastBoost, $g_sProfileConfigPath, "forecast", "txtForecastBoost", 6, "Int")
 IniReadS($ichkForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMax", 0, "Int")
 IniReadS($icmbForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMax", 0, "Int")
 ;$icmbForecastHopingSwitchMax = IniRead($g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMax", "0")
 IniReadS($itxtForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMax", 2, "Int")
 IniReadS($ichkForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMin", 0, "Int")
 IniReadS($icmbForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMin", 0, "Int")
 IniReadS($itxtForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMin", 2, "Int")
 IniReadS($icmbSwLang, $g_sProfileConfigPath, "Lang", "cmbSwLang", 1, "int")



 IniReadS($iChkLaunchWatchdog, $g_sProfileConfigPath, "Other", "chkLaunchWatchdog", 1, "Int")

 ; Check Collectors Outside - Added by rulesss
IniReadS($ichkDBMeetCollOutside, $g_sProfileConfigPath, "search", "DBMeetCollOutside", 0, "int")
IniReadS($iDBMinCollOutsidePercent, $g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", 50, "int")

EndFunc   ;==>ReadConfig_RK_MOD
