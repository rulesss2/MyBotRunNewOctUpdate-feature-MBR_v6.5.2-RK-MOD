#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

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

