; #FUNCTION# ====================================================================================================================
; Name ..........: iTools AVM implementation
; Description ...: Handles iTools open, close and configuration etc. http://pro.itools.cn/simulate/
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Cosote (11-2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func OpeniTools($bRestart = False)

	Local $PID, $hTimer, $iCount = 0, $process_killed, $cmdOutput, $connected_to, $cmdPar

	SetLog("Starting " & $g_sAndroidEmulator & " and Clash Of Clans", $COLOR_SUCCESS)

	Local $launchAndroid = (WinGetAndroidHandle() = 0 ? True : False)
	If $launchAndroid Then
		; Launch iTools
		$cmdPar = GetAndroidProgramParameter()
		SetDebugLog("ShellExecute: " & $g_sAndroidProgramPath & " " & $cmdPar)
		$PID = ShellExecute($g_sAndroidProgramPath, $cmdPar, $__iTools_Path)
		If _Sleep(1000) Then Return False
		If $PID <> 0 Then $PID = ProcessExists($PID)
		SetDebugLog("$PID= " & $PID)
		If $PID = 0 Then ; IF ShellExecute failed
			SetLog("Unable to load " & $g_sAndroidEmulator & ($g_sAndroidInstance = "" ? "" : "(" & $g_sAndroidInstance & ")") & ", please check emulator/installation.", $COLOR_ERROR)
			SetLog("Unable to continue........", $COLOR_WARNING)
			btnStop()
			SetError(1, 1, -1)
			Return False
		EndIf
	EndIf

	SetLog("Please wait while " & $g_sAndroidEmulator & " and CoC start...", $COLOR_SUCCESS)
	$hTimer = __TimerInit()

	; Test ADB is connected
	$connected_to = ConnectAndroidAdb(False, 60 * 1000)
	If Not $g_bRunState Then Return False

	; Wait for boot completed
	If WaitForAndroidBootCompleted($g_iAndroidLaunchWaitSec - __TimerDiff($hTimer) / 1000, $hTimer) Then Return False

	If __TimerDiff($hTimer) >= $g_iAndroidLaunchWaitSec * 1000 Then ; if it took 4 minutes, Android/PC has major issue so exit
		SetLog("Serious error has occurred, please restart PC and try again", $COLOR_ERROR)
		SetLog($g_sAndroidEmulator & " refuses to load, waited " & Round(__TimerDiff($hTimer) / 1000, 2) & " seconds for window", $COLOR_ERROR)
		SetError(1, @extended, False)
		Return False
	EndIf

	SetLog($g_sAndroidEmulator & " Loaded, took " & Round(__TimerDiff($hTimer) / 1000, 2) & " seconds to begin.", $COLOR_SUCCESS)

	Return True

EndFunc   ;==>OpeniTools

Func IsiToolsCommandLine($CommandLine)
	SetDebugLog("Check iTools command line instance: " & $CommandLine)
	Local $sInstance = ($g_sAndroidInstance = "" ? $g_avAndroidAppConfig[$g_iAndroidConfig][1] : $g_sAndroidInstance)
	$CommandLine = StringReplace($CommandLine, GetiToolsPath(), "")
	If StringRegExp($CommandLine, "/start " & $sInstance & "\b") = 1 Then Return True
	If StringRegExp($CommandLine, "/restart .*\b" & $sInstance & "\b") = 1 Then Return True
	Return False
EndFunc   ;==>IsiToolsCommandLine

Func GetiToolsProgramParameter($bAlternative = False)
	Local $sInstance = ($g_sAndroidInstance = "" ? $g_avAndroidAppConfig[$g_iAndroidConfig][1] : $g_sAndroidInstance)
	If Not $bAlternative Or $g_sAndroidInstance <> $g_avAndroidAppConfig[$g_iAndroidConfig][1] Then
		; should be launched with these parameter
		Return "/start " & $sInstance
	EndIf
	; default instance gets launched when no parameter was specified (this is the alternative way)
	Return ""
EndFunc   ;==>GetiToolsProgramParameter

Func GetiToolsPath()
	Local $iTools_Path = "" ;RegRead($g_sHKLM & "\SOFTWARE\iTools\iTools VM\", "InstallDir")
	If $iTools_Path <> "" And FileExists($iTools_Path & "\iToolsAVM.exe") = 0 Then
		$iTools_Path = ""
	EndIf
	Local $InstallLocation = ""
	Local $DisplayIcon = RegRead($g_sHKLM & "\SOFTWARE" & $g_sWow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\iToolsAVM\", "DisplayIcon")
	If @error = 0 Then
		Local $iLastBS = StringInStr($DisplayIcon, "\", 0, -1) - 1
		$InstallLocation = StringLeft($DisplayIcon, $iLastBS)
	EndIf
	If $iTools_Path = "" And FileExists($InstallLocation & "\iToolsAVM.exe") = 1 Then
		$iTools_Path = $InstallLocation
	EndIf
	If $iTools_Path = "" And FileExists(@ProgramFilesDir & "\iToolsAVM\iToolsAVM.exe") = 1 Then
		$iTools_Path = @ProgramFilesDir & "\iToolsAVM"
	EndIf
	SetError(0, 0, 0)
	If $iTools_Path <> "" And StringRight($iTools_Path, 1) <> "\" Then $iTools_Path &= "\"
	Return StringReplace($iTools_Path, "\\", "\")
EndFunc   ;==>GetiToolsPath

Func GetiToolsAdbPath()
	Local $adbPath = GetiToolsPath() & "tools\adb.exe"
	If FileExists($adbPath) Then Return $adbPath
	Return ""
EndFunc   ;==>GetiToolsAdbPath

Func InitiTools($bCheckOnly = False)
	Local $process_killed, $aRegExResult, $g_sAndroidAdbDeviceHost, $g_sAndroidAdbDevicePort, $oops = 0
	;Local $iToolsVersion = RegRead($g_sHKLM & "\SOFTWARE" & $g_sWow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\iTools\", "DisplayVersion")
	SetError(0, 0, 0)

	Local $VirtualBox_Path = RegRead($g_sHKLM & "\SOFTWARE\Oracle\VirtualBox\", "InstallDir")
	If @error <> 0 And FileExists(@ProgramFilesDir & "\Oracle\VirtualBox\") Then
		$VirtualBox_Path = @ProgramFilesDir & "\Oracle\VirtualBox\"
		SetError(0, 0, 0)
	EndIf
	$VirtualBox_Path = StringReplace($VirtualBox_Path, "\\", "\")

	Local $iTools_Path = GetiToolsPath()
	Local $iTools_Manage_Path = $VirtualBox_Path & "VBoxManage.exe"

	If FileExists($iTools_Path) = 0 Then
		If Not $bCheckOnly Then
			SetLog("Serious error has occurred: Cannot find " & $g_sAndroidEmulator, $COLOR_ERROR)
			SetLog("installation directory", $COLOR_ERROR)
			SetError(1, @extended, False)
		Else
			SetDebugLog($g_sAndroidEmulator & ": Cannot find installation directory")
		EndIf
		Return False
	EndIf

	If FileExists($iTools_Path & "iToolsAVM.exe") = 0 Then
		If Not $bCheckOnly Then
			SetLog("Serious error has occurred: Cannot find " & $g_sAndroidEmulator & ":", $COLOR_ERROR)
			SetLog($iTools_Path & "iToolsAVM.exe", $COLOR_ERROR)
		Else
			SetDebugLog($g_sAndroidEmulator & ": Cannot find " & $iTools_Path & "iToolsAVM.exe")
			SetError(1, @extended, False)
		EndIf
		Return False
	EndIf

	If FileExists($iTools_Path & "tools\adb.exe") = 0 Then
		If Not $bCheckOnly Then
			SetLog("Serious error has occurred: Cannot find " & $g_sAndroidEmulator & ":", $COLOR_ERROR)
			SetLog($iTools_Path & "tools\adb.exe", $COLOR_ERROR)
			SetError(1, @extended, False)
		Else
			SetDebugLog($g_sAndroidEmulator & ": Cannot find " & $iTools_Path & "tools\adb.exe")
		EndIf
		Return False
	EndIf

	If FileExists($iTools_Manage_Path) = 0 Then
		If Not $bCheckOnly Then
			SetLog("Serious error has occurred: Cannot find " & $g_sAndroidEmulator & ":", $COLOR_ERROR)
			SetLog($iTools_Manage_Path, $COLOR_ERROR)
			SetError(1, @extended, False)
		Else
			SetDebugLog($g_sAndroidEmulator & ": Cannot find " & $iTools_Manage_Path)
		EndIf
		Return False
	EndIf

	; Read ADB host and Port
	Local $ops = 0
	If Not $bCheckOnly Then
		InitAndroidConfig(True) ; Restore default config

		$__VBoxVMinfo = LaunchConsole($iTools_Manage_Path, "showvminfo " & $g_sAndroidInstance, $process_killed)
		; check if instance is known
		If StringInStr($__VBoxVMinfo, "Could not find a registered machine named") > 0 Then
			; Unknown vm
			SetLog("Cannot find " & $g_sAndroidEmulator & " instance " & $g_sAndroidInstance, $COLOR_ERROR)
			Return False
		EndIf
		$__VBoxGuestProperties = LaunchConsole($iTools_Manage_Path, "guestproperty enumerate " & $g_sAndroidInstance, $process_killed)

		; update global variables
		$g_sAndroidProgramPath = $iTools_Path & "iToolsAVM.exe"
		$g_sAndroidAdbPath = FindPreferredAdbPath()
		If $g_sAndroidAdbPath = "" Then $g_sAndroidAdbPath = $iTools_Path & "tools\adb.exe"
		$g_sAndroidVersion = ""
		$__iTools_Path = $iTools_Path
		$__VBoxManage_Path = $iTools_Manage_Path

		$aRegExResult = StringRegExp($__VBoxVMinfo, "ADB_PORT.*host ip = ([^,]+),", $STR_REGEXPARRAYMATCH)
		If Not @error Then
			$g_sAndroidAdbDeviceHost = $aRegExResult[0]
			If $g_iDebugSetlog = 1 Then Setlog("Func LaunchConsole: Read $g_sAndroidAdbDeviceHost = " & $g_sAndroidAdbDeviceHost, $COLOR_DEBUG)
		Else
			$oops = 1
			SetLog("Cannot read " & $g_sAndroidEmulator & "(" & $g_sAndroidInstance & ") ADB Device Host", $COLOR_ERROR)
		EndIf

		$aRegExResult = StringRegExp($__VBoxVMinfo, "ADB_PORT.*host port = (\d{3,5}),", $STR_REGEXPARRAYMATCH)
		If Not @error Then
			$g_sAndroidAdbDevicePort = $aRegExResult[0]
			If $g_iDebugSetlog = 1 Then Setlog("Func LaunchConsole: Read $g_sAndroidAdbDevicePort = " & $g_sAndroidAdbDevicePort, $COLOR_DEBUG)
		Else
			$oops = 1
			SetLog("Cannot read " & $g_sAndroidEmulator & "(" & $g_sAndroidInstance & ") ADB Device Port", $COLOR_ERROR)
		EndIf

		If $oops = 0 Then
			$g_sAndroidAdbDevice = $g_sAndroidAdbDeviceHost & ":" & $g_sAndroidAdbDevicePort
		Else ; use defaults
			SetLog("Using ADB default device " & $g_sAndroidAdbDevice & " for " & $g_sAndroidEmulator, $COLOR_ERROR)
		EndIf

		; get screencap paths: Name: 'picture', Host path: 'C:\Users\Administrator\Pictures\iTools Photo' (machine mapping), writable
		$g_sAndroidPicturesPath = "/mnt/shared/picture/"
		$aRegExResult = StringRegExp($__VBoxVMinfo, "Name: 'picture', Host path: '(.*)'.*", $STR_REGEXPARRAYMATCH)
		If Not @error Then
			$g_bAndroidSharedFolderAvailable = True
			$g_sAndroidPicturesHostPath = $aRegExResult[0] & "\"
		Else
			$oops = 1
			$g_bAndroidAdbScreencap = False
			$g_bAndroidSharedFolderAvailable = False
			$g_sAndroidPicturesHostPath = ""
			SetLog($g_sAndroidEmulator & " shared folder is not available", $COLOR_ERROR)
		EndIf

		; Android Window Title is always "iTools" so add instance name
		$g_bUpdateAndroidWindowTitle = True

	EndIf

	Return SetError($oops, 0, True)

EndFunc   ;==>InitiTools

Func SetScreeniTools()

	If Not $g_bRunState Then Return False
	If Not InitAndroid() Then Return False

	Local $cmdOutput, $process_killed

	; Set width and height
	$cmdOutput = LaunchConsole($__VBoxManage_Path, "guestproperty set " & $g_sAndroidInstance & " vbox_graph_mode " & $g_iAndroidClientWidth & "x" & $g_iAndroidClientHeight & "-16", $process_killed)

	; Set dpi
	$cmdOutput = LaunchConsole($__VBoxManage_Path, "guestproperty set " & $g_sAndroidInstance & " vbox_dpi 160", $process_killed)

	;vboxmanage sharedfolder add droid4x --name picture --hostpath "C:\Users\Administrator\Pictures\Droid4X Photo" --automount
	AndroidPicturePathAutoConfig() ; ensure $g_sAndroidPicturesHostPath is set and exists
	If $g_bAndroidSharedFolderAvailable = False And $g_bAndroidPicturesPathAutoConfig = True And FileExists($g_sAndroidPicturesHostPath) = 1 Then
		; remove tailing backslash
		Local $path = $g_sAndroidPicturesHostPath
		If StringRight($path, 1) = "\" Then $path = StringLeft($path, StringLen($path) - 1)
		$cmdOutput = LaunchConsole($__VBoxManage_Path, "sharedfolder add " & $g_sAndroidInstance & " --name picture --hostpath """ & $path & """  --automount", $process_killed)
	EndIf

	Return True

EndFunc   ;==>SetScreeniTools

Func RebootiToolsSetScreen()

	Return RebootAndroidSetScreenDefault()

EndFunc   ;==>RebootiToolsSetScreen

Func CloseiTools()

	Return CloseVboxAndroidSvc()

EndFunc   ;==>CloseiTools

Func CheckScreeniTools($bSetLog = True)

	If Not InitAndroid() Then Return False

	Local $aValues[2][2] = [ _
			["vbox_dpi", "160"], _
			["vbox_graph_mode", $g_iAndroidClientWidth & "x" & $g_iAndroidClientHeight & "-16"] _
			]
	Local $i, $Value, $iErrCnt = 0, $process_killed, $aRegExResult, $properties

	For $i = 0 To UBound($aValues) - 1
		$aRegExResult = StringRegExp($__VBoxGuestProperties, "Name: " & $aValues[$i][0] & ", value: (.+), timestamp:", $STR_REGEXPARRAYMATCH)
		If @error = 0 Then $Value = $aRegExResult[0]
		If $Value <> $aValues[$i][1] Then
			If $iErrCnt = 0 Then
				SetGuiLog("MyBot doesn't work with " & $g_sAndroidEmulator & " screen configuration!", $COLOR_ERROR, $bSetLog)
			EndIf
			SetGuiLog("Setting of " & $aValues[$i][0] & " is " & $Value & " and will be changed to " & $aValues[$i][1], $COLOR_ERROR, $bSetLog)
			$iErrCnt += 1
		EndIf
	Next

	If $iErrCnt > 0 Then Return False

	; check if shared folder exists
	If AndroidPicturePathAutoConfig(Default, Default, $bSetLog) Then $iErrCnt += 1

	If $iErrCnt > 0 Then Return False
	Return True

EndFunc   ;==>CheckScreeniTools

Func HideiToolsWindow($bHide = True)
	Return EmbediTools($bHide)
EndFunc   ;==>HideiToolsWindow

Func EmbediTools($bEmbed = Default)

	If $bEmbed = Default Then $bEmbed = $g_bAndroidEmbedded

	; Find QTool Parent Window
	Local $aWin = _WinAPI_EnumProcessWindows(GetAndroidPid(), False)
	Local $i
	Local $hToolbar = 0
	Local $hAddition = []

	For $i = 1 To UBound($aWin) - 1
		Local $h = $aWin[$i][0]
		Local $c = $aWin[$i][1]
		If $c = "CHWindow" Then
			Local $aPos = WinGetPos($h)
			If UBound($aPos) > 2 Then
				If ($aPos[2] = 38 Or $aPos[2] = 21) Then
					; found toolbar
					$hToolbar = $h
				EndIf
				If $aPos[2] = 10 Or $aPos[3] = 10 Then
					; found additional window to hide
					ReDim $hAddition[UBound($hAddition) + 1]
					$hAddition[UBound($hAddition) - 1] = $h
				EndIf
			EndIf
		EndIf
	Next

	If $hToolbar = 0 Then
		SetDebugLog("EmbediTools(" & $bEmbed & "): toolbar Window not found, list of windows:" & $c, Default, True)
		For $i = 1 To UBound($aWin) - 1
			Local $h = $aWin[$i][0]
			Local $c = $aWin[$i][1]
			SetDebugLog("EmbediTools(" & $bEmbed & "): Handle = " & $h & ", Class = " & $c, Default, True)
		Next
	Else
		SetDebugLog("EmbediTools(" & $bEmbed & "): $hToolbar=" & $hToolbar, Default, True)
		WinMove2($hToolbar, "", -1, -1, -1, -1, $HWND_NOTOPMOST, 0, False)
		_WinAPI_ShowWindow($hToolbar, ($bEmbed ? @SW_HIDE : @SW_SHOWNOACTIVATE))
		For $i = 0 To UBound($hAddition) - 1
			WinMove2($hAddition[$i], "", -1, -1, -1, -1, $HWND_NOTOPMOST, 0, False)
			_WinAPI_ShowWindow($hAddition[$i], ($bEmbed ? @SW_HIDE : @SW_SHOWNOACTIVATE))
		Next
	EndIf

EndFunc   ;==>EmbediTools

#cs
	Func iToolsBotStartEvent()
	Return AndroidCloseSystemBar()
	EndFunc   ;==>iToolsBotStartEvent

	Func iToolsBotStopEvent()
	Return AndroidOpenSystemBar()
	EndFunc   ;==>iToolsBotStopEvent
#ce
