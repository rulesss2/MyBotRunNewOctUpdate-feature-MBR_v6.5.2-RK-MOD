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

   IniReadS($iChkGiantSlot, $g_sProfileConfigPath, "SetSleep", "EnableGiantSlot", 0, "Int")
   IniReadS($iCmbGiantSlot , $g_sProfileConfigPath, "SetSleep", "CmbGiantSlot", 0 ,"Int")

   ;Background by Kychera
   IniReadS($iBackGr, $g_sProfileConfigPath, "background", "BackGr", 0, "Int")
   IniReadS($ichkPic, $g_sProfileConfigPath, "background", "chkPic", 1, "Int")

   ;Transparent Gui by Kychera
   IniReadS($iSldTransLevel, $g_sProfileConfigPath, "TransLevel", "Level", 0, "Int")

   ;Forecast
 IniReadS($iChkForecastBoost, $g_sProfileConfigPath, "forecast", "chkForecastBoost", 0, "Int")
 IniReadS($iTxtForecastBoost, $g_sProfileConfigPath, "forecast", "txtForecastBoost", 6, "Int")
 IniReadS($ichkForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMax", 0, "Int")
 IniReadS($icmbForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMax", 0, "Int")
 IniReadS($itxtForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMax", 2, "Int")
 IniReadS($ichkForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMin", 0, "Int")
 IniReadS($icmbForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMin", 0, "Int")
 IniReadS($itxtForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMin", 2, "Int")
 IniReadS($icmbSwLang, $g_sProfileConfigPath, "Lang", "cmbSwLang", 1, "int")
 ;watchdog
 IniReadS($iChkLaunchWatchdog, $g_sProfileConfigPath, "Other", "chkLaunchWatchdog", 1, "Int")

 ; Check Collectors Outside
IniReadS($ichkDBMeetCollOutside, $g_sProfileConfigPath, "search", "DBMeetCollOutside", 0, "int")
IniReadS($iDBMinCollOutsidePercent, $g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", 50, "int")

; CSV Deploy Speed
 IniReadS($g_iCmbCSVSpeed[$DB], $g_sProfileConfigPath, "DeploymentSpeed", "DB", 2, "Int")
 IniReadS($g_iCmbCSVSpeed[$LB], $g_sProfileConfigPath, "DeploymentSpeed", "LB", 2, "Int")

 #cs   
  ; Profile Switch
  IniReadS($ichkGoldSwitchMax, $g_sProfileConfigPath, "profiles", "chkGoldSwitchMax", 0, "int")
  IniReadS($icmbGoldMaxProfile, $g_sProfileConfigPath, "profiles", "cmbGoldMaxProfile", 0, "int")
  IniReadS($itxtMaxGoldAmount, $g_sProfileConfigPath, "profiles", "txtMaxGoldAmount", 6000000, "int")
  IniReadS($ichkGoldSwitchMin, $g_sProfileConfigPath, "profiles", "chkGoldSwitchMin", 0, "int")
  IniReadS($icmbGoldMinProfile, $g_sProfileConfigPath, "profiles", "cmbGoldMinProfile", 0, "int")
  IniReadS($itxtMinGoldAmount, $g_sProfileConfigPath, "profiles", "txtMinGoldAmount", 500000, "int")
  IniReadS($ichkElixirSwitchMax, $g_sProfileConfigPath, "profiles", "chkElixirSwitchMax", 0, "int")
  IniReadS($icmbElixirMaxProfile, $g_sProfileConfigPath, "profiles", "cmbElixirMaxProfile", 0, "int")
  IniReadS($itxtMaxElixirAmount, $g_sProfileConfigPath, "profiles", "txtMaxElixirAmount", 6000000, "int")
  IniReadS($ichkElixirSwitchMin, $g_sProfileConfigPath, "profiles", "chkElixirSwitchMin", 0, "int")
  IniReadS($icmbElixirMinProfile, $g_sProfileConfigPath, "profiles", "cmbElixirMinProfile", 0, "int")
  IniReadS($itxtMinElixirAmount, $g_sProfileConfigPath, "profiles", "txtMinElixirAmount", 500000, "int")
  IniReadS($ichkDESwitchMax, $g_sProfileConfigPath, "profiles", "chkDESwitchMax", 0, "int")
  IniReadS($icmbDEMaxProfile, $g_sProfileConfigPath, "profiles", "cmbDEMaxProfile", 0, "int")
  IniReadS($itxtMaxDEAmount, $g_sProfileConfigPath, "profiles", "txtMaxDEAmount", 200000, "int")
  IniReadS($ichkDESwitchMin, $g_sProfileConfigPath, "profiles", "chkDESwitchMin", 0, "int")
  IniReadS($icmbDEMinProfile, $g_sProfileConfigPath, "profiles", "cmbDEMinProfile", 0, "int")
  IniReadS($itxtMinDEAmount, $g_sProfileConfigPath, "profiles", "txtMinDEAmount", 10000, "int")
  IniReadS($ichkTrophySwitchMax, $g_sProfileConfigPath, "profiles", "chkTrophySwitchMax", 0, "int")
  IniReadS($icmbTrophyMaxProfile, $g_sProfileConfigPath, "profiles", "cmbTrophyMaxProfile", 0, "int")
  IniReadS($itxtMaxTrophyAmount, $g_sProfileConfigPath, "profiles", "txtMaxTrophyAmount", 3000, "int")
  IniReadS($ichkTrophySwitchMin, $g_sProfileConfigPath, "profiles", "chkTrophySwitchMin", 0, "int")
  IniReadS($icmbTrophyMinProfile, $g_sProfileConfigPath, "profiles", "cmbTrophyMinProfile", 0, "int")
  IniReadS($itxtMinTrophyAmount, $g_sProfileConfigPath, "profiles", "txtMinTrophyAmount", 1000, "int")
#ce
  	;Request russian
	IniReadS($ichkRusLang2, $g_sProfileConfigPath, "Lang", "chkRusLang2", 0, "int")

	; Move the Request CC Troops
	$bReqCCFirst = (IniRead($g_sProfileConfigPath, "planned", "ReqCCFirst", 0) = 1)

	; Misc Battle Settings
	IniReadS($g_bAndroidAdbClicksEnabled , $g_sProfileConfigPath, "Fast Clicks", "UseADBFastClicks", 0, "int")

	 ;Notify alert bot sleep
	 IniReadS($iNotifyAlertBOTSleep, $g_sProfileConfigPath, "notify", "AlertPBVMFound", 0, "int")

	 ; Android Settings	 
     $sAndroid = IniRead($g_sProfileConfigPath, "Android", "Emulator", "<No Emulators>")
     $sAndroidInstance = IniRead($g_sProfileConfigPath, "Android", "Instance", "")
	   
EndFunc   ;==>ReadConfig_RK_MOD