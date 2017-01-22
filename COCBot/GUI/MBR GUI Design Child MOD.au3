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
$hGUI_MOD = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, BitOR($WS_CHILD, $WS_TABSTOP), -1, $frmBotEx)
;GUISetBkColor($COLOR_WHITE, $hGUI_BOT)

GUISwitch($hGUI_MOD)

$hGUI_MOD_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
$hGUI_MOD_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(91,1,"Mod Option"))
$35 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 23, 442, 410, $WS_CLIPCHILDREN)
Local $xStart = 0, $yStart = 0


 ; Android Settings
	Local $x = 25, $y = 43
	$grpHideAndroid = GUICtrlCreateGroup(GetTranslated(91,2,"Android Options"), $x - 20, $y - 20, 438, 50)
		$cmbAndroid = GUICtrlCreateCombo("", $x - 10, $y - 5, 130, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(91,3,"Use this to select the Android Emulator to use with this profile.")
			GUICtrlSetTip(-1, $txtTip)
			setupAndroidComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "cmbAndroid")
		$lblAndroidInstance = GUICtrlCreateLabel(GetTranslated(91,4,"Instance:"), $x + 130, $y - 2 , 60, 21, $SS_RIGHT)
		$txtAndroidInstance = GUICtrlCreateInput("", $x + 200, $y - 5, 210, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			$txtTip = GetTranslated(91,5,"Enter the Instance to use with this profile.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "txtAndroidInstance")
			GUICtrlSetState(-1, $GUI_DISABLE)
 ; Misc Battle Settings
	Local $x = 25, $y = 92
	$grpDontEndBattle = GUICtrlCreateGroup(GetTranslated(91,9, "Miscellaneous Battle Settings"), $x - 20, $y - 20, 440, 45)
		$chkFastADBClicks = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13) ;$x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(91,11, "Tick this to enable faster ADB deployment for MEmu and Droid4x in Multi-finger mode.") & @CRLF & @CRLF & _
		GetTranslated(91,12,      "     WARNING:  This is experimental, if you have issues with deployment, disable it.")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkFastADBClicks")
			GUICtrlCreateLabel(GetTranslated(91,10, "Enable Fast ADB Clicks") & ":", $x + 7, $y, -1, -1)
GUICtrlCreateTabItem("")

$hGUI_MOD_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(106,1,"Chat"))
   $36 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 23, 442, 410, $WS_CLIPCHILDREN)
