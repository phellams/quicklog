
import-module -name .\ -force
#! CMDLET TESTING

$logname = "Logtastic"


# Default Message with no param given
Write-LogTastic "Default Message Type=info Message no param switch" -Name $logname
Write-LogTastic -Message "Default Message Type=info with logname" -Name $logname

[string[]]$types = "info","action", "success", "error", "complete"

# #! Loop through types
foreach($type in $types){
  Write-LogTastic -Message "$type Message" -Name $logname -Type $type
  start-sleep -Milliseconds 500
  Write-LogTastic -Message "$type Message Custom unicode" -Name $logname -Type $type -unicode "#1F517"
  start-sleep -Milliseconds 8000
  Write-LogTastic -Message "$type Message with propture @{pt:{prop=propvalue}}" -Name $logname -Type $type
  start-sleep -Milliseconds 2000
  Write-LogTastic -Message "$type Message with colortune {ct:blue:blue colored Text}" -Name $logname -Type $type  
  start-sleep -Milliseconds 200
  Write-LogTastic -Message "$type SubMessage" -Name $logname -Type $type -SubMessage
  start-sleep -Milliseconds 100
  Write-LogTastic -Message "$type Message With No Exection Time" -Name $logname -Type $type -NoExecTime
  start-sleep -Milliseconds 500
  Write-LogTastic -Message "$type Message With No Emoji Icon" -Name $logname -Type $type -noLogIcon
  start-sleep -Milliseconds 3000
  Write-LogTastic -Message "$type Message With No Date/Time Stamp" -Name $logname -Type $type -noDateTime
  start-sleep -Milliseconds 500
  Write-LogTastic -Message "$type Message With No Emoji Icon and No Date/Time Stamp" -Name $logname -Type $type -NoDateTime -NoLogIcon
}



$max = 20
$logname = "Logtastic"
$submessage = $false
for($i=1;$i -lt $max; $i++){
  $barcount = get-random -Minimum 25 -Maximum 50
  $RPercent = get-random -Minimum 0 -Maximum 100
  if($submessage -eq $false){$submessage = $true}
  else{$submessage = $false}
  if($NoDateTime -eq $false){$NoDateTime = $true}
  else{$NoDateTime = $false}
  if($NoLogIcon -eq $false){$NoLogIcon = $true}
  else{$NoLogIcon = $false}
  Write-LogTasticProgress -BarCount $barcount `
                          -Percent $RPercent `
                          -Name $logname `
                          -Status "Running" `
                          -SubMessage $submessage `
                          -Total "369mb" `
                          -Bandwidth "467.2mb" `
                          -Transferred "863.2gb" `
                          -Eta "8Mins, 12Secs" 
}