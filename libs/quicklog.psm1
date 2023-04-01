using module .\get-elapsed.psm1
using module submodules\propture\get-propture.ps1 
using module submodules\powerunicode\powerunicode.psm1
<#  -------------------------------------------------------------------------------------------------------
/** ******************************************************************************************************* 
#!   NAME--------: quicklog
##   AUTHER------: mnoxx | codedus
#!   VERSION-----: 0.1.2
#?   DESCRIPTION-: Simple function to output to console log messages, wrapper for write-host
#?                 can be used for any script 
#?                 
*?   SUNMODULES--: Get-Elapsed, Get-Propture, PowerUnicode
*            
##   BUILD ENV---: BUILD: Powershellcore 7.3.1
*?   LICENCE-----: MIT
*********************************************************************************************************#>

class QuickLog {
    [string]$name
    [string]$type
    [string]$unicode
    [bool]$submessage
    [string]$datestring
    [datetime]$date
    [string]$message
    [pscustomobject]$icons
    [bool]$logdate
    [bool]$logfile

    QuickLog([string]$name) {
        $this.icons = [PSCustomObject]@{
            Error           = "#1F980"
            Success         = "#1F340"
            Info            = "#1FAD0"
            Complete        = "#2705"
            Action          = "#1F331"
            Separator       = "#21A4"
            LeftArrow       = "#2771"
            Plus            = "#2795"
            ArrowDiagDown   = "#2198"
            DownCurvedArrow = "#21AA"
            logtime         = "#231A"
            download        = "#23EC"
            upload          = "#1F347"
            request         = "#1F310" # 🌐
            response        = "#1F311" # 🌑
        }
        $this.name = $name
        $this.date = Get-Date
        $this.logdate = $false
        $this.unicode = "#1F43D"
    }

    [void] enablelogdate() {
        $this.logdate = $true
    }

    [void] enablelogfile([string]$path) {
        if(test-path -path $path){
            Start-Transcript -path "$path\documents\$($this.name).log" -Append
        }else{
            Start-Transcript -path "$env:HOMEDRIVE$env:HOMEPATH\documents\$($this.name).log" -Append
        }
    }

    [void]WriteLog([string]$message, [string]$type, [string]$unicode, [bool]$submessage) {
        $this.datestring = Get-Date -Format "hh:mm:ss"
        $this.message = $message
        $this.type = $type
        $this.unicode = $unicode
        $this.submessage = $submessage
        if ($null -eq $this.unicode -or $this.unicode.length -eq 0) { $this.unicode = "#1F43D" }
        if ($message -like "*@{pt:{*") { $message_exploded = $message.split('@').split('}}') } else { $message_exploded = $null }

        write-host "$([powerunicode]::printByUnicode($this.unicode))" -nonewline;
        write-host -ForegroundColor yellow "[" -nonewline;
        write-host -ForegroundColor gray "$($this.name)" -NoNewline;

        if ($this.submessage -eq $true) {
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))$(if($this.logdate -eq $true){$this.datestring})]" -NoNewline;
        }
        else {
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))$(if($this.logdate -eq $true){$this.datestring})]$([powerunicode]::printByUnicode($this.icons.Sperator))" -NoNewline;
        }
        if ($this.submessage -eq $true) {
            switch ($type) {
                success { Write-Host -ForegroundColor green "     " -nonewline; }
                error { Write-Host -ForegroundColor red "     " -nonewline; }
                info { Write-Host -ForegroundColor blue "     " -nonewline; }
                complete { Write-Host -ForegroundColor darkgreen "     " -nonewline; }
                action { Write-Host -ForegroundColor yellow "     " -nonewline; }
                find {}
                request{}
                response{}
            }
        }
        else {
            switch ($type) {
                success { Write-Host -ForegroundColor green     "$([powerunicode]::printByUnicode($this.icons.Success))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                error { Write-Host -ForegroundColor red       "$([powerunicode]::printByUnicode($this.icons.error))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                info { Write-Host -ForegroundColor blue      "$([powerunicode]::printByUnicode($this.icons.info))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                complete { Write-Host -ForegroundColor darkgreen "$([powerunicode]::printByUnicode($this.icons.complete))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                action { Write-Host -ForegroundColor yellow    "$([powerunicode]::printByUnicode($this.icons.action))$([powerunicode]::printByUnicode($this.icons.leftArrow)) " -nonewline; }    
            }
        }
        # Message Area ----------------
        if ($null -ne $message_exploded) {

            foreach ($emsp in $message_exploded) {
                if ($emsp -like "*{pt:{*") {
                    $emsp_pt_removed = $emsp -replace "{pt:{", ""
                    $props = Get-ProptureSD -stringdata $emsp_pt_removed
                    foreach ($propname in $props.keys) {
                        $value = $props[$propname]
                        if ( $type -eq "error") {
                            write-host -foregroundColor Magenta "$propname" -nonewline; write-host ":" -nonewline; write-host " " -nonewline; write-host -foregroundColor darkgray "$value" -nonewline; write-host "" -nonewline;
                        }
                        else {
                            write-host -foregroundColor Magenta "$propname" -nonewline; write-host ":" -nonewline; write-host " " -nonewline; write-host -foregroundColor darkgray "$value" -nonewline; write-host "" -nonewline;
                        }
                    }
                }
                else {
                    if ( $type -eq "error") {
                        write-host -foregroundColor red $emsp -NoNewline;
                    }
                    else {
                        write-host $emsp -NoNewline; 
                    }
                }
            }
        }
        elseif ($null -eq $message_exploded) {
            if ( $type -eq "error") {
                write-host -ForegroundColor red $message -nonewline;
            }
            else {
                write-host $message -nonewline;
            }
        }
        else {

        }
        # Message Area ----------------
        switch ($type) {
            success { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) s-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
            error { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) e-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
            info { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) i-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
            complete { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) c-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
            action { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) a-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
        }
    }
    [string]buildprogressbar([int]$percent){
        # 25 is the number of characters in the progress bar
        $barcount = 50
        $bar = ""
        $bar = $bar + "["
        $bar = $bar + ("-" * [math]::floor(($barcount * $percent) / 100))
        $bar = $bar + ">"
        $bar = $bar + (" " * [math]::floor($barcount - (($barcount * $percent) / 100)))
        $bar = $bar + "]"
        return $bar
    }

    [void]Writeprogress([PSCustomObject]$stats) {
        
        $barcount = 25
        
        write-host "$([powerunicode]::printByUnicode($this.unicode))" -nonewline;
        write-host -ForegroundColor yellow "[" -nonewline;
        write-host -ForegroundColor gray "$($this.name)" -NoNewline;

        if ($stats.submessage -eq $true) {
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))$(if($this.logdate -eq $true){$this.datestring})]" -NoNewline;
        }
        else {
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))$(if($this.logdate -eq $true){$this.datestring})]$([powerunicode]::printByUnicode($this.icons.Sperator))" -NoNewline;
        }

        if ($stats.submessage -eq $true) {
            Write-Host -ForegroundColor yellow "     " -nonewline;
        }
        else {
            Write-Host -ForegroundColor blue "$([powerunicode]::printByUnicode($this.icons.download))$([powerunicode]::printByUnicode($this.icons.leftArrow))" -NoNewline;
            write-host -foregroundcolor green "$($this.buildprogressbar($stats.percent))" -NoNewline;
            write-host -ForegroundColor gray "[ " -nonewline;
            write-host -ForegroundColor darkgreen "032mb/s 200MB/87.7GB" -nonewline;
            write-host -ForegroundColor gray " ]"
        }
    }
}
