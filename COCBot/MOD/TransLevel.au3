#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Kychera
 Date:           18.01.2017
 Script Function: Transparent Gui. 0% = 255
 
#ce ----------------------------------------------------------------------------
Func Slider()        
     $iSldTransLevel = GUICtrlRead($SldTransLevel)      
	  Switch $iSldTransLevel                
                Case 0
                    WinSetTrans($frmBot, "", 255)
				Case 1
                    WinSetTrans($frmBot, "", 235)	
                Case 2
                    WinSetTrans($frmBot, "", 220)
                Case 3
                    WinSetTrans($frmBot, "", 205)
                Case 4
                    WinSetTrans($frmBot, "", 190)
			    Case 5
                    WinSetTrans($frmBot, "", 175)
				Case 6
                    WinSetTrans($frmBot, "", 160)
				Case 7
                    WinSetTrans($frmBot, "", 100)	
                Case 8
                    WinSetTrans($frmBot, "", 50)            
      EndSwitch    
EndFunc	

 