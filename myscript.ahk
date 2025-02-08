; --- Auto-Updating AHK Script ---
CurrentVersion := "1.2.0"
VersionCheckURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/version.txt"
DownloadURL := "https://raw.githubusercontent.com/Vortex7171/MyAHKScript/main/myscript.ahk"

; --- GUI Creation ---
Gui, Add, Edit, vCountryName w200, Enter Country
Gui, Add, Text,, Select Speed:
Gui, Add, DropDownList, vSpeedChoice, 1 (Slow)|2 (Medium)|3 (Fast)|4 (Insanely Fast)
Gui, Add, Button, gStartMacro, OK
Gui, Show, w250, Enter Country & Speed
Return

StartMacro:
Gui, Submit, NoHide
Gui, Destroy

; Set speed based on user selection
If (SpeedChoice = "1 (Slow)")
    SpeedDelay := 200
Else If (SpeedChoice = "2 (Medium)")
    SpeedDelay := 100
Else If (SpeedChoice = "3 (Fast)")
    SpeedDelay := 50
Else
    SpeedDelay := 0

MsgBox, Press OK when you see the intermission box. The script will then start monitoring.

; Start monitoring for the intermission box
Loop {
    PixelGetColor, color, 1036, 547, RGB
    ; Skip tooltip and just perform the check faster
    if (color = "0x272F38") {
        ; Sleep a short time before checking again
        Sleep, 10
        continue
    }

    ; Intermission ended - Proceed with selection
    break
}

; Start the country selection process
Sleep, SpeedDelay

; Move to and click search bar (adjusted for speed)
MouseMove, 285, 627
Click
Sleep, SpeedDelay

; Paste the country name instantly
Clipboard := CountryName
Send, ^v
Sleep, SpeedDelay

; Click first country in list
Click, 208, 650
Sleep, SpeedDelay

; Click Play button
Click, 959, 963

ExitApp

Esc::ExitApp  ; Press Escape to exit the script
