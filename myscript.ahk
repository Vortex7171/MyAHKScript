; GUI Creation
Gui, Add, Edit, vCountryName w200  ; Input box for country name
Gui, Add, Button, gStartMacro, OK  ; Button to confirm input
Gui, Show, w250, Enter Country
Return

StartMacro:
Gui, Submit, NoHide  ; Save input and close GUI
Gui, Destroy
MsgBox, Ready! When you're ready, press 'P' to select the country.
Return

p::  ; Press 'P' to start automation
    WinActivate, Roblox  ; Focus the game window
    Sleep, 100  ; Reduced delay
    
    ; Move to and click search bar
    MouseMove, 285, 627
    Sleep, 50  ; Reduced delay
    Click
    Sleep, 50
    
    Send, ^a  ; Select all text
    Sleep, 50
    Send, {Backspace}  ; Clear text
    Sleep, 50
    
    ; Type the country name
    Send, %CountryName%
    Sleep, 150  ; Reduced delay
    
    ; Click first country in list
    Click, 208, 650
    Sleep, 200  ; Reduced delay
    
    ; Click Play button
    Click, 959, 963

    ExitApp  ; Close script when finished
Return
