<#PSScriptInfo

.VERSION 0.1.3.0

.GUID 4172032c-d164-4985-896d-d60d4c31cbdd

.AUTHOR mnoxx / Codedus

.COMPANYNAME Codedus

.COPYRIGHT 2023 Codedus. All rights reserved.

.TAGS automation, log, logmessage, unicode

.LICENSEURI https://choosealicense.com/licenses/mit

.PROJECTURI https://gitlab.snowlab.tk/powershell/quicklog.git

.ICONURI https://gitlab.snowlab.tk/powershell/quicklog/-/blob/main/logo.svg

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS New-QuickLog, Get-Elapsed, PowerUniCode

.EXTERNALSCRIPTDEPENDENCIES

.DEFINEDFUNCTIONS New-Quicklog

.RELEASENOTES https://gitlab.snowlab.tk/powershell/quicklog/-/blob/main/Releases.md

.PRIVATEDATA = @{ Tags = 'automation'; LicenseUri = 'https://choosealicense.com/licenses/mit'; ProjectUri = 'https://gitlab.snowlab.tk/powershell/quicklog.git'; IconUri = 'https://gitlab.snowlab.tk/powershell/quicklog/-/blob/main/logo.svg'; ReleaseNotes = 'https://gitlab.snowlab.tk/powershell/quicklog/-/blob/main/Releases.md'; Prerelease = ''} # End of PrivateData hashtable

#>

<# 

.DESCRIPTION 
 Quicklog is a PowerShell function that outputs a formatted log message to the console. 

#> 
Param()

# Include Scripts here
. $psscriptroot\libs\New-Quicklog.ps1

