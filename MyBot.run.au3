﻿; #FUNCTION# ====================================================================================================================
; Name ..........: MBR Bot
; Description ...: This file contens the Sequence that runs all MBR Bot
; Author ........:  (2014)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

#RequireAdmin
#AutoIt3Wrapper_UseX64=7n
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/mo /rsln
;#AutoIt3Wrapper_Change2CUI=y
;#pragma compile(Console, true)
#pragma compile(Icon, "Images\MyBot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free Clash of Clans bot - https://mybot.run)
#pragma compile(ProductName, My Bot)
#pragma compile(ProductVersion, 6.5)
#pragma compile(FileVersion, 6.5)
#pragma compile(LegalCopyright, © https://mybot.run)
#pragma compile(Out, MyBot.run.exe) ; Required

#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <Process.au3>

;~ Boost launch time by increasing process priority (will be restored again when finished launching)
Global $iBotProcessPriority = _ProcessGetPriority(@AutoItPID)
ProcessSetPriority(@AutoItPID, $PROCESS_ABOVENORMAL)

Global $iBotLaunchTime = 0
Global $hBotLaunchTime = TimerInit()

$sBotVersion = "v6.5.3" ;~ Don't add more here, but below. Version can't be longer than vX.y.z because it is also use on Checkversion()
$sBotTitle = "My Bot " & $sBotVersion & " @RK MOD v 2.0 " ;~ Don't use any non file name supported characters like \ / : * ? " < > |

#include "COCBot\functions\Config\DelayTimes.au3"
#include "COCBot\MBR Global Variables.au3"
_GDIPlus_Startup()
#include "COCBot\GUI\MBR GUI Design Splash.au3"
#include "COCBot\functions\Config\ScreenCoordinates.au3"
#include "COCBot\functions\Other\ExtMsgBox.au3"
#include "COCBot\functions\Chatbot\Chatbot.au3"

Opt("GUIResizeMode", $GUI_DOCKALL) ; Default resize mode for dock android support
Opt("GUIEventOptions", 1) ; Handle minimize and restore for dock android support
Opt("GUICloseOnESC", 0) ; Don't send the $GUI_EVENT_CLOSE message when ESC is pressed.
Opt("WinTitleMatchMode", 3) ; Window Title exact match mode

If Not FileExists(@ScriptDir & "\License.txt") Then
	$license = InetGet("http://www.gnu.org/licenses/gpl-3.0.txt", @ScriptDir & "\License.txt")
EndIf

;multilanguage
If Not FileExists(@ScriptDir & "\Languages") Then DirCreate(@ScriptDir & "\Languages")
#include "COCBot\functions\Other\Multilanguage.au3"
DetectLanguage()
Local $sMsg

$sMsg = GetTranslated(500, 1, "Don't Run/Compile the Script as (x64)! Try to Run/Compile the Script as (x86) to get the bot to work.\r\n" & _
		"If this message still appears, try to re-install AutoIt.")
If @AutoItX64 = 1 Then
	If IsHWnd($hSplash) Then GUIDelete($hSplash) ; Delete the splash screen since we don't need it anymore
	MsgBox(0, "", $sMsg)
	_GDIPlus_Shutdown()
	Exit
EndIf

#include "COCBot\functions\Other\MBRFunc.au3"
; check for VC2010, .NET software and MyBot Files and Folders
If CheckPrerequisites(True) Then
	MBRFunc(True) ; start MBRFunctions dll
EndIf
;==================Themes====
#include "Themes\_UskinLibrary.au3"
_Uskin_LoadDLL()
;===========================
#include "COCBot\functions\Android\Android.au3"

If $aCmdLine[0] < 2 and $sAndroid = "" Then
	DetectRunningAndroid()
	If Not $FoundRunningAndroid Then DetectInstalledAndroid()
EndIf

; Update Bot title
$sBotTitle = $sBotTitle & "(" & ($AndroidInstance <> "" ? $AndroidInstance : $Android) & ")" ;Do not change this. If you do, multiple instances will not work.

UpdateSplashTitle($sBotTitle & GetTranslated(500, 20, ", Profile: %s", $sCurrProfile))

If $bBotLaunchOption_Restart = True Then
   If CloseRunningBot($sBotTitle) = True Then
	  ; wait for Mutexes to get disposed
	  ;Sleep(1000) ; slow systems
   EndIf
EndIf

If $bBotLaunchOption_Restart = True Then
	If WinGetHandle($sBotTitle) Then SplashStep(GetTranslated(500, 36, "Closing previous bot..."))
	If CloseRunningBot($sBotTitle) = True Then
		; wait for Mutexes to get disposed
		Sleep(3000)
		; check if Android is running
		WinGetAndroidHandle()
	EndIf
Else
	SplashStep("")
EndIf

