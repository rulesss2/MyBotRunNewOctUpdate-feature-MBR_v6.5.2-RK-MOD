﻿; #FUNCTION# ====================================================================================================================
; Name ..........: MBR Bot
; Description ...: This file contains the initialization and main loop sequences f0r the MBR Bot
; Author ........:  (2014)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; AutoIt pragmas
#RequireAdmin
#AutoIt3Wrapper_UseX64=7n
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/rsln /MI=3
;/SV=0

;#AutoIt3Wrapper_Change2CUI=y
;#pragma compile(Console, true)
#pragma compile(Icon, "Images\MyBot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free Clash of Clans bot - https://mybot.run)
#pragma compile(ProductName, My Bot)
#pragma compile(ProductVersion, 7.0)
#pragma compile(FileVersion, 7.0)
#pragma compile(LegalCopyright, © https://mybot.run)
#pragma compile(Out, MyBot.run.exe) ; Required

; Enforce variable declarations
Opt("MustDeclareVars", 1)

Global $g_sBotVersion = "v7.0.1" ;~ Don't add more here, but below. Version can't be longer than vX.y.z because it is also use on Checkversion()
Global $g_sModversion = "v3.6" ;<== Just Change This to Version Number
Global $g_sModSupportUrl = "https://mybot.run/forums/index.php?/topic/27601-mybotrun-dococ-v352/&" ;<== Our Website Link Or Link Download
Global $g_sBotTitle = "" ;~ Don't assign any title here, use Func UpdateBotTitle()
Global $g_hFrmBot = 0 ; The main GUI window

Global $icmbAccountsQuantity = 0, $CurrentAccount = 0 ; moved here to get rid of declare error
Global $aTxtLogInitText[0][6] = [[]] ; moved here to get rid of declare error


; MBR includes
#include "COCBot\MBR Global Variables.au3"
#include "COCBot\functions\Config\DelayTimes.au3"
#include "COCBot\GUI\MBR GUI Design Splash.au3"
#include "COCBot\functions\Config\ScreenCoordinates.au3"
#include "COCBot\functions\Other\ExtMsgBox.au3"
#include "COCBot\functions\Other\MBRFunc.au3"
#include "COCBot\functions\Android\Android.au3"
#include "COCBot\functions\Android\Distributors.au3"
#include "COCBot\MBR GUI Design.au3"
#include "COCBot\MBR GUI Control.au3"
#include "COCBot\MBR Functions.au3"
#include "COCBot\functions\Other\Multilanguage.au3"
; MBR References.au3 must be last include
#include "COCBot\MBR References.au3"

