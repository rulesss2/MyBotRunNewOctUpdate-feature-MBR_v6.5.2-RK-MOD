#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         rk team
 Date            03.03.2017
 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------

; Script Start - Add your code below here
; Multi Finger Attack Style Setting
Global $LblDBMultiFinger = 0, $TxtUnitFactor = 0, $TxtWaveFactor = 0
Global $CmbDBMultiFinger = 0, $ChkUnitFactor = 0, $ChkWaveFactor = 0

Global Enum $directionLeft, $directionRight
Global Enum $sideBottomRight, $sideTopLeft, $sideBottomLeft, $sideTopRight
Global Enum $mfRandom, $mfFFStandard, $mfFFSpiralLeft, $mfFFSpiralRight, $mf8FBlossom, $mf8FImplosion, $mf8FPinWheelLeft, $mf8FPinWheelRight

Global $iMultiFingerStyle = 1
Global Enum $eCCSpell = $eHaSpell + 1
;-------------------------------------------------------
; unit wave factor
Global $ChkUnitFactor
Global $TxtUnitFactor
Global $ChkWaveFactor
Global $TxtWaveFactor
Global $iChkUnitFactor = 0
Global $iTxtUnitFactor = 10
Global $iChkWaveFactor = 0
Global $iTxtWaveFactor = 100
;-------------------------------------------------------
;Background by Kychera
Global $BackGr, $chkPic
Global $iBackGr = 1
Global $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
Global $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24
Global $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55
Global $ichkPic = 1
;-------------------------------------------------------
;Transparent Gui - by Kychera
Global $iSldTransLevel = 0
Global $SldTransLevel = 0
;-------------------------------------------------------
Global $chatIni = ""
Global $cmblang = 0,  $icmblang = 0
Global $chkRusLang = 0, $ichkRusLang = 0

;--------------------------------------------------------
;Forecast Added by rulesss
Global Const $COLOR_DEEPPINK = 0xFF1493
Global Const $COLOR_DARKGREEN = 0x006400
Global $oIE = ObjCreate("Shell.Explorer.2")
Global $grpForecast
Global $ieForecast = 0
Global $dtStamps[0]
Global $lootMinutes[0]
Global $timeOffset = 0
Global $TimerForecast = 0
Global $lootIndexScaleMarkers
Global $currentForecast
Global $chkForecastBoost = 0, $txtForecastBoost = 0
Global $iChkForecastBoost, $iTxtForecastBoost = 6
Global $cmbForecastHopingSwitchMax, $cmbForecastHopingSwitchMin
Global $chkForecastHopingSwitchMax = 0, $lblForecastHopingSwitchMax = 0, $txtForecastHopingSwitchMax = 2, $chkForecastHopingSwitchMin = 0, $lblForecastHopingSwitchMin = 0, $txtForecastHopingSwitchMin = 0
Global $ichkForecastHopingSwitchMax, $icmbForecastHopingSwitchMax , $itxtForecastHopingSwitchMax = 2, $ichkForecastHopingSwitchMin, $icmbForecastHopingSwitchMin, $itxtForecastHopingSwitchMin = 2
;Added Multi Switch Language by rulesss and Kychera
Global $icmbSwLang = 0
Global $cmbSwLang = 0
;--------------------------------------------------------------------
;Disable Watchdog
Global $iChkLaunchWatchdog = 1
Global $ChkLaunchWatchdog = 0

; Check Collector Outside - Added by rulesss
#region Check Collectors Outside
; Collectors outside filter
Global $ichkDBMeetCollOutside, $iDBMinCollOutsidePercent, $iCollOutsidePercent ; check later if $iCollOutsidePercent obsolete

; constants
Global Const $THEllipseWidth = 200, $THEllipseHeigth = 150, $CollectorsEllipseWidth = 130, $CollectorsEllipseHeigth = 97.5
Global Const $centerX = 430, $centerY = 335 ; check later if $THEllipseWidth, $THEllipseHeigth obsolete
Global $hBitmapFirst
#endregion

; CSV Speed
 Global $g_hCmbCSVSpeed[2] = [$LB, $DB]
 Global $g_iCmbCSVSpeed[2] = [$LB, $DB]
 Global $g_hDivider

