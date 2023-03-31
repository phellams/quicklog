using module G:\devspace\projects\powershell\psgeneral\libs\get-elapsed\get-elapsed.psm1
using module ..\..\powerunicode\powerunicode-class.psm1
using module ..\..\propture\get-propture.ps1

class QuickLog {
    [string]$name
    [string]$type
    [string]$unicode
    [bool]$submessage
    [DateTime]$date
    [string]$message
    [pscustomobject]$icons

    [string]$unicodeError = "#2B55"
    [string]$unicodeSuccess = "#2705"
    [string]$unicodeInfo = "#1FAA7"
    [string]$unicodeComplete = "#1F375"
    [string]$unicodeAction = "#1F527"
    [string]$unicodeSperator = "#2194"
    [string]$unicodeLeftArrow = "#25B6"
    [string]$unicodePlus = "#2795"
    [string]$unicodeArrorDiagDown = "#2198"
    [string]$unicodeDownCurvedArrow = "#21AA"

    QuickLog([string]$name, [string]$message, [string]$type, [string]$unicode, [bool]$submessage) {
        $this.icons = [PSCustomObject]@{
            Error           = "#2B55" # 🐟
            Success         = "#2705"
            Info            = "#1FAA7"
            Complete        = "#1F375"
            Action          = "#1F527"
            Separator       = "#2194"
            LeftArrow       = "#25B6"
            Plus            = "#2795"
            ArrowDiagDown   = "#2198"
            DownCurvedArrow = "#21AA"
        }
        
        $this.name = $name
        $this.message = $message
        $this.type = $type
        $this.unicode = $unicode
        $this.submessage = $submessage
        if ($this.unicode -eq $null -or $this.unicode.length -eq 0) {
            $this.unicode = "#1F438"
        }
        $this.date = Get-Date
    }

    [void]WriteLog() {
        $message_exploded = $null
        if ($this.message -like "*@{pt:{*") {
            $message_exploded = $this.message.split('@').split('}}')
        }

        Write-Host -ForegroundColor Yellow "[" -NoNewline
        Write-Host "$([powerunicode]::printByUnicode($this.unicode))" -NoNewline
        Write-Host -ForegroundColor Magenta "-$($this.name)" -NoNewline
        if ($this.submessage) {
            Write-Host -ForegroundColor Yellow "]" -NoNewline
        }
        else {
            Write-Host -ForegroundColor Yellow "]$([powerunicode]::printByUnicode($this.unicodeSperator))" -NoNewline
        }

        if ($this.submessage) {
            switch ($this.type) {
                "success" { Write-Host -ForegroundColor Green "      $([powerunicode]::printByUnicode($this.unicodeLeftArrow)) " -NoNewline }
                "error" { Write-Host -ForegroundColor Red "      $([powerunicode]::printByUnicode($this.unicodeLeftArrow)) " -NoNewline }
                "info" { Write-Host -ForegroundColor Blue "       $([powerunicode]::printByUnicode($this.unicodeLeftArrow)) " -NoNewline }
                "complete" { Write-Host -ForegroundColor DarkGreen "      $([powerunicode]::printByUnicode($this.unicodeLeftArrow)) " -NoNewline }
                "action" { Write-Host -ForegroundColor Yellow "    $([powerunicode]::printByUnicode($this.unicodeLeftArrow)) " -NoNewline }
            }
        }
        else {
            switch ($this.type) {
                "success" {
                    Write-Host -ForegroundColor Green "$([powerunicode]::printByUnicode($this.unicodeSuccess)) " -NoNewline 
                }
                "error" { Write-Host -ForegroundColor Red "$([powerunicode]::printByUnicode($this.unicodeError)) " -NoNewline }
                "info" { Write-Host -ForegroundColor Blue "$([powerunicode]::printByUnicode($this.unicodeInfo)) " -NoNewline }
                "complete" { Write-Host -ForegroundColor DarkGreen "$([powerunicode]::printByUnicode($this.unicodeComplete)) " -NoNewline }
                "action" { Write-Host -ForegroundColor Yellow "$([powerunicode]::printByUnicode($this.unicodeAction)) " -NoNewline }
            }
        }

        Write-Host -ForegroundColor Gray "$($this.message)"
        if ($message_exploded -ne $null) {
            foreach ($msg in $message_exploded) {
                Write-Host -ForegroundColor Gray "$msg"
            }
        }

        # write to log file
        $elapsed = [get_elapsed]::getElapsedTime()
        $propture = [get-propture]::getPropture()
        $log = "{0:dd.MM.yyyy HH:mm:ss} {1} [{2}] {3}{4}{5}{6}{7}{8} {9} - {10}" -f $this.date, $elapsed, $propture["computername"], $propture["username"], $propture["domain"], $propture["os"], $propture["os_version"], $propture["ps_version"], $this.name, $this.message
        Add-Content -Path "$PSScriptRoot\log.txt" -Value $log
    }
}

