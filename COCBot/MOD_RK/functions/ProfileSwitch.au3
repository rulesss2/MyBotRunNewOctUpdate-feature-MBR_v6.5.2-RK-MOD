Func ProfileSwitch()
	If $ichkGoldSwitchMax = 1 Or $ichkGoldSwitchMin = 1 Or $ichkElixirSwitchMax = 1 Or $ichkElixirSwitchMin = 1 Or _
	$ichkDESwitchMax = 1 Or $ichkDESwitchMin = 1 Or $ichkTrophySwitchMax = 1 Or $ichkTrophySwitchMin = 1 Then
		Local $SwitchtoProfile = ""
		While True
			If $ichkGoldSwitchMax = 1 Then
				If Number($iGoldCurrent) >= Number($itxtMaxGoldAmount) Then
					$SwitchtoProfile = $icmbGoldMaxProfile
					Setlog("Village Gold detected Above Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")					
					ExitLoop
				EndIf
			EndIf
			If $ichkGoldSwitchMin = 1 Then
				If Number($iGoldCurrent) < Number($itxtMinGoldAmount) And Number($iGoldCurrent) > 1 Then
					$SwitchtoProfile = $icmbGoldMinProfile
					Setlog("Village Gold detected Below Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMax = 1 Then
				If Number($iElixirCurrent) >= Number($itxtMaxElixirAmount) Then
					$SwitchtoProfile = $icmbElixirMaxProfile
					Setlog("Village Gold detected Above Elixir Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMin = 1 Then
				If Number($iElixirCurrent) < Number($itxtMinElixirAmount) And Number($iElixirCurrent) > 1 Then
					$SwitchtoProfile = $icmbElixirMinProfile
					Setlog("Village Gold detected Below Elixir Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMax = 1 Then
				If Number($iDarkCurrent) >=	Number($itxtMaxDEAmount) Then
					$SwitchtoProfile = $icmbDEMaxProfile
					Setlog("Village Dark Elixir detected Above Dark Elixir Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMin = 1 Then
				If Number($iDarkCurrent) < Number($itxtMinDEAmount) And Number($iDarkCurrent) > 1 Then
					$SwitchtoProfile = $icmbDEMinProfile
					Setlog("Village Dark Elixir detected Below Dark Elixir Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMax = 1 Then
				If Number($iTrophyCurrent) >= Number($itxtMaxTrophyAmount) Then
					$SwitchtoProfile = $icmbTrophyMaxProfile
					Setlog("Village Trophies detected Above Throphy Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMin = 1 Then
				If Number($iTrophyCurrent) < Number($itxtMinTrophyAmount) And Number($iTrophyCurrent) > 1 Then
					$SwitchtoProfile = $icmbTrophyMinProfile
					Setlog("Village Trophies detected Below Trophy Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			ExitLoop
		WEnd

		If $SwitchtoProfile <> -1 Then
				TrayTip( " Profile Switch Village Report!", "Gold: "  & _NumberFormat($iGoldCurrent) & "; Elixir: " &  _NumberFormat($iElixirCurrent) & "; Dark: " &  _NumberFormat($iDarkCurrent) & "; Trophy: " & _NumberFormat($iTrophyCurrent), "", 0)
				If FileExists(@ScriptDir & "\Audio\SwitchingProfiles.wav") Then
					SoundPlay(@ScriptDir & "\Audio\SwitchingProfiles.wav", 1)
				ElseIf FileExists(@WindowsDir & "\media\tada.wav") Then
					SoundPlay(@WindowsDir & "\media\tada.wav", 1)
				EndIf

			_GUICtrlComboBox_SetCurSel($g_hCmbProfile, $SwitchtoProfile)
			cmbProfile()
			If _Sleep(3000) Then Return
			runBot()
		EndIf
	EndIf

EndFunc
Func ProfileSwitchCheck()

    If GUICtrlRead($chkGoldSwitchMax) = $GUI_CHECKED Then
    $ichkGoldSwitchMax = 1		
	Else
		$ichkGoldSwitchMax = 0
	EndIf
	
	
	If GUICtrlRead($chkGoldSwitchMin) = $GUI_CHECKED Then
	    $ichkGoldSwitchMin = 1		
	Else
		$ichkGoldSwitchMin = 0
	EndIf
	

	If GUICtrlRead($chkElixirSwitchMax) = $GUI_CHECKED Then	    
		$ichkElixirSwitchMax = 1		
	Else
		$ichkElixirSwitchMax = 0
	EndIf
	
	
	If GUICtrlRead($chkElixirSwitchMin) = $GUI_CHECKED Then
	    $ichkElixirSwitchMin = 1		
	Else
		$ichkElixirSwitchMin = 0
	EndIf
	

	If GUICtrlRead($chkDESwitchMax) = $GUI_CHECKED Then
	   $ichkDESwitchMax = 1		
	Else
		$ichkDESwitchMax = 0	
	EndIf
	
	If GUICtrlRead($chkDESwitchMin) = $GUI_CHECKED Then 
	  $ichkDESwitchMin = 1 		
	Else
	  $ichkDESwitchMin = 0
	EndIf
	

	If GUICtrlRead($chkTrophySwitchMax) = $GUI_CHECKED Then 
	   $ichkTrophySwitchMax = 1		
	Else
	   $ichkTrophySwitchMax = 0
	EndIf
	
	If GUICtrlRead($chkTrophySwitchMin) = $GUI_CHECKED Then
	   $ichkTrophySwitchMin = 1		
	Else
	   $ichkTrophySwitchMin = 0 
	EndIf

EndFunc