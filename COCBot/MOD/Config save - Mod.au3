; #FUNCTION# ====================================================================================================================
; Name ..........: Config save - Mod.au3
; Description ...: Extension of saveConfig() for Mod
; Syntax ........: saveConfig()
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


; Config save for SwitchAcc Mode

	If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then
		IniWrite($profile, "Switch Account", "Enable", 1)
	Else
		IniWrite($profile, "Switch Account", "Enable", 0)
	EndIf

	IniWrite($profile, "Switch Account", "Total Coc Account", _GUICtrlCombobox_GetCurSel($cmbTotalAccount)+1)		; 1 = 1 Acc, 2 = 2 Acc, etc.

	If GUICtrlRead($radSmartSwitch) = $GUI_CHECKED Then
	   IniWrite($profile, "Switch Account", "Smart Switch", 1)
	Else
	   IniWrite($profile, "Switch Account", "Smart Switch", 0)
	EndIf

	If GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED Then
		If GUICtrlRead($radCloseCoC) = $GUI_CHECKED Then
			IniWrite($profile, "Switch Account", "Sleep Combo", 1)		; Sleep Combo = 1 => Close CoC
		Else
			IniWrite($profile, "Switch Account", "Sleep Combo", 2)		; Sleep Combo = 2 => Close Android
		EndIf
	Else
		IniWrite($profile, "Switch Account", "Sleep Combo", 0)
	EndIf

	For $i = 1 to 8
		IniWriteS($profile, "Switch Account", "MatchProfileAcc." & $i, _GUICtrlCombobox_GetCurSel($cmbAccountNo[$i-1])+1)		; 1 = Acc 1, 2 = Acc 2, etc.
	Next

	For $i = 1 to 8
		IniWriteS($profile, "Switch Account", "ProfileType." & $i, _GUICtrlCombobox_GetCurSel($cmbProfileType[$i-1])+1)			; 1 = Active, 2 = Donate, 3 = Idle
	Next

	For $i = 1 to 8
		IniWriteS($profile, "Switch Account", "AccLocation." & $i, $aLocateAccConfig[$i-1])
	Next

   ; Config for Adding Quicktrain Combo
	If GUICtrlRead($hRadio_Army12) = $GUI_CHECKED Then
		IniWriteS($config, "troop", "QuickTrain12", 1)
	Else
		IniWriteS($config, "troop", "QuickTrain12", 0)
	EndIf

	If GUICtrlRead($hRadio_Army123) = $GUI_CHECKED Then
		IniWriteS($config, "troop", "QuickTrain123", 1)
	Else
		IniWriteS($config, "troop", "QuickTrain123", 0)
	EndIf


; Multi Finger - Added by rulesss
IniWrite($config, "MultiFinger", "Select", $iMultiFingerStyle)

; Unit Wave Factor
If GUICtrlRead($chkUnitFactor) = $GUI_CHECKED Then
	IniWriteS($config, "SetSleep", "EnableUnitFactor", 1)
Else
	IniWriteS($config, "SetSleep", "EnableUnitFactor", 0)
EndIf
IniWriteS($config, "SetSleep", "UnitFactor", GUICtrlRead($txtUnitFactor))

If GUICtrlRead($chkWaveFactor) = $GUI_CHECKED Then
	IniWriteS($config, "SetSleep", "EnableWaveFactor", 1)
Else
	IniWriteS($config, "SetSleep", "EnableWaveFactor", 0)
EndIf
IniWriteS($config, "SetSleep", "WaveFactor", GUICtrlRead($txtWaveFactor))

; CSV Deployment Speed Mod
IniWriteS($config, "attack", "CSVSpeedDB", $isldSelectedCSVSpeed[$DB])
IniWriteS($config, "attack", "CSVSpeedAB", $isldSelectedCSVSpeed[$LB])

