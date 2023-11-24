using module ..\NuPSForge\libs\New-NuspecPacakgeFile.psm1
using module ..\NuPSForge\libs\New-NupkgPacakge.psm1

# Powershell Gallery Description Does not support markdown indenting
# ? But Nuget and CHoc Does
$Additional_descriptions = @"
♦- Enable/Disable log name in log message
♦- Enable/Disable time/date in log message
♦- Enable/Disable custom utf-8 Unicode Icon for log name
♦- Add utf-8 Unicode Emoji into log message{ge:unicode}
♦- Add colored text into log message via {ct:colorName:text}
♦- Add Property Name And Value into log message via {pt:{Name=Value}}
♦- Switch outputs between parent message and sub message types
♦- Display Basic Progress bar
♦- Themed Progress bar bars with BarMaster
♦- Themed Loaders with SpinMaster

# Parameters
Module Parameters for the module
```powershell
Write-LTMessage 
[-Name [String]]
-Message [String] 
-Type [String][Action|info|success|complete|error]
-UniCode [String]"#code" 
-SubMessage [Switch ]$true # Default
-NoDatTime [Switch] $true # Default
-NoLogIcon [Switch] $true # Default
```
"@

# --Config--
$ModuleManifest = Test-ModuleManifest -path .\dist\logtastic\logtastic.psd1

$NuSpecParams = @{
  path=".\dist\LogTastic"
  ModuleName = "LogTastic"
  ModuleVersion = $ModuleManifest.Version
  Author = $ModuleManifest.Author
  Description = "$($ModuleManifest.Description)`n`n$Additional_descriptions"
  ProjectUrl = $ModuleManifest.PrivateData.PSData.ProjectUri
  License = "MIT"
  company = $ModuleManifest.CompanyName
  Tags = $ModuleManifest.Tags
  dependencies = $ModuleManifest.ExternalModuleDependencies
}
$NuSpecParamsChoco = @{
  path=".\dist\LogTastic"
  ModuleName = "LogTastic"
  ModuleVersion = $ModuleManifest.Version
  Author = $ModuleManifest.Author
  Description = "$($ModuleManifest.Description)"
  ProjectUrl = $ModuleManifest.PrivateData.PSData.ProjectUri
  License = "MIT"
  company = $ModuleManifest.CompanyName
  Tags = $ModuleManifest.Tags
  dependencies = $ModuleManifest.ExternalModuleDependencies
}
# --Config--

if(!(Test-Path -path .\dist\nuget)){mkdir .\dist\nuget}
if(!(Test-Path -path .\dist\choco)){mkdir .\dist\choco}
if(!(Test-Path -path .\dist\psgal)){mkdir .\dist\psgal}

# Create Zip With .nuspec file for PSGallery
write-host -foregroundColor Yellow "Creating Zip File for PSGallery"
$zipFileName = "$($NuSpecParams.ModuleName).zip"
compress-archive -path '.\dist\logtastic\*' -destinationpath .\dist\psgal\$zipFileName -compressionlevel optimal -update

New-NuspecPacakgeFile @NuSpecParams
Start-sleep -Seconds 1 # Wait for file to be created
New-NupkgPacakge -path .\dist\LogTastic  -outpath .\dist\nuget

# Chocolatey Supports markdown in the description field so create a new nuspec file with additional descriptions in markdown
New-NuspecPacakgeFile @NuSpecParamsChoco
Start-sleep -Seconds 1 # Wait for file to be created
New-NupkgPacakge -path .\dist\LogTastic  -outpath .\dist\choco