; Autoit Options
Opt("GUIResizeMode", $GUI_DOCKALL) ; Default resize mode for dock android support
Opt("GUIEventOptions", 1) ; Handle minimize and restore for dock android support
Opt("GUICloseOnESC", 0) ; Don't send the $GUI_EVENT_CLOSE message when ESC is pressed.
Opt("WinTitleMatchMode", 3) ; Window Title exact match mode
Opt("GUIOnEventMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 10)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)

; All executable code is in a function block, to detect coding errors, such as variable declaration scope problems
InitializeBot()

; Hand over control to main loop
MainLoop()

Func UpdateBotTitle()
	Local $sTitle = "My Bot " & $g_sBotVersion & "  DocOc " & $g_sModversion & " "
	If $g_sBotTitle = "" Then
		$g_sBotTitle = $sTitle
		Return
	EndIf

	$g_sBotTitle = $sTitle & "(" & ($g_sAndroidInstance <> "" ? $g_sAndroidInstance : $g_sAndroidEmulator) & ")" ;Do not change this. If you do, multiple instances will not work.

	If $g_hFrmBot <> 0 Then
		; Update Bot Window Title also
		WinSetTitle($g_hFrmBot, "", $g_sBotTitle)
	EndIf

	SetDebugLog("Bot title updated to: " & $g_sBotTitle)
EndFunc   ;==>UpdateBotTitle

Func InitializeBot()

   ProcessCommandLine()

   SetupProfileFolder()

   ; check for VC2010, .NET software and MyBot Files and Folders
   If CheckPrerequisites(True) Then
	   MBRFunc(True) ; start MBRFunctions dll
   EndIf

   ; initialize bot title
   UpdateBotTitle()

   InitAndroidConfig()

   If FileExists(@ScriptDir & "\EnableMBRDebug.txt") Then $g_bDevMode = True

   ; <><><>
   ; No "SetDebugLog" or "SetLog" calls prior to this line.  Make sure #included files do not contain executable code outside of function blocks.
   ; Calling "SetDebugLog" or "SetLog" before this line will cause MBR to create its log file in the @ScriptDir folder, instead of the profile folder.
   ; <><><>

   ; Debug Output of launch parameter
   SetDebugLog("@AutoItExe: " & @AutoItExe)
   SetDebugLog("@ScriptFullPath: " & @ScriptFullPath)
   SetDebugLog("@WorkingDir: " & @WorkingDir)
   SetDebugLog("@AutoItPID: " & @AutoItPID)
   SetDebugLog("@OSArch: " & @OSArch)
   SetDebugLog("@OSVersion: " & @OSVersion)
   SetDebugLog("@OSBuild: " & @OSBuild)
   SetDebugLog("@OSServicePack: " & @OSServicePack)
   SetDebugLog("Primary Display: " & @DesktopWidth & " x " & @DesktopHeight & " - " & @DesktopDepth & "bit")

   ; early load of config
   If FileExists($g_sProfileConfigPath) Or FileExists($g_sProfileBuildingPath) Then
	   readConfig()
   EndIf

   __GDIPlus_Startup()
   CreateSplashScreen()

   Local $hBotLaunchTime = TimerInit()
   Local $sAndroidInfo = ""
   Local $iBotProcessPriority = _ProcessGetPriority(@AutoItPID)
   ProcessSetPriority(@AutoItPID, $PROCESS_ABOVENORMAL) ;~ Boost launch time by increasing process priority (will be restored again when finished launching)
   InitializeMBR($sAndroidInfo)

   ; Create GUI
   CreateMainGUI()

   InitializeMainGUI()

   ; Files/folders
   SetupFilesAndFolders()

   ; Show main GUI
   ShowMainGUI()
   DestroySplashScreen()

   ; Some final setup steps and checks
   FinalInitialization($hBotLaunchTime, $sAndroidInfo)
   ProcessSetPriority(@AutoItPID, $iBotProcessPriority) ;~ Restore process priority

   ; Ensure watchdog is launched
   LaunchWatchdog()

   ; AutoStart Bot if requested
   AutoStart()

EndFunc   ;==>InitializeBot

; #FUNCTION# ====================================================================================================================
; Name ..........: ProcessCommandLine
; Description ...: Handle command line parameters
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
Func ProcessCommandLine()
   ; Handle Command Line Launch Options and fill $g_asCmdLine
   If $CmdLine[0] > 0 Then
	   For $i = 1 To $CmdLine[0]
		   Switch $CmdLine[$i]
			   ; terminate bot if it exists (by window title!)
			   Case "/restart", "/r", "-restart", "-r"
				   $g_bBotLaunchOption_Restart = True
			   Case "/autostart", "/a", "-autostart", "-a"
				   $g_bBotLaunchOption_Autostart = True
			   Case Else
				   $g_asCmdLine[0] += 1
				   ReDim $g_asCmdLine[$g_asCmdLine[0] + 1]
				   $g_asCmdLine[$g_asCmdLine[0]] = $CmdLine[$i]
		   EndSwitch
	   Next
	EndIf

   ; Handle Command Line Parameters
   If $g_asCmdLine[0] > 0 Then
	   $g_sProfileCurrentName = StringRegExpReplace($g_asCmdLine[1], '[/:*?"<>|]', '_')
   ElseIf FileExists($g_sProfilePath & "\profile.ini") Then
	   $g_sProfileCurrentName = StringRegExpReplace(IniRead($g_sProfilePath & "\profile.ini", "general", "defaultprofile", ""), '[/:*?"<>|]', '_')
	   If $g_sProfileCurrentName = "" Or Not FileExists($g_sProfilePath & "\" & $g_sProfileCurrentName) Then $g_sProfileCurrentName = "<No Profiles>"
   Else
	   $g_sProfileCurrentName = "<No Profiles>"
   EndIf
EndFunc   ;==>ProcessCommandLine

; #FUNCTION# ====================================================================================================================
; Name ..........: InitializeAndroid
; Description ...: Initialize Android
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: cosote (Feb-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func InitializeAndroid()
	Local $s = GetTranslated(500, 21, "Initializing Android...")
	SplashStep($s)

	If $g_bBotLaunchOption_Restart = False Then
		; initialize Android config
		InitAndroidConfig(True)

		; Change Android type and update variable
		If $g_asCmdLine[0] > 1 Then
			Local $i
			For $i = 0 To UBound($g_avAndroidAppConfig) - 1
				If StringCompare($g_avAndroidAppConfig[$i][0], $g_asCmdLine[2]) = 0 Then
					$g_iAndroidConfig = $i
					SplashStep($s & "(" & $g_avAndroidAppConfig[$i][0] & ")...", False)
					If $g_avAndroidAppConfig[$i][1] <> "" And $g_asCmdLine[0] > 2 Then
						; Use Instance Name
						UpdateAndroidConfig($g_asCmdLine[3])
					Else
						UpdateAndroidConfig()
					EndIf
					SplashStep($s & "(" & $g_avAndroidAppConfig[$i][0] & ")", False)
				EndIf
			Next
		EndIf

		SplashStep(GetTranslated(500, 22, "Detecting Android..."))
		If $g_asCmdLine[0] < 2 Then
			DetectRunningAndroid()
			If Not $g_bFoundRunningAndroid Then DetectInstalledAndroid()
		EndIf
	EndIf

	CleanSecureFiles()

EndFunc   ;==>InitializeAndroid

; #FUNCTION# ====================================================================================================================
; Name ..........: SetupProfileFolder
; Description ...: Populate profile-related globals
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
Func SetupProfileFolder()
   $g_sProfileConfigPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\config.ini"
   $g_sProfileWeakBasePath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\stats_chkweakbase.INI"
   $g_sProfileBuildingPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\building.ini"
   $g_sProfileLogsPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Logs\"
   $g_sProfileLootsPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Loots\"
   $g_sProfileTempPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Temp\"
   $g_sProfileTempDebugPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Temp\Debug\"
   $g_sProfileDonateCapturePath = $g_sProfilePath & "\" & $g_sProfileCurrentName & '\Donate\'
   $g_sProfileDonateCaptureWhitelistPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & '\Donate\White List\'
   $g_sProfileDonateCaptureBlacklistPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & '\Donate\Black List\'
EndFunc   ;==>SetupProfileFolder

; #FUNCTION# ====================================================================================================================
; Name ..........: InitializeMBR
; Description ...: MBR setup routine
; Syntax ........:
; Parameters ....: $sAI - populated with AndroidInfo string in this function
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func InitializeMBR(ByRef $sAI)
   ; license
   If Not FileExists(@ScriptDir & "\License.txt") Then
	   Local $hDownload = InetGet("http://www.gnu.org/licenses/gpl-3.0.txt", @ScriptDir & "\License.txt")

		; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
		Local $i = 0
		Do
			Sleep($iDelayDownloadLicense)
			$i += 1
		Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) Or $i > 25

		InetClose($hDownload)
   EndIf

   ; multilanguage
   If Not FileExists(@ScriptDir & "\Languages") Then DirCreate(@ScriptDir & "\Languages")
   DetectLanguage()

   ; must be called after language is detected
   TranslateTroopNames()
   InitializeCOCDistributors()

   ; check for compiled x64 version
   Local $sMsg = GetTranslated(500, 1, "Don't Run/Compile the Script as (x64)! Try to Run/Compile the Script as (x86) to get the bot to work.\r\n" & _
		   "If this message still appears, try to re-install AutoIt.")
   If @AutoItX64 = 1 Then
	  DestroySplashScreen()
	  MsgBox(0, "", $sMsg)
	  __GDIPlus_Shutdown()
	  Exit
   EndIf

   ; Initialize Android emulator
   InitializeAndroid()

   ; Update Bot title
   UpdateBotTitle()
   UpdateSplashTitle($g_sBotTitle & GetTranslated(500, 20, ", Profile: %s", $g_sProfileCurrentName))

   If $g_bBotLaunchOption_Restart = True Then
	   If WinGetHandle($g_sBotTitle) Then SplashStep(GetTranslated(500, 36, "Closing previous bot..."), False)
	   If CloseRunningBot($g_sBotTitle) = True Then
		   ; wait for Mutexes to get disposed
		   Sleep(3000)
		   ; check if Android is running
		   WinGetAndroidHandle()
	   EndIf
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

   $g_hMutex_BotTitle = _Singleton($g_sBotTitle, 1)
   $sAI = GetTranslated(500, 3, "%s", $g_sAndroidEmulator)
   Local $sAndroidInfo2 = GetTranslated(500, 4, "%s (instance %s)", $g_sAndroidEmulator, $g_sAndroidInstance)
   If $g_sAndroidInstance <> "" Then
	   $sAI = $sAndroidInfo2
   EndIf

   ; Check if we are already running for this instance
   $sMsg = GetTranslated(500, 5, "My Bot for %s is already running.\r\n\r\n", $sAI)
   If $g_hMutex_BotTitle = 0 Then
	   DestroySplashScreen()
	   MsgBox(BitOR($MB_OK, $MB_ICONINFORMATION, $MB_TOPMOST), $g_sBotTitle, $sMsg & $cmdLineHelp)
	  __GDIPlus_Shutdown()
	  Exit
   EndIf

   ; Check if we are already running for this profile
   $g_hMutex_Profile = _Singleton(StringReplace($g_sProfilePath & "\" & $g_sProfileCurrentName, "\", "-"), 1)
   $sMsg = GetTranslated(500, 6, "My Bot with Profile %s is already running in %s.\r\n\r\n", $g_sProfileCurrentName, $g_sProfilePath & "\" & $g_sProfileCurrentName)
   If $g_hMutex_Profile = 0 Then
	   _WinAPI_CloseHandle($g_hMutex_BotTitle)
	   DestroySplashScreen()
	   MsgBox(BitOR($MB_OK, $MB_ICONINFORMATION, $MB_TOPMOST), $g_sBotTitle, $sMsg & $cmdLineHelp)
	  __GDIPlus_Shutdown()
	  Exit
   EndIf

   ; Get mutex
   $g_hMutex_MyBot = _Singleton("MyBot.run", 1)
   $g_bOnlyInstance = $g_hMutex_MyBot <> 0 ; And False
   SetDebugLog("My Bot is " & ($g_bOnlyInstance ? "" : "not ") & "the only running instance")
EndFunc   ;==>InitializeMBR

; #FUNCTION# ====================================================================================================================
; Name ..........: SetupFilesAndFolders
; Description ...: Checks for presence of needed files and folders, cleans up and creates as required
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
Func SetupFilesAndFolders()

   CheckPrerequisites(False)
   ;DirCreate($sTemplates)
   DirCreate($g_sProfilePresetPath)
   DirCreate($g_sProfilePath & "\" & $g_sProfileCurrentName)
   DirCreate($g_sProfileLogsPath)
   DirCreate($g_sProfileLootsPath)
   DirCreate($g_sProfileTempPath)
   DirCreate($g_sProfileTempDebugPath)

   $g_sProfileDonateCapturePath = $g_sProfilePath & "\" & $g_sProfileCurrentName & '\Donate\'
   $g_sProfileDonateCaptureWhitelistPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & '\Donate\White List\'
   $g_sProfileDonateCaptureBlacklistPath = $g_sProfilePath & "\" & $g_sProfileCurrentName & '\Donate\Black List\'
   DirCreate($g_sProfileDonateCapturePath)
   DirCreate($g_sProfileDonateCaptureWhitelistPath)
   DirCreate($g_sProfileDonateCaptureBlacklistPath)

   ;Migrate old bot without profile support to current one
   FileMove(@ScriptDir & "\*.ini", $g_sProfilePath & "\" & $g_sProfileCurrentName, $FC_OVERWRITE + $FC_CREATEPATH)
   DirCopy(@ScriptDir & "\Logs", $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Logs", $FC_OVERWRITE + $FC_CREATEPATH)
   DirCopy(@ScriptDir & "\Loots", $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Loots", $FC_OVERWRITE + $FC_CREATEPATH)
   DirCopy(@ScriptDir & "\Temp", $g_sProfilePath & "\" & $g_sProfileCurrentName & "\Temp", $FC_OVERWRITE + $FC_CREATEPATH)
   DirRemove(@ScriptDir & "\Logs", 1)
   DirRemove(@ScriptDir & "\Loots", 1)
   DirRemove(@ScriptDir & "\Temp", 1)

   ;Setup profile if doesn't exist yet
   If FileExists($g_sProfileConfigPath) = 0 Then
	   createProfile(True)
	   applyConfig()
   EndIf

   If $ichkDeleteLogs = 1 Then DeleteFiles($g_sProfileLogsPath, "*.*", $iDeleteLogsDays, 0)
   If $ichkDeleteLoots = 1 Then DeleteFiles($g_sProfileLootsPath, "*.*", $iDeleteLootsDays, 0)
   If $ichkDeleteTemp = 1 Then DeleteFiles($g_sProfileTempPath, "*.*", $iDeleteTempDays, 0)
   If $ichkDeleteTemp = 1 Then DeleteFiles($g_sProfileTempDebugPath, "*.*", $iDeleteTempDays, 0)

   SetDebugLog("$g_sProfilePath = " & $g_sProfilePath)
   SetDebugLog("$g_sProfileCurrentName = " & $g_sProfileCurrentName)
   SetDebugLog("$g_sProfileLogsPath = " & $g_sProfileLogsPath)
EndFunc   ;==>SetupFilesAndFolders

; #FUNCTION# ====================================================================================================================
; Name ..........: FinalInitialization
; Description ...: Finalize various setup requirements
; Syntax ........:
; Parameters ....: $hBLT: Timer handle containing time bot was launched
;				   $sAI: AndroidInfo for displaying in the log
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func FinalInitialization(Const $hBLT, Const $sAI)
   If $g_bFoundRunningAndroid Then
	   SetLog(GetTranslated(500, 7, "Found running %s %s", $g_sAndroidEmulator, $g_sAndroidVersion), $COLOR_SUCCESS)
   EndIf
   If $g_bFoundInstalledAndroid Then
	   SetLog("Found installed " & $g_sAndroidEmulator & " " & $g_sAndroidVersion, $COLOR_SUCCESS)
   EndIf
   SetLog(GetTranslated(500, 8, "Android Emulator Configuration: %s", $sAI), $COLOR_SUCCESS)

   ;AdlibRegister("PushBulletRemoteControl", $g_iPBRemoteControlInterval)
   ;AdlibRegister("PushBulletDeleteOldPushes", $g_iPBDeleteOldPushesInterval)

   CheckDisplay() ; verify display size and DPI (Dots Per Inch) setting

   LoadAmountOfResourcesImages()

   ;~ InitializeVariables();initialize variables used in extrawindows
   CheckVersion() ; check latest version on mybot.run site

   ;~ Remember time in Milliseconds bot launched
   $g_iBotLaunchTime = TimerDiff($hBLT)
   SetDebugLog("MyBot.run launch time " & Round($g_iBotLaunchTime) & " ms.")

   If $g_bAndroidShieldEnabled = False Then
	   SetLog(GetTranslated(500, 9, "Android Shield not available for %s", @OSVersion), $COLOR_ACTION)
   EndIf

   DisableProcessWindowsGhosting()
EndFunc   ;==>FinalInitialization

; #FUNCTION# ====================================================================================================================
; Name ..........: MainLoop
; Description ...: Main application loop
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
Func MainLoop()
   While 1
	   _Sleep($iDelaySleep, True, False)

	   Switch $g_iBotAction
		   Case $eBotStart
			   BotStart()
			   If $g_iBotAction = $eBotStart Then $g_iBotAction = $eBotNoAction
		   Case $eBotStop
			   BotStop()
			   If $g_iBotAction = $eBotStop Then $g_iBotAction = $eBotNoAction
		   Case $eBotSearchMode
			   BotSearchMode()
			   If $g_iBotAction = $eBotSearchMode Then $g_iBotAction = $eBotNoAction
		   Case $eBotClose
			   BotClose()
	   EndSwitch

	   ; force app crash for debugging/testing purposes
	   ;DllCallAddress("NONE", 0)
	WEnd
EndFunc   ;==>MainLoop

Func runBot() ;Bot that runs everything in order

	If $FirstInit Then SwitchAccount(True)
	Local $iWaitTime
	While 1
		; In order to prevent any GDI leaks, restart always GDI+ Environment here (update: bad, cause bot "crashes")
		;__GDIPlus_Shutdown()
		;__GDIPlus_Startup()
		PrepareDonateCC()
		$g_bRestart = False
		$fullArmy = False
		$g_iCommandStop = -1
		If _Sleep($iDelayRunBot1) Then Return
		checkMainScreen()
		If $g_bRestart = True Then ContinueLoop
;============Switch Account / Multi Stat Hook into main Code=================
			If $ichkSwitchAccount = 1 Then
				Setlog("Checking the Lab's Status", $COLOR_INFO)
				If Labstatus() Then ; Faster Getting an Updated State of Lab Running, or Stopped
					GUICtrlSetBkColor($g_lblLabStatus[$CurrentAccount], $COLOR_GREEN)
					GUICtrlSetBkColor($g_lblLabStatusPO[$CurrentAccount], $COLOR_GREEN)
				EndIf	; other color states are painted in LabStatus

				If _Sleep($iDelayRunBot5) Then Return
				checkMainScreen(False)
				If $g_bRestart = True Then ContinueLoop
				Setlog("Checking the Hero's Status", $COLOR_INFO)
				HeroStatsStaus() ; Early Update of Hero Status

				If _Sleep($iDelayRunBot5) Then Return
				checkMainScreen(False)
				If $g_bRestart = True Then ContinueLoop
			EndIf
;============Switch Account / Multi Stat Hook into main Code=================

		chkShieldStatus()
		If $g_bRestart = True Then ContinueLoop

		If $g_bQuicklyFirstStart = True Then
			$g_bQuicklyFirstStart = False
		Else
			$g_bQuickAttack = QuickAttack()
		EndIf

		If checkAndroidReboot() = True Then ContinueLoop
		If $Is_ClientSyncError = False And $Is_SearchLimit = False And ($g_bQuickAttack = False) Then
			If BotCommand() Then btnStop()
			If _Sleep($iDelayRunBot2) Then Return
			checkMainScreen(False)
			If $g_bRestart = True Then ContinueLoop
			If _Sleep($iDelayRunBot3) Then Return
			VillageReport()
			If $OutOfGold = 1 And (Number($iGoldCurrent) >= Number($g_iTxtRestartGold)) Then ; check if enough gold to begin searching again
				$OutOfGold = 0 ; reset out of gold flag
				Setlog("Switching back to normal after no gold to search ...", $COLOR_SUCCESS)
				$g_bChkBotStop = False ; reset halt attack variable
				$g_iCmbBotCond = _GUICtrlComboBox_GetCurSel($g_hCmbBotCond) ; Restore User GUI halt condition after modification for out of gold
				$bTrainEnabled = True
				$bDonationEnabled = True
				ContinueLoop ; Restart bot loop to reset $g_iCommandStop
			EndIf
			If $OutOfElixir = 1 And (Number($iElixirCurrent) >= Number($g_iTxtRestartElixir)) And (Number($iDarkCurrent) >= Number($g_iTxtRestartDark)) Then ; check if enough elixir to begin searching again
				$OutOfElixir = 0 ; reset out of gold flag
				Setlog("Switching back to normal setting after no elixir to train ...", $COLOR_SUCCESS)
				$g_bChkBotStop = False ; reset halt attack variable
				$g_iCmbBotCond = _GUICtrlComboBox_GetCurSel($g_hCmbBotCond) ; Restore User GUI halt condition after modification for out of elixir
				$bTrainEnabled = True
				$bDonationEnabled = True
				ContinueLoop ; Restart bot loop to reset $g_iCommandStop
			EndIf
			If _Sleep($iDelayRunBot5) Then Return
			checkMainScreen(False)
			If $g_bRestart = True Then ContinueLoop

			Local $aRndFuncList = ['Collect', 'CheckTombs', 'ReArm', 'CleanYard', 'CollectTreasury']
			While 1
				If $g_bRunState = False Then Return
				If $g_bRestart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
				If UBound($aRndFuncList) > 1 Then
					Local $Index = Random(0, UBound($aRndFuncList), 1)
					If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
					_RunFunction($aRndFuncList[$Index])
					_ArrayDelete($aRndFuncList, $Index)
				Else
					_RunFunction($aRndFuncList[0])
					ExitLoop
				EndIf
				If $g_bRestart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
			WEnd
			AddIdleTime()
			If $g_bRunState = False Then Return
			If $g_bRestart = True Then ContinueLoop
			If IsSearchAttackEnabled() Then ; if attack is disabled skip reporting, requesting, donating, training, and boosting
				Local $aRndFuncList = ['ReplayShare', 'NotifyReport', 'DonateCC,Train', 'BoostBarracks', 'BoostSpellFactory', 'BoostKing', 'BoostQueen', 'BoostWarden', 'RequestCC']
				While 1
					If $g_bRunState = False Then Return
					If $g_bRestart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
					If UBound($aRndFuncList) > 1 Then
						Local $Index = Random(0, UBound($aRndFuncList), 1)
						If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
						_RunFunction($aRndFuncList[$Index])
						_ArrayDelete($aRndFuncList, $Index)
					Else
						_RunFunction($aRndFuncList[0])
						ExitLoop
					EndIf
					If checkAndroidReboot() = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
				WEnd
				If $g_bRunState = False Then Return
				If $g_bRestart = True Then ContinueLoop
				If $g_iUnbrkMode >= 1 Then
					If Unbreakable() = True Then ContinueLoop
				EndIf
			EndIf
			MainSuperXPHandler()
			Local $aRndFuncList = ['Laboratory', 'UpgradeHeroes', 'UpgradeBuilding']
			While 1
				If $g_bRunState = False Then Return
				If $g_bRestart = True Then ContinueLoop 2 ; must be level 2 due to loop-in-loop
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
			If $g_bRunState = False Then Return
			If $g_bRestart = True Then ContinueLoop
			If IsSearchAttackEnabled() Then ; If attack scheduled has attack disabled now, stop wall upgrades, and attack.
				$iNbrOfWallsUpped = 0
				UpgradeWall()
				If _Sleep($iDelayRunBot3) Then Return
				If $g_bRestart = True Then ContinueLoop
				Idle()
				;$fullArmy1 = $fullArmy
				If _Sleep($iDelayRunBot3) Then Return
				If $g_bRestart = True Then ContinueLoop

				If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
					AttackMain()
					$g_bSkipFirstZoomout = False
					If $OutOfGold = 1 Then
						Setlog("Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
						$g_bChkBotStop = True ; set halt attack variable
						$g_iCmbBotCond = 18 ; set stay online/collect only mode
						$g_bFirstStart = True ; reset First time flag to ensure army balancing when returns to training
						ContinueLoop
					EndIf
					If _Sleep($iDelayRunBot1) Then Return
					If $g_bRestart = True Then ContinueLoop
				EndIf
			Else
				$iWaitTime = Random($iDelayWaitAttack1, $iDelayWaitAttack2)
				SetLog("Attacking Not Planned and Skipped, Waiting random " & StringFormat("%0.1f", $iWaitTime / 1000) & " Seconds", $COLOR_WARNING)
				If _SleepStatus($iWaitTime) Then Return False
			EndIf
		Else ;When error occours directly goes to attack
			If $g_bQuickAttack Then
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
			If $g_iDebugSetlog = 1 Then SetLog("Runbot Trophy Count: " & $iTrophyCurrent, $COLOR_DEBUG)
			AttackMain()
			$g_bSkipFirstZoomout = False
			If $OutOfGold = 1 Then
				Setlog("Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
				$g_bChkBotStop = True ; set halt attack variable
				$g_iCmbBotCond = 18 ; set stay online/collect only mode
				$g_bFirstStart = True ; reset First time flag to ensure army balancing when returns to training
				$Is_ClientSyncError = False ; reset fast restart flag to stop OOS mode and start collecting resources
				ContinueLoop
			EndIf
			If _Sleep($iDelayRunBot5) Then Return
			If $g_bRestart = True Then ContinueLoop
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
    Static $iCollectCounter = 0 ; Collect counter, when reaches $g_iCollectAtCount, it will collect

	Local $TimeIdle = 0 ;In Seconds
	If $g_iDebugSetlog = 1 Then SetLog("Func Idle ", $COLOR_DEBUG)

	While $IsFullArmywithHeroesAndSpells = False
		checkAndroidReboot()

		;Execute Notify Pending Actions
		NotifyPendingActions()
		If _Sleep($iDelayIdle1) Then Return
		If $g_iCommandStop = -1 Then SetLog("====== Waiting for full army ======", $COLOR_SUCCESS)
		Local $hTimer = TimerInit()
		Local $iReHere = 0
		BotHumanization()

		;If $g_bDonateSkipNearFullEnable = True Then getArmyCapacity(true,true)
		If $bActiveDonate And $g_bChkDonate Then
			Local $aHeroResult = CheckArmyCamp(True, True, True)
			While $iReHere < 7
				$iReHere += 1
				If $iReHere = 1 And SkipDonateNearFullTroops(True, $aHeroResult) = False And BalanceDonRec(True) Then
					DonateCC(True)
				ElseIf SkipDonateNearFullTroops(False, $aHeroResult) = False And BalanceDonRec(False) Then
					DonateCC(True)
				EndIf
				If _Sleep($iDelayIdle2) Then ExitLoop
				If $g_bRestart = True Then ExitLoop
				If checkAndroidReboot() Then ContinueLoop 2
			WEnd
		EndIF
		If _Sleep($iDelayIdle1) Then ExitLoop
		checkObstacles() ; trap common error messages also check for reconnecting animation
		checkMainScreen(False) ; required here due to many possible exits
		If ($g_iCommandStop = 3 Or $g_iCommandStop = 0) And $bTrainEnabled = True Then
			CheckArmyCamp(True, True)
			If _Sleep($iDelayIdle1) Then Return
			If ($fullArmy = False Or $bFullArmySpells = False) And $bTrainEnabled = True Then
				SetLog("Army Camp and Barracks are not full, Training Continues...", $COLOR_ACTION)
				$g_iCommandStop = 0
			EndIf
		EndIf
		ReplayShare($iShareAttackNow)
		If _Sleep($iDelayIdle1) Then Return
		If $g_bRestart = True Then ExitLoop
		If $iCollectCounter > $g_iCollectAtCount Then ; This is prevent from collecting all the time which isn't needed anyway
			Local $aRndFuncList = ['Collect', 'CheckTombs', 'DonateCC', 'CleanYard']
			While 1
				If $g_bRunState = False Then Return
				If $g_bRestart = True Then ExitLoop
				If checkAndroidReboot() Then ContinueLoop 2
				If UBound($aRndFuncList) > 1 Then
					Local $Index = Random(0, UBound($aRndFuncList), 1)
					If $Index > UBound($aRndFuncList) - 1 Then $Index = UBound($aRndFuncList) - 1
					_RunFunction($aRndFuncList[$Index])
					_ArrayDelete($aRndFuncList, $Index)
				Else
					_RunFunction($aRndFuncList[0])
					ExitLoop
				EndIf
			WEnd
			If $g_bRunState = False Then Return
			If $g_bRestart = True Then ExitLoop
			If _Sleep($iDelayIdle1) Or $g_bRunState = False Then ExitLoop
			$iCollectCounter = 0
		EndIf
		$iCollectCounter = $iCollectCounter + 1
		AddIdleTime()
		checkMainScreen(False) ; required here due to many possible exits
		If $g_iCommandStop = -1 Then
			If $actual_train_skip < $max_train_skip Then
				If CheckNeedOpenTrain($g_iTimeBeforeTrain) Then TrainRevamp()
				MainSuperXPHandler()
				If $g_bRestart = True Then ExitLoop
				If _Sleep($iDelayIdle1) Then ExitLoop
				checkMainScreen(False)
			Else
				Setlog("Humanize bot, prevent to delete and recreate troops " & $actual_train_skip + 1 & "/" & $max_train_skip, $color_blue)
				$actual_train_skip = $actual_train_skip + 1
				If $actual_train_skip >= $max_train_skip Then
					$actual_train_skip = 0
				EndIf
				CheckArmyCamp(True, True)
			EndIf
		EndIf
		If _Sleep($iDelayIdle1) Then Return
		If $g_iCommandStop = 0 And $bTrainEnabled = True Then
			If Not ($fullArmy) Then
				If $actual_train_skip < $max_train_skip Then
					If CheckNeedOpenTrain($g_iTimeBeforeTrain) Then TrainRevamp()
					If $g_bRestart = True Then ExitLoop
					If _Sleep($iDelayIdle1) Then ExitLoop
					checkMainScreen(False)
				Else
					$actual_train_skip = $actual_train_skip + 1
					If $actual_train_skip >= $max_train_skip Then
						$actual_train_skip = 0
					EndIf
					CheckArmyCamp(True, True)
				EndIf
				MainSuperXPHandler()
			EndIf
			If $fullArmy Then
				SetLog("Army Camp and Barracks are full, stop Training...", $COLOR_ACTION)
				$g_iCommandStop = 3
			EndIf
		EndIf
		If _Sleep($iDelayIdle1) Then Return
		If $g_iCommandStop = -1 Then
			DropTrophy()
			If $g_bRestart = True Then ExitLoop
			;If $fullArmy Then ExitLoop		; Never will reach to SmartWait4Train() to close coc while Heroes/Spells not ready 'if' Army is full, so better to be commented
			If _Sleep($iDelayIdle1) Then ExitLoop
			checkMainScreen(False)
		EndIf
		If _Sleep($iDelayIdle1) Then Return
		If $g_bRestart = True Then ExitLoop
		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		$g_iTimeBeforeTrain += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds

		If $canRequestCC = True Then RequestCC()

		SetLog("Time Idle: " & StringFormat("%02i", Floor(Floor($TimeIdle / 60) / 60)) & ":" & StringFormat("%02i", Floor(Mod(Floor($TimeIdle / 60), 60))) & ":" & StringFormat("%02i", Floor(Mod($TimeIdle, 60))))

		SwitchAccount()

		If $OutOfGold = 1 Or $OutOfElixir = 1 Then Return ; Halt mode due low resources, only 1 idle loop
		If ($g_iCommandStop = 3 Or $g_iCommandStop = 0) And $bTrainEnabled = False Then ExitLoop ; If training is not enabled, run only 1 idle loop

		If $iChkSnipeWhileTrain = 1 Then SnipeWhileTrain() ;snipe while train

		If $g_iCommandStop = -1 Then ; Check if closing bot/emulator while training and not in halt mode
			SmartWait4Train()
			If $g_bRestart = True Then ExitLoop ; if smart wait activated, exit to runbot in case user adjusted GUI or left emulator/bot in bad state
		EndIf

	WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
	If $ichkEnableSuperXP = 1 And $irbSXTraining = 2 Then
		MainSuperXPHandler()
		Return
	EndIf

	;LoadAmountOfResourcesImages() ; for debug
	getArmyCapacity(True, True)
	If IsSearchAttackEnabled() Then
		If (IsSearchModeActive($DB) And checkCollectors(True, False)) Or IsSearchModeActive($LB) Or IsSearchModeActive($TS) Then
			If $iChkUseCCBalanced = 1 Then ;launch profilereport() only if option balance D/R it's activated
				ProfileReport()
				If _Sleep($iDelayAttackMain1) Then Return
				checkMainScreen(False)
				If $g_bRestart = True Then Return
			EndIf
			If $iChkTrophyRange = 1 And Number($iTrophyCurrent) > Number($iTxtMaxTrophy) Then ;If current trophy above max trophy, try drop first
				DropTrophy()
				$Is_ClientSyncError = False ; reset OOS flag to prevent looping.
				If _Sleep($iDelayAttackMain1) Then Return
				Return ; return to runbot, refill armycamps
			EndIf
			If $g_iDebugSetlog = 1 Then
				SetLog(_PadStringCenter(" Hero status check" & BitAND($g_aiAttackUseHeroes[$DB], $g_aiSearchHeroWaitEnable[$DB], $iHeroAvailable) & "|" & $g_aiSearchHeroWaitEnable[$DB] & "|" & $iHeroAvailable, 54, "="), $COLOR_DEBUG)
				SetLog(_PadStringCenter(" Hero status check" & BitAND($g_aiAttackUseHeroes[$LB], $g_aiSearchHeroWaitEnable[$LB], $iHeroAvailable) & "|" & $g_aiSearchHeroWaitEnable[$LB] & "|" & $iHeroAvailable, 54, "="), $COLOR_DEBUG)
				;Setlog("BullyMode: " & $g_abAttackTypeEnable[$TB] & ", Bully Hero: " & BitAND($g_aiAttackUseHeroes[$g_iAtkTBMode], $g_aiSearchHeroWaitEnable[$g_iAtkTBMode], $iHeroAvailable) & "|" & $g_aiSearchHeroWaitEnable[$g_iAtkTBMode] & "|" & $iHeroAvailable, $COLOR_DEBUG)
			EndIf
			PrepareSearch()
			If $OutOfGold = 1 Then Return ; Check flag for enough gold to search
			If $g_bRestart = True Then Return
			VillageSearch()
			If $OutOfGold = 1 Then Return ; Check flag for enough gold to search
			If $g_bRestart = True Then Return
			PrepareAttack($g_iMatchMode)
			If $g_bRestart = True Then Return
			Attack()
			If $g_bRestart = True Then Return
			ReturnHome($TakeLootSnapShot)
			If _Sleep($iDelayAttackMain2) Then Return
			Return True
		Else
			Setlog("No one of search condition match:", $COLOR_WARNING)
			Setlog("Waiting on troops, heroes and/or spells according to search settings", $COLOR_WARNING)
			$Is_SearchLimit = False
			$Is_ClientSyncError = False
			$g_bQuickAttack = False
		EndIf
	Else
		SetLog("Attacking Not Planned, Skipped..", $COLOR_WARNING)
	EndIf
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
	SetLog(" ====== Start Attack ====== ", $COLOR_SUCCESS)
	If ($g_iMatchMode = $DB And $g_aiAttackAlgorithm[$DB] = 1) Or ($g_iMatchMode = $LB And $g_aiAttackAlgorithm[$LB] = 1) Then
		If $g_iDebugSetlog = 1 Then Setlog("start scripted attack", $COLOR_ERROR)
		Algorithm_AttackCSV()
	ElseIf $g_iMatchMode = $DB And $g_aiAttackAlgorithm[$DB] = 2 Then
		If $g_iDebugSetlog = 1 Then Setlog("start milking attack", $COLOR_ERROR)
		Alogrithm_MilkingAttack()
	Else
		If $g_iDebugSetlog = 1 Then Setlog("start standard attack", $COLOR_ERROR)
		algorithm_AllTroops()
	EndIf
EndFunc   ;==>Attack


Func QuickAttack()

	Local $quicklymilking = 0
	Local $quicklythsnipe = 0

	getArmyCapacity(True, True)

	If ($g_aiAttackAlgorithm[$DB] = 2 And IsSearchModeActive($DB)) Or (IsSearchModeActive($TS)) Then
		VillageReport()
	EndIf

	$iTrophyCurrent = getTrophyMainScreen($aTrophies[0], $aTrophies[1])
	If ($iChkTrophyRange = 1 And Number($iTrophyCurrent) > Number($iTxtMaxTrophy)) Then
		If $g_iDebugSetlog = 1 Then Setlog("No quickly re-attack, need to drop tropies", $COLOR_DEBUG)
		Return False ;need to drop tropies
	EndIf

	If $g_aiAttackAlgorithm[$DB] = 2 And IsSearchModeActive($DB) Then
		If Int($CurCamp) >= $TotalCamp * $g_aiSearchCampsPct[$DB] / 100 And $g_abSearchCampsEnable[$DB] Then
			If $g_iDebugSetlog = 1 Then Setlog("Milking: Quickly re-attack " & Int($CurCamp) & " >= " & $TotalCamp & " * " & $g_aiSearchCampsPct[$DB] & "/100 " & "= " & $TotalCamp * $g_aiSearchCampsPct[$DB] / 100, $COLOR_DEBUG)
			Return True ;milking attack OK!
		Else
			If $g_iDebugSetlog = 1 Then Setlog("Milking: No Quickly re-attack:  cur. " & Int($CurCamp) & "  need " & $TotalCamp * $g_aiSearchCampsPct[$DB] / 100 & " firststart = " & ($g_bQuicklyFirstStart), $COLOR_DEBUG)
			Return False ;milking attack no restart.. no enough army
		EndIf
	EndIf

	If IsSearchModeActive($TS) Then
		If Int($CurCamp) >= $TotalCamp * $g_aiSearchCampsPct[$TS] / 100 And $g_abSearchCampsEnable[$TS] Then
			If $g_iDebugSetlog = 1 Then Setlog("THSnipe: Quickly re-attack " & Int($CurCamp) & " >= " & $TotalCamp & " * " & $g_aiSearchCampsPct[$TS] & "/100 " & "= " & $TotalCamp * $g_aiSearchCampsPct[$TS] / 100, $COLOR_DEBUG)
			Return True ;ts snipe attack OK!
		Else
			If $g_iDebugSetlog = 1 Then Setlog("THSnipe: No Quickly re-attack:  cur. " & Int($CurCamp) & "  need " & $TotalCamp * $g_aiSearchCampsPct[$TS] / 100 & " firststart = " & ($g_bQuicklyFirstStart), $COLOR_DEBUG)
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
		Case "CollectTreasury"
			CollectTreasury()
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
			If $bActiveDonate And $g_bChkDonate Then
				;If $g_bDonateSkipNearFullEnable = True and $g_bFirstStart = False Then getArmyCapacity(True, True)
				If SkipDonateNearFullTroops(True) = False And BalanceDonRec(True) Then DonateCC()
				If _Sleep($iDelayRunBot1) = False Then checkMainScreen(False)
			EndIF
		Case "DonateCC,Train"
			If $bActiveDonate And $g_bChkDonate Then
				If $g_bFirstStart Then
					getArmyCapacity(True, False)
					getArmySpellCapacity(False, True)
				EndIf
				If SkipDonateNearFullTroops(True) = False And BalanceDonRec(True) Then DonateCC()
			EndIF
			If _Sleep($iDelayRunBot1) = False Then checkMainScreen(False)
			If $bTrainEnabled = True Then ;
				If $actual_train_skip < $max_train_skip Then
					;Train()
					TrainRevamp()
					_Sleep($iDelayRunBot1)
				Else
					Setlog("Humanize bot, prevent to delete and recreate troops " & $actual_train_skip + 1 & "/" & $max_train_skip, $color_blue)
					$actual_train_skip = $actual_train_skip + 1
					If $actual_train_skip >= $max_train_skip Then
						$actual_train_skip = 0
					EndIf
					CheckOverviewFullArmy(True, False) ; use true parameter to open train overview window
					If ISArmyWindow(False, $ArmyTAB) then CheckExistentArmy("Spells") ; Imgloc Method
					getArmyHeroCount(False, TRue)
				EndIf
			Else
				If $g_iDebugSetlogTrain = 1 Then Setlog("Halt mode - training disabled", $COLOR_DEBUG)
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
