; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

$hGUI_BullyMode = GUICreate("", $_GUI_MAIN_WIDTH - 30 - 10, $_GUI_MAIN_HEIGHT - 255 - 30 - 30, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_SEARCH)
;GUISetBkColor($COLOR_WHITE, $hGUI_BullyMode)
;$hGUI_BullyMode = GUICreate("", $_GUI_MAIN_WIDTH - 30 - 10, $_GUI_MAIN_HEIGHT - 255 - 30, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_SEARCH)
$22 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 0, 442, 363, $WS_CLIPCHILDREN)
GUISwitch($hGUI_BullyMode)

Local $x = 20, $y = 130 - 105
	$grpBullyAtkCombo = GUICtrlCreateGroup(GetTranslated(629,1, "Bully Attack Combo"), $x - 20, $y - 20, 430, 330)
	    $y -= 5
		$x -= 10
		 $lblBullyMode	= GUICtrlCreateLabel(GetTranslated(629,2, "In Bully Mode, ALL bases that meet the TH level requirement below will be attacked.") , $x - 5, $y + 3, 209, 30, $SS_LEFT)
		 GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$y +=35
		$lblBullyDelay = GUICtrlCreateLabel(GetTranslated(629,3,"Enable Bully after"), $x, $y+3)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$txtATBullyMode = GUICtrlCreateInput("150", $x + 95, $y, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(629,4, "TH Bully: No. of searches to wait before activating.")
			GUICtrlSetLimit(-1, 3)
			_GUICtrlSetTip(-1, $txtTip)
		$lblATBullyMode = GUICtrlCreateLabel(GetTranslated(603,5, -1), $x + 135, $y + 5, -1, -1)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$y +=25
		$lblATBullyMode = GUICtrlCreateLabel(GetTranslated(629,6, "Max TH level") & ":", $x - 5, $y + 3, 90, -1, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$cmbYourTH = GUICtrlCreateCombo("", $x + 95, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(629,7, "TH Bully: Max. Townhall level to bully.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "4-6|7|8|9|10|11", "4-6")
		$y += 24
		GUICtrlCreateLabel(GetTranslated(629,8, "When found, Attack with settings from")&":", $x + 10, $y, -1, -1, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$y += 14
		$radUseDBAttack = _GUICtrlCreateRadio(GetTranslated(629,9, "DeadBase Atk."), $x + 20, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(629,10, "Use Dead Base attack settings when attacking a TH Bully match."))
			GUICtrlSetState(-1, $GUI_CHECKED)
		$radUseLBAttack = _GUICtrlCreateRadio(GetTranslated(629,11, "Active Base Atk."), $x + 115, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(629,12, "Use Active Base attack settings when attacking a TH Bully match."))
	GUICtrlCreateGroup("", -99, -99, 1, 1)
