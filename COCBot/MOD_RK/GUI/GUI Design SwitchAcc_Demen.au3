; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Mod - Switch Account
; Description ...: This file creates the "Mods" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team Mod MBR (NguyenAnhHD, Demen)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $lblProfileNo[8], $lblProfileName[8], $cmbAccountNo[8], $cmbProfileType[8]
Global $chkSwitchAcc = 0, $chkTrain = 0, $cmbTotalAccount = 0, $radNormalSwitch = 0, $radSmartSwitch = 0, $chkUseTrainingClose = 0, $radCloseCoC = 0, $radCloseAndroid = 0, $cmbLocateAcc = 0
Global $g_StartHideSwitchAcc_Demen = 0, $g_SecondHideSwitchAcc_Demen, $g_EndHideSwitchAcc_Demen = 0

Func CreateSwitchAcc_Demen()
	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)

	; Adding option for SwitchAcc_Demen_Style
	Local $x = 20, $y = 45
	GUICtrlCreateLabel(GetTranslated(109,1, "Switch Account Style:"), $x + 285, $y, -1, -1)
	$g_hRdoSwitchAcc_DocOc = GUICtrlCreateRadio("DocOc", $x + 270, $y + 16, -1, -1)
		_GUICtrlSetTip(-1, GetTranslated(109,2, "Use SwitchAcc moded by DocOc Team"))
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetOnEvent(-1, "RdoSwitchAcc_Style")
	$g_hRdoSwitchAcc_Demen = GUICtrlCreateRadio("Demen", $x + 350, $y + 16, -1, -1)
		_GUICtrlSetTip(-1, GetTranslated(109,3, "Use SwitchAcc moded by Demen"))
		GUICtrlSetOnEvent(-1, "RdoSwitchAcc_Style")

	Local $sTxtTip = ""
	Local $x = 22, $y = 105

		$g_StartHideSwitchAcc_Demen = GUICtrlCreateDummy()
		GUICtrlCreateGroup(GetTranslated(109,4, "Switch Account Mode"), $x - 12, $y - 20, 200, 295)
			$chkSwitchAcc = GUICtrlCreateCheckbox(GetTranslated(109,5, "Enable Switch Account"), $x - 5, $y, -1, -1)
				$sTxtTip = GetTranslated(109,6, "Switch to another account & profile when troop training time is >= 1 minutes") & _
					@CRLF & GetTranslated(109,7, "This function supports maximum 8 CoC accounts & 8 Bot profiles") & _
					@CRLF & GetTranslated(109,8, "Make sure to create sufficient Profiles equal to number of CoC Accounts")
				GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "chkSwitchAcc")

			$chkTrain = GUICtrlCreateCheckbox(GetTranslated(109,9, "Pre-train"), $x + 127, $y, -1, -1)
				$sTxtTip = GetTranslated(109,10, "Enable it to pre-train donated troops in quick train 3 before switch to next account.") & _
					@CRLF & GetTranslated(109,11, "This function requires use Quick Train, not Custom Train.") & _
					@CRLF & GetTranslated(109,12, "Use army 1 for farming troops, army 2 for spells and army 3 for donated troops.")
				GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "chkTrain")

			GUICtrlCreateLabel(GetTranslated(109,13, "Total CoC Acc:"), $x + 10, $y + 29, -1, -1)
				$sTxtTip = GetTranslated(109,14, "Choose number of CoC Accounts pre-logged")

			$cmbTotalAccount = GUICtrlCreateCombo("", $x + 95, $y + 25, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "1 Acc." & "|" & "2 Acc." & "|" & "3 Acc." & "|" & "4 Acc." & "|" & "5 Acc." & "|" & "6 Acc." & "|" & "7 Acc." & "|" & "8 Acc.")
				GUICtrlSetTip(-1, $sTxtTip)

			$radNormalSwitch = GUICtrlCreateRadio(GetTranslated(109,15, "Normal switch"), $x + 10, $y + 55, -1, 16)
				GUICtrlSetTip(-1, GetTranslated(109,16, "Switching accounts continously"))
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$radSmartSwitch = GUICtrlCreateRadio(GetTranslated(109,17, "Smart switch"), $x + 100, $y + 55, -1, 16)
				GUICtrlSetTip(-1, GetTranslated(109,18, "Switch to account with the shortest remain training time"))
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$y += 80
			$chkUseTrainingClose = GUICtrlCreateCheckbox(GetTranslated(109,19, "Combo Sleep after Switch Acc."), $x - 5, $y, -1, -1)
				$sTxtTip = GetTranslated(109,20, "Close CoC combo with Switch Account when there is more than 3 mins remaining on training time of all accounts.")
				GUICtrlSetTip(-1, $sTxtTip)

			GUIStartGroup()
			$radCloseCoC = GUICtrlCreateRadio(GetTranslated(109,21, "Close CoC"), $x + 10, $y + 30, -1, 16)
				GUICtrlSetState(-1, $GUI_CHECKED)

			$radCloseAndroid = GUICtrlCreateRadio(GetTranslated(109,22, "Close Android"), $x + 100, $y + 30, -1, 16)

			$y += 60
			GUICtrlCreateLabel(GetTranslated(109,23, "Manually locate account coordinates"), $x, $y, -1, -1)

			$cmbLocateAcc = GUICtrlCreateCombo("", $x + 15, $y + 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(109,24, "Select CoC Account to manually locate its y-coordinate")
				GUICtrlSetData(-1, "Acc. 1" & "|" & "Acc. 2" & "|" & "Acc. 3" & "|" & "Acc. 4" & "|" & "Acc. 5" & "|" & "Acc. 6" & "|" & "Acc. 7" & "|" & "Acc. 8", "Acc. 1")
				GUICtrlSetTip(-1, $sTxtTip)

			GUICtrlCreateButton(GetTranslated(109,25, "Locate"), $x + 80, $y + 24 , 50, 23)
				GUICtrlSetTip(-1, GetTranslated(109,26, "Starting locate your CoC Account"))
				GUICtrlSetOnEvent(-1, "btnLocateAcc")

			GUICtrlCreateButton(GetTranslated(109,27, "Clear All"), $x + 135, $y + 24 , 50, 23, $BS_MULTILINE)
				GUICtrlSetTip(-1, GetTranslated(109,28, "Clear location data of all accounts"))
				GUICtrlSetOnEvent(-1, "btnClearAccLocation")

		GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Profiles & Account matching
	Local $x = 235, $y = 105

	GUICtrlCreateGroup(GetTranslated(109,29, "Profiles"), $x - 20, $y - 20, 225, 295)
		GUICtrlCreateButton(GetTranslated(109,30, "Update Profiles"), $x + 40, $y - 5 , -1, 25)
			GUICtrlSetOnEvent(-1, "g_btnUpdateProfile")
		GUICtrlCreateButton(GetTranslated(109,31, "Clear Profiles"), $x + 130, $y - 5 , -1, 25)
			GUICtrlSetOnEvent(-1, "btnClearProfile")

	$y += 35
		GUICtrlCreateLabel(GetTranslated(109,32, "No."), $x-10, $y, 15,-1,$SS_CENTER)
		GUICtrlCreateLabel(GetTranslated(109,33, "Profile Name"), $x+10, $y, 90,-1,$SS_CENTER)
		GUICtrlCreateLabel(GetTranslated(109,34, "Acc."), $x+105, $y, 30,-1,$SS_CENTER)
		GUICtrlCreateLabel(GetTranslated(109,35, "Bot Type"), $x+140, $y, 60,-1,$SS_CENTER)

	$y += 20
		GUICtrlCreateGraphic($x - 10, $y, 205, 1, $SS_GRAYRECT)
		GUICtrlCreateGraphic($x + 10, $y - 25, 1, 40, $SS_GRAYRECT)

	$g_SecondHideSwitchAcc_Demen = GUICtrlCreateDummy()
	$y += 10
		 For $i = 0 To 7
			$lblProfileNo[$i] = GUICtrlCreateLabel($i + 1 & ".", $x -10, $y + 4 + ($i) * 25, 15, 18, $SS_CENTER)
			GUICtrlCreateGraphic($x + 10, $y + ($i) * 25, 1, 25, $SS_GRAYRECT)

			$lblProfileName[$i] = GUICtrlCreateLabel(GetTranslated(109,36, "Village Name"), $x +10, $y + 4 + ($i) * 25, 90, 18, $SS_CENTER)
				If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, $ProfileList[$i+1])
			$cmbAccountNo[$i] = GUICtrlCreateCombo("", $x + 105, $y + ($i) * 25, 30, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(109,37, "Select the index of CoC Account to match with this Profile")
				GUICtrlSetData(-1, "1" & "|" & "2" & "|" & "3" & "|" & "4" & "|" & "5" & "|" & "6" & "|" & "7" & "|" & "8")
				GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "cmbMatchProfileAcc"&$i+1)
			$cmbProfileType[$i] = GUICtrlCreateCombo("", $x + 140, $y + ($i) * 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(109,38, "Define the botting type of this profile")
				GUICtrlSetData(-1, GetTranslated(109,39, "Active") & "|" & GetTranslated(109,40, "Donate") & "|" & GetTranslated(109,41, "Idle"))
				GUICtrlSetTip(-1, $sTxtTip)
			If $i > $nTotalProfile - 1 Then
				For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
					GUICtrlSetState($j, $GUI_HIDE)
				Next
			EndIf
		 Next
		 GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$g_EndHideSwitchAcc_Demen = GUICtrlCreateDummy()

	For $i = $g_StartHideSwitchAcc_Demen To $g_EndHideSwitchAcc_Demen
		GUICtrlSetState($i,$GUI_HIDE)
	Next

EndFunc



