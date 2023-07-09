
using module ..\Logtastic.psm1
#! CMDLET TESTING

#! Action
Write-LogTastic -Message "Action Message" -Name "ltm" -Type "action"

Write-LogTastic -Message "Action Message Custom unicode" -Name "ltm" -Type "action" -Unicode "#1F606"

Write-LogTastic -Message "Action Message with proture @{pt:{prop=provalue}}" -Name "ltm" -Type "action"

Write-LogTastic -Message "Action SubMessage" -Name "ltm" -Type "action" -SubMessage

#! Info
Write-LogTastic -Message "Info Message" -Name "ltm" -Type "Info"

Write-LogTastic -Message "Info Message Custom unicode" -Name "ltm" -Type "Info" -Unicode "#1F606"

Write-LogTastic -Message "Info SubMessage" -Name "ltm" -Type "Info" -SubMessage

Write-LogTastic -Message "Info Message with proture @{pt:{prop=provalue}}" -Name "ltm" -Type "Info"

#! success
Write-LogTastic -Message "success Message" -Name "ltm" -Type "success"

Write-LogTastic -Message "success Message Custom unicode" -Name "ltm" -Type "success" -Unicode "#1F606"

Write-LogTastic -Message "success SubMessage" -Name "ltm" -Type "success" -SubMessage

Write-LogTastic -Message "success Message with proture @{pt:{prop=provalue}}" -Name "ltm" -Type "success"


#! error
Write-LogTastic -Message "error Message" -Name "ltm" -Type "error"

Write-LogTastic -Message "error Message Custom unicode" -Name "ltm" -Type "error" -Unicode "#1F951"

Write-LogTastic -Message "error {ct:cyan:ColorTune} SubMessage" -Name "ltm" -Type "error" -SubMessage

Write-LogTastic -Message "error {ct:cyan:ColorTune} Message with proture @{pt:{error=errorvalue}}" -Name "ltm" -Type "error"


#! complete
Write-LogTastic -Message "complete Message" -Name "ltm" -Type "complete"

Write-LogTastic -Message "complete Message Custom unicode" -Name "ltm" -Type "complete" -Unicode "#1F951"

Write-LogTastic -Message "complete SubMessage" -Name "ltm" -Type "complete" -SubMessage

Write-LogTastic -Message "complete Message with proture @{pt:{prop=provalue}}" -Name "ltm" -Type "complete"

# Write-ltmM - Full message call class method message
# Write-ltmInfo - Auto Set Info
# Write-ltmError - Auto Set Error
# Write-ltmComplete - Auto Set Complete
# Write-ltmSuccess - Auto Set Success
# Write-ltmAction - Auto Set Action
# Write-ltmProgress - Auto Set Progress
