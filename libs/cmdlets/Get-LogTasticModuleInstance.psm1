using module ..\logtastic_lib.psm1
<#
.SYNOPSIS
Returns and instance of the LogTastic class.

.DESCRIPTION
Returns and instance of the LogTastic class, providing access to the LogTastic methods.

.EXAMPLE
$logtastic = Get-LogTasticModuleInstance

This example returns an instance of the LogTastic class.

.INPUTS
None.

.OUTPUTS
none.

.NOTES
- 

.LINK
logtastic (Module): https://github.com/sgkens/logtastic
#>

$logtastic_instance = New-Object -TypeName LogTastic

Function Get-LogTasticModuleInstance() {
  [alias("gltmi")]
  [CmdletBinding()]
  [OutPutType([object])]
  param()
  process {
    return $logtastic_instance
  }
}
