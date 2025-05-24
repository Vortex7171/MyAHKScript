; --- Auto-Updating AHK Script ---
CurrentVersion := "1.9.5"  ; Your script's current version

; GitHub raw URLs (Replace with your actual GitHub repo details)
VersionCheckURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/version.txt"
DownloadURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/myscript.ahk"

; Check for an update
UrlDownloadToFile, %VersionCheckURL%, version.txt
FileRead, LatestVersion, version.txt
FileDelete, version.txt  ; Clean up temp file

StringTrimRight, LatestVersion, LatestVersion, 1  ; Remove newline if present

If (LatestVersion != "" && LatestVersion != CurrentVersion) {
    MsgBox, An update (v%LatestVersion%) is available! Downloading now...
    
    ; Download the updated script
    UrlDownloadToFile, %DownloadURL%, update.ahk
    
    ; Ensure update is downloaded
    if !FileExist("update.ahk") {
        MsgBox, Update download failed! Exiting...
        ExitApp
    }
    
    ; Replace the current script with the new one
    FileMove, update.ahk, %A_ScriptFullPath%, 1
    if !FileExist(A_ScriptFullPath) {  
        MsgBox, Update failed! Running old version.
        ExitApp
    }

    MsgBox, Update complete! Restarting script...
    Run, %A_ScriptFullPath%  ; Restart script
    ExitApp
}

; --- GUI Creation ---
Gui, Add, Edit, vCountryName w200, Enter Country  ; Input box for country name
Gui, Add, Text,, Select Speed:
Gui, Add, DropDownList, vSpeedChoice, 1 (Slow)|2 (Medium)|3 (Fast)|4 (Insanely Fast)  ; Speed selection
Gui, Add, Checkbox, vAutoMode, Enable Auto Mode
Gui, Add, Button, gConfirm, OK  ; Calls Confirm when clicked
Gui, Show, w250, Enter Country & Speed
Return

Confirm:
Gui, Submit, NoHide
Gui, Destroy

; Set speed based on user selection
SpeedChoice := (SpeedChoice = "1 (Slow)") ? 200 : (SpeedChoice = "2 (Medium)") ? 100 : (SpeedChoice = "3 (Fast)") ? 50 : 0

ProcessCompleted := False  ; Ensure the process is not marked as complete yet

If (AutoMode) {
    MsgBox, Press OK when you see the intermission box.
    Gosub, StartMacro
} Else {
    MsgBox, Press P to start the macro.
}

Return

StartMacro:
If (ProcessCompleted) {
    MsgBox, The macro has already completed.
    Return
}

ProcessCompleted := True  ; Prevents re-triggering

; Start monitoring
Loop {
    IfWinExist, Roblox
        WinActivate  ; Activate only if not already active
    PixelGetColor, color, 1036, 547, RGB
    
    if (color = "0x272F38") {
        Sleep, 50  ; Faster checking
        Continue
    }
    
    Break
}

; Start the country selection process
Clipboard := CountryName  ; Copy country name to clipboard
Sleep, SpeedChoice  

; Click on the Search Bar
MouseClick, left, 293, 582
Sleep, SpeedChoice

; Paste the country name
Send, ^v
Sleep, SpeedChoice * 2

; Click first country in list
MouseClick, left, 212, 607
Sleep, SpeedChoice * 2

; Click updated Play button
MouseClick, left, 705, 940

ExitApp

p::
If (!ProcessCompleted) {
    Gosub, StartMacro
}
Return

Esc::ExitApp  ; Press Escape to exit the script
