#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------


Func cmbSwLang() ; rulesss and Kychera

     Switch GUICtrlRead($cmbSwLang)
	 ;
		 Case "EN"
				   setForecast2()
		 Case "RU"
				   setForecast3()
		 Case "FR"
				   setForecast4()
		 Case "DE"
				   setForecast5()
		 Case "ES"
				   setForecast6()
		 Case "IT"
		           setForecast7()
		 Case "PT"
				   setForecast8()
		 Case "IN"
				   setForecast9()
     EndSwitch
EndFunc

Func chkRusLang2()
If GUICtrlRead($chkRusLang2) = $GUI_CHECKED Then
		$ichkRusLang2 = 1
	Else
		$ichkRusLang2 = 0
	EndIf
EndFunc 



Func chkFastADBClicks()
	If GUICtrlRead($chkFastADBClicks) = $GUI_CHECKED Then
		$g_bAndroidAdbClicksEnabled = 1
	Else
		$g_bAndroidAdbClicksEnabled = 0
	EndIf
EndFunc   ;==>chkFastADBClicks

Func ChkNotifyAlertBOTSleep()
   If $g_bNotifyPBEnable = True Or $g_bNotifyTGEnable = True Then
      GUICtrlSetState($ChkNotifyAlertBOTSleep, $GUI_ENABLE)
   Else
      GUICtrlSetState($ChkNotifyAlertBOTSleep, $GUI_DISABLE)
   EndIf
EndFunc 

Func ChkNotifyConnect()
   If $g_bNotifyPBEnable = True Or $g_bNotifyTGEnable = True Then
      GUICtrlSetState($ChkNotifyAlertConnect, $GUI_ENABLE)
   Else
      GUICtrlSetState($ChkNotifyAlertConnect, $GUI_DISABLE)
   EndIf
EndFunc 


Func setupAndroidComboBox()
	Local $androidString = ""
	Local $aAndroid = getInstalledEmulators()

	; Convert the array into a string
	$androidString = _ArrayToString($aAndroid, "|")

	; Set the new data of valid Emulators
	GUICtrlSetData($CmbAndroid, $androidString, $aAndroid[0])
EndFunc   ;==>setupAndroidComboBox

Func CmbAndroid()
	$sAndroid = GUICtrlRead($CmbAndroid)
	modifyAndroid()
EndFunc   ;==>cmbAndroid

Func TxtAndroidInstance()
	$sAndroidInstance = GUICtrlRead($TxtAndroidInstance)
	modifyAndroid()
EndFunc   ;==>$txtAndroidInstance
