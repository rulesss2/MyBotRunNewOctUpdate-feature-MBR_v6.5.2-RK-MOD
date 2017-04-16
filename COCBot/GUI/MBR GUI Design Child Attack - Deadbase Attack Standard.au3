; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Standard Attack" tab under the "Attack" tab under the "DeadBase" tab under the "Search & Attack" tab under the "Attack Plan" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_DEADBASE_ATTACK_STANDARD = 0
Global $g_hCmbStandardDropOrderDB = 0, $g_hCmbStandardDropSidesDB = 0, $g_hCmbStandardUnitDelayDB = 0, $g_hCmbStandardWaveDelayDB = 0, $g_hChkRandomSpeedAtkDB = 0, _
	   $g_hChkSmartAttackRedAreaDB = 0, $g_hCmbSmartDeployDB = 0, $g_hChkAttackNearGoldMineDB = 0, $g_hChkAttackNearElixirCollectorDB = 0, $g_hChkAttackNearDarkElixirDrillDB = 0

Global $g_hLblSmartDeployDB = 0, $g_hPicAttackNearDarkElixirDrillDB = 0

Func CreateAttackSearchDeadBaseStandard()

   $g_hGUI_DEADBASE_ATTACK_STANDARD = _GUICreate("", $_GUI_MAIN_WIDTH - 195, $g_iSizeHGrpTab4, 150, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_DEADBASE)
   ;GUISetBkColor($COLOR_WHITE, $g_hGUI_DEADBASE_ATTACK_STANDARD)
  $43 = GUICtrlCreatePic (@ScriptDir & "\Images2\1.jpg", 0, -5, 280, 352, $WS_CLIPCHILDREN)
   Local $sTxtTip
   Local $x = 25, $y = 20
	   GUICtrlCreateGroup(GetTranslated(608,1,"Deploy"), $x - 20, $y - 20, 270, $g_iSizeHGrpTab4)
   ;	$x -= 15
		   GUICtrlCreateLabel(GetTranslated(608,2,"Troop Drop Order"),$x, $y, 143,18,$SS_LEFT)
           GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $y += 15
		   $g_hCmbStandardDropOrderDB = GUICtrlCreateCombo("", $x, $y, 150, Default, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1, GetTranslated(608,25,"Default(All Troops)")&"|Barch/BAM/BAG|GiBarch", GetTranslated(608,25, -1))
			   _GUICtrlSetTip(-1, GetTranslated(608,33,"Select a preset troop drop order.") & @CRLF & _
								  GetTranslated(608,34,"Each option deploys troops in a different order and in different waves") & @CRLF & _
								  GetTranslated(608,35,"Only the troops selected in the ""Only drop these troops"" option will be dropped"))

		   $y += 25
		   GUICtrlCreateLabel(GetTranslated(608,3, "Attack on")&":", $x, $y + 5, -1, -1)
		   GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $g_hCmbStandardDropSidesDB = GUICtrlCreateCombo("", $x + 55, $y, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   _GUICtrlSetTip(-1, GetTranslated(608,4, "Attack on a single side, penetrates through base") & @CRLF & _
								  GetTranslated(608,5, "Attack on two sides, penetrates through base") & @CRLF & _
								  GetTranslated(608,6, "Attack on three sides, gets outer and some inside of base"), _
								  GetTranslated(608,40, "Attack on Classic Four Fingers"), _
								  GetTranslated(671,42, "Multi Finger"), _
								  GetTranslated(608,7,"Select the No. of sides to attack on."))
			   GUICtrlSetData(-1, GetTranslated(608,8, "one side") & "|" & GetTranslated(608,9, "two sides") & "|" & _
								  GetTranslated(608,10, "three sides") & "|" & GetTranslated(608,11, "all sides equally") & "|" & GetTranslated(608,41, "Classic Four Fingers") & "|" & GetTranslated(671,42, "Multi Finger"), _
								  GetTranslated(608,11, -1))
			   GUICtrlSetOnEvent(-1, "Bridge") ; Uncheck SmartAttack Red Area when enable FourFinger to avoid conflict

		   $y += 25
		   GUICtrlCreateLabel(GetTranslated(608,12, "Delay Unit") & ":", $x, $y + 5, -1, -1)
		   GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
			   $sTxtTip = GetTranslated(608,13, "This delays the deployment of troops, 1 (fast) = like a Bot, 10 (slow) = Like a Human.") & @CRLF & _
						  GetTranslated(608,14, "Random will make bot more varied and closer to a person.")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hCmbStandardUnitDelayDB = GUICtrlCreateCombo("", $x + 55, $y, 36, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "4")
		   GUICtrlCreateLabel(GetTranslated(608,15, "Wave") & ":", $x + 100, $y + 5, -1, -1)
		   GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hCmbStandardWaveDelayDB = GUICtrlCreateCombo("", $x + 140, $y, 36, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "4")

		  $y += 22
		   $g_hChkRandomSpeedAtkDB = GUICtrlCreateCheckbox("", $x, $y, 13, 13)
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetOnEvent(-1, "chkRandomSpeedAtkDB")
			   GUICtrlCreateLabel(GetTranslated(608,16, "Randomize delay for Units && Waves"), $x + 17, $y, -1, -1)
               GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $y +=22
		   $g_hChkSmartAttackRedAreaDB = GUICtrlCreateCheckbox("", $x, $y, 13, 13)
			   _GUICtrlSetTip(-1, GetTranslated(608,18, "Use Smart Attack to detect the outer 'Red Line' of the village to attack. And drop your troops close to it."))
			   GUICtrlSetState(-1, $GUI_CHECKED)
			   GUICtrlSetOnEvent(-1, "chkSmartAttackRedAreaDB")
			   GUICtrlCreateLabel(GetTranslated(608,18, "Use Smart Attack to detect the outer 'Red Line' of the village to attack. And drop your troops close to it."), $x + 17, $y, -1, -1)
		       GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $y += 22
		   $g_hLblSmartDeployDB = GUICtrlCreateLabel(GetTranslated(608,19, "Drop Type") & ":", $x, $y + 5, -1, -1)
		   GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
			   $sTxtTip = GetTranslated(608,20, "Select the Deploy Mode for the waves of Troops.") & @CRLF & GetTranslated(608,21, "Type 1: Drop a single wave of troops on each side then switch troops, OR") & @CRLF & GetTranslated(608,22, "Type 2: Drop a full wave of all troops (e.g. giants, barbs and archers) on each side then switch sides.")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hCmbSmartDeployDB = GUICtrlCreateCombo("", $x + 55, $y, 120, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1, GetTranslated(608,23, "Sides, then Troops") & "|" & GetTranslated(608,24, "Troops, then Sides") , GetTranslated(608,23, -1))
			   _GUICtrlSetTip(-1, $sTxtTip)

		   $y += 26
		   $g_hChkAttackNearGoldMineDB = GUICtrlCreateCheckbox("", $x + 20, $y, 17, 17)
			   $sTxtTip = GetTranslated(608,26, "Drop troops near Gold Mines")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   GUICtrlCreateIcon($g_sLibIconPath, $eIcnMine, $x + 40 , $y - 3 , 24, 24)
			   _GUICtrlSetTip(-1, $sTxtTip)

		   $x += 75
		   $g_hChkAttackNearElixirCollectorDB = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
			   $sTxtTip = GetTranslated(608,27, "Drop troops near Elixir Collectors")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   GUICtrlCreateIcon($g_sLibIconPath, $eIcnCollector, $x + 20 , $y - 3 , 24, 24)
			   _GUICtrlSetTip(-1, $sTxtTip)

		   $x += 55
		   $g_hChkAttackNearDarkElixirDrillDB = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
			   $sTxtTip = GetTranslated(608,28, "Drop troops near Dark Elixir Drills")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hPicAttackNearDarkElixirDrillDB = GUICtrlCreateIcon($g_sLibIconPath, $eIcnDrill, $x + 20 , $y - 3, 24, 24)
			   _GUICtrlSetTip(-1, $sTxtTip)
	$x = 25
	$y += 15
	$LblDBMultiFinger = GUICtrlCreateLabel(GetTranslated(671,51,"Style:"), $x - 5, $y + 3, 35, -1, $SS_RIGHT)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$CmbDBMultiFinger = GUICtrlCreateCombo("", $x + 35, $y, 175, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		$sTxtTip = GetTranslated(671,52,"Select which multi finger attack style you would like.") & @CRLF & @CRLF & _
			GetTranslated(671,53,	  "     Random will chose one of the attacks at random.") & @CRLF & _
			GetTranslated(671,54,	  "     Four Finger and Eight Finger attacks will attack from all 4 sides at once.")
	GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetData(-1,  GetTranslated(671,43,"Random") & "|" & _
						GetTranslated(671,44,"Four Finger Standard") & "|" & _
						GetTranslated(671,45,"Four Finger Spiral Left") & "|" & _
						GetTranslated(671,46,"Four Finger Spiral Right") & "|" & _
						GetTranslated(671,47,"Eight Finger Blossom") & "|" & _
						GetTranslated(671,48,"Eight Finger Implosion") & "|" & _
						GetTranslated(671,49,"Eight Finger Pin Wheel Spiral Left") & "|" & _
						GetTranslated(671,50,"Eight Finger Pin Wheel Spiral Right"), GetTranslated(671,44,"Four Finger Standard"))
	GUICtrlSetOnEvent(-1, "cmbDBMultiFinger")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; Unit Wave Factor
$x = 20
$y = 220

GUICtrlCreateGroup(GetTranslated(671, 107, "Deploy speed for all standard attack mode."), $x, $y, 255, 110)
$y += 5
$ChkGiantSlot = _GUICtrlCreateCheckbox(GetTranslated(671, 102,"GiantSlot"), $x+10, $y + 10, 130, 25)
	$sTxtTip = GetTranslated(671, 103, "perimeter (> = 12, recommended)") & @CRLF & _               
			   GetTranslated(671, 104, "two points on each side (> = 8, recommended)")
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "ChkGiantSlot")
	GUICtrlSetState(-1, $GUI_UNCHECKED)
$CmbGiantSlot = GUICtrlCreateCombo("", $x + 130, $y + 20, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1,  GetTranslated(671, 112, "Perimeter") & "|" & _
                    GetTranslated(671, 113, "TwoPoints"), GetTranslated(671, 112, "Perimeter"))
					GUICtrlSetOnEvent(-1, "CmbGiantSlot")   
$y += 30
$ChkUnitFactor = _GUICtrlCreateCheckbox(GetTranslated(671, 108, "Modify Unit Factor"), $x+10, $y + 10, 130, 25)
	$sTxtTip = GetTranslated(671, 109, "Unit deploy delay = Unit setting x Unit Factor (millisecond)")
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkUnitFactor")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$TxtUnitFactor = GUICtrlCreateInput("10", $x + 180, $y + 20, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$sTxtTip = GetTranslated(671, 109, "Unit deploy delay = Unit setting x Unit Factor (millisecond)")
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 10)
	GUICtrlSetOnEvent(-1, "chkUnitFactor")
$y += 30
$ChkWaveFactor = _GUICtrlCreateCheckbox(GetTranslated(671, 110, "Modify Wave Factor"), $x+10, $y + 10, 130, 25)
	$sTxtTip = GetTranslated(671, 111, "Switch troop delay = Wave setting x Wave Factor (millisecond)")
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkWaveFactor")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$TxtWaveFactor = GUICtrlCreateInput("100", $x + 180, $y + 20, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$sTxtTip = GetTranslated(671, 111, "Switch troop delay = Wave setting x Wave Factor (millisecond)")
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 100)
	GUICtrlSetOnEvent(-1, "chkWaveFactor")   
	   GUICtrlCreateGroup("", -99, -99, 1, 1)
 GUICtrlCreateGroup("", -99, -99, 1, 1)
   ;GUISetState()
EndFunc