$chatIni = $sProfilePath & "\" & $sCurrProfile & "\chat.ini"
   ChatbotReadSettings()

	Local $x = 22, $y = 47

   GUICtrlCreateGroup(GetTranslated(106, 2,"Global Chat"), $x - 20, $y - 20, 215, 360)
    $y -= 5
   $chkGlobalChat = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
	_GUICtrlSetTip($chkGlobalChat, GetTranslated(106, 4, "Use global chat to send messages"))
   GUICtrlSetState($chkGlobalChat, $ChatbotChatGlobal)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
	GUICtrlCreateLabel(GetTranslated(106, 3, "Advertise in global"), $x + 7, $y, -1, -1)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
   $y += 18
   $chkGlobalScramble = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
	_GUICtrlSetTip($chkGlobalScramble, GetTranslated(106, 6, "Scramble the message pieces defined in the textboxes below to be in a random order"))
   GUICtrlSetState($chkGlobalScramble, $ChatbotScrambleGlobal)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
	GUICtrlCreateLabel(GetTranslated(106, 5, "Scramble global chats"), $x + 7, $y, -1, -1)
   $y += 18
   $chkSwitchLang = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
	_GUICtrlSetTip($chkSwitchLang, GetTranslated(106, 8, "Switch languages after spamming for a new global chatroom"))
   GUICtrlSetState($chkSwitchLang, $ChatbotSwitchLang)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
	GUICtrlCreateLabel(GetTranslated(106, 7, "Switch languages"), $x + 7, $y, -1, -1)
	;======kychera===========
   $cmbLang = GUICtrlCreateCombo("", $x + 120, $y, 45, 45, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "FR|DE|ES|IT|NL|NO|PR|TR|RU", "RU")
   ;==========================
   $y += 22
  $ChatbotChatDelayLabel = GUICtrlCreateLabel(GetTranslated(106,9,"Chat Delay"), $x - 10, $y)
   GUICtrlSetTip($ChatbotChatDelayLabel, GetTranslated(106,10,"Delay chat between number of bot cycles"))
   $chkchatdelay = GUICtrlCreateInput("0", $x + 50, $y - 1, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
   GUICtrlSetLimit(-1, 2)
   $y += 20
   $editGlobalMessages1 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages1, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages1, GetTranslated(106,11,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   $editGlobalMessages2 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages2, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages2, GetTranslated(106,12,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   $editGlobalMessages3 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages3, @CRLF), $x - 15, $y, 202, 65)
   GUICtrlSetTip($editGlobalMessages3, GetTranslated(106,13,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   $editGlobalMessages4 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages4, @CRLF), $x - 15, $y, 202, 55)
   GUICtrlSetTip($editGlobalMessages4, GetTranslated(106,14,"Take one item randomly from this list (one per line) and add it to create a message to send to global"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 65
   GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 240, $y = 47

   GUICtrlCreateGroup(GetTranslated(106,15,"Clan Chat"), $x - 20, $y - 20, 218, 360)
   $y -= 5
   $chkClanChat = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
	_GUICtrlSetTip($chkClanChat, GetTranslated(106, 17, "Use clan chat to send messages"))
   GUICtrlSetState($chkClanChat, $ChatbotChatClan)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
	GUICtrlCreateLabel(GetTranslated(106, 16, "Chat in clan chat") & ":", $x + 7, $y, -1, -1)
	$chkRusLang = GUICtrlCreateCheckbox("", $x + 125, $y, 13, 13)
   GUICtrlSetState(-1, $GUI_UNCHECKED)
   _GUICtrlSetTip(-1, GetTranslated(106,51, "On. Russian send text. Note: The input language in the Android emulator must be RUSSIAN."))
   GUICtrlCreateLabel(GetTranslated(106, 52, "Russian"), $x + 142, $y, -1, -1)
   ;GUICtrlSetOnEvent(-1, "chkRusLang")
   $y += 22
   $chkUseResponses = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13);GUICtrlCreateCheckbox(GetTranslated(106,18,"Use custom responses"), $x - 10, $y)
   GUICtrlSetTip($chkUseResponses, GetTranslated(106,19,"Use the keywords and responses defined below"))
   GUICtrlSetState($chkUseResponses, $ChatbotClanUseResponses)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   GUICtrlCreateLabel(GetTranslated(106,18,"Use custom responses"), $x + 7, $y, -1, -1)
   $y += 22
   $chkUseGeneric = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
   GUICtrlSetTip($chkUseGeneric, GetTranslated(106,25,"Use generic chats if reading the latest chat failed or there are no new chats"))
   GUICtrlSetState($chkUseGeneric, $ChatbotClanAlwaysMsg)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   GUICtrlCreateLabel(GetTranslated(106,24,"Use generic chats"), $x + 7, $y, -1, -1)
   $y += 22
   $chkChatPushbullet = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
   GUICtrlSetTip($chkChatPushbullet, GetTranslated(106,27,"Send and recieve chats via pushbullet or telegram. Use BOT <myvillage> GETCHATS <interval|NOW|STOP> to get the latest clan chat as an image, and BOT <myvillage> SENDCHAT <chat message> to send a chat to your clan"))
   GUICtrlSetState($chkChatPushbullet, $ChatbotUsePushbullet)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   GUICtrlCreateLabel(GetTranslated(106,26,"Use remote for chatting"), $x + 7, $y, -1, -1)
   $y += 22
   $chkPbSendNewChats = GUICtrlCreateCheckbox("", $x - 10, $y, 13, 13)
   GUICtrlSetTip($chkPbSendNewChats, GetTranslated(106,29,"Will send an image of your clan chat via pushbullet & telegram when a new chat is detected. Not guaranteed to be 100% accurate."))
   GUICtrlSetState($chkPbSendNewChats, $ChatbotPbSendNew)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   GUICtrlCreateLabel(GetTranslated(106,28,"Notify me new clan chat"), $x + 7, $y, -1, -1)
   $y += 25

   $editResponses = GUICtrlCreateEdit(_ArrayToString($ClanResponses, ":", -1, -1, @CRLF), $x - 15, $y, 206, 80)
   GUICtrlSetTip($editResponses, GetTranslated(106,30,"Look for the specified keywords in clan messages and respond with the responses. One item per line, in the format keyword:response"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 92
   $editGeneric = GUICtrlCreateEdit(_ArrayToString($ClanMessages, @CRLF), $x - 15, $y, 206, 80)
   GUICtrlSetTip($editGeneric, GetTranslated(106,31,"Generic messages to send, one per line"))
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")

   ChatGuicheckboxUpdateAT()
   GUICtrlCreateTabItem("")
;~ -------------------------------------------------------------
;~ This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.                   A LAISSER IMPERATIVEMENT !!!!!!!!!!!!!!
;~ -------------------------------------------------------------
Global $LastControlToHideMOD = GUICtrlCreateDummy()
Global $iPrevState[$LastControlToHideMOD + 1]
;~ -------------------------------------------------------------
GUICtrlCreateTabItem("")

$hGUI_MOD_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslated(107,1,"Forecast"))
$37 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 23, 442, 410, $WS_CLIPCHILDREN)
Global $grpForecast
Global $ieForecast

Local $xStart = 0, $yStart = 0
Local $x = $xStart + 10, $y = $yStart + 25
	$ieForecast = GUICtrlCreateObj($oIE, $x , $y , 430, 310)

GUICtrlCreateGroup("", -99, -99, 1, 1)

$y += + 318
	$chkForecastBoost = GUICtrlCreateCheckbox(GetTranslated(107,11, "Boost When >"), $x, $y, -1, -1)
		$txtTip = GetTranslated(107,13, "Boost Barracks,Heroes, when the loot index.")
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "chkForecastBoost")
	$txtForecastBoost = GUICtrlCreateInput("6.0", $x + 87, $y + 2, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
		$txtTip = GetTranslated(107,7, "Minimum loot index for boosting.")
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetTip(-1, $txtTip)
		_GUICtrlEdit_SetReadOnly(-1, True)
		GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$y += - 27
	$chkForecastHopingSwitchMax = GUICtrlCreateCheckbox("", $x + 150, $y + 27, 13, 13)
			$txtTip = "" ; à renseigner
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkForecastHopingSwitchMax")
			GUICtrlCreateLabel(GetTranslated(107,16,"Switch to"), $x + 168, $y + 27, -1, -1)
	$cmbForecastHopingSwitchMax = GUICtrlCreateCombo("", $x + 218, $y + 25, 95, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "" ; à renseigner
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
	$lblForecastHopingSwitchMax = GUICtrlCreateLabel(GetTranslated(107,17,"When Index <"), $x + 316, $y + 28, -1, -1)
	$txtForecastHopingSwitchMax = GUICtrlCreateInput("2.5", $x + 400, $y + 26, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			$txtTip = "" ; à renseigner
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetData(-1, 2.5)
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
	$chkForecastHopingSwitchMin = GUICtrlCreateCheckbox("", $x + 150, $y + 55, 13, 13)
			$txtTip = "" ; à renseigner
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkForecastHopingSwitchMin")
			GUICtrlCreateLabel(GetTranslated(107,18,"Switch to"), $x + 168, $y + 55, -1, -1)
	$cmbForecastHopingSwitchMin = GUICtrlCreateCombo("", $x + 218, $y + 53, 95, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "" ; à renseigner
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
	$lblForecastHopingSwitchMin = GUICtrlCreateLabel(GetTranslated(107,19,"When Index >"), $x + 316, $y + 58, -1, -1)
	$txtForecastHopingSwitchMin = GUICtrlCreateInput("2.5", $x + 400, $y + 54, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			$txtTip = "" ; à renseigner
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetData(-1, 2.5)
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
GUICtrlCreateGroup("", -99, -99, 1, 1)
setupProfileComboBox()
GUICtrlCreateGroup("", -99, -99, 1, 1)
	$cmbSwLang = GUICtrlCreateCombo("", $x, $y + 50, 45, 45, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
             GUICtrlSetData(-1, "EN|RU|FR|DE|ES|IT|PT|IN", "RU")
			 GUICtrlSetOnEvent(-1, "cmbSwLang")
GUICtrlCreateTabItem("")

$hGUI_MOD_TAB_ITEM5 = GUICtrlCreateTabItem("Humanization")
#include "MBR GUI Design Child MOD - Humanization.au3"
GUICtrlCreateTabItem("")

$hGUI_MOD_TAB_ITEM6 = GUICtrlCreateTabItem("Switch Profiles")
$11 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 23, 442, 410, $WS_CLIPCHILDREN)
Local $x = 25, $y = 60
	$grpGoldSwitch = GUICtrlCreateGroup(GetTranslated(655,14, "Gold Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ;Gold Switch
		$chkGoldSwitchMax = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,16, "Enable this to switch profiles when gold is above amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbGoldMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblGoldMax = GUICtrlCreateLabel(GetTranslated(655,18, "When Gold is Above"), $x + 145, $y, -1, -1)
		$txtMaxGoldAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,19, "Set the amount of Gold to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)

	$y += 30
		$chkGoldSwitchMin = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,20, "Enable this to switch profiles when gold is below amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbGoldMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblGoldMin = GUICtrlCreateLabel(GetTranslated(655,21, "When Gold is Below"), $x + 145, $y, -1, -1)
		$txtMinGoldAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,19, "Set the amount of Gold to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
		$picProfileGold = _GUICtrlCreatePic(@ScriptDir & "\Images\GoldStorage.png", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	$grpElixirSwitch = GUICtrlCreateGroup(GetTranslated(655,22, "Elixir Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ; Elixir Switch
		$chkElixirSwitchMax = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,23, "Enable this to switch profiles when Elixir is above amount.")
			_GUICtrlSetTip(-1, $txtTip)

		$cmbElixirMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblElixirMax = GUICtrlCreateLabel(GetTranslated(655,24, "When Elixir is Above"), $x + 145, $y, -1, -1)
		$txtMaxElixirAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,25, "Set the amount of Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
	$y += 30
		$chkElixirSwitchMin = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,26, "Enable this to switch profiles when Elixir is below amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbElixirMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblElixirMin = GUICtrlCreateLabel(GetTranslated(655,27, "When Elixir is Below"), $x + 145, $y, -1, -1)
		$txtMinElixirAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,25, "Set the amount of Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
		$picProfileElixir = _GUICtrlCreatePic(@ScriptDir & "\Images\ElixirStorage.png", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	$grpDESwitch = GUICtrlCreateGroup(GetTranslated(655,28, "Dark Elixir Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ;DE Switch
		$chkDESwitchMax = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,29, "Enable this to switch profiles when Dark Elixir is above amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbDEMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblDEMax = GUICtrlCreateLabel(GetTranslated(655,30, "When Dark Elixir is Above"), $x + 145, $y, -1, -1)
		$txtMaxDEAmount = GUICtrlCreateInput("200000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,31, "Set the amount of Dark Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
	$y += 30
		$chkDESwitchMin = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,32, "Enable this to switch profiles when Dark Elixir is below amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbDEMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblDEMin = GUICtrlCreateLabel(GetTranslated(655,33, "When Dark Elixir is Below"), $x + 145, $y, -1, -1)
		$txtMinDEAmount = GUICtrlCreateInput("10000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,31, "Set the amount of Dark Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picProfileDE = _GUICtrlCreatePic(@ScriptDir & "\Images\DEStorage.png", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	$grpTrophySwitch = GUICtrlCreateGroup(GetTranslated(655,34, "Trophy Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ; Trophy Switch
		$chkTrophySwitchMax = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,35, "Enable this to switch profiles when Trophies are above amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbTrophyMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblTrophyMax = GUICtrlCreateLabel(GetTranslated(655,36, "When Trophies are Above"), $x + 145, $y, -1, -1)
		$txtMaxTrophyAmount = GUICtrlCreateInput("3000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,37, "Set the amount of Trophies to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
	$y += 30
		$chkTrophySwitchMin = _GUICtrlCreateCheckbox(GetTranslated(655,15, "Switch To"), $x - 10, $y - 5, -1, -1)
			$txtTip = GetTranslated(655,38, "Enable this to switch profiles when Trophies are below amount.")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbTrophyMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(655,17, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $txtTip)
		$lblTrophyMin = GUICtrlCreateLabel(GetTranslated(655,39, "When Trophies are Below"), $x + 145, $y, -1, -1)
		$txtMinTrophyAmount = GUICtrlCreateInput("1000", $x + 275, $y - 5, 60, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(655,37, "Set the amount of Trophies to trigger switching Profile.")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
		$picProfileTrophy = _GUICtrlCreatePic(@ScriptDir & "\Images\TrophyLeague.png", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
		setupProfileComboBoxswitch()
GUICtrlCreateTabItem("")
