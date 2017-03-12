#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
; Switch Profile by rulesss
Func btnRecycle()
	FileDelete($config)
	SaveConfig()
	SetLog(GetTranslated(637, 20, "Profile ") & $sCurrProfile & GetTranslated(637, 21, " was recycled with success"), $COLOR_GREEN)
	SetLog(GetTranslated(637, 22, "All unused settings were removed"), $COLOR_GREEN)
EndFunc   ;==>btnRecycle
; Script Start - Add your code below here
Func setupProfileComboBoxswitch()
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbGoldMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbGoldMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbGoldMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbGoldMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbElixirMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbElixirMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbElixirMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbElixirMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbDEMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbDEMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbDEMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbDEMinProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbTrophyMaxProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbTrophyMaxProfile, $profileString, "<No Profiles>")
		; Clear the combo box current data in case profiles were deleted
		GUICtrlSetData($cmbTrophyMinProfile, "", "")
		; Set the new data of available profiles
		GUICtrlSetData($cmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBox