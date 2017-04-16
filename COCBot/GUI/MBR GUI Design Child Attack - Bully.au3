; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Bully" tab under the "Search & Attack" tab under the "Attack Plan" tab
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

Global $g_hGUI_BULLY = 0

Global $g_hTxtATBullyMode = 0, $g_hCmbBullyMaxTH = 0, $g_hRadBullyUseDBAttack = 0, $g_hRadBullyUseLBAttack = 0
Global $g_hGrpBullyAtkCombo = 0, $g_hLblBullyMode = 0, $g_hLblATBullyMode = 0

Global $g_ahPicBullyMaxTH[12]

Func CreateAttackSearchBully()
	Local $sTxtTip = ""
   $g_hGUI_BULLY = _GUICreate("", $g_iSizeWGrpTab3, $g_iSizeHGrpTab3, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_SEARCH)
   ;GUISetBkColor($COLOR_WHITE, $g_hGUI_BULLY)
   GUISwitch($g_hGUI_BULLY)
   $22 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 0, 442, 363, $WS_CLIPCHILDREN)
   Local $x = 20, $y = 130 - 105
	   $g_hGrpBullyAtkCombo = GUICtrlCreateGroup(GetTranslated(629,1, "Bully Attack Combo"), $x - 20, $y - 20, $g_iSizeWGrpTab3, $g_iSizeHGrpTab3 - 6)
		   $y -= 5
		   $x -= 10
			$g_hLblBullyMode = GUICtrlCreateLabel(GetTranslated(629,2, "In Bully Mode, ALL bases that meet the TH level requirement below will be attacked.") , $x - 5, $y + 3, 209, 30, $SS_LEFT)
            GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $y +=35
		   GUICtrlCreateLabel(GetTranslated(629,3,"Enable Bully after"), $x, $y+3)
		   GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $g_hTxtATBullyMode = GUICtrlCreateInput("150", $x + 95, $y, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			   GUICtrlSetLimit(-1, 3)
			   _GUICtrlSetTip(-1, GetTranslated(629,4, "TH Bully: No. of searches to wait before activating."))
		   GUICtrlCreateLabel(GetTranslated(603, 11, -1), $x + 135, $y + 5, -1, -1)
           GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $y +=25
		   $g_hLblATBullyMode = GUICtrlCreateLabel(GetTranslated(629,6, "Max TH level") & ":", $x - 5, $y + 3, 90, -1, $SS_RIGHT)
           GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $g_hCmbBullyMaxTH = GUICtrlCreateCombo("", $x + 85, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   $sTxtTip = GetTranslated(629,7, "TH Bully: Max. Townhall level to bully.")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetData(-1, "4-6|7|8|9|10|11", "4-6")
			GUICtrlSetOnEvent(-1, "CmbBullyMaxTH")
		$g_ahPicBullyMaxTH[6] = GUICtrlCreateIcon($g_sLibIconPath, $eHdV06, $x + 137, $y - 3, 24, 24)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState (-1, $GUI_SHOW)
		$g_ahPicBullyMaxTH[7] = GUICtrlCreateIcon($g_sLibIconPath, $eHdV07, $x + 137, $y - 3, 24, 24)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$g_ahPicBullyMaxTH[8] = GUICtrlCreateIcon($g_sLibIconPath, $eHdV08, $x + 137, $y - 3, 24, 24)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$g_ahPicBullyMaxTH[9] = GUICtrlCreateIcon($g_sLibIconPath, $eHdV09, $x + 137, $y - 3, 24, 24)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$g_ahPicBullyMaxTH[10] = GUICtrlCreateIcon($g_sLibIconPath, $eHdV10, $x + 137, $y - 3, 24, 24)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$g_ahPicBullyMaxTH[11] = GUICtrlCreateIcon($g_sLibIconPath, $eHdV11, $x + 137, $y - 3, 24, 24)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState (-1, $GUI_HIDE)

		   $y += 24
		   GUICtrlCreateLabel(GetTranslated(629,8, "When found, Attack with settings from")&":", $x + 10, $y, -1, -1, $SS_RIGHT)
           GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		   $y += 14
		   $g_hRadBullyUseDBAttack = _GUICtrlCreateRadio(GetTranslated(629,9, "DeadBase Atk."), $x + 20, $y, -1, -1)
			   _GUICtrlSetTip(-1, GetTranslated(629,10, "Use Dead Base attack settings when attacking a TH Bully match."))
			   GUICtrlSetState(-1, $GUI_CHECKED)
		   $g_hRadBullyUseLBAttack = _GUICtrlCreateRadio(GetTranslated(629,11, "Active Base Atk."), $x + 115, $y, -1, -1)
			   _GUICtrlSetTip(-1, GetTranslated(629,12, "Use Active Base attack settings when attacking a TH Bully match."))
	   GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc
