; #FUNCTION# ====================================================================================================================
; Name ..........: Config read - Mod.au3
; Description ...: Extension of readConfig() for Mod
; Syntax ........: readConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Config Read for SwitchAcc Mode
		IniReadS($ichkSwitchAcc, $profile, "Switch Account", "Enable", "0")
		IniReadS($icmbTotalCoCAcc, $profile, "Switch Account", "Total Coc Account", "-1")
		IniReadS($ichkSmartSwitch, $profile, "Switch Account", "Smart Switch", "0")
		$ichkCloseTraining = Number(IniRead($profile, "Switch Account", "Sleep Combo", "0"))	; Sleep Combo, 1 = Close CoC, 2 = Close Android, 0 = No sleep

		For $i = 0 to 7
			IniReadS($aMatchProfileAcc[$i],$profile, "Switch Account", "MatchProfileAcc." & $i+1, "-1")
			IniReadS($aProfileType[$i], $profile, "Switch Account", "ProfileType." & $i+1, "-1")
			IniReadS($aAccPosY[$i], $profile, "Switch Account", "AccLocation." & $i+1, "-1")
		Next


  ; Config for Adding QuicktrainCombo
   IniReadS($iRadio_Army12, $config, "troop", "QuickTrain12", "0")
   IniReadS($iRadio_Army123, $config, "troop", "QuickTrain123", "0")

   ; Multi Finger - Added by rulesss
   $iMultiFingerStyle = IniRead($config, "MultiFinger", "Select", "2")

   ; Unit Wave Factor

   IniReadS($ichkUnitFactor, $config, "SetSleep", "EnableUnitFactor", "1", "Int")
   IniReadS($itxtUnitFactor, $config, "SetSleep", "UnitFactor", "10","Int")

   IniReadS($ichkWaveFactor, $config, "SetSleep", "EnableWaveFactor", "1", "Int")
   IniReadS($itxtWaveFactor, $config, "SetSleep", "WaveFactor", "100","Int")

   ; CSV Deployment Speed Mod-- Added by rulesss
   IniReadS($isldSelectedCSVSpeed[$DB], $config, "attack", "CSVSpeedDB", 3)
   IniReadS($isldSelectedCSVSpeed[$LB], $config, "attack", "CSVSpeedAB", 3)

    ;modification Chat by rulesss
   $ichkchatdelay = IniRead($config, "global", "chdelay", "0")

   ;==========;Russian Languages by Kychera==========
   $ichkRusLang = IniRead($config, "Lang", "chkRusLang", "0")
   $ichkRusLang2 = IniRead($config, "Lang", "chkRusLang2", "0")
   $icmbLang = IniRead($config, "Lang", "cmbLang", "8")

   ; Android Settings
   $sAndroid = IniRead($config, "Android", "Emulator", "<No Emulators>")
   $sAndroidInstance = IniRead($config, "Android", "Instance", "")

   ; Misc Battle Settings - Added by rulesss
   $AndroidAdbClicksEnabled = IniRead($config, "Fast Clicks", "UseADBFastClicks", "0")

;Forecast Added by rulesss
$iChkForecastBoost = IniRead($config, "forecast", "chkForecastBoost", "0")
$iTxtForecastBoost = IniRead($config, "forecast", "txtForecastBoost", "6.0")
$ichkForecastHopingSwitchMax = IniRead($config, "profiles", "chkForecastHopingSwitchMax", "0")
$icmbForecastHopingSwitchMax = IniRead($config, "profiles", "cmbForecastHopingSwitchMax", "0")
$itxtForecastHopingSwitchMax = IniRead($config, "profiles", "txtForecastHopingSwitchMax", "2.5")
$ichkForecastHopingSwitchMin = IniRead($config, "profiles", "chkForecastHopingSwitchMin", "0")
$icmbForecastHopingSwitchMin = IniRead($config, "profiles", "cmbForecastHopingSwitchMin", "0")
$itxtForecastHopingSwitchMin = IniRead($config, "profiles", "txtForecastHopingSwitchMin", "2.5")
;Added Multi Switch Language by rulesss and Kychera
$icmbSwLang = IniRead($config, "Lang", "cmbSwLang", "0")


