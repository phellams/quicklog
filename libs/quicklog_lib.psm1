using module sm\get-elapsed.psm1
using module sm\Get-PropTune.psm1
using module sm\Get-ColorTune.psm1
using module sm\powerunicode\powerunicode.psm1
<#  -------------------------------------------------------------------------------------------------------
/** ******************************************************************************************************* 
#!   NAME--------: quicklog class
##   AUTHER------: snoonx | nytscripts
#?   DESCRIPTION-: Powershell class used to generate log messages, wrapper for write-host and output to console           
*?   DEPENDANCIES: Get-Elapsed, Get-Propture, PowerUnicode    
##   BUILD ENV---: BUILD: Powershellcore 7.3.1
*?   LICENCE-----: MIT
** ******************************************************************************************************#>
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
    [string]$PTSeperator

    QuickLog([string]$name,[string]$unicode) {
        $this.icons = [PSCustomObject]@{
            Error           = "#1F4A2" #
            Error2          = "#2757" # 💣
            Success         = "#1F95D" #  
            Info            = "#1F300" # 📑
            Complete        = "#2705"  # ✅
            Action          = "#1F31F" # 🌱
            request         = "#1F310" # 🌐
            response        = "#1F311" # 🌑
            Petagram       = "#1F50A" # 🔯
            Seperator        = "#1F4A0" # 💠
            Separator2       = "#2666" # ♦
            Separator3       = "#2638" # ❄ 
            LeftArrow       = "#2771"  #  ❱
            Plus            = "#2795"  # ➕
            logtime         = "#23F0"  # ⏰
            download        = "#23EC"  # ⏬
            upload          = "#1F347" # 🍇
            ArrowDiagDown   = "#21AA"  # ↪
            ArrowDiagUp     = "#2197"  # ↗
            UpCurvedArrow   = "#2197"  # ↗
            ArrowUp         = "#2B06"  # ⬆
            ArrowDown       = "#2B07"  # ⬇
            ArrowLeft       = "#2B05"  # ⬅
            ArrowRight      = "#27A1"  # ➡
            DataStreamLeftRight  = "#2194"  # ↔
            DataStreamUpDown   = "#2195"  # ↕
            DataStreamRight = "#21C4" # ⇄
            DataStreamLeft = "#21C6" # ⇆
            DataStreamDUpDown = "#21C5" # ⇅
            ArrowDataStreamUp = "#21C8" # ⇈
            ArrowDataStreamLeft = "#21C7" # ⇇
            ArrowDataStreamRight = "#21C9" # ⇉
            TleftArrow = "#21A4" # ↤
            TRightArrow = "#21A6" # ↦
            ArrowDiagDownAlt = "#21B3" # ↳
            Tick            = "#2714"  # ✔
        }
        $this.name = $name
        $this.date = Get-Date
        $this.logdate = $false
        if ($null -eq $this.unicode) {
            $this.unicode = "#1F43D"
        }
        else{
            $this.unicode = $unicode
        }
        if ($null -eq $this.PTSeperator) {
            $this.PTSeperator = "$([powerunicode]::printByUnicode($this.icons.Separator3))"
        }
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

    [void]WriteLog([string]$message, [string]$type, [bool]$submessage) {
        $this.datestring = Get-Date -Format "hh:mm:ss"
        $this.message = $message
        $this.type = $type
        $this.submessage = $submessage
        
        # Set default unicode if not set
        if ($null -eq $this.unicode -or $this.unicode.length -eq 0) { $this.unicode = "#1F43D" }
        
        #? custom name of the log or apps name its used with
        #? Default: ql
        #write-host "$([powerunicode]::printByUnicode($this.unicode))" -nonewline;
        write-host -ForegroundColor yellow "[$([powerunicode]::printByUnicode($this.unicode))-" -nonewline;
        write-host -ForegroundColor gray "$($this.name)" -NoNewline;

        #? If message is a submessage
        if ($this.submessage -eq $true) {
            if ($this.logdate -eq $true) {
                write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))" -NoNewline;
                write-host -ForegroundColor gray "$($this.datestring)]" -NoNewline;
            }
        }
        else {
            if ($this.logdate -eq $true) {
                write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))" -NoNewline;
                write-host -ForegroundColor gray "$($this.datestring)]" -NoNewline;
                write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.Separator))" -NoNewline;
            }
        }
        if ($this.submessage -eq $true) {
            switch ($type) {
                success { 
                    Write-Host -ForegroundColor green "     $([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; 
                }
                error { 
                    Write-Host -ForegroundColor red "     $([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; 
                }
                info { 
                    Write-Host -ForegroundColor blue "     $([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; 
                }
                complete { 
                    Write-Host -ForegroundColor darkgreen "     $([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; 
                }
                action { 
                    Write-Host -ForegroundColor yellow "     $([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline;
                 }
                # find {}
                # request{}
               # response{}
            }
        }
        else {
            switch ($this.type) {
                success { 
                    Write-Host -ForegroundColor green "$([powerunicode]::printByUnicode($this.icons.Success))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; 
                }
                error { 
                    Write-Host -ForegroundColor red "$([powerunicode]::printByUnicode($this.icons.error))$([powerunicode]::printByUnicode($this.icons.LeftArrow))$([powerunicode]::printByUnicode($this.icons.error2))" -nonewline;
                }
                info { 
                    Write-Host -ForegroundColor blue "$([powerunicode]::printByUnicode($this.icons.info))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; 
                }
                complete { 
                    Write-Host -ForegroundColor darkgreen "$([powerunicode]::printByUnicode($this.icons.complete))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; 
                }
                action { 
                    Write-Host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.action))$([powerunicode]::printByUnicode($this.icons.leftArrow)) " -nonewline; 
                }    
            }
        }
        # Message Area -if Proptune Key is prsent ---------------
        # For Proptune
        $ColorElements = [regex]::Matches($this.message,"(\{ct:)(.*?)(\})")
        if($ColorElements) {
            for($i=0; $i -lt $ColorElements.count; $i++){
                $PropColorData = $ColorElements[$i].value -replace "{ct:", "" -replace "}", ""
                $color = $PropColorData.split(":")[0]
                $text = $PropColorData.split(":")[1]
                # inline color 
                $InlineTextColor = Get-ColorTune -text $text -color $color
                $this.message = $this.message.replace($ColorElements[$i].value, (Get-ColorTune -Text $text -color $color))
            }
         }
        if ($this.message -like "*@{pt:{*") { $proptune_exploded_log = $this.message.split('@').split('}}') } else { $proptune_exploded_log = $null }
        if ($null -ne $proptune_exploded_log) {

            foreach ($emsp in $proptune_exploded_log) {
                if ($emsp -like "*{pt:{*") {
                    $emsp_pt_removed = $emsp -replace "{pt:{", ""
                    $props = Get-PropTune -StringData $emsp_pt_removed
                    foreach ($propname in $props.keys) {
                        $value = $props[$propname]
                        if ( $this.type -eq "error") {
                            write-host "○─" -foregroundColor yellow -nonewline; write-host -foregroundColor Magenta "$propname`:" -nonewline; write-host -foregroundColor darkgray "$value" -nonewline; write-host "" -nonewline;
                        }
                        else {
                            write-host "○─" -foregroundColor yellow -nonewline; write-host -foregroundColor Magenta "$propname`:" -nonewline; write-host -foregroundColor darkgray "$value" -nonewline; write-host "" -nonewline;
                        }
                    }
                }
                else {
                    if ( $this.type -eq "error") {
                        write-host -foregroundColor red "$($emsp)" -NoNewline;
                    }
                    else {
                        write-host $emsp -NoNewline; 
                    }
                }
            }
        }
        elseif ($null -eq $proptune_exploded_log) {
            if ( $this.type -eq "error") {
                write-host -ForegroundColor red "$($this.message)" -nonewline;
            }
            else {
                write-host $this.message -nonewline;
            }
        }
        else {

        }
        # if submessage is true then print the submessage without executiontime
        if(!$this.submessage){
            switch ($this.type) {
                success { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) s-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
                error { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) e-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
                info { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) i-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
                complete { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) c-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
                action { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) a-ex:$(get-elapsed -Datetime $this.date -Formattedstring)" }
            }         
        }
        else{
            switch ($this.type) {
                success { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                error { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                info { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                complete { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) $([powerunicode]::printByUnicode($this.icons.Tick))" }
                action { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
            }
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
        
        write-host "[$([powerunicode]::printByUnicode($this.unicode))-" -nonewline;
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