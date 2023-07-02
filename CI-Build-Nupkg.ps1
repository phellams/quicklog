using module ..\NuPSForge\libs\New-NuspecPacakgeFile.psm1
using module ..\NuPSForge\libs\New-NupkgPacakge.psm1


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


