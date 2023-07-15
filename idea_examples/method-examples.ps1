using module ..\logtastic.psm1

$logtastic = Get-LogTasticModuleInstance

#! CLASS TESTING
# creat class call examplate
$LogTastic.Name = "Logt"
$LogTastic.enablelogdate()
$logtastic.enablelogicon()
$logtastic.EnableExecTime()

[string[]]$types = "info", "action", "success", "error", "complete"

foreach($type in $types){
  $LogTastic.WriteLog("$type Message", $type , $false)
  $LogTastic.WriteLog("$type Message Custom unicode", $type , $false)
  $LogTastic.WriteLog("$type Message with propture @{pt:{prop=provalue}}", $type , $false)
  $LogTastic.WriteLog("$type Message with colortune {ct:blue:blue colored Text}", $type , $false)  
  $LogTastic.WriteLog("$type SubMessage", $type , $true)
  $logtastic.DisableExecTime()
  $LogTastic.WriteLog("$type Message with no execution time", $type , $false)
  $logtastic.EnableExectime()
  $LogTastic.DisableLogIcon()
  $LogTastic.WriteLog("$type Message With No Emoji Icon", $type , $false)
  $LogTastic.EnableLogIcon()
  $LogTastic.DisableLogdate()
  $LogTastic.WriteLog("$type Message With No Date/Time Stamp", $type , $false)
  $LogTastic.DisableLogIcon()
  $LogTastic.DisableLogdate()
  $LogTastic.WriteLog("$type Message With No Emoji Icon and No Date/Time Stamp", $type , $false)
  $LogTastic.EnableLogIcon()
  $LogTastic.EnableLogdate()
}

$total = 369mb
[int]$max = 20
$submessage = $false
for($i=0; $i -lt $max;$i++){
  $randomPercent = get-random -Minimum 15 -Maximum 100
  $ramdomBarcound = get-random -Minimum 25 -Maximum 100

  if(!$LogTastic.Logdate){$LogTastic.EnableLogdate()}
  else{$LogTastic.DisableLogdate()}
  if(!$LogTastic.LogIcon){$LogTastic.EnableLogIcon()}
  else{$LogTastic.DisableLogIcon()}
  if ($submessage -eq $false){$submessage = $true}
  else{$submessage = $false}

  if($i -eq 10){$submessage = $false}
  $logtastic.WriteProgress(@{
    barcount = $ramdomBarcound
    percent = $randomPercent
    status = "Running"
    submessage = $submessage
    total = $total
    bandwidth = "1.2mb"
    transfered = "86.2mb"
    eta = ""
  })
}

#PROGRESS BAR
# $LogTastic.Writeprogress(@{barcount = 50; percent = 87; status = "Running"; submessage = $false; total= "200gb"; bandwidth = "26mb/s"; transfered="150mb"; eta = "00:00:00" })
# $LogTastic.Writeprogress(@{barcount = 24; percent = 20; status = "paused"; submessage = $true; total= "566gb"; bandwidth = "26mb/s"; transfered="780mb"; eta = "00:00:00" })
# $LogTastic.Writeprogress(@{barcount = 38; percent = 20; status = "Running"; submessage = $false; total= "86"; transfered="12"; eta = "00:00:00" })
#$LogTastic.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $true })


#$LogTastic.ThemeProperties.utfe
$LogTastic.GetThemeProperty("info")
$LogTastic.GetThemeUnicode("info")

