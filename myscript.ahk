; --- Auto-Updating AHK Script ---
CurrentVersion := "1.4.0"
VersionCheckURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/version.txt"
DownloadURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/myscript.ahk"

; --- Check for Updates ---
UrlDownloadToFile, %VersionCheckURL%, version.txt
FileRead, LatestVersion, version.txt
LatestVersion := Trim(LatestVersion)

If (LatestVersion != CurrentVersion) {
    MsgBox, 48, Update Available, A new version (%LatestVersion%) is available!`nWould you like to update now?
    IfMsgBox, Yes
    {
        UrlDownloadToFile, %DownloadURL%, myscript.ahk
        MsgBox, Update complete! Please restart the script.
        ExitApp
    }
}

; --- GUI Creation ---
Gui, Add, Edit, vCountryName w200, Enter Country
Gui, Add, Text,, Select Speed:
Gui, Add, DropDownList, vSpeedChoice, 1 (Slow)|2 (Medium)|3 (Fast)|4 (Insanely Fast)
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
Clipboard := CountryName ; Put country name in clipboard
Sleep, SpeedChoice  

; Move to and click search bar
MouseMove, 285, 627
Click
Sleep, SpeedChoice

; Paste the country name
Send, ^v
Sleep, SpeedChoice * 2

; Click first country in list and Play
Click, 208, 650
Click, 959, 963

ExitApp

p::
If (!ProcessCompleted) {
    Gosub, StartMacro
}
Return

Esc::ExitApp  ; Press Escape to exit the script
