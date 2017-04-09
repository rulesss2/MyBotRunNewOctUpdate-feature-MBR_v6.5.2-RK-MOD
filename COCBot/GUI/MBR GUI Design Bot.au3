; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Bot" tab
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
#include-once

Global $g_hGUI_BOT = 0

#include "MBR GUI Design Child Bot - Options.au3"
#include "MBR GUI Design Child Bot - Android.au3"
#include "MBR GUI Design Child Bot - Debug.au3"
;#include "MBR GUI Design Child Bot - Profiles.au3"
#include "MBR GUI Design Child Bot - Stats.au3"

Global $g_hGUI_BOT_TAB = 0, $g_hGUI_BOT_TAB_ITEM1 = 0, $g_hGUI_BOT_TAB_ITEM2 = 0, $g_hGUI_BOT_TAB_ITEM3 = 0, $g_hGUI_BOT_TAB_ITEM4 = 0, $g_hGUI_BOT_TAB_ITEM5 = 0

Func CreateBotTab()
	$g_hGUI_BOT = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hFrmBotEx)
	;GUISetBkColor($COLOR_WHITE, $g_hGUI_BOT)

	$g_hGUI_STATS = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_BOT)

	GUISwitch($g_hGUI_BOT)
	$g_hGUI_BOT_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
	$g_hGUI_BOT_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(600, 35, "Options"))
	CreateBotOptions()
	$g_hGUI_BOT_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(600, 53, "Android"))
	CreateBotAndroid()
	$g_hGUI_BOT_TAB_ITEM3 = GUICtrlCreateTabItem(GetTranslated(600, 51, "Debug"))
	CreateBotDebug()
;	$g_hGUI_BOT_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslated(600, 36, "Profiles"))
;	CreateBotProfiles()


;	$g_hGUI_BOT_TAB_ITEM5 = GUICtrlCreateTabItem(GetTranslated(600, 37, "Stats"))
;	; This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;	$g_hLastControlToHide = GUICtrlCreateDummy()
;	ReDim $g_aiControlPrevState[$g_hLastControlToHide + 1]
;	CreateBotStats()
;	GUICtrlCreateTabItem("")
EndFunc   ;==>CreateBotTab
