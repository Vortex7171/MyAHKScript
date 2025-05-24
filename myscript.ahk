; --- Auto-Updating AHK Script ---
CurrentVersion := "2.0.0"

VersionCheckURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/version.txt"
DownloadURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/myscript.ahk"

; Check for updates
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
Gui, Add, Text, x10 y+10 cGray, Make sure the game is in fullscreen (F11)
Gui, Show, w260 h190, Enter Country & Speed
Return

Confirm:
Gui, Submit, NoHide
Gui, Destroy

; Set speed (adjusted so Fast is now faster and Insanely Fast is fastest)
SpeedChoice := (SpeedChoice = "1 (Slow)") ? 200 
            : (SpeedChoice = "2 (Medium)") ? 100 
            : (SpeedChoice = "3 (Fast)") ? 25 
            : 5

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

; Ensure fullscreen (F11) is pressed
IfWinExist, Roblox
{
    WinGet, Style, Style, Roblox
    ; Check if not fullscreen (0xC40000 = WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX)
    if (Style & 0xC40000)
    {
        WinActivate
        Sleep, 200
        Send, {F11}
        Sleep, 500
    }
}

; Start monitoring
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

; Click Search Bar
MouseClick, left, 293, 582
Sleep, SpeedChoice

; Paste Country
Send, ^v
Sleep, SpeedChoice * 2

; Click First Result
MouseClick, left, 212, 607
Sleep, SpeedChoice * 2

; Click Play Button (705, 940)
MouseClick, left, 705, 940

ExitApp

p::
If (!ProcessCompleted) {
    Gosub, StartMacro
}
Return

Esc::ExitApp
