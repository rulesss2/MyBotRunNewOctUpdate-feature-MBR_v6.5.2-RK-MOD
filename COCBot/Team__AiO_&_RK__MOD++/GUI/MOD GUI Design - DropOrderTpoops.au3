; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Design DropOrderTpoops
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: Kychera 05/2017
; Modified ......: Team AiO & RK MOD++ (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Global $g_hChkCustomTrainDropOrderEnable = 0
Global $g_bCustomTrainDropOrderEnable = False
Global $g_hBtnRemoveTroops2, $g_hBtnTroopOrderSet2
Global $g_ahImgTroopDropOrderSet = 0
Global $g_ahImgTroopDropOrder[$eTroopCountDrop] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Global $cmbDropTroops = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Global Const $g_asTroopDropList[] = [ "", _
   GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtBarbarians", "Barbarians"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtArchers", "Archers"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtGiants", "Giants"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtGoblins", "Goblins"), _
   GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtWallBreakers", "Wall Breakers"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtBalloons", "Balloons"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtWizards", "Wizards"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtHealers", "Healers"), _
   GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtDragons", "Dragons"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtPekkas", "Pekkas"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtBabyDragons", "Baby Dragons"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtMiners", "Miners"), _
   GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtMinions", "Minions"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtHogRiders", "Hog Riders"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtValkyries", "Valkyries"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtGolems", "Golems"), _
   GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtWitches", "Witches"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtLavaHounds", "Lava Hounds"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtBowlers", "Bowlers"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtClanCastle", "ClanCastle"), GetTranslatedFileIni("MBR Global GUI Design Names Troops", "TxtHeroes", "Heroes")]


Func TroopsDrop()
$g_hGUI_TRAINARMY_TAB_ITEM5 = GUICtrlCreateTabItem(GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "g_hGUI_TRAINARMY_TAB_ITEM5", "Order Troops"))
;$10 = GUICtrlCreatePic(@ScriptDir & '\COCBot\Team__AiO_&_RK__MOD++\Images\1.jpg', 2, 23, 442, 410, $WS_CLIPCHILDREN)
Local $x = 25, $y = 45
GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "Group_1", "Custom dropping order"), $x - 20, $y - 20, 350, 380)
$x += 10
$y += 20
        ;GUICtrlCreateLabel("BETA", $x + 200, $y - 35, 50, 30)
		;GUICtrlSetFont(-1, 14, 700, 0, "Comic Sans MS")
		 ;GUICtrlSetBkColor(-1, 0xCCFFCC)
$g_hChkCustomTrainDropOrderEnable = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "ChkCustomTrainDropOrderEnable", "Enable troops order drop"), $x - 10, $y - 20, -1, -1)
	   GUICtrlSetState(-1, $GUI_UNCHECKED)
	   _GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "TxtDropOrderEnable_Info_01", "Enable to select a custom troop dropping order") & @CRLF & _
						  GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "TxtDropOrderEnable_Info_02", "Changing drop order can NOT be used with CSV scripted attack! For a standard attack. Live and dead bases. Consistency - all troops"))
	   GUICtrlSetOnEvent(-1, "chkTroopDropOrder")

	  ; Create translated list of Troops for combo box
Local $sComboData = ""
	    For $j = 0 To UBound($g_asTroopDropList) - 1
		  $sComboData &= $g_asTroopDropList[$j] & "|"
	    Next
$y += 5
	  For $p = 0 To $eTroopCountDrop - 1
		  If $p < 10 Then
			  GUICtrlCreateLabel($p + 1 & ":", $x - 19, $y + 2, -1, 18)
			  $cmbDropTroops[$p] = GUICtrlCreateCombo("", $x, $y, 94, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				  GUICtrlSetOnEvent(-1, "GUITrainOrder2")
				 GUICtrlSetData(-1, $sComboData, "")

				 ;_GUICtrlSetTip(-1, $txtTroopOrder & $p + 1)
				 GUICtrlSetState(-1, $GUI_DISABLE)
			  $g_ahImgTroopDropOrder[$p] = GUICtrlCreateIcon($g_sLibIconPath, $eIcnOptions, $x + 96, $y + 1, 18, 18)
			  $y += 25 ; move down to next combobox location
		  Else
			  If $p = 10 Then
				  $x += 128
				  $y = 45 + 23
			  EndIf
			  GUICtrlCreateLabel($p + 1 & ":", $x - 5, $y + 2, -1, 18)
			  $cmbDropTroops[$p] = GUICtrlCreateCombo("", $x + 20, $y, 94, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				  GUICtrlSetOnEvent(-1, "GUITrainOrder2")
				 GUICtrlSetData(-1, $sComboData, "")

				 ;_GUICtrlSetTip(-1, $txtTroopOrder & $p + 1)
				 GUICtrlSetState(-1, $GUI_DISABLE)
			$g_ahImgTroopDropOrder[$p] =  GUICtrlCreateIcon($g_sLibIconPath, $eIcnOptions, $x + 120, $y + 1, 18, 18)
			  $y += 25 ; move down to next combobox location
		  EndIf
	  Next

	  $x = 25
	  $y = 350
		  ; Create push button to set training order once completed
		  $g_hBtnTroopOrderSet2 = GUICtrlCreateButton(GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "BtnTroopOrderSet2", "Apply New Order"), $x, $y, 100, 25)
			 GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_ENABLE))
			 _GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "TxtBtnTroopOrderSet2_Info_01", "Push button when finished selecting custom troops dropping order") & @CRLF & _
								GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "TxtBtnTroopOrderSet2_Info_02", "When not all troop slots are filled, will use random troop order in empty slots!"))
			 GUICtrlSetOnEvent(-1, "btnTroopOrderSet2")
		  ;$g_ahImgTroopOrderSet = GUICtrlCreateIcon($g_sLibIconPath, $eIcnSilverStar, $x + 226, $y + 2, 18, 18)
      $x += 150
	     $g_hBtnRemoveTroops2 = GUICtrlCreateButton(GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "BtnRemoveTroops2", "Empty drop list"), $x, $y, 110, 25)
			GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_DISABLE))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - DropOrderTpoops", "TxtBtnRemoveTroops2_Info_01", "Push button to remove all troops from list and start over"))
			GUICtrlSetOnEvent(-1, "btnRemoveTroops2")

EndFunc