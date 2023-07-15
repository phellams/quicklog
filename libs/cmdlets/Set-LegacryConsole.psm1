<#
.SYNOPSIS
Installs PSReadLine module if not already installed.
Installs Pscx # Custom 

.DESCRIPTION
Returns and instance of the LogTastic class, providing access to the LogTastic methods.

.PARAMETER Name
Name of the log file. (Optional)

.PARAMETER Unicode
Specifies char for the log name. (Optional)

.EXAMPLE
$ltm = New-LogTastic -Name "Log1" -unicode $null
$ltm.enablelogdate()
$ltm.enablelogicon()
$ltm.WriteMessage("This is an information message", "info", $false)
$ltm.WriteMessage("This is an information message", "info", $true) # submessage

This example writes an information message to the log file with the name "Log1".

.INPUTS
None.

.OUTPUTS
returns an instance of the LogTastic class. [object]

.NOTES
- 

.LINK
logtastic (Module): https://github.com/sgkens/logtastic
#>
Function New-LogTastic() {
  [alias("nlt")]
  [CmdletBinding()]
  [OutPutType([object])]
  param(
    [Alias('n')]
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$name,
    [Alias('u')]
    [Parameter(Mandatory = $false, Position = 1)]
    [string]$Unicode
  )
  process {
    if ($null -eq $name -or $name.length -eq 0 ) { $name = "ltm" }
    if ($null -eq $Unicode -or $Unicode.length -eq 0 ) { 
      $ltm = [Logtastic]::new($name, $null)
    }
    else {
      $ltm = [Logtastic]::new($name, $unicode)
    }
    return $ltm
  }
}
Export-ModuleMember -Function New-LogTastic