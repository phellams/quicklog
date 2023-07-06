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
"@

# --Config--
$ModuleManifest = Test-ModuleManifest -path .\dist\logtastic\logtastic.psd1

$NuSpecParams = @{
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


New-NuspecPacakgeFile @NuSpecParams
Start-sleep -Seconds 3 # Wait for file to be created
New-NupkgPacakge -path .\dist\LogTastic  -outpath .\dist

# Create Zip With .nuspec file for PSGallery
$zipFileName = "$($NuSpecParams.ModuleName).$($ModuleManifest.Version.ToString()).zip"
compress-archive -path .\dist\logtastic -destinationpath .\dist\$zipFileName -compressionlevel optimal


