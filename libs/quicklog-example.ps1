using module .\quicklog.psm1
# creat class call examplate
$quicklog = [QuickLog]::new("QuickLog")
$quicklog.enablelogdate()

# ACTION
$quicklog.WriteLog("Action Message", "action", '' , $false)
$quicklog.WriteLog("Action Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "action", '' , $false)
$quicklog.WriteLog("Action Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "action", '#1F41F' , $false)
$quicklog.WriteLog("Action SubMessage", "action", '#1F41F' , $true)
$quicklog.WriteLog("Action Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "action", '#1F41F' , $true)

# INFO
$quicklog.WriteLog("info Message", "info", '' , $false)
$quicklog.WriteLog("info Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "info", '' , $false)
$quicklog.WriteLog("info Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "info", '#1F41F' , $false)
$quicklog.WriteLog("info SubMessage", "info", '#1F41F' , $true)
$quicklog.WriteLog("info Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "info", '#1F41F' , $true)


#start-sleep -Seconds 3
# SUCCESS
$quicklog.WriteLog("success Message", "success", '' , $false)
$quicklog.WriteLog("success Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "success", '' , $false)
$quicklog.WriteLog("success Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "success", '#1F41F' , $false)
$quicklog.WriteLog("success SubMessage", "success", '#1F41F' , $true)
$quicklog.WriteLog("success Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "success", '#1F41F' , $true)

# ERROR
$quicklog.WriteLog("error Message", "error", '' , $false)
$quicklog.WriteLog("error Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "error", '' , $false)
$quicklog.WriteLog("error Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "error", '#1F41F' , $false)
$quicklog.WriteLog("error SubMessage", "error", '#1F41F' , $true)
$quicklog.WriteLog("error Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "error", '#1F41F' , $true)

# COMPLETE
$quicklog.WriteLog("complete Message", "complete", '' , $false)
$quicklog.WriteLog("complete Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/quicklog/libs/quicklog-example.ps1}} @{pt:{parsevalue2=myvale2}}", "complete", '' , $false)
$quicklog.WriteLog("complete Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo", "complete", '#1F41F' , $false)
$quicklog.WriteLog("complete SubMessage", "complete", '#1F41F' , $true)
$quicklog.WriteLog("complete Message with propture @{pt:{unicode=#1F41F}} and custom quicklog logo and is a submessage", "complete", '#1F41F' , $true)

#PROGRESS BAR
$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $false })
$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 20; "status" = "status1"; "submessage" = $false })
$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 30; "status" = "status1"; "submessage" = $false })
#$quicklog.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $true })




