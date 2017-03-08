; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: RK Team 2017
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
 #include-once

Global $g_hGUI_RK = 0

Global $g_hGUI_RK_TAB = 0,  $g_hGUI_RK_TAB_ITEM1 = 0 , $g_hGUI_RK_TAB_ITEM2 = 0 , $g_hGUI_RK_TAB_ITEM4 = 0


Func CreateRKTab()

	$g_hGUI_RK = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hFrmBotEx)

	GUISwitch($g_hGUI_RK)
	   $g_hGUI_RK_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
            $g_hGUI_RK_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(91,1, "Mod Option"))

			$g_hGUI_RK_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(106,1,"Chat"))
              ChatbotGUI()


   $g_hLastControlToHide = GUICtrlCreateDummy()
   ReDim $g_aiControlPrevState[$g_hLastControlToHide + 1]

			$g_hGUI_RK_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslated(107,1,"Forecast"))

   GUICtrlCreateTabItem("")

EndFunc

Func ChatbotGUI()
$36 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 23, 442, 410, $WS_CLIPCHILDREN)
$chatIni = $g_sProfilePath & "\" & $g_sProfileCurrentName &  "\chat.ini"
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
  ;$ChatbotChatDelayLabel = GUICtrlCreateLabel(GetTranslated(106,9,"Chat Delay"), $x - 10, $y)
  ; GUICtrlSetTip($ChatbotChatDelayLabel, GetTranslated(106,10,"Delay chat between number of bot cycles"))
   ;$chkchatdelay = GUICtrlCreateInput("0", $x + 50, $y - 1, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
  ; GUICtrlSetLimit(-1, 2)
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
   GUICtrlSetTip($chkChatPushbullet, GetTranslated(106,27,"Send and recieve chats via pushbullet or telegram.") & @CRLF & GetTranslated(106,53, "Use BOT <myvillage> GETCHATS <interval|NOW|STOP> to get the latest clan") & @CRLF & GetTranslated(106,54, "chat as an image, and BOT <myvillage> SENDCHAT <chat message> to send a chat to your clan") & @CRLF & GetTranslated(106, 55, ")"))
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
EndFunc