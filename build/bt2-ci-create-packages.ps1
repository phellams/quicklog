import-module -name .\

#---CONFIG----------------------------
# Nupkg Powershell Forge
$ModuleName = "nupsforge"

$ModuleManifest = Test-ModuleManifest -path .\dist\$modulename\$modulename.psd1
#---CONFIG----------------------------

# ? Powershell Gallery Description Does not support markdown indenting
# ? But Nuget and Choco Does
$Additional_descriptions = @'
LogTastic is a PowerShell Module that outputs styled log messages to the console. It is designed to be used in conjunction with other PowerShell modules and scripts to provide a consistent look and feel to the console output.

# 🧩 Module Features
🪶 *Enable*/*Disable* log name in log message template, Distinguish between running scripts \
🪶  *Enable*/*Disable* time/date in log message `[🐽-ltm⌚01:43:34]...` \
🪶  *Enable*/*Disable* custom utf-8 Unicode Icon Log name `[🐽-ltm]...` \
🪶  *Inject* utf-8 Unicode Emojis into log messages with `#` > `{ge:#unicode}` \
🪶  *Inject* colored text [***powershell color palet***] into log message with `{ct:colorName:texts}`  \
🪶  *Inject* Property Names And Value into log message via `@{pt:{Name=Value}}`  \
🪶  *Switch* outputs between `Parent` and `SubMessages` types \
🪶  *Ouput* Basic Progress Bars `[########>------------------>(25mb/sec | 6.88% Complete)]` \
🪶  *Ouput* Custom Progress Bars  with [`Tadpol`]() \
🪶  *Output* Colors Loaders with [`Tradel`]()

 ### Examplea - Minimum Parameters
```Powershell
# Import Module
Import-Module -Name LogTastic

# Minimal Params
Write-LTMessage -Name 'LT' -Message "My Message String" -Type info -Unicode "#jahfu"

# All Params
Write-LTMessage -Message "LTM Message with a type:Action" -Name "ltm" -Type Action
# Ouput
PS > '[🐽-ltm⏰01:43:34]🌟❱ LTM Message with a type:Action  a-ex: 0m 0s 71Ms'

# SubMessage
Write-LTMessage -Name 'LT' -Message "My Message String" -Type info -Unicode "#jahfu"
```

### Parameter List `Write-LTMessage`
```powershell
Write-LTMessage
  [[alias -n]-Name [String]] # Optional
  [[alias -m]-Message [String]] # Manditory
  [[alias -t]-Type [String][Action|Info|Success|Complete|Error]] # Optional Default info
  [[alias -uc]-UniCode [String]"#code"] # Optional Default 'ltm' eg. [🐽-ltm⏰00:00:00]🌟❱
  [[alias -sm ]-SubMessage [Switch]]# Default $false adds indentation and removes execution time
  [[alias -ndt]-NoDatTime [Switch]] # Default $false eg. [🐽-ltm]🌟❱
  [[alias -nli]-NoLogIcon [Switch]] # Default $false eg. [ltm]🌟❱
```

## Short hand via alias 
> If you prefer 

```Powershell
# Write-LTMessage info short hand - Custom name and emoji
ltm -m "My Message String" -n ltm -t info -uc "#jahfu" 
# Write-LTMessage info short hand - no log date and no emoji icon
ltm -m "My Message String" -n ltm -t info -uc "#jahfu" -dtd -d
# Write-LTMessage - Minium params
ltm "My Message String" # 
```
'@

# --Config--
$ModuleName = "nupsforge"
$ModuleManifest = Test-ModuleManifest -path .\dist\nupsforge\nupsforge.psd1
# --Config--

if (!(Test-Path -path .\dist\nuget)) { mkdir .\dist\nuget }
if (!(Test-Path -path .\dist\choco)) { mkdir .\dist\choco }
if (!(Test-Path -path .\dist\psgal)) { mkdir .\dist\psgal }

$NuSpecParams = @{
  path              = ".\dist\$ModuleName"
  ModuleName        = $ModuleName
  ModuleVersion     = $ModuleManifest.Version -replace "\.\d+$", "" # remove the extra .0 as semver has 0.0.0 and powershell 0.0.0.0
  Author            = $ModuleManifest.Author
  Description       = $ModuleManifest.Description #$Additional_descriptions -replace '```','```' -replace '\`','``'
  ProjectUrl        = $ModuleManifest.PrivateData.PSData.ProjectUrl
  License           = "MIT"
  company           = $ModuleManifest.CompanyName
  Tags              = $ModuleManifest.Tags
  dependencies      = $ModuleManifest.ExternalModuleDependencies
  LicenseAcceptance = $false
}
# NuGet- Proget/GitlabSE
New-NuspecPackageFile @NuSpecParams
New-VerificationFile -Path .\dist\$modulename  # Output to '\tools\VERIFICATIONS.txt' by default
Start-sleep -Seconds 1 # Wait for file to be created
New-NupkgPackage -path .\dist\$ModuleName  -outpath .\dist\nuget


# Create Zip With .nuspec file for PSGallery
[console]::write( "Creating Zip File for PSGallery `n" )
[console]::write( "Source: .\dist\$ModuleName\* `n" )
[console]::write( "output: .\dist\psgal\$zipFileName `n" )
$zipFileName = "$($NuSpecParams.ModuleName).zip"
compress-archive -path .\dist\$ModuleName\* -destinationpath .\dist\psgal\$zipFileName -compressionlevel optimal -update


# Chocolatey Supports markdown in the description field so create a new nuspec file with additional descriptions in markdown
$NuSpecParamsChoco = @{
  path              = ".\dist\$ModuleName"
  ModuleName        = $ModuleName
  ModuleVersion     = $ModuleManifest.Version -replace "\.\d+$", "" # remove the extra .0 as semver has 0.0.0 and powershell 0.0.0.0
  Author            = $ModuleManifest.Author
  Description       = $Additional_descriptions -replace '```', '```' -replace '\`', '``'
  ProjectUrl        = $ModuleManifest.PrivateData.PSData.ProjectUrl 
  IconUrl           = $ModuleManifest.PrivateData.PSData.IconUrl 
  docsUrl           = $ModuleManifest.PrivateData.PSData.docsUrl 
  projectSourceUrl  = $ModuleManifest.PrivateData.PSData.projectSourceUrl 
  MailingListUrl    = $ModuleManifest.PrivateData.PSData.MailingListUrl 
  bugTrackerUrl     = $ModuleManifest.PrivateData.PSData.BugTrackerUrl 
  LicenseUrl        = $ModuleManifest.PrivateData.PSData.LicenseUrl 
  ReleaseNotes      = $ModuleManifest.PrivateData.PSData.ReleaseNotes
  company           = $ModuleManifest.CompanyName
  Tags              = $ModuleManifest.Tags
  dependencies      = $ModuleManifest.ExternalModuleDependencies
  LicenseAcceptance = $false
}
New-ChocoNuspecFile @NuSpecParamsChoco
New-VerificationFile -Path .\dist\$modulename  # Output to '\tools\VERIFICATIONS.txt' by default
Start-sleep -Seconds 1 # Wait for file to be created
New-ChocoPackage -path .\dist\$ModuleName  -outpath .\dist\choco