;modification Chat by rulesss
IniWrite($config, "global", "chdelay", GUICtrlRead($chkchatdelay))

   ;==========;Russian Languages by Kychera==========
	If GUICtrlRead($chkRusLang) = $GUI_CHECKED Then
		$ichkRusLang = 1
	Else
		$ichkRusLang = 0
	EndIf

	IniWriteS($config, "Lang", "chkRusLang", $ichkRusLang)
	If GUICtrlRead($chkRusLang2) = $GUI_CHECKED Then
		$ichkRusLang2 = 1
	Else
		$ichkRusLang2 = 0
	EndIf

	IniWriteS($config, "Lang", "chkRusLang2", $ichkRusLang2)
	$icmbLang = _GUICtrlComboBox_GetCurSel($cmbLang)
    IniWriteS($config, "Lang", "cmbLang", $icmbLang)

	;==========;Russian Languages by Kychera==========

    ; Android Settings
    IniWrite($config, "Android", "Emulator", GUICtrlRead($cmbAndroid))
    IniWrite($config, "Android", "Instance", GUICtrlRead($txtAndroidInstance))

    ; Misc Battle Settings - - Added by rulesss
    If GUICtrlRead($chkFastADBClicks) = $GUI_CHECKED Then
	    IniWrite($config, "Fast Clicks", "UseADBFastClicks", 1)
    Else
	    IniWrite($config, "Fast Clicks", "UseADBFastClicks", 0)
    EndIf

    ;forecast Added by rulesss
	IniWrite($config, "forecast", "txtForecastBoost", GUICtrlRead($txtForecastBoost))

	If GUICtrlRead($chkForecastBoost) = $GUI_CHECKED Then
		IniWrite($config, "forecast", "chkForecastBoost", 1)
	Else
		IniWrite($config, "forecast", "chkForecastBoost", 0)
	EndIf

	If GUICtrlRead($chkForecastHopingSwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkForecastHopingSwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkForecastHopingSwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbForecastHopingSwitchMax", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax))
	IniWrite($config, "profiles", "txtForecastHopingSwitchMax", GUICtrlRead($txtForecastHopingSwitchMax))

	If GUICtrlRead($chkForecastHopingSwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkForecastHopingSwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkForecastHopingSwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbForecastHopingSwitchMin", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin))
	IniWrite($config, "profiles", "txtForecastHopingSwitchMin", GUICtrlRead($txtForecastHopingSwitchMin))

	;Added Multi Switch Language by rulesss and Kychera
	$icmbSwLang = _GUICtrlComboBox_GetCurSel($cmbSwLang)
    IniWriteS($config, "Lang", "cmbSwLang", $icmbSwLang)


    If GUICtrlRead($chkLaunchWatchdog) = $GUI_CHECKED Then
        $ichkLaunchWatchdog = 1
    Else
        $ichkLaunchWatchdog = 0
    EndIf

    IniWriteS($config, "Other", "chkLaunchWatchdog", $ichkLaunchWatchdog)

	; Check Collectors Outside - Added by rulesss
	If GUICtrlRead($chkDBMeetCollOutside) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBMeetCollOutside", 1)
	Else
		IniWriteS($config, "search", "DBMeetCollOutside", 0)
	EndIf
	IniWriteS($config, "search", "DBMinCollOutsidePercent", GUICtrlRead($txtDBMinCollOutsidePercent))

	;Transparent Gui (Modified Kychera)
	$iSldTransLevel = GUICtrlRead($SldTransLevel)
	IniWrites($config, "TransLevel", "Level", $iSldTransLevel)

    ; Clan Hop Setting - Added by rulesss
    If GUICtrlRead($chkClanHop) = $GUI_CHECKED Then
	    IniWrite($config, "Others", "ClanHop", 1)
    Else
	    IniWrite($config, "Others", "ClanHop", 0)
    EndIf

    ; CoCStats by rulesss
	If GUICtrlRead($chkCoCStats) = $GUI_CHECKED Then
		IniWrite($config, "Stats", "chkCoCStats", "1")
	Else
		IniWrite($config, "Stats", "chkCoCStats", "0")
	EndIf
	    IniWrite($config, "Stats", "txtAPIKey", GUICtrlRead($txtAPIKey))

	; Profile Switch Settings by rulesss
	If GUICtrlRead($chkGoldSwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkGoldSwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkGoldSwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbGoldMaxProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMaxProfile))
	IniWrite($config, "profiles", "txtMaxGoldAmount", GUICtrlRead($txtMaxGoldAmount))

	If GUICtrlRead($chkGoldSwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkGoldSwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkGoldSwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbGoldMinProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMinProfile))
	IniWrite($config, "profiles", "txtMinGoldAmount", GUICtrlRead($txtMinGoldAmount))

	If GUICtrlRead($chkElixirSwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkElixirSwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkElixirSwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbElixirMaxProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMaxProfile))
	IniWrite($config, "profiles", "txtMaxElixirAmount", GUICtrlRead($txtMaxElixirAmount))

	If GUICtrlRead($chkElixirSwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkElixirSwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkElixirSwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbElixirMinProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMinProfile))
	IniWrite($config, "profiles", "txtMinElixirAmount", GUICtrlRead($txtMinElixirAmount))

	If GUICtrlRead($chkDESwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkDESwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkDESwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbDEMaxProfile", _GUICtrlComboBox_GetCurSel($cmbDEMaxProfile))
	IniWrite($config, "profiles", "txtMaxDEAmount", GUICtrlRead($txtMaxDEAmount))

	If GUICtrlRead($chkDESwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkDESwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkDESwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbDEMinProfile", _GUICtrlComboBox_GetCurSel($cmbDEMinProfile))
	IniWrite($config, "profiles", "txtMinDEAmount", GUICtrlRead($txtMinDEAmount))

	If GUICtrlRead($chkTrophySwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkTrophySwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkTrophySwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbTrophyMaxProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMaxProfile))
	IniWrite($config, "profiles", "txtMaxTrophyAmount", GUICtrlRead($txtMaxTrophyAmount))

	If GUICtrlRead($chkTrophySwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkTrophySwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkTrophySwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbTrophyMinProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMinProfile))
	IniWrite($config, "profiles", "txtMinTrophyAmount", GUICtrlRead($txtMinTrophyAmount))

	;Background by Kychera
	If GUICtrlRead($chkPic) = $GUI_CHECKED Then
		$ichkPic = 1
	Else
		$ichkPic = 0
	EndIf
	IniWriteS($config, "background", "chkPic", $ichkPic)
	$iBackGr = _GUICtrlComboBox_GetCurSel($BackGr)
	IniWriteS($config, "background", "BackGr", $iBackGr)

	; Smart Upgrade
    IniWrite($config, "upgrade", "chkSmartUpgrade", $ichkSmartUpgrade)
    IniWrite($config, "upgrade", "chkIgnoreTH", $ichkIgnoreTH)
    IniWrite($config, "upgrade", "chkIgnoreKing", $ichkIgnoreKing)
    IniWrite($config, "upgrade", "chkIgnoreQueen", $ichkIgnoreQueen)
    IniWrite($config, "upgrade", "chkIgnoreWarden", $ichkIgnoreWarden)
    IniWrite($config, "upgrade", "chkIgnoreCC", $ichkIgnoreCC)
    IniWrite($config, "upgrade", "chkIgnoreLab", $ichkIgnoreLab)
    IniWrite($config, "upgrade", "chkIgnoreBarrack", $ichkIgnoreBarrack)
    IniWrite($config, "upgrade", "chkIgnoreDBarrack", $ichkIgnoreDBarrack)
    IniWrite($config, "upgrade", "chkIgnoreFactory", $ichkIgnoreFactory)
    IniWrite($config, "upgrade", "chkIgnoreDFactory", $ichkIgnoreDFactory)
    IniWrite($config, "upgrade", "chkIgnoreGColl", $ichkIgnoreGColl)
    IniWrite($config, "upgrade", "chkIgnoreEColl", $ichkIgnoreEColl)
    IniWrite($config, "upgrade", "chkIgnoreDColl", $ichkIgnoreDColl)
    IniWrite($config, "upgrade", "SmartMinGold", GUICtrlRead($SmartMinGold))
    IniWrite($config, "upgrade", "SmartMinElixir", GUICtrlRead($SmartMinElixir))
    IniWrite($config, "upgrade", "SmartMinDark", GUICtrlRead($SmartMinDark))
