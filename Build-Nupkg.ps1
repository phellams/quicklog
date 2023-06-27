using module ..\NuPSForge\libs\New-NuspecPacakgeFile.psm1
using module ..\NuPSForge\libs\New-NupkgPacakge.psm1


$ModuleManifest = Test-ModuleManifest -path .\dist\logtastic\logtastic.psd1

$NuSpecParams = @{
  path=".\dist\LogTastic"
  ModuleName = "LogTastic"
  ModuleVersion = $ModuleManifest.Version
  Author = $ModuleManifest.Author
  Description = $ModuleManifest.Description
  ProjectUrl = $ModuleManifest.PrivateData.PSData.ProjectUri
  License = "MIT"
  company = $ModuleManifest.CompanyName
  Tags = $ModuleManifest.Tags
  dependencies = $ModuleManifest.ExternalModuleDependencies
}

New-NuspecPacakgeFile @NuSpecParams
Start-sleep -Seconds 3
New-NupkgPacakge -path .\dist\LogTastic  -outpath .\dist


