; --- Auto-Updating AHK Script ---
CurrentVersion := "1.9.2"  ; Your script's current version

; GitHub raw URLs
VersionCheckURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/version.txt"
DownloadURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/myscript.ahk"

; Check for an update
UrlDownloadToFile, %VersionCheckURL%, version.txt
FileRead, LatestVersion, version.txt
FileDelete, version.txt

StringTrimRight, LatestVersion, LatestVersion, 1

If (LatestVersion != "" && LatestVersion != CurrentVersion) {
    MsgBox, An update (v%LatestVersion%) is available! Downloading now...

    UrlDownloadToFile, %DownloadURL%, update.ahk

    if !FileExist("update.ahk") {
        MsgBox, Update download failed! Exiting...
        ExitApp
    }

    FileMove, update.ahk, %A_ScriptFullPath%, 1
    if !FileExist(A_ScriptFullPath) {
        MsgBox, Update failed! Running old version.
        ExitApp
    }

    MsgBox, Update complete! Restarting script...
    Run, %A_ScriptFullPath%
    ExitApp
}

; --- GUI Creation ---
Gui, Add, Edit, vCountryName w200, Enter Country
Gui, Add, Text,, Select Speed:
Gui, Add, DropDownList, vSpeedChoice, 1 (Slow)|2 (Medium)|3 (Fast)|4 (Insanely Fast)
Gui, Add, Checkbox, vAutoMode, Enable Auto Mode
Gui, Add, Button, gConfirm, OK
Gui, Show, w250, Enter Country & Speed
Return

Confirm:
Gui, Submit, NoHide
Gui, Destroy

SpeedChoice := (SpeedChoice = "1 (Slow)") ? 200 : (SpeedChoice = "2 (Medium)") ? 100 : (SpeedChoice = "3 (Fast)") ? 50 : 0
ProcessCompleted := False

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
ProcessCompleted := True

; --- Ensure window-relative mouse movement ---
CoordMode, Mouse, Window
CoordMode, Pixel, Screen

Loop {
    IfWinExist, Roblox
        WinActivate
    PixelGetColor, color, 1036, 547, RGB
    if (color = "0x272F38") {
        Sleep, 50
        Continue
    }
    Break
}

Clipboard := CountryName
Sleep, SpeedChoice

; Click updated Search Bar location
MouseClick, left, 293, 582
Sleep, SpeedChoice

; Paste country
Send, ^v
Sleep, SpeedChoice * 2

; Click updated First Result location
MouseClick, left, 212, 607
Sleep, SpeedChoice * 2

; Click original Play Button location (unchanged)
MouseClick, left, 959, 963

ExitApp

p::
If (!ProcessCompleted) {
    Gosub, StartMacro
}
Return

Esc::ExitApp  ; Press Escape to exit the script
