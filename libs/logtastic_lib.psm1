using module sm\Get-Elapsed.psm1
using module sm\Get-PropTune.psm1
using module sm\Get-ColorTune.psm1
using module sm\powerunicode\powerunicode.psm1
#*  ____       _      __   __
#*  / __ \__ __(_)____/ /__/ / ___ ___ _
#  / /_/ / // / // __/  '_/ /_/ _ Y _ `/
#  \___\_\_,_/_/ \__/_/\_Y____|___|_, /
#&                               /__
<# ----------------------------------------o
& CLASSNAME: [logtastic]
~ VERSION: 0.1.0
- AUTHOR: Snoonx @ SimpleScripts.dev
- LICENSE: MIT   
* DESCRIPTION:   
    Powershell class used to generate log messages, wrapper for write-host 
    and output to console   
? DEPENDANCIES:
        • Elapsed #~ v1.0.0
        • Proptune #~ v1.0.0
        • ColorTune #~ v1.0.0   
        • PowerUnicode #~ v1.0.0    
? NOTES
    This class is still in development and is not ready for production use.
    @Colorful comments vscode url: 
        - #? https://marketplace.visualstudio.com/items?itemName=bierner.colorful-comments
    BUILD ENV
        Powershellcore 7.3.1
----------------------------------------o #>
class logtastic {
    [string]$name
    [string]$type
    [string]$unicode
    [bool]$submessage
    [string]$datestring
    [datetime]$date
    [string]$message
    [pscustomobject]$icons
    [bool]$logdate
    [bool]$logicon
    [bool]$logfile
    [bool]$ExecTime
    [string]$PTSeperator
    [int]$sm_indent
    [datetime]$StartTime
    [datetime]$lastMessageTime
    [String]$CurrentLogTime
    [string]$LastLogTime
    

    logtastic([string]$unicode) {
        $this.icons = [PSCustomObject]@{
            Error           = "#2753" # ❓
            Error2          = "#2757" # ❗
            Success         = "#1F530" # 🔰
           # Info            = "#1F300" # 🌀
            Info            = "#1F4D2" # 📒
            Complete        = "#2705"  # ✅
            Action          = "#1F364" # 🍤
            request         = "#1F310" # 🌐
            response        = "#1F311" # 🌑
            Speaker         = "#1F50A" # 🔊
            Seperator       = "#1F4A0" # 💠
            Separator2      = "#2666"  # ♦
            Separator3      = "#2638"  # ☸ 
            LeftArrow       = "#2771"  #  ❱
            Plus            = "#2795"  # ➕
            logtime         = "#23F0"  # ⏰
            download        = "#1F4E5"  # ⏬
            download2       = "#1F300" # 🌀
            upload          = "#1F4E4" # 📤
            ArrowDiagDown   = "#21AA"  # ↪
            ArrowDiagUp     = "#2197"  # ↗
            UpCurvedArrow   = "#2197"  # ↗
            ArrowUp         = "#2B06"  # ⬆
            ArrowDown       = "#2B07"  # ⬇
            ArrowLeft       = "#2B05"  # ⬅
            ArrowRight      = "#27A1"  # ➡
            DataStreamLeftRight  = "#2194"  # ↔
            DataStreamUpDown     = "#2195"  # ↕
            DataStreamRight      = "#21C4" # ⇄
            DataStreamLeft       = "#21C6" # ⇆
            DataStreamDUpDown    = "#21C5" # ⇅
            ArrowDataStreamUp    = "#21C8" # ⇈
            ArrowDataStreamLeft  = "#21C7" # ⇇
            ArrowDataStreamRight = "#21C9" # ⇉
            TleftArrow           = "#21A4" # ↤
            TRightArrow          = "#21A6" # ↦
            ArrowDiagDownAlt     = "#21B3" # ↳
            Tick                 = "#2714"  # ✔
        }
        $this.logdate = $true
        $this.sm_indent = 5
        $this.StartTime = $this.GetLogTime()
        $this.LastLogTime = $this.GetLogTime()
        if ($null -eq $this.unicode) {
            $this.unicode = "#1F365"
        }
        else{
            $this.unicode = $unicode
        }
        if ($null -eq $this.PTSeperator) {
            $this.PTSeperator = "$([powerunicode]::printByUnicode($this.icons.Separator3))"
        }
    }

