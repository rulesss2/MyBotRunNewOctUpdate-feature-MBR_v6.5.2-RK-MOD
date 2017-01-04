; #FUNCTION# ====================================================================================================================
; Name ..........: ParseAttackCSV_Read_SIDE_variables
; Description ...:
; Syntax ........: ParseAttackCSV_Read_SIDE_variables()
; Parameters ....:
; Return values .: None
; Author ........: Sardo (2016)
; Modified ......: MR.ViPER (3-1-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func ParseAttackCSV_Read_SIDE_variables($lineContent = "")

	$attackcsv_locate_mine = 0
	$attackcsv_locate_elixir = 0
	$attackcsv_locate_drill = 0
	$attackcsv_locate_gold_storage = 0
	$attackcsv_locate_elixir_storage = 0
	$attackcsv_locate_dark_storage = 0
	$attackcsv_locate_townhall = 0
	$attackcsv_locate_Eagle = 0
	;	$attackcsv_locate_Inferno = 0
	;	$attackcsv_locate_XBow = 0
	;	$attackcsv_locate_WizTower = 0
	;	$attackcsv_locate_Mortar = 0
	;	$attackcsv_locate_GemBox = 0

	If $iMatchMode = $DB Then
		Local $filename = $scmbDBScriptName
	Else
		Local $filename = $scmbABScriptName
	EndIf

	Local $f, $line, $acommand, $command
	Local $value1, $value2, $value3, $value4, $value5, $value6, $value7, $value8, $value9
	Local $bForceSideExist = False

	Select
		Case $lineContent = ""
			If FileExists($dirAttacksCSV & "\" & $filename & ".csv") Then
				$f = FileOpen($dirAttacksCSV & "\" & $filename & ".csv", 0)
				; Read in lines of text until the EOF is reached
				While 1
					$line = FileReadLine($f)
					If @error = -1 Then ExitLoop
					$acommand = StringSplit($line, "|")
					If $acommand[0] >= 8 Then
						$command = StringStripWS(StringUpper($acommand[1]), $STR_STRIPTRAILING)
						If $command <> "SIDE" And $command <> "SIDEB" Then ContinueLoop
						; Assign Values
						For $i = 2 To (UBound($acommand) - 1)
							If IsDeclared("value" & ($i - 1)) Then Assign("value" & ($i - 1), StringStripWS(StringUpper($acommand[$i]), $STR_STRIPTRAILING), 4)
						Next

						If $command = "SIDE" Then
							;forced side
							If StringUpper($value8) = "TOP-LEFT" Or StringUpper($value8) = "TOP-RIGHT" Or StringUpper($value8) = "BOTTOM-LEFT" Or StringUpper($value8) = "BOTTOM-RIGHT" Then
								;keep original values
								$bForceSideExist = True
							Else
								;if this line uses a building, then it must be detected
								If Int($value1) > 0 Then $attackcsv_locate_mine = 1
								If Int($value2) > 0 Then $attackcsv_locate_elixir = 1
								If Int($value3) > 0 Then $attackcsv_locate_drill = 1
								If Int($value4) > 0 Then $attackcsv_locate_gold_storage = 1
								If Int($value5) > 0 Then $attackcsv_locate_elixir_storage = 1
								If Int($value6) > 0 Then $attackcsv_locate_dark_storage = 1
								If Int($value7) > 0 Then $attackcsv_locate_townhall = 1
								; $value8 = Forced Side value
							EndIf
						EndIf

						If $command = "SIDEB" And $bForceSideExist = False Then
							If Int($value1) > 0 Then $attackcsv_locate_Eagle = 1
							;					If Int($value2) > 0 Then $attackcsv_locate_Inferno = 1
							;					If Int($value3) > 0 Then $attackcsv_locate_XBow = 1
							;					If Int($value4) > 0 Then $attackcsv_locate_WizTower = 1
							;					If Int($value5) > 0 Then $attackcsv_locate_Mortar = 1
							;					If Int($value6) > 0 Then $attackcsv_locate_GemBox = 1
							;					If Int($value7) > 0 Then $attackcsv_locate_GemBox = 1
							;					If Int($value8) > 0 Then $attackcsv_locate_GemBox = 1
						EndIf

					EndIf
				WEnd
				FileClose($f)
			Else
				SetLog("Cannot find attack file " & $dirAttacksCSV & "\" & $filename & ".csv", $COLOR_ERROR)
			EndIf
		Case Else
			$line = $lineContent
			$acommand = StringSplit($line, "|")
			If $acommand[0] >= 8 Then
				$command = StringStripWS(StringUpper($acommand[1]), $STR_STRIPTRAILING)
				; Assign Values
				For $i = 2 To (UBound($acommand) - 1)
					If IsDeclared("value" & ($i - 1)) Then Assign("value" & ($i - 1), StringStripWS(StringUpper($acommand[$i]), $STR_STRIPTRAILING), 4)
				Next

				If $command = "SIDE" Then
					;forced side
					If StringUpper($value8) = "TOP-LEFT" Or StringUpper($value8) = "TOP-RIGHT" Or StringUpper($value8) = "BOTTOM-LEFT" Or StringUpper($value8) = "BOTTOM-RIGHT" Then
						;keep original values
						$bForceSideExist = True
					Else
						;if this line uses a building, then it must be detected
						If Int($value1) > 0 Then $attackcsv_locate_mine = 1
						If Int($value2) > 0 Then $attackcsv_locate_elixir = 1
						If Int($value3) > 0 Then $attackcsv_locate_drill = 1
						If Int($value4) > 0 Then $attackcsv_locate_gold_storage = 1
						If Int($value5) > 0 Then $attackcsv_locate_elixir_storage = 1
						If Int($value6) > 0 Then $attackcsv_locate_dark_storage = 1
						If Int($value7) > 0 Then $attackcsv_locate_townhall = 1
						; $value8 = Forced Side value
					EndIf
				EndIf

				If $command = "SIDEB" And $bForceSideExist = False Then
					If Int($value1) > 0 Then $attackcsv_locate_Eagle = 1
					;					If Int($value2) > 0 Then $attackcsv_locate_Inferno = 1
					;					If Int($value3) > 0 Then $attackcsv_locate_XBow = 1
					;					If Int($value4) > 0 Then $attackcsv_locate_WizTower = 1
					;					If Int($value5) > 0 Then $attackcsv_locate_Mortar = 1
					;					If Int($value6) > 0 Then $attackcsv_locate_GemBox = 1
					;					If Int($value7) > 0 Then $attackcsv_locate_GemBox = 1
					;					If Int($value8) > 0 Then $attackcsv_locate_GemBox = 1
				EndIf
			EndIf
	EndSelect

EndFunc   ;==>ParseAttackCSV_Read_SIDE_variables
