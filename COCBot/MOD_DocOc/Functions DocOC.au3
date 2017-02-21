; #FUNCTION# ====================================================================================================================
; Name ..........: DocOC Functions
; Description ...: This file Includes several files in the current script.
; Syntax ........: #include
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================


#include "functions\Other\CheckVersion.au3"
#include "functions\Other\ArrayFunctions.au3"

#include "functions\Search\multiSearch.au3"

#include "functions\Village\TreasuryCollect.au3"
#include "functions\Village\SuperXP.au3"

#include "functions\Attack\Attack Algorithms\algorithm_AllTroops.au3"
#include "functions\Attack\RedArea\DropTroop.au3"
#include "functions\Attack\Troops\DropOnEdge.au3"
#include "functions\Attack\Troops\DropOnEdges.au3"
#include "functions\Attack\Troops\LauchTroop.au3"
#include "functions\Attack\AttackCSV\ParseAttackCSV.au3"

#include "functions\BotHumanization\BotHumanization.au3"
#include "functions\BotHumanization\AttackNDefenseActions.au3"
#include "functions\BotHumanization\BestClansNPlayersActions.au3"
#include "functions\BotHumanization\ChatActions.au3"
#include "functions\BotHumanization\ClanActions.au3"
#include "functions\BotHumanization\ClanWarActions.au3"

#include "functions\Config\saveConfig.au3"
#include "functions\Config\readConfig.au3"
#include "functions\Config\applyConfig.au3"