Local $cmdLineHelp = GetTranslated(500, 2, "By using the commandline (or a shortcut) you can start multiple Bots:\r\n" & _
		"     MyBot.run.exe [ProfileName] [EmulatorName] [InstanceName]\r\n\r\n" & _
		"With the first command line parameter, specify the Profilename (you can create profiles on the Bot/Profiles tab, if a " & _
		"profilename contains a {space}, then enclose the profilename in double quotes). " & _
		"With the second, specify the name of the Emulator and with the third, an Android Instance (not for BlueStacks). \r\n" & _
		"Supported Emulators are MEmu, Droid4X, Nox, BlueStacks2, BlueStacks, KOPlayer and LeapDroid.\r\n\r\n" & _
		"Examples:\r\n" & _
		"     MyBot.run.exe MyVillage BlueStacks2\r\n" & _
		"     MyBot.run.exe ""My Second Village"" MEmu MEmu_1")

$hMutex_BotTitle = _Singleton($sBotTitle, 1)
Local $sAndroidInfo = GetTranslated(500, 3, "%s", $Android)
Local $sAndroidInfo2 = GetTranslated(500, 4, "%s (instance %s)", $Android, $AndroidInstance)
If $AndroidInstance <> "" Then
	$sAndroidInfo = $sAndroidInfo2
EndIf

$sMsg = GetTranslated(500, 5, "My Bot for %s is already running.\r\n\r\n", $sAndroidInfo)
If $hMutex_BotTitle = 0 Then
	If IsHWnd($hSplash) Then GUIDelete($hSplash) ; Delete the splash screen since we don't need it anymore
	MsgBox(BitOR($MB_OK, $MB_ICONINFORMATION, $MB_TOPMOST), $sBotTitle, $sMsg & $cmdLineHelp)
	_GDIPlus_Shutdown()
	Exit
EndIf

