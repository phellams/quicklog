using module .\libs\new-quicklog.ps1
# ACTION
new-quicklog -name "QuickLog" -message "Action Message" -type "action"
new-quicklog -name "QuickLog" -message "Action Message with propture @{pt:{parsevalue1=myvale}}" -type "action"
new-quicklog -name "QuickLog" -message "Action Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo" -type "action" -unicode "#1F41F"
new-quicklog -name "QuickLog" -message "Action Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo and is a submessage" -type "action" -unicode "#1F41F" -SubMessage
# INFO
new-quicklog -name "QuickLog" -message "info Message" -type "info"
new-quicklog -name "QuickLog" -message "info Message with propture @{pt:{parsevalue1=myvale}}" -type "info"
new-quicklog -name "QuickLog" -message "info Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo" -type "info" -unicode "#1F41F"
new-quicklog -name "QuickLog" -message "info Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo and is a submessage" -type "info" -unicode "#1F41F" -SubMessage
#
new-quicklog -name "QuickLog" -message "success Message" -type "success"
new-quicklog -name "QuickLog" -message "success Message with propture @{pt:{parsevalue1=myvale}}" -type "success"
new-quicklog -name "QuickLog" -message "success Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo" -type "success" -unicode "#1F41F"
new-quicklog -name "QuickLog" -message "success Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo and is a submessage" -type "success" -unicode "#1F41F" -SubMessage

new-quicklog -name "QuickLog" -message "complete Message" -type "complete"
new-quicklog -name "QuickLog" -message "complete Message with propture @{pt:{parsevalue1=myvale}}" -type "complete"
new-quicklog -name "QuickLog" -message "complete Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo" -type "complete" -unicode "#1F41F"
new-quicklog -name "QuickLog" -message "complete Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo and is a submessage" -type "complete" -unicode "#1F41F" -SubMessage

new-quicklog -name "QuickLog" -message "error Message" -type "error"
new-quicklog -name "QuickLog" -message "error Message with propture @{pt:{parsevalue1=myvale}}" -type "error"
new-quicklog -name "QuickLog" -message "error Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo" -type "error" -unicode "#1F41F"
new-quicklog -name "QuickLog" -message "error Message with propture @{pt:{parsevalue1=myvale}} and custom quicklog logo and is a submessage" -type "error" -unicode "#1F41F" -SubMessage



#UTF codes
# bell #1F514
# bookmark #1F516
# hammer #1F528
# left-pointing magnifying glass U+1F50D
# right-pointing magnifying glass U+1F50E
# speech balloon #1F4AC
# frog face #1F438
# octopus #1F419
#  ---- eight spoked asterisk #2733
#  ---- sparkle #2747
# triangular flag on post # 1F6A9
# heavy exclamation mark symbol #2757