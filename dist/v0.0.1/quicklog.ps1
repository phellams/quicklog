
<#PSScriptInfo

.VERSION 0.1.0.0

.GUID 4172032c-d164-4985-896d-d60d4c31cbdd

.AUTHOR mnoxx / Codedus

.COMPANYNAME Codedus

.COPYRIGHT 2023 Codedus. All rights reserved.

.TAGS automation

.LICENSEURI https://choosealicense.com/licenses/mit

.PROJECTURI https://gitlab.snowlab.tk/powershell/quicklog.git

.ICONURI https://gitlab.snowlab.tk/powershell/quicklog/-/blob/main/logo.svg

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS G:\devspace\projects\powershell\gitlab-apira/quicklog-.ps1,G:\devspace\projects\powershell\gitlab-apira/quicklog-.ps1

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
https://gitlab.snowlab.tk/powershell/quicklog/-/blob/main/Releases.md

.PRIVATEDATA

#>

<# 
.DESCRIPTION 
 The New-Quicklog function is a PowerShell script that outputs a formatted log message to the console. 

#> 
Param()

using module $psscriptroot\libs\New-Quicklog.ps1