; SmartUpgrade
Global $ichkSmartUpgrade
Global $ichkIgnoreTH, $ichkIgnoreKing, $ichkIgnoreQueen, $ichkIgnoreWarden, $ichkIgnoreCC, $ichkIgnoreLab
Global $ichkIgnoreBarrack, $ichkIgnoreDBarrack, $ichkIgnoreFactory, $ichkIgnoreDFactory, $ichkIgnoreGColl, $ichkIgnoreEColl, $ichkIgnoreDColl
Global $iSmartMinGold, $iSmartMinElixir, $iSmartMinDark
Global $sBldgText, $sBldgLevel, $aString
Global $upgradeName[3] = ["", "", ""]
Global $UpgradeCost
Global $TypeFound = 0
Global $UpgradeDuration
Global $canContinueLoop = True

; SwitchAcc_Demen_Style
Global $profile = $g_sProfilePath & "\Profile.ini"
Global $iSwitchAccStyle = 1	; 1 = DocOc, 2 = Demen
Global $ichkSwitchAcc = 0, $ichkTrain = 0, $icmbTotalCoCAcc, $nTotalCoCAcc = 8, $ichkSmartSwitch, $ichkCloseTraining
Global $nTotalProfile = 1, $nCurProfile = 1, $nNextProfile
Global $ProfileList
Global $aProfileType[8]		; Type of the all Profiles, 1 = active, 2 = donate, 3 = idle
Global $aMatchProfileAcc[8]	; Accounts match with All Profiles
Global $aDonateProfile, $aActiveProfile
Global $aAttackedCountSwitch[8], $ActiveSwitchCounter = 0, $DonateSwitchCounter = 0
Global $bReMatchAcc = False
Global $aTimerStart[8], $aTimerEnd[8]
Global $aRemainTrainTime[8], $aUpdateRemainTrainTime[8], $nMinRemainTrain
Global $aLocateAccConfig[8], $aAccPosY[8]

; Profile Switch 
Global $profileString
Global $ichkGoldSwitchMax = 0, $itxtMaxGoldAmount = 6000000, $icmbGoldMaxProfile = 0, $ichkGoldSwitchMin = 0, $itxtMinGoldAmount = 500000, $icmbGoldMinProfile = 0
Global $ichkElixirSwitchMax = 0, $itxtMaxElixirAmount = 6000000, $icmbElixirMaxProfile = 0, $ichkElixirSwitchMin = 0, $itxtMinElixirAmount = 500000, $icmbElixirMinProfile = 0
Global $ichkDESwitchMax = 0, $itxtMaxDEAmount = 200000, $icmbDEMaxProfile = 0, $ichkDESwitchMin = 0, $itxtMinDEAmount = 10000, $icmbDEMinProfile = 0
Global $ichkTrophySwitchMax = 0, $itxtMaxTrophyAmount = 3000, $icmbTrophyMaxProfile = 0, $ichkTrophySwitchMin = 0, $itxtMinTrophyAmount = 1000, $icmbTrophyMinProfile = 0

Global $chkGoldSwitchMax = 0, $cmbGoldMaxProfile = 0, $lblGoldMax = 0, $txtMaxGoldAmount = 0
Global $chkGoldSwitchMin = 0, $cmbGoldMinProfile = 0, $lblGoldMin = 0, $txtMinGoldAmount = 0, $picProfileGold = 0
Global $chkElixirSwitchMax = 0, $cmbElixirMaxProfile = 0, $lblElixirMax = 0, $txtMaxElixirAmount = 0
Global $chkElixirSwitchMin = 0, $cmbElixirMinProfile = 0, $lblElixirMin = 0, $txtMinElixirAmount = 0, $picProfileElixir = 0
Global $chkDESwitchMax = 0, $cmbDEMaxProfile = 0, $lblDEMax = 0, $txtMaxDEAmount = 0
Global $chkDESwitchMin = 0, $cmbDEMinProfile = 0, $lblDEMin = 0, $txtMinDEAmount = 0, $picProfileDE = 0
Global $chkTrophySwitchMax = 0, $cmbTrophyMaxProfile = 0, $lblTrophyMax = 0, $txtMaxTrophyAmount = 0
Global $chkTrophySwitchMin = 0, $cmbTrophyMinProfile = 0, $lblTrophyMin = 0, $txtMinTrophyAmount = 0, $picProfileTrophy = 0