$ichkLaunchWatchdog = IniRead($config, "Other", "chkLaunchWatchdog", "1")

; Check Collectors Outside - Added by rulesss
$ichkDBMeetCollOutside = IniRead($config, "search", "DBMeetCollOutside", "0")
$iDBMinCollOutsidePercent = IniRead($config, "search", "DBMinCollOutsidePercent", "50")

;Transparent Gui (Modified Kychera)
$iSldTransLevel = IniRead($config, "TransLevel", "Level", "0")

; Clan Hop Setting - Added by rulesss
$ichkClanHop = IniRead($config, "Others", "ClanHop", "0")

; CoCStats by rulesss
$ichkCoCStats = IniRead($config, "Stats", "chkCoCStats", "0")
$MyApiKey = IniRead($config, "Stats", "txtAPIKey", "")

; Profile Switch by rulesss
$ichkGoldSwitchMax = IniRead($config, "profiles", "chkGoldSwitchMax", "0")
$icmbGoldMaxProfile = IniRead($config, "profiles", "cmbGoldMaxProfile", "0")
$itxtMaxGoldAmount = IniRead($config, "profiles", "txtMaxGoldAmount", "6000000")
$ichkGoldSwitchMin = IniRead($config, "profiles", "chkGoldSwitchMin", "0")
$icmbGoldMinProfile = IniRead($config, "profiles", "cmbGoldMinProfile", "0")
$itxtMinGoldAmount = IniRead($config, "profiles", "txtMinGoldAmount", "500000")

$ichkElixirSwitchMax = IniRead($config, "profiles", "chkElixirSwitchMax", "0")
$icmbElixirMaxProfile = IniRead($config, "profiles", "cmbElixirMaxProfile", "0")
$itxtMaxElixirAmount = IniRead($config, "profiles", "txtMaxElixirAmount", "6000000")
$ichkElixirSwitchMin = IniRead($config, "profiles", "chkElixirSwitchMin", "0")
$icmbElixirMinProfile = IniRead($config, "profiles", "cmbElixirMinProfile", "0")
$itxtMinElixirAmount = IniRead($config, "profiles", "txtMinElixirAmount", "500000")

$ichkDESwitchMax = IniRead($config, "profiles", "chkDESwitchMax", "0")
$icmbDEMaxProfile = IniRead($config, "profiles", "cmbDEMaxProfile", "0")
$itxtMaxDEAmount = IniRead($config, "profiles", "txtMaxDEAmount", "200000")
$ichkDESwitchMin = IniRead($config, "profiles", "chkDESwitchMin", "0")
$icmbDEMinProfile = IniRead($config, "profiles", "cmbDEMinProfile", "0")
$itxtMinDEAmount = IniRead($config, "profiles", "txtMinDEAmount", "10000")

$ichkTrophySwitchMax = IniRead($config, "profiles", "chkTrophySwitchMax", "0")
$icmbTrophyMaxProfile = IniRead($config, "profiles", "cmbTrophyMaxProfile", "0")
$itxtMaxTrophyAmount = IniRead($config, "profiles", "txtMaxTrophyAmount", "3000")
$ichkTrophySwitchMin = IniRead($config, "profiles", "chkTrophySwitchMin", "0")
$icmbTrophyMinProfile = IniRead($config, "profiles", "cmbTrophyMinProfile", "0")
$itxtMinTrophyAmount = IniRead($config, "profiles", "txtMinTrophyAmount", "1000")
;Background by Kychera
$iBackGr = IniRead($config, "background", "BackGr", "0")
$ichkPic = IniRead($config, "background", "chkPic", "1")