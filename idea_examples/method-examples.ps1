using module ..\libs\logtastic_lib.psm1

#! CLASS TESTING
# creat class call examplate
$LogTastic = [LogTastic]::new($null)
$LogTastic.Name = "Logt"
$LogTastic.enablelogdate()
$logtastic.enablelogicon()
$logtastic.EnableExecTime()

[string[]]$types = "info","action", "success", "error", "complete"

foreach($type in $types){
  $LogTastic.WriteLog("$type Message", $type , $false)
  $LogTastic.unicode = "#1F517"
  $LogTastic.WriteLog("$type Message Custom unicode", $type , $false)
  $LogTastic.unicode = $null
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

# # ACTION
# $LogTastic.WriteLog("Action Message", "action" , $false)
# $LogTastic.WriteLog("Action SubMessage", "action" , $true)
# $LogTastic.WriteLog("Action Message with propture test @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{mysecon=this}}", "action" , $false)
# $LogTastic.WriteLog("Action Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "action" , $false)
# $LogTastic.WriteLog("Action Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "action" , $true)
# $LogTastic.WriteLog("Action Message @{pt:{unicode=#1F41F}} ColorTune {ct:gray:This is blue in color} and @{pt:{unicode=#1F41F}}", "action" , $true)

# # INFO
# $LogTastic.WriteLog("info Message", "info" , $false)
# $LogTastic.WriteLog("info Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "info" , $false)
# $LogTastic.WriteLog("info Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "info" , $false)
# $LogTastic.WriteLog("info SubMessage", "info" , $true)
# $LogTastic.WriteLog("info Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "info" , $true)


# #start-sleep -Seconds 3
# # SUCCESS
# $LogTastic.WriteLog("success Message", "success" , $false)
# $LogTastic.WriteLog("success Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "success" , $false)
# $LogTastic.WriteLog("success Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "success" , $false)
# $LogTastic.WriteLog("success SubMessage", "success" , $true)
# $LogTastic.WriteLog("success Message with propture @{pt:{unicode=#1F41F}} {ct:green:This is green color} is a submessage", "success" , $true)

# # ERROR
# $LogTastic.WriteLog("error Message", "error" , $false)
# $LogTastic.WriteLog("error Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "error" , $false)
# $LogTastic.WriteLog("error Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "error", $false)
# $LogTastic.WriteLog("error SubMessage", "error" , $true)
# $LogTastic.WriteLog("error Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "error", $true)

# # COMPLETE
# $LogTastic.WriteLog("complete Message", "complete" , $false)
# $LogTastic.WriteLog("complete Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "complete" , $false)
# $LogTastic.WriteLog("complete Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "complete" , $false)
# $LogTastic.WriteLog("complete SubMessage", "complete" , $true)
# $LogTastic.WriteLog("complete Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "complete", $true)

#PROGRESS BAR
$LogTastic.Writeprogress(@{barcount = 50; percent = 87; status = "Running"; submessage = $false; total= "200gb"; bandwidth = "26mb/s"; transfered="150mb"; eta = "00:00:00" })
$LogTastic.Writeprogress(@{barcount = 24; percent = 20; status = "paused"; submessage = $true; total= "566gb"; bandwidth = "26mb/s"; transfered="780mb"; eta = "00:00:00" })
$LogTastic.Writeprogress(@{barcount = 38; percent = 20; status = "Running"; submessage = $false; total= "86"; transfered="12"; eta = "00:00:00" })
#$LogTastic.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $true })

