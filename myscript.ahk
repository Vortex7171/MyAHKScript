; --- Auto-Updating AHK Script ---
CurrentVersion := "1.1.0"  ; Your script's current version

; GitHub raw URLs (Replace with your actual GitHub repo details)
VersionCheckURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/version.txt"
DownloadURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/myscript.ahk"

; Check for an update
UrlDownloadToFile, %VersionCheckURL%, version.txt
FileRead, LatestVersion, version.txt
FileDelete, version.txt  ; Clean up temp file

StringTrimRight, LatestVersion, LatestVersion, 1  ; Remove newline if present

MsgBox, Checking for update...`nCurrent: %CurrentVersion%`nLatest: %LatestVersion%

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
} else {
    ; No update needed
    MsgBox, You have the latest version (%CurrentVersion%).
}

; --- GUI Creation ---
Gui, Add, Edit, vCountryName w200, Enter Country  ; Input box for country name
Gui, Add, Text,, Select Speed:
Gui, Add, DropDownList, vSpeedChoice, 1 (Slow)|2 (Medium)|3 (Fast)|4 (Insanely Fast)  ; Speed selection
Gui, Add, Button, gStartMacro, OK  ; Button to confirm input
Gui, Show, w250, Enter Country & Speed
Return

StartMacro:
Gui, Submit, NoHide  ; Save input and close GUI
Gui, Destroy

; Set speed based on user selection
If (SpeedChoice = 1)
    SpeedDelay := 200  ; Slow
Else If (SpeedChoice = 2)
    SpeedDelay := 100  ; Medium
Else If (SpeedChoice = 3)
    SpeedDelay := 50   ; Fast
Else
    SpeedDelay := 0    ; Insanely Fast (no delay)

MsgBox, Ready! When you're ready, press 'P' to select the country.
Return

p::  ; Press 'P' to start automation
    WinActivate, Roblox  ; Focus the game window
    Sleep, SpeedDelay  ; Adjust speed dynamically
    
    ; Move to and click search bar
    MouseMove, 285, 627
    Sleep, SpeedDelay
    Click
    Sleep, SpeedDelay
    
    ; Paste the country name instantly
    Clipboard := CountryName
    Sleep, SpeedDelay
    Send, ^v  ; Paste from clipboard

    Sleep, SpeedDelay * 2  ; Slightly longer delay
    
    ; Click first country in list
    Click, 208, 650
    Sleep, SpeedDelay * 2
    
    ; Click Play button
    Click, 959, 963

    ExitApp  ; Close script when finished
Return