$hMutex_Profile = _Singleton(StringReplace($sProfilePath & "\" & $sCurrProfile, "\", "-"), 1)
$sMsg = GetTranslated(500, 6, "My Bot with Profile %s is already running in %s.\r\n\r\n", $sCurrProfile, $sProfilePath & "\" & $sCurrProfile)
If $hMutex_Profile = 0 Then
	_WinAPI_CloseHandle($hMutex_BotTitle)
	If IsHWnd($hSplash) Then GUIDelete($hSplash) ; Delete the splash screen since we don't need it anymore
	MsgBox(BitOR($MB_OK, $MB_ICONINFORMATION, $MB_TOPMOST), $sBotTitle, $sMsg & $cmdLineHelp)
	_GDIPlus_Shutdown()
	Exit
EndIf

$hMutex_MyBot = _Singleton("MyBot.run", 1)
$OnlyInstance = $hMutex_MyBot <> 0 ; And False
SetDebugLog("My Bot is " & ($OnlyInstance ? "" : "not ") & "the only running instance")

#include "COCBot\functions\Android\Distributors.au3"
#include "COCBot\MBR Global Variables Troops.au3"
#include "COCBot\MBR GUI Design.au3"
#include "COCBot\MBR GUI Control.au3"
#include "COCBot\MBR Functions.au3"

CheckPrerequisites(False)
;DirCreate($sTemplates)
DirCreate($sPreset)
DirCreate($sProfilePath & "\" & $sCurrProfile)
DirCreate($dirLogs)
DirCreate($dirLoots)
DirCreate($dirTemp)
DirCreate($dirTempDebug)

$donateimagefoldercapture = $sProfilePath & "\" & $sCurrProfile & '\Donate\'
$donateimagefoldercaptureWhiteList = $sProfilePath & "\" & $sCurrProfile & '\Donate\White List\'
$donateimagefoldercaptureBlackList = $sProfilePath & "\" & $sCurrProfile & '\Donate\Black List\'
DirCreate($donateimagefoldercapture)
DirCreate($donateimagefoldercaptureWhiteList)
DirCreate($donateimagefoldercaptureBlackList)

;Migrate old bot without profile support to current one
FileMove(@ScriptDir & "\*.ini", $sProfilePath & "\" & $sCurrProfile, $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Logs", $sProfilePath & "\" & $sCurrProfile & "\Logs", $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Loots", $sProfilePath & "\" & $sCurrProfile & "\Loots", $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Temp", $sProfilePath & "\" & $sCurrProfile & "\Temp", $FC_OVERWRITE + $FC_CREATEPATH)
DirRemove(@ScriptDir & "\Logs", 1)
DirRemove(@ScriptDir & "\Loots", 1)
DirRemove(@ScriptDir & "\Temp", 1)
Local $forecastDir = @ScriptDir & "\COCBot\Forecast"
DirCreate($forecastDir)

;Setup profile if doesn't exist yet
If FileExists($config) = 0 Then
	createProfile(True)
EndIf

If $ichkDeleteLogs = 1 Then DeleteFiles($dirLogs, "*.*", $iDeleteLogsDays, 0)
If $ichkDeleteLoots = 1 Then DeleteFiles($dirLoots, "*.*", $iDeleteLootsDays, 0)
If $ichkDeleteTemp = 1 Then DeleteFiles($dirTemp, "*.*", $iDeleteTempDays, 0)
If $ichkDeleteTemp = 1 Then DeleteFiles($dirTempDebug, "*.*", $iDeleteTempDays, 0)

$sMsg = GetTranslated(500, 7, "Found running %s %s", $Android, $AndroidVersion)
If $FoundRunningAndroid Then
	SetLog($sMsg, $COLOR_SUCCESS)
EndIf
If $FoundInstalledAndroid Then
	SetLog("Found installed " & $Android & " " & $AndroidVersion, $COLOR_SUCCESS)
EndIf
SetLog(GetTranslated(500, 8, "Android Emulator Configuration: %s", $sAndroidInfo), $COLOR_SUCCESS)
SetLog(GetTranslated(601, 29, "Theme used") & ":" & " " & $ThemeName, $COLOR_BLACK)
;AdlibRegister("PushBulletRemoteControl", $PBRemoteControlInterval)
;AdlibRegister("PushBulletDeleteOldPushes", $PBDeleteOldPushesInterval)

CheckDisplay() ; verify display size and DPI (Dots Per Inch) setting

$iGUIEnabled = 1

;~ InitializeVariables();initialize variables used in extrawindows
;~ CheckVersion() ; check latest version on mybot.run site

;~ Update profile to write config for SwitchAcc Mode - DEMEN
btnUpdateProfile()


$sMsg = GetTranslated(500, 9, "Android Shield not available for %s", @OSVersion)
If $AndroidShieldEnabled = False Then
	SetLog($sMsg, $COLOR_ACTION)
EndIf

DisableProcessWindowsGhosting()

;~ Restore process priority
ProcessSetPriority(@AutoItPID, $iBotProcessPriority)

; ensure watchdog is launched
If $ichkLaunchWatchdog = 0 Then
LaunchWatchdog()
EndIf

;~ Remember time in Milliseconds bot launched
$iBotLaunchTime = TimerDiff($hBotLaunchTime)
Setlog("MyBot.run launch time " & Round($iBotLaunchTime) & " ms.", $COLOR_INFO)

;AutoStart Bot if request
AutoStart()
While 1
	_Sleep($iDelaySleep, True, False)

	Switch $BotAction
		Case $eBotStart
			BotStart()
			If $BotAction = $eBotStart Then $BotAction = $eBotNoAction
		Case $eBotStop
			BotStop()
			If $BotAction = $eBotStop Then $BotAction = $eBotNoAction
		Case $eBotSearchMode
			BotSearchMode()
			If $BotAction = $eBotSearchMode Then $BotAction = $eBotNoAction
		Case $eBotClose
			BotClose()
	EndSwitch

	; force app crash for debugging/testing purposes
	;DllCallAddress("NONE", 0)
WEnd

Func runBot() ;Bot that runs everything in order

	If $ichkSwitchAcc = 1 And $bReMatchAcc = True Then 				; SwitchAcc
		$nCurProfile = _GUICtrlCombobox_GetCurSel($cmbProfile) + 1
		Setlog("Rematching Profile [" & $nCurProfile &"] - " & $ProfileList[$nCurProfile] & " (CoC Acc. " & $aMatchProfileAcc[$nCurProfile-1] & ")")
		SwitchCoCAcc()
		$bReMatchAcc = False
	EndIf

	$TotalTrainedTroops = 0
	Local $Quickattack = False
	Local $iWaitTime
	While 1
		PrepareDonateCC()
		$Restart = False
		$fullArmy = False
		$CommandStop = -1
		If _Sleep($iDelayRunBot1) Then Return
		checkMainScreen()
		If $Restart = True Then ContinueLoop
		chkShieldStatus()
		If $Restart = True Then ContinueLoop

		If $quicklyfirststart = True Then
			$quicklyfirststart = False
		Else
			$Quickattack = QuickAttack()
		EndIf

		If checkAndroidReboot() = True Then ContinueLoop
		If $Is_ClientSyncError = False And $Is_SearchLimit = False And ($Quickattack = False) Then
			If BotCommand() Then btnStop()
			If _Sleep($iDelayRunBot2) Then Return
			checkMainScreen(False)
			If $Restart = True Then ContinueLoop
			If _Sleep($iDelayRunBot3) Then Return
			VillageReport()
			If $OutOfGold = 1 And (Number($iGoldCurrent) >= Number($itxtRestartGold)) Then ; check if enough gold to begin searching again
				$OutOfGold = 0 ; reset out of gold flag
				Setlog("Switching back to normal after no gold to search ...", $COLOR_SUCCESS)
				$ichkBotStop = 0 ; reset halt attack variable
				$icmbBotCond = _GUICtrlComboBox_GetCurSel($cmbBotCond) ; Restore User GUI halt condition after modification for out of gold
				$bTrainEnabled = True
				$bDonationEnabled = True
				ContinueLoop ; Restart bot loop to reset $CommandStop
			EndIf
			If $OutOfElixir = 1 And (Number($iElixirCurrent) >= Number($itxtRestartElixir)) And (Number($iDarkCurrent) >= Number($itxtRestartDark)) Then ; check if enough elixir to begin searching again
				$OutOfElixir = 0 ; reset out of gold flag
				Setlog("Switching back to normal setting after no elixir to train ...", $COLOR_SUCCESS)
				$ichkBotStop = 0 ; reset halt attack variable
				$icmbBotCond = _GUICtrlComboBox_GetCurSel($cmbBotCond) ; Restore User GUI halt condition after modification for out of elixir
				$bTrainEnabled = True
				$bDonationEnabled = True
				ContinueLoop ; Restart bot loop to reset $CommandStop
			EndIf
			If _Sleep($iDelayRunBot5) Then Return
			checkMainScreen(False)
			If $Restart = True Then ContinueLoop
			Local $aRndFuncList = ['Collect', 'CheckTombs', 'ReArm', 'CleanYard']
			While 1
				If $RunState = False Then Return
				If $Restart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
				If UBound($aRndFuncList) > 1 Then
					$Index = Random(0, UBound($aRndFuncList), 1)
					If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
					_RunFunction($aRndFuncList[$Index])
					_ArrayDelete($aRndFuncList, $Index)
				Else
					_RunFunction($aRndFuncList[0])
					ExitLoop
				EndIf
				If $Restart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
			WEnd
			AddIdleTime()
			If $RunState = False Then Return
			If $Restart = True Then ContinueLoop
			If $iChkForecastBoost = 1 Then
 				$currentForecast = readCurrentForecast()
 					If $currentForecast >= Number($iTxtForecastBoost, 3) Then
 					SetLog("Boost Time !", $COLOR_GREEN)
 					Else
 					SetLog("Forecast index is below the required value, no boost !", $COLOR_RED)
 					EndIf
 			EndIf
			If IsSearchAttackEnabled() Then ; if attack is disabled skip reporting, requesting, donating, training, and boosting
				Local $aRndFuncList = ['ReplayShare', 'NotifyReport', 'DonateCC,Train', 'BoostBarracks', 'BoostSpellFactory', 'BoostKing', 'BoostQueen', 'BoostWarden', 'RequestCC']
				While 1
					If $RunState = False Then Return
					If $Restart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
					If UBound($aRndFuncList) > 1 Then
						$Index = Random(0, UBound($aRndFuncList), 1)
						If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
						_RunFunction($aRndFuncList[$Index])
						_ArrayDelete($aRndFuncList, $Index)
					Else
						_RunFunction($aRndFuncList[0])
						ExitLoop
					EndIf
					If checkAndroidReboot() = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
				WEnd
				If $RunState = False Then Return
				If $Restart = True Then ContinueLoop
				If $iUnbreakableMode >= 1 Then
					If Unbreakable() = True Then ContinueLoop
				EndIf
			EndIf
			SmartUpgrade()
			MainSuperXPHandler()
			Local $aRndFuncList = ['Laboratory', 'UpgradeHeroes', 'UpgradeBuilding']
			While 1
				If $RunState = False Then Return
				If $Restart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
				If UBound($aRndFuncList) > 1 Then
					$Index = Random(0, UBound($aRndFuncList), 1)
					If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
					_RunFunction($aRndFuncList[$Index])
					_ArrayDelete($aRndFuncList, $Index)
				Else
					_RunFunction($aRndFuncList[0])
					ExitLoop
				EndIf
				If checkAndroidReboot() = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
			WEnd
			clanHop()
			If $RunState = False Then Return
			If $Restart = True Then ContinueLoop
			If IsSearchAttackEnabled() Then ; If attack scheduled has attack disabled now, stop wall upgrades, and attack.
				$iNbrOfWallsUpped = 0
				UpgradeWall()
				If _Sleep($iDelayRunBot3) Then Return
				If $Restart = True Then ContinueLoop

				If $ichkSwitchAcc = 1 And $aProfileType[$nCurProfile-1] = 2 Then checkSwitchAcc()  		;  Switching to active account after donation - SwitchAcc

				Idle()
				;$fullArmy1 = $fullArmy
				If _Sleep($iDelayRunBot3) Then Return
				If $Restart = True Then ContinueLoop

				If $CommandStop <> 0 And $CommandStop <> 3 Then
					AttackMain()
					$SkipFirstZoomout = False
					If $OutOfGold = 1 Then
						Setlog("Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
						$ichkBotStop = 1 ; set halt attack variable
						$icmbBotCond = 18 ; set stay online/collect only mode
						$FirstStart = True ; reset First time flag to ensure army balancing when returns to training
						ContinueLoop
					EndIf
					If _Sleep($iDelayRunBot1) Then Return
					If $Restart = True Then ContinueLoop
				EndIf
			Else
				$iWaitTime = Random($iDelayWaitAttack1, $iDelayWaitAttack2)
				SetLog("Attacking Not Planned and Skipped, Waiting random " & StringFormat("%0.1f", $iWaitTime / 1000) & " Seconds", $COLOR_WARNING)
				If _SleepStatus($iWaitTime) Then Return False
			EndIf
		Else ;When error occours directly goes to attack
			If $Quickattack Then
				Setlog("Quick Restart... ", $COLOR_INFO)
			Else
				If $Is_SearchLimit = True Then
					SetLog("Restarted due search limit", $COLOR_INFO)
				Else
					SetLog("Restarted after Out of Sync Error: Attack Now", $COLOR_INFO)
				EndIf
			EndIf
			If _Sleep($iDelayRunBot3) Then Return
			;  OCR read current Village Trophies when OOS restart maybe due PB or else DropTrophy skips one attack cycle after OOS
			$iTrophyCurrent = Number(getTrophyMainScreen($aTrophies[0], $aTrophies[1]))
			If $debugsetlog = 1 Then SetLog("Runbot Trophy Count: " & $iTrophyCurrent, $COLOR_DEBUG)
			AttackMain()
			$SkipFirstZoomout = False
			If $OutOfGold = 1 Then
				Setlog("Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
				$ichkBotStop = 1 ; set halt attack variable
				$icmbBotCond = 18 ; set stay online/collect only mode
				$FirstStart = True ; reset First time flag to ensure army balancing when returns to training
				$Is_ClientSyncError = False ; reset fast restart flag to stop OOS mode and start collecting resources
				ContinueLoop
			EndIf
			If _Sleep($iDelayRunBot5) Then Return
			If $Restart = True Then ContinueLoop
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds
	ForecastSwitch()
	If $debugsetlog = 1 Then SetLog("Func Idle ", $COLOR_DEBUG)

	While $IsFullArmywithHeroesAndSpells = False
		checkAndroidReboot()

		;Execute Notify Pending Actions
		NotifyPendingActions()
		If _Sleep($iDelayIdle1) Then Return
		If $CommandStop = -1 Then SetLog("====== Waiting for full army  ======", $COLOR_SUCCESS)
		If $ChatbotChatGlobal = True Or $ChatbotChatClan = True Then
               ChatbotMessage()
		EndIf
		Local $hTimer = TimerInit()
		Local $iReHere = 0
		;PrepareDonateCC()

		BotHumanization()

		;If $iSkipDonateNearFulLTroopsEnable = 1 Then getArmyCapacity(true,true)
		If $bActiveDonate = True Then
			Local $aHeroResult = CheckArmyCamp(True, True, True)
			While $iReHere < 7
				$iReHere += 1
				If $iReHere = 1 And SkipDonateNearFullTroops(True, $aHeroResult) = False Then
					DonateCC(True)
			   ;modification Chat by rulesss
			   ; If $iReHere = 6 Then
			    ;    ChatbotMessage()
			    ;EndIf
               ;End Chat
				ElseIf SkipDonateNearFullTroops(False, $aHeroResult) = False Then
					DonateCC(True)
				EndIf
				If _Sleep($iDelayIdle2) Then ExitLoop
				If $Restart = True Then ExitLoop
				If checkAndroidReboot() Then ContinueLoop 2
			WEnd
		EndIf
		If _Sleep($iDelayIdle1) Then ExitLoop
		checkObstacles() ; trap common error messages also check for reconnecting animation
		checkMainScreen(False) ; required here due to many possible exits
		If ($CommandStop = 3 Or $CommandStop = 0) Then
			CheckArmyCamp(True, True)
			If _Sleep($iDelayIdle1) Then Return
			If ($fullArmy = False Or $bFullArmySpells = False) And $bTrainEnabled = True Then
				SetLog("Army Camp and Barracks are not full, Training Continues...", $COLOR_ACTION)
				$CommandStop = 0
			EndIf
		EndIf
		ReplayShare($iShareAttackNow)
		If _Sleep($iDelayIdle1) Then Return
		If $Restart = True Then ExitLoop
		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			Local $aRndFuncList = ['Collect', 'CheckTombs', 'DonateCC', 'SendChat', 'CleanYard']
			While 1
				If $RunState = False Then Return
				If $Restart = True Then ExitLoop
				If checkAndroidReboot() Then ContinueLoop 2
				If UBound($aRndFuncList) > 1 Then
					$Index = Random(0, UBound($aRndFuncList), 1)
					If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
					_RunFunction($aRndFuncList[$Index])
					_ArrayDelete($aRndFuncList, $Index)
				Else
					_RunFunction($aRndFuncList[0])
					ExitLoop
				EndIf
			WEnd
			If $RunState = False Then Return
			If $Restart = True Then ExitLoop
			If _Sleep($iDelayIdle1) Or $RunState = False Then ExitLoop
			$iCollectCounter = 0
		EndIf
		$iCollectCounter = $iCollectCounter + 1
		AddIdleTime()
		checkMainScreen(False) ; required here due to many possible exits
		If $CommandStop = -1 Then
			If $troops_maked_after_fullarmy = False And $actual_train_skip < $max_train_skip Then
				$troops_maked_after_fullarmy = False
				;Train()
				TrainRevamp()
				MainSuperXPHandler()
				If $Restart = True Then ExitLoop
				If _Sleep($iDelayIdle1) Then ExitLoop
				checkMainScreen(False)
			Else
				Setlog("Humanize bot, prevent to delete and recreate troops " & $actual_train_skip + 1 & "/" & $max_train_skip, $color_blue)
				$actual_train_skip = $actual_train_skip + 1
				If $actual_train_skip >= $max_train_skip Then
					$actual_train_skip = 0
					$troops_maked_after_fullarmy = False
				EndIf
				CheckArmyCamp(True, True)
			EndIf
		EndIf
		If _Sleep($iDelayIdle1) Then Return
		If $CommandStop = 0 And $bTrainEnabled = True Then
			If Not ($fullArmy) Then
				If $troops_maked_after_fullarmy = False And $actual_train_skip < $max_train_skip Then
					$troops_maked_after_fullarmy = False
					;Train()
					TrainRevamp()
					If $Restart = True Then ExitLoop
					If _Sleep($iDelayIdle1) Then ExitLoop
					checkMainScreen(False)
				Else
					$actual_train_skip = $actual_train_skip + 1
					If $actual_train_skip >= $max_train_skip Then
						$actual_train_skip = 0
						$troops_maked_after_fullarmy = False
					EndIf
					CheckArmyCamp(True, True)
				EndIf
			    MainSuperXPHandler()
			EndIf
			If $fullArmy Then
				SetLog("Army Camp and Barracks are full, stop Training...", $COLOR_ACTION)
				$CommandStop = 3
			EndIf
		EndIf
		If _Sleep($iDelayIdle1) Then Return
		If $CommandStop = -1 Then
			DropTrophy()
			If $Restart = True Then ExitLoop
			;If $fullArmy Then ExitLoop		; Never will reach to SmartWait4Train() to close coc while Heroes/Spells not ready 'if' Army is full, so better to be commented
			If _Sleep($iDelayIdle1) Then ExitLoop
			checkMainScreen(False)
		EndIf
		If _Sleep($iDelayIdle1) Then Return
		If $Restart = True Then ExitLoop
		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds

		If $canRequestCC = True Then RequestCC()

		SetLog("Time Idle: " & StringFormat("%02i", Floor(Floor($TimeIdle / 60) / 60)) & ":" & StringFormat("%02i", Floor(Mod(Floor($TimeIdle / 60), 60))) & ":" & StringFormat("%02i", Floor(Mod($TimeIdle, 60))))

		If $OutOfGold = 1 Or $OutOfElixir = 1 Then Return ; Halt mode due low resources, only 1 idle loop
		If ($CommandStop = 3 Or $CommandStop = 0) And $bTrainEnabled = False Then ExitLoop ; If training is not enabled, run only 1 idle loop

		If $iChkSnipeWhileTrain = 1 Then SnipeWhileTrain() ;snipe while train

		If $CommandStop = -1 Then ; Check if closing bot/emulator while training and not in halt mode
			If $ichkSwitchAcc = 1 Then				; SwitchAcc - DEMEN
				checkSwitchAcc()					; SwitchAcc - DEMEN
			Else									; SwitchAcc - DEMEN
				SmartWait4Train()
			EndIf
			If $Restart = True Then ExitLoop ; if smart wait activated, exit to runbot in case user adjusted GUI or left emulator/bot in bad state
		EndIf

	WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
	;LoadAmountOfResourcesImages() ; for debug
	If $ichkEnableSuperXP = 1 And $irbSXTraining = 2 Then
 		MainSuperXPHandler()
 		Return
 	EndIf
    ;getArmyCapacity(True, True)
	If IsSearchAttackEnabled() Then
		If (IsSearchModeActive($DB) And checkCollectors(True, False)) Or IsSearchModeActive($LB) Or IsSearchModeActive($TS) Then
			If $iChkUseCCBalanced = 1 Or $iChkUseCCBalancedCSV = 1 Then ;launch profilereport() only if option balance D/R it's activated
				ProfileReport()
				If _Sleep($iDelayAttackMain1) Then Return
				checkMainScreen(False)
				If $Restart = True Then Return
			EndIf
			If $iChkTrophyRange = 1 And Number($iTrophyCurrent) > Number($iTxtMaxTrophy) Then ;If current trophy above max trophy, try drop first
				DropTrophy()
				$Is_ClientSyncError = False ; reset OOS flag to prevent looping.
				If _Sleep($iDelayAttackMain1) Then Return
				Return ; return to runbot, refill armycamps
			EndIf
			If $debugsetlog = 1 Then
				SetLog(_PadStringCenter(" Hero status check" & BitAND($iHeroAttack[$DB], $iHeroWait[$DB], $iHeroAvailable) & "|" & $iHeroWait[$DB] & "|" & $iHeroAvailable, 54, "="), $COLOR_DEBUG)
				SetLog(_PadStringCenter(" Hero status check" & BitAND($iHeroAttack[$LB], $iHeroWait[$LB], $iHeroAvailable) & "|" & $iHeroWait[$LB] & "|" & $iHeroAvailable, 54, "="), $COLOR_DEBUG)
				;Setlog("BullyMode: " & $OptBullyMode & ", Bully Hero: " & BitAND($iHeroAttack[$iTHBullyAttackMode], $iHeroWait[$iTHBullyAttackMode], $iHeroAvailable) & "|" & $iHeroWait[$iTHBullyAttackMode] & "|" & $iHeroAvailable, $COLOR_DEBUG)
			EndIf
			PrepareSearch()
			If $OutOfGold = 1 Then Return ; Check flag for enough gold to search
			If $Restart = True Then Return
			VillageSearch()
			If $OutOfGold = 1 Then Return ; Check flag for enough gold to search
			If $Restart = True Then Return
			PrepareAttack($iMatchMode)
			If $Restart = True Then Return
			Attack()
			If $Restart = True Then Return
			ReturnHome($TakeLootSnapShot)
			If _Sleep($iDelayAttackMain2) Then Return
			Return True
		Else
			Setlog("No one of search condition match:", $COLOR_WARNING)
			Setlog("Waiting on troops, heroes and/or spells according to search settings", $COLOR_WARNING)
			$Is_SearchLimit = False
			$Is_ClientSyncError = False
			$Quickattack = False
		; SwitchAcc - DEMEN
			If $ichkSwitchAcc = 1 Then
				checkSwitchAcc()
			Else
				SmartWait4Train()
			EndIf
		; =============== SwitchAcc - DEMEN

		EndIf
	Else
		SetLog("Attacking Not Planned, Skipped..", $COLOR_WARNING)
	EndIf
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
	SetLog(" ====== Start Attack ====== ", $COLOR_SUCCESS)
	If ($iMatchMode = $DB And $iAtkAlgorithm[$DB] = 1) Or ($iMatchMode = $LB And $iAtkAlgorithm[$LB] = 1) Then
		If $debugsetlog = 1 Then Setlog("start scripted attack", $COLOR_ERROR)
		Algorithm_AttackCSV()
	ElseIf $iMatchMode = $DB And $iAtkAlgorithm[$DB] = 2 Then
		If $debugsetlog = 1 Then Setlog("start milking attack", $COLOR_ERROR)
		Alogrithm_MilkingAttack()
	Else
		If $debugsetlog = 1 Then Setlog("start standard attack", $COLOR_ERROR)
		algorithm_AllTroops()
	EndIf
EndFunc   ;==>Attack


Func QuickAttack()

	Local $quicklymilking = 0
	Local $quicklythsnipe = 0

	getArmyCapacity(True, True)

	If ($iAtkAlgorithm[$DB] = 2 And IsSearchModeActive($DB)) Or (IsSearchModeActive($TS)) Then
		VillageReport()
	EndIf

	$iTrophyCurrent = getTrophyMainScreen($aTrophies[0], $aTrophies[1])
	If ($iChkTrophyRange = 1 And Number($iTrophyCurrent) > Number($iTxtMaxTrophy)) Then
		If $debugsetlog = 1 Then Setlog("No quickly re-attack, need to drop tropies", $COLOR_DEBUG)
		Return False ;need to drop tropies
	EndIf

	If $iAtkAlgorithm[$DB] = 2 And IsSearchModeActive($DB) Then
		If Int($CurCamp) >= $TotalCamp * $iEnableAfterArmyCamps[$DB] / 100 And $iEnableSearchCamps[$DB] = 1 Then
			If $debugsetlog = 1 Then Setlog("Milking: Quickly re-attack " & Int($CurCamp) & " >= " & $TotalCamp & " * " & $iEnableAfterArmyCamps[$DB] & "/100 " & "= " & $TotalCamp * $iEnableAfterArmyCamps[$DB] / 100, $COLOR_DEBUG)
			Return True ;milking attack OK!
		Else
			If $debugsetlog = 1 Then Setlog("Milking: No Quickly re-attack:  cur. " & Int($CurCamp) & "  need " & $TotalCamp * $iEnableAfterArmyCamps[$DB] / 100 & " firststart = " & ($quicklyfirststart), $COLOR_DEBUG)
			Return False ;milking attack no restart.. no enough army
		EndIf
	EndIf

	If IsSearchModeActive($TS) Then
		If Int($CurCamp) >= $TotalCamp * $iEnableAfterArmyCamps[$TS] / 100 And $iEnableSearchCamps[$TS] = 1 Then
			If $debugsetlog = 1 Then Setlog("THSnipe: Quickly re-attack " & Int($CurCamp) & " >= " & $TotalCamp & " * " & $iEnableAfterArmyCamps[$TS] & "/100 " & "= " & $TotalCamp * $iEnableAfterArmyCamps[$TS] / 100, $COLOR_DEBUG)
			Return True ;ts snipe attack OK!
		Else
			If $debugsetlog = 1 Then Setlog("THSnipe: No Quickly re-attack:  cur. " & Int($CurCamp) & "  need " & $TotalCamp * $iEnableAfterArmyCamps[$TS] / 100 & " firststart = " & ($quicklyfirststart), $COLOR_DEBUG)
			Return False ;ts snipe no restart... no enough army
		EndIf
	EndIf

EndFunc   ;==>QuickAttack

Func _RunFunction($action)
	SetDebugLog("_RunFunction: " & $action & " BEGIN", $COLOR_DEBUG2)
	Switch $action
		Case "Collect"
			Collect()
			_Sleep($iDelayRunBot1)
		Case "CheckTombs"
			CheckTombs()
			_Sleep($iDelayRunBot3)
		Case "CleanYard"
			CleanYard()
		Case "ReArm"
			ReArm()
			_Sleep($iDelayRunBot3)
		Case "ReplayShare"
			ReplayShare($iShareAttackNow)
			_Sleep($iDelayRunBot3)
		Case "NotifyReport"
			NotifyReport()
			_Sleep($iDelayRunBot3)
		Case "DonateCC"
			If $bActiveDonate = True Then
				;If $iSkipDonateNearFulLTroopsEnable = 1 and $FirstStart = False Then getArmyCapacity(True, True)
				If SkipDonateNearFullTroops(True) = False Then DonateCC()
				If _Sleep($iDelayRunBot1) = False Then checkMainScreen(False)
			EndIf
		Case "SendChat"
		    If $ChatbotChatGlobal = True Or $ChatbotChatClan = True Then
               ChatbotMessage()
		    EndIf
		Case "DonateCC,Train"
			If $iSkipDonateNearFulLTroopsEnable = 1 And $FirstStart = True Then getArmyCapacity(True, True)
			If $bActiveDonate = True Then
				If SkipDonateNearFullTroops(True) = False Then DonateCC()
			EndIf
			If _Sleep($iDelayRunBot1) = False Then checkMainScreen(False)
			If $troops_maked_after_fullarmy = False And $actual_train_skip < $max_train_skip Then
				$troops_maked_after_fullarmy = False
				;Train()
				TrainRevamp()
				_Sleep($iDelayRunBot1)
			Else
				Setlog("Humanize bot, prevent to delete and recreate troops " & $actual_train_skip + 1 & "/" & $max_train_skip, $color_blue)
				$actual_train_skip = $actual_train_skip + 1
				If $actual_train_skip >= $max_train_skip Then
					$actual_train_skip = 0
					$troops_maked_after_fullarmy = False
				EndIf
				CheckOverviewFullArmy(True, False) ; use true parameter to open train overview window
				If ISArmyWindow(False, $ArmyTAB) then CheckExistentArmy("Spells") ; Imgloc Method
				getArmyHeroCount(False, True)
			EndIf
		Case "BoostBarracks"
			BoostBarracks()
		Case "BoostSpellFactory"
			BoostSpellFactory()
		Case "BoostKing"
			BoostKing()
		Case "BoostQueen"
			BoostQueen()
		Case "BoostWarden"
			BoostWarden()
		Case "RequestCC"
			RequestCC()
			If _Sleep($iDelayRunBot1) = False Then checkMainScreen(False)
		Case "Laboratory"
			Laboratory()
			If _Sleep($iDelayRunBot3) = False Then checkMainScreen(False)
		Case "UpgradeHeroes"
			UpgradeHeroes()
			_Sleep($iDelayRunBot3)
		Case "UpgradeBuilding"
			UpgradeBuilding()
			_Sleep($iDelayRunBot3)
	    Case "SuperXP"
 			MainSuperXPHandler()
 			_Sleep($iDelayRunBot3)
		Case ""
			SetDebugLog("Function call doesn't support empty string, please review array size", $COLOR_ERROR)
		Case Else
			SetLog("Unknown function call: " & $action, $COLOR_ERROR)
	EndSwitch
	SetDebugLog("_RunFunction: " & $action & " END", $COLOR_DEBUG2)
EndFunc   ;==>_RunFunction
