using module ..\libs\logtastic_lib.psm1
using module ..\libs\cmdlets\Write-LTMessage.psm1

#! CLASS TESTING
# creat class call examplate
$LogTastic = [LogTastic]::new("ql"<#NAME#>, $null<##>)
$LogTastic.enablelogdate()
#$LogTastic.unicode = "#1F951"

# ACTION
$LogTastic.WriteLog("Action Message", "action" , $false)
$LogTastic.WriteLog("Action Message with propture test @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{mysecon=this}}", "action" , $false)
$LogTastic.WriteLog("Action Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "action" , $false)
$LogTastic.WriteLog("Action SubMessage", "action" , $true)
$LogTastic.WriteLog("Action Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "action" , $true)
$LogTastic.WriteLog("Action Message @{pt:{unicode=#1F41F}} ColorTune {ct:gray:This is blue in color} and @{pt:{unicode=#1F41F}}", "action" , $true)

# INFO
$LogTastic.WriteLog("info Message", "info" , $false)
$LogTastic.WriteLog("info Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "info" , $false)
$LogTastic.WriteLog("info Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "info" , $false)
$LogTastic.WriteLog("info SubMessage", "info" , $true)
$LogTastic.WriteLog("info Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "info" , $true)


#start-sleep -Seconds 3
# SUCCESS
$LogTastic.WriteLog("success Message", "success" , $false)
$LogTastic.WriteLog("success Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "success" , $false)
$LogTastic.WriteLog("success Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "success" , $false)
$LogTastic.WriteLog("success SubMessage", "success" , $true)
$LogTastic.WriteLog("success Message with propture @{pt:{unicode=#1F41F}} {ct:green:This is green color} is a submessage", "success" , $true)

# ERROR
$LogTastic.WriteLog("error Message", "error" , $false)
$LogTastic.WriteLog("error Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "error" , $false)
$LogTastic.WriteLog("error Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "error", $false)
$LogTastic.WriteLog("error SubMessage", "error" , $true)
$LogTastic.WriteLog("error Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "error", $true)

# COMPLETE
$LogTastic.WriteLog("complete Message", "complete" , $false)
$LogTastic.WriteLog("complete Message with propture @{pt:{path=G:/devspace/projects/powershell/_repos/LogTastic/libs/LogTastic-example.ps1}} @{pt:{parsevalue2=myvale2}}", "complete" , $false)
$LogTastic.WriteLog("complete Message with propture @{pt:{parsevalue1=myvale}} and custom LogTastic logo", "complete" , $false)
$LogTastic.WriteLog("complete SubMessage", "complete" , $true)
$LogTastic.WriteLog("complete Message with propture @{pt:{unicode=#1F41F}} and custom LogTastic logo and is a submessage", "complete", $true)

#PROGRESS BAR
$LogTastic.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $false })
$LogTastic.Writeprogress(@{"item" = "item1"; "percent" = 20; "status" = "status1"; "submessage" = $false })
$LogTastic.Writeprogress(@{"item" = "item1"; "percent" = 30; "status" = "status1"; "submessage" = $false })
#$LogTastic.Writeprogress(@{"item" = "item1"; "percent" = 10; "status" = "status1"; "submessage" = $true })



#! CMDLET TESTING

#! Action
Write-LTMessage -Message "Action Message" -Name "ql" -Type "action"
Write-LTMessage -Message "Action Message Custom unicode" -Name "ql" -Type "action" -Unicode "#1F951"
Write-LTMessage -Message "Action Message with proture @{pt:{prop=provalue}}" -Name "ql" -Type "action"
Write-LTMessage -Message "Action SubMessage" -Name "ql" -Type "action" -SubMessage

#! Info
Write-LTMessage -Message "Info Message" -Name "ql" -Type "Info"
Write-LTMessage -Message "Info Message Custom unicode" -Name "ql" -Type "Info" -Unicode "#1F951"
Write-LTMessage -Message "Info SubMessage" -Name "ql" -Type "Info" -SubMessage
Write-LTMessage -Message "Info Message with proture @{pt:{prop=provalue}}" -Name "ql" -Type "Info"

#! success
Write-LTMessage -Message "success Message" -Name "ql" -Type "success"
Write-LTMessage -Message "success Message Custom unicode" -Name "ql" -Type "success" -Unicode "#1F951"
Write-LTMessage -Message "success SubMessage" -Name "ql" -Type "success" -SubMessage
Write-LTMessage -Message "success Message with proture @{pt:{prop=provalue}}" -Name "ql" -Type "success"


#! error
Write-LTMessage -Message "error Message" -Name "ql" -Type "error"
Write-LTMessage -Message "error Message Custom unicode" -Name "ql" -Type "error" -Unicode "#1F951"
Write-LTMessage -Message "error {ct:cyan:ColorTune} SubMessage" -Name "ql" -Type "error" -SubMessage
Write-LTMessage -Message "error {ct:cyan:ColorTune} Message with proture @{pt:{error=errorvalue}}" -Name "ql" -Type "error"

#! complete
Write-LTMessage -Message "complete Message" -Name "ql" -Type "complete"
Write-LTMessage -Message "complete Message Custom unicode" -Name "ql" -Type "complete" -Unicode "#1F951"
Write-LTMessage -Message "complete SubMessage" -Name "ql" -Type "complete" -SubMessage
Write-LTMessage -Message "complete Message with proture @{pt:{prop=provalue}}" -Name "ql" -Type "complete"

# Write-QLM - Full message call class method message
# Write-QLInfo - Auto Set Info
# Write-QLError - Auto Set Error
# Write-QLComplete - Auto Set Complete
# Write-QLSuccess - Auto Set Success
# Write-QLAction - Auto Set Action
# Write-QLProgress - Auto Set Progress







#$val = "Action Message unicode: #1F41F  ColorTune {ct:blue:This is blue in color} and unicode: #1F41F"
#$val -match "(\{ct:)(.*?)(\})" 
#$val -replace "(\{ct:)(.*?)(\})", "This is blue in red"
#$val

#[regex]::Match("Action Message unicode: #1F41F ColorTune {ct:blue:This is blue in color}  ColorTune {ct:blue:This is blue in color} and unicode: #1F41F","(\{ct:)(.*?)(\}")