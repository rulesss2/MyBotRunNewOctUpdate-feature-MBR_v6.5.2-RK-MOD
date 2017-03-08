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

Global $iChkLaunchWatchdog = 1
Global $ChkLaunchWatchdog = 0

