using module .\quicklog.psm1
# creat class call examplate
$quicklog = [QuickLog]::new("ql",$null)
$quicklog.enablelogdate()
$quicklog.unicode = "#1F951"

# ACTION
$quicklog.WriteLog("Action Message", "action" , $false)
$quicklog.WriteLog("Action Message with propture @{pt:{size=1gb,count=27}} test @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1,parsevalue2=myvale2}}", "action" , $false)
$quicklog.WriteLog("Action Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "action" , $false)
$quicklog.WriteLog("Action SubMessage", "action" , $true)
$quicklog.WriteLog("Action Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "action" , $true)

# INFO
$quicklog.WriteLog("info Message", "info" , $false)
$quicklog.WriteLog("info Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "info" , $false)
$quicklog.WriteLog("info Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "info" , $false)
$quicklog.WriteLog("info SubMessage", "info" , $true)
$quicklog.WriteLog("info Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "info" , $true)


#start-sleep -Seconds 3
# SUCCESS
$quicklog.WriteLog("success Message", "success" , $false)
$quicklog.WriteLog("success Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "success" , $false)
$quicklog.WriteLog("success Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "success" , $false)
$quicklog.WriteLog("success SubMessage", "success" , $true)
$quicklog.WriteLog("success Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "success" , $true)

# ERROR
$quicklog.WriteLog("error Message", "error" , $false)
$quicklog.WriteLog("error Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "error" , $false)
$quicklog.WriteLog("error Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "error", $false)
$quicklog.WriteLog("error SubMessage", "error" , $true)
$quicklog.WriteLog("error Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "error", $true)

# COMPLETE
$quicklog.WriteLog("complete Message", "complete" , $false)
$quicklog.WriteLog("complete Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "complete" , $false)
$quicklog.WriteLog("complete Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "complete" , $false)
$quicklog.WriteLog("complete SubMessage", "complete" , $true)
$quicklog.WriteLog("complete Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "complete", $true)

#PROGRESS BAR
$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $false })
$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 20; "status" = "status1"; "submessage" = $false })
$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 30; "status" = "status1"; "submessage" = $false })
#$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $true })




