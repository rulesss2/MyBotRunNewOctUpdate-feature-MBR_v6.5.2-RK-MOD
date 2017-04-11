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

Global $g_hGUI_RK_TAB = 0,  $g_hGUI_RK_TAB_ITEM1 = 0 , $g_hGUI_RK_TAB_ITEM2 = 0 , $g_hGUI_RK_TAB_ITEM4 = 0, $g_hGUI_RK_TAB_ITEM5 = 0
Global $g_hRKTab = 0


Func CreateRKTab()

	$g_hGUI_RK = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hFrmBotEx)

	GUISwitch($g_hGUI_RK)
	   $g_hGUI_RK_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
            $g_hGUI_RK_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(91,1, "Mod Option"))
              ModOptionGUI()
			$g_hGUI_RK_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(106,1,"Chat"))
              ChatbotGUI()			
			  $g_hGUI_RK_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslated(107,1,"Forecast"))
			$g_hLastControlToHide = GUICtrlCreateDummy()
   ReDim $g_aiControlPrevState[$g_hLastControlToHide + 1]
              ForecastGUI()
   GUICtrlCreateTabItem("")
  
EndFunc

Func ModOptionGUI()

EndFunc

Func ChatbotGUI()

EndFunc

Func ForecastGUI()

EndFunc
