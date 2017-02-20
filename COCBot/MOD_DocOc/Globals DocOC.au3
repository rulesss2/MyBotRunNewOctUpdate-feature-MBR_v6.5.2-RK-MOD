; #FUNCTION# ====================================================================================================================
; Name ..........: MBR Global Variables for DOCOC team
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: Everyone all the time  :)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; ================================================== BOT DocOc Version PART ================================================= ;

Global $g_sLastModversion = "" ;latest version from GIT
Global $g_sLastModmessage = "" ;message for last version
Global $g_sOldModversmessage = "" ;warning message for old bot

; ================================================== TREASURY COLLECT PART ================================================== ;

Global $g_ichkGoldTrCollect, $g_ichkElxTrCollect, $g_ichkDarkTrCollect
Global $g_ichkFullGoldTrCollect, $g_ichkFullElxTrCollect, $g_ichkFullDarkTrCollect
Global $g_itxtMinGoldTrCollect, $g_itxtMinElxTrCollect, $g_itxtMinDarkTrCollect
Global $g_ichkEnableTrCollect, $g_ichkForceTrCollect

; ================================================== BOT HUMANIZATION PART ================================================== ;

Global $g_iMinimumPriority, $g_iMaxActionsNumber, $g_iActionToDo
Global $g_aSetActionPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Global $g_sFrequenceChain = GetTranslated(42, 100, "Never|Sometimes|Frequently|Often|Very Often")
Global $g_sReplayChain = "1|2|4"
Global $g_ichkUseBotHumanization, $g_ichkUseAltRClick, $g_icmbMaxActionsNumber, $g_ichkCollectAchievements, $g_ichkLookAtRedNotifications

Global $g_iacmbPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_iacmbMaxSpeed[2] = [0, 0]
Global $g_iacmbPause[2] = [0, 0]
Global $g_iahumanMessage[2] = ["", ""]

Global $g_acmbPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_acmbMaxSpeed[2] = [0, 0]
Global $g_acmbPause[2] = [0, 0]
Global $g_ahumanMessage[2] = ["", ""]

Global $g_aReplayDuration[2] = [0, 0] ; An array, [0] = Minute | [1] = Seconds
Global $g_bOnReplayWindow, $g_iReplayToPause

Global $g_iQuickMISX = 0, $g_iQuickMISY = 0
Global $g_iLastLayout = 0

; ================================================== BOT SuperXP PART ================================================== ;

Global $ichkEnableSuperXP = 0, $irbSXTraining = 1, $ichkSXBK = 0, $ichkSXAQ = 0, $ichkSXGW = 0, $iStartXP = 0, $iCurrentXP = 0, $iGainedXP = 0, $iGainedXPHour = 0, $itxtMaxXPtoGain = 500
Global $DebugSX = 0
;SuperXP / GoblinXP
Global Const $iDelayDropSuperXP1 = 500
Global Const $iDelayDropSuperXP2 = 1000
Global Const $iDelayDropSuperXP3 = 250
Global Const $iDelayPrepareSearchSuperXP = 500


Global $CurBaseRedLine[2] = ["", ""]
Global $DCD = "440,70|825,344|440,640|55,344"
Global $ECD = "440,22|860,344|440,670|2,344"