; #FUNCTION# ====================================================================================================================
; Name ..........: Functions_TeamVN
; Description ...: This file Includes several files in the current script.
; Syntax ........: #include
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================



; Config 
#include "functions\Config\saveConfig.au3"
#include "functions\Config\readConfig.au3"
#include "functions\Config\applyConfig.au3"

; CSV Command DropS, SideP, Zap, Remain (Mr.Viper) 
#include "functions\Attack\AttackCSV\DropSpellFromINIOnDefense.au3"
#include "functions\Attack\AttackCSV\DropTroopFromINI.au3"
#include "functions\Attack\AttackCSV\ParseAttackCSV.au3"
#include "functions\Attack\AttackCSV\ParseAttackCSV_Read_SIDE_variables.au3"
#include "functions\Attack\AttackCSV\SideP.au3"
#include "functions\Attack\AttackCSV\UpdateTroopQuantity.au3"
#include "functions\Attack\AttackCSV\ZapCmd.au3"

#include "functions\Attack\RedArea\_GetRedArea.au3"

#include "functions\Attack\Troops\GetXPosOfArmySlot.au3"
#include "functions\Attack\Troops\ReadTroopQuantity.au3"

#include "functions\Other\ArrayFunctions.au3"
#include "functions\Search\multiSearch.au3"

; Auto Hide 
#include "functions\Mod's\AutoHide.au3"

; Check Collector Outside 
#include "functions\Mod's\AreCollectorsOutside.au3"

; Switch Profile 
#include "functions\Mod's\ProfileSwitch.au3"

; Smart Upgarde 
#include "functions\Mod's\SmartUpgrade.au3"

; Upgrade Management 
#include "functions\Mod's\UpgradesMgmt.au3"

; SwitchAcc (Demen)
#include "functions\Mod's\SwitchAcc.au3"
#include "functions\Mod's\UpdateProfileStats.au3"

; SimpleTrain (Demen) 
#include "functions\Mod's\SimpleTrain.au3"

; CoCStats 
#include "functions\Mod's\CoCStats.com.au3"

; ClanHop (Rhinoceros) 
#include "functions\Mod's\ClanHop.au3"

;Super XP
#include "functions\Village\SuperXP.au3"

;Humanization
#include "functions\BotHumanization\BotHumanization.au3"
#include "functions\BotHumanization\AttackNDefenseActions.au3"
#include "functions\BotHumanization\BestClansNPlayersActions.au3"
#include "functions\BotHumanization\ChatActions.au3"
#include "functions\BotHumanization\ClanActions.au3"
#include "functions\BotHumanization\ClanWarActions.au3"