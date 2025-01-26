using module ..\libs\quicklog_lib.psm1

$quicklog = New-Object -TypeName quicklog

#! CLASS TESTING
# creat class call examplate
$quicklog.Name = "Logt"
$quicklog.enablelogdate()
$quicklog.enablelogicon()
$quicklog.EnableExecTime()

[string[]]$types = "info", "action", "success", "error", "complete"

foreach($type in $types){
  $quicklog.GenerateLog("$type Message", $type , $false)
  $quicklog.Writelog()
  $quicklog.GenerateLog("$type Message Custom unicode", $type , $false)
  $quicklog.Writelog()
  $quicklog.GenerateLog("$type Message with propture @{pt:{prop=provalue}}", $type , $false)
  $quicklog.Writelog()
  $quicklog.GenerateLog("$type Message with colortune {ct:blue:blue colored Text}", $type , $false)
  $quicklog.Writelog()
  $quicklog.GenerateLog("$type SubMessage", $type , $true)
  $quicklog.Writelog()
  $quicklog.DisableExecTime()
  $quicklog.GenerateLog("$type Message with no execution time", $type , $false)
  $quicklog.Writelog()
  $quicklog.EnableExectime()
  $quicklog.DisableLogIcon()
  $quicklog.GenerateLog("$type Message With No Emoji Icon", $type , $false)
  $quicklog.Writelog()
  $quicklog.EnableLogIcon()
  $quicklog.DisableLogdate()
  $quicklog.GenerateLog("$type Message With No Date/Time Stamp", $type , $false)
  $quicklog.Writelog()
  $quicklog.DisableLogIcon()
  $quicklog.DisableLogdate()
  $quicklog.GenerateLog("$type Message With No Emoji Icon and No Date/Time Stamp", $type , $false)
  $quicklog.Writelog()
  $quicklog.EnableLogIcon()
  $quicklog.EnableLogdate()
}

$total = 369mb
[int]$max = 20
$submessage = $false
for($i=0; $i -lt $max;$i++){
  $randomPercent = get-random -Minimum 15 -Maximum 100
  $ramdomBarcound = get-random -Minimum 25 -Maximum 100

  if(!$quicklog.Logdate){$quicklog.EnableLogdate()}
  else{$quicklog.DisableLogdate()}
  if(!$quicklog.LogIcon){$quicklog.EnableLogIcon()}
  else{$quicklog.DisableLogIcon()}
  if ($submessage -eq $false){$submessage = $true}
  else{$submessage = $false}

  if($i -eq 10){$submessage = $false}
  $quicklog.GenerateProgress(@{
    barcount = $ramdomBarcound
    percent = $randomPercent
    status = "Running"
    submessage = $submessage
    total = $total
    bandwidth = "1.2mb"
    transfered = "86.2mb"
    eta = ""
  })
  $quicklog.WriteProgress()
}

#PROGRESS BAR
# $quicklog.Writeprogress(@{barcount = 50; percent = 87; status = "Running"; submessage = $false; total= "200gb"; bandwidth = "26mb/s"; transfered="150mb"; eta = "00:00:00" })
# $quicklog.Writeprogress(@{barcount = 24; percent = 20; status = "paused"; submessage = $true; total= "566gb"; bandwidth = "26mb/s"; transfered="780mb"; eta = "00:00:00" })
# $quicklog.Writeprogress(@{barcount = 38; percent = 20; status = "Running"; submessage = $false; total= "86"; transfered="12"; eta = "00:00:00" })
#$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $true })


#$quicklog.ThemeProperties.utfe
$quicklog.GetThemeProperty("utfe")
$quicklog.GetThemeUnicode("info","utfe")