    [void] EnableLogdate() {
        $this.logdate = $true
    }

    [void] DisableLogdate() {
        $this.logdate = $false
    }

    [void] EnableLogIcon() {
        $this.logicon = $true
    }

    [void] DisableLogIcon() {
        $this.logicon = $false
    }
    [void] EnableLogfile() {
        $this.logfile = $true
    }
    [void] DisableLogfile() {
        $this.logfile = $false
    }

    [void] EnableExectime() {
        $this.Exectime = $true
    }
    [void] DisablExectime() {
        $this.Exectime = $false
    }

    [string] NewIndent([int]$indent) {
        [string] $indentstring = " "
        $indentstring = $indentstring * $indent
        return $indentstring
    }
    [string] GetLogTime() {
        return (Get-Date).toString()
    }

    [void] EnableLogfile([string]$path) {
        if(test-path -path $path){
            Start-Transcript -path "$path\documents\$($this.name).log" -Append
        }else{
            Start-Transcript -path "$env:HOMEDRIVE$env:HOMEPATH\documents\$($this.name).log" -Append
        }
    }

    [void]WriteLog([string]$message, [string]$type, [bool]$submessage) {
        $this.datestring = Get-Date -Format "hh:mm:ss"
        $this.CurrentLogTime = $this.GetLogTime()
        $this.message = $message
        $this.type = $type
        $this.submessage = $submessage
        
        # Set default unicode if not set
        if ($null -eq $this.unicode -or $this.unicode.length -eq 0) { $this.unicode = "#1F43D" }
        
        write-host -foregroundcolor yellow "[" -nonewline;

        if($this.logicon -eq $true){
            #? custom name of the log or apps name its used with
            #write-host "$([powerunicode]::printByUnicode($this.unicode))" -nonewline;
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.unicode))" -nonewline;
            write-host -ForegroundColor gray "-" -nonewline;
            write-host -ForegroundColor gray "$($this.name)" -NoNewline;
        }
        else{
            write-host -ForegroundColor yellow "$($this.name)-" -nonewline;
        }
        #? If message is a submessage
        if ($this.submessage -eq $true) {
            if ($this.logdate -eq $true) {
                write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))" -NoNewline;
                write-host -ForegroundColor gray "$($this.datestring)" -NoNewline;
                write-host -foregroundcolor yellow "]" -nonewline;
            }
        }
        else {
            if ($this.logdate -eq $true) {
                write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))" -NoNewline;
                write-host -ForegroundColor gray "$($this.datestring)" -NoNewline;
                write-host -Foregroundcolor yellow "]" -nonewline;
                write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.Separator))" -NoNewline;
            }
        }
        if ($this.submessage -eq $true) {
            switch ($type) {
                success { Write-Host -ForegroundColor green "$($this.NewIndent($this.sm_indent))$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; }
                error { Write-Host -ForegroundColor red "$($this.NewIndent($this.sm_indent))$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; }
                info { Write-Host -ForegroundColor blue "$($this.NewIndent($this.sm_indent))$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline; }
                complete { Write-Host -ForegroundColor darkgreen "$($this.NewIndent($this.sm_indent))$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline;}
                action { Write-Host -ForegroundColor yellow "$($this.NewIndent($this.sm_indent))$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline;}
                default { Write-Host -ForegroundColor blue "$($this.NewIndent($this.sm_indent))$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -nonewline;}
            }
        }
        else {
            switch ($this.type) {
                success { Write-Host -ForegroundColor green "$([powerunicode]::printByUnicode($this.icons.Success))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                error { Write-Host -ForegroundColor red "$([powerunicode]::printByUnicode($this.icons.error))$([powerunicode]::printByUnicode($this.icons.LeftArrow))$([powerunicode]::printByUnicode($this.icons.error2))" -nonewline;}
                info { Write-Host -ForegroundColor blue "$([powerunicode]::printByUnicode($this.icons.info))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                complete { Write-Host -ForegroundColor darkgreen "$([powerunicode]::printByUnicode($this.icons.complete))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }
                action { Write-Host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.action))$([powerunicode]::printByUnicode($this.icons.leftArrow)) " -nonewline; }
                default { Write-Host -ForegroundColor blue "$([powerunicode]::printByUnicode($this.icons.info))$([powerunicode]::printByUnicode($this.icons.LeftArrow)) " -nonewline; }   
            }
        }

        # Message Area -if colortune Key is prsent ---------------
        $ColorElements = [regex]::Matches($this.message,"(\{ct:)(.*?)(\})")
        if($ColorElements) {
            for($i=0; $i -lt $ColorElements.count; $i++){
                $PropColorData = $ColorElements[$i].value -replace "{ct:", "" -replace "}", ""
                $color = $PropColorData.split(":")[0]
                $text = $PropColorData.split(":")[1]
                # inline color 
                #$InlineTextColor = Get-ColorTune -text $text -color $color
                $this.message = $this.message.replace($ColorElements[$i].value, (Get-ColorTune -Text $text -color $color))
            }
         }
        # Message Area -if Proptune Key is prsent ---------------
        if ($this.message -like "*@{pt:{*") { $proptune_exploded_log = $this.message.split('@').split('}}') } else { $proptune_exploded_log = $null }
        if ($null -ne $proptune_exploded_log) {

            foreach ($emsp in $proptune_exploded_log) {
                if ($emsp -like "*{pt:{*") {
                    $emsp_pt_removed = $emsp -replace "{pt:{", ""
                    $props = Get-PropTune -StringData $emsp_pt_removed
                    foreach ($propname in $props.keys) {
                        $value = $props[$propname]
                        if ( $this.type -eq "error") {
                            write-host "○─" -foregroundColor yellow -nonewline; 
                            write-host -foregroundColor Magenta "$propname`:" -nonewline; 
                            write-host -foregroundColor darkgray "$value" -nonewline; 
                            write-host "" -nonewline;
                        }
                        else {
                            write-host "○─" -foregroundColor yellow -nonewline; 
                            write-host -foregroundColor Magenta "$propname`:" -nonewline; 
                            write-host -foregroundColor darkgray "$value" -nonewline; 
                            write-host "" -nonewline;
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
        if(!$this.submessage){
            switch ($this.type) {
                success { 
                    Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" -nonewline;
                    if($this.Exectime){
                        write-host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.TLeftArrow))" -nonewline;
                        write-host -ForegroundColor DarkCyan "s-ex:$(Get-Elapsed -From $this.LastLogTime -To $this.CurrentLogTime -Formattedstring)"
                    }else{
                        write-host ""
                    }
                }
                error { 
                    Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" -nonewline;
                    if($this.Exectime){
                        write-host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.TLeftArrow))" -nonewline;
                        write-host -ForegroundColor DarkCyan "e-ex:$(Get-Elapsed -From $this.LastLogTime -To $this.CurrentLogTime -Formattedstring)"
                    }else{
                        write-host ""
                    }
                }
                info { 
                    Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" -nonewline;
                    if($this.Exectime){
                        write-host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.TLeftArrow))" -nonewline;
                        write-host -ForegroundColor DarkCyan "i-ex:$(Get-Elapsed -From $this.LastLogTime -To $this.CurrentLogTime -Formattedstring)"
                    }else{
                        write-host ""
                    }
                }
                complete { 
                    Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" -nonewline;
                    if($this.Exectime){
                        write-host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.TLeftArrow))" -nonewline;
                        write-host -ForegroundColor DarkCyan "c-ex:$(Get-Elapsed -From $this.LastLogTime -To $this.CurrentLogTime -Formattedstring)"
                    }else{
                        write-host ""
                    }
                }
                action { 
                    Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" -nonewline;
                    if($this.Exectime){
                        write-host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.TLeftArrow))" -nonewline;
                        write-host -ForegroundColor DarkCyan "a-ex:$(Get-Elapsed -From $this.LastLogTime -To $this.CurrentLogTime -Formattedstring)"
                    }else{
                        write-host ""
                    }
                }
                Default { 
                    Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" -nonewline;
                    if($this.Exectime){
                        write-host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.TLeftArrow))" -nonewline;
                        write-host -ForegroundColor DarkCyan "ex:$(Get-Elapsed -From $this.LastLogTime -To $this.CurrentLogTime -Formattedstring)"
                    }else{
                        write-host ""
                    }
                }
            }         
        }
        else{
            switch ($this.type) {
                success { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                error { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                info { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                complete { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator)) $([powerunicode]::printByUnicode($this.icons.Tick))" }
                action { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }
                default { Write-Host -ForegroundColor DarkCyan " $([powerunicode]::printByUnicode($this.icons.Sperator))" }                
            }
            $this.LastLogTime = $this.GetLogTime()
        }
        # Set the last log message time allows to calculate the time difference between the logs
    }

    [string]BuildProgressBar([int]$percent, [int]$barcount = 50){
        # 25 is the number of characters in the progress bar
        $bar = ""
        $bar = $bar + "["
        $bar = $bar + ("●" * [math]::floor(($barcount * $percent) / 100))
        $bar = $bar + ">"
        $bar = $bar + ("○" * [math]::floor($barcount - (($barcount * $percent) / 100)))
        $bar = $bar + "]"
        return $bar
    }

    [void]Writeprogress([PSCustomObject]$stats) { # @{ percent = 10; barcount= 25 }
    
        
        write-host "[$([powerunicode]::printByUnicode($this.unicode))-" -nonewline;
        write-host -ForegroundColor gray "$($this.name)" -NoNewline;

        if ($stats.submessage -eq $true) {
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))$(if($this.logdate -eq $true){$this.datestring})]$([powerunicode]::printByUnicode($this.icons.Sperator))" -NoNewline;
            Write-Host -ForegroundColor yellow "     " -nonewline;
            write-host -ForegroundColor Blue "$([powerunicode]::printByUnicode($this.icons.ArrowDiagDown)) " -NoNewline;
            write-host -foregroundcolor green "$($this.buildprogressbar($stats.percent,$stats.barcount))" -NoNewline;
            write-host -ForegroundColor blue "[" -nonewline;
            write-host -ForegroundColor Magenta "$([powerunicode]::printByUnicode($this.icons.Download)) " -nonewline;
            Write-Host -ForeGroundcolor darkgreen "$($stats.bandwidth)" -NoNewline;
            write-host -ForegroundColor darkgreen "$($stats.transfered)" -NoNewline;
            write-host -ForegroundColor Magenta "$([powerunicode]::printByUnicode($this.icons.DataStreamLeftRight))" -nonewline;
            write-host -ForegroundColor darkgreen "$($stats.Total)" -nonewline;
            write-host -ForegroundColor blue "]-$($stats.status) $($stats.eta)"
        }
        else {
            write-host -ForegroundColor yellow "$([powerunicode]::printByUnicode($this.icons.logtime))$(if($this.logdate -eq $true){$this.datestring})]$([powerunicode]::printByUnicode($this.icons.Sperator))" -NoNewline;
            Write-Host -ForegroundColor blue "$([powerunicode]::printByUnicode($this.icons.download2))$([powerunicode]::printByUnicode($this.icons.leftArrow))" -NoNewline;
            write-host -foregroundcolor green "$($this.buildprogressbar($stats.percent,$stats.barcount))" -NoNewline;
            write-host -ForegroundColor blue "[" -nonewline;
            write-host -ForegroundColor Magenta "$([powerunicode]::printByUnicode($this.icons.Download)) " -nonewline;
            Write-Host -ForeGroundcolor darkgreen "$($stats.bandwidth)" -NoNewline;
            write-host -ForegroundColor darkgreen "$($stats.transfered)" -NoNewline;
            write-host -ForegroundColor Magenta "$([powerunicode]::printByUnicode($this.icons.DataStreamLeftRight))" -nonewline;
            write-host -ForegroundColor darkgreen "$($stats.Total)" -nonewline;
            write-host -ForegroundColor blue "]-$($stats.status) $($stats.eta)"
        }
    }
}



