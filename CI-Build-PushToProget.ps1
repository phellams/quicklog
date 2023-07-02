# --CONFIG--
$ModuleManifest       = Test-ModuleManifest .\dist\logtastic\logtastic.psd1
$apikey               = "c47b5f976dfaf9275d0bbbb7b671c81b78a70ff0"
$ModuleName           = "LogTastic"
$ProGet_chocInstance  = "https://repo.codedus.tk/nuget/Choco"
$ProGet_nugetInstace  = "https://repo.codedus.tk/nuget/nuget"
$ProGet_PSGalInstance = "https://repo.codedus.tk/nuget/PsCore"
$ProGet_PSGalInstance_name = 'pscore'
# Output FileNames
$nupkgFileName        = "$($ModuleManifest.CompanyName).$($ModuleName).$($ModuleManifest.Version.ToString()).nupkg"
$zipFileName          = "$($ModuleName)"
$ModuleFolderName       = "$($ModuleName)"
$ModuleInfo           = Test-ModuleManifest -path ".\dist\$ModuleName\$ModuleName`.psd1"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# --CONFIG--


# # @ https://stackoverflow.com/questions/35296482/invalid-web-uri-error-on-register-psrepository/35296483#35296483
# !NOTE Extract this function as new install of windows fix this issue
# !NOTE could be related to chcolatey install will test later
# Function Register-PSRepositoryFix {
#     [CmdletBinding()]
#     Param (
#         [Parameter(Mandatory=$true)]
#         [String]
#         $Name,

#         [Parameter(Mandatory=$true)]
#         [Uri]
#         $SourceLocation,

#         [ValidateSet('Trusted', 'Untrusted')]
#         $InstallationPolicy = 'Trusted'
#     )

#     $ErrorActionPreference = 'Stop'

#     Try {
#         Write-Verbose 'Trying to register via ​Register-PSRepository'
#         if(get-repository -Name pscore){
#             write-host "Repository already exists, skipping add"
#         }
#         ​Register-PSRepository -Name $Name -SourceLocation $SourceLocation -InstallationPolicy $InstallationPolicy
#         Write-Verbose 'Registered via Register-PSRepository'
#     } Catch {
#         Write-Verbose 'Register-PSRepository failed, registering via workaround'

#         # Adding PSRepository directly to file
#         Register-PSRepository -name $Name -SourceLocation $env:TEMP -InstallationPolicy $InstallationPolicy
#         $PSRepositoriesXmlPath = "$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\PowerShellGet\PSRepositories.xml"
#         $repos = Import-Clixml -Path $PSRepositoriesXmlPath
#         $repos[$Name].SourceLocation = $SourceLocation.AbsoluteUri
#         $repos[$Name].PublishLocation = (New-Object -TypeName Uri -ArgumentList $SourceLocation, 'package/').AbsoluteUri
#         $repos[$Name].ScriptSourceLocation = ''
#         $repos[$Name].ScriptPublishLocation = ''
#         $repos | Export-Clixml -Path $PSRepositoriesXmlPath

#         # Reloading PSRepository list
#         Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted
#         Write-Verbose 'Registered via workaround'
#     }
# }


# # Push to ProGet Chocolatey
# if($choco = Get-command choco.exe){
#   write-host "Checking if Chocolatey is installed, skipping install"
#   write-host "Pushing to chocolatey: .\dist\$nupkgFileName"
#   choco push ".\dist\$nupkgFileName" --source $ProGet_chocInstance --apikey $apikey
#   write-host "Pushed to chocolatey $nupkgFileName - Complete"
# }else{
#   write-host "Chocolatey is not installed, installing Chocolatey"
#   break;
# }
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# [Net.ServicePointManager]::SecurityProtocol
# $parameters = @{
#   Name = "PowerShellCore"
#   SourceLocation = "https://repo.codedus.tk/nuget/PowerShellCore"
#   InstallationPolicy = 'Trusted'
# }
# # Register-PSRepository @parameters
# Register-PSRepositoryFix -Name "pscore" -SourceLocation "https://repo.codedus.tk/nuget/PsCore/" -InstallationPolicy Trusted




# Push to ProGet Nuget
if(Get-command nuget.exe){
  write-host "Checking if Nuget is installed, skipping install"
  write-host "Pushing to Nuget: .\dist\$nupkgFileName"
  nuget push ".\dist\$nupkgFileName" -source $ProGet_nugetInstace -apikey $apikey
  write-host "Pushed to Nuget $nupkgFileName - Complete"
}else{
  write-host "Nuget is not installed, installing Nuget"
  break;
}
# # Push to ProGet PSGallery
write-host "Pushing to Powershell-Nuget-Proget: .\dist\$zipFileName"

# puish to proget pscore repo 'powershell gallery'
# Publish-Module -Path ".\dist\$zipFileName" -Repository pscore -NuGetApiKey $apikey
publish-Module `
  -path ".\dist\$zipFileName" `
  -Repository $ProGet_PSGalInstance_name `
  -NuGetApiKey $apikey `
  -projecturi $ModuleInfo.ProjectUri `
  -licenseuri $ModuleInfo.LicenseUri `
  -IconUri 'https://gitlab.snowlab.tk/powershell/logtastic/-/raw/main/icon.png' `
  -ReleaseNotes $ModuleInfo.ReleaseNotes `
  -Tags $ModuleInfo.Tags `
  -Verbose
  



