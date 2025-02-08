CurrentVersion := "1.0.0"  ; Your script's current version

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
