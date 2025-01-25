#---CONFIG----------------------------

# ModuleName
$moduleName  = "quicklog"
$Files       = "quicklog.psm1", "quicklog.psd1", "LICENSE", "icon.png", "readme.md"
$folders     = "libs"
$exclude     = "Issue#1.txt"

#find-Module -Repository powershell -Name 'commitfusion' -MinimumVersion $psmpacker_v | Install-module | Import-Module
#---CONFIG----------------------------


# if (Get-Module -ListAvailable -name 'psmpacker' | Where-Object { $_.version -eq "$psmpacker_v.0" }) {
#     install-module -name psmpacker -repository powershell -MinimumVersion 0.1.5
# }
# import-module -name psmpacker -MinimumVersion $psmpacker_v

$AutoVersion = (Get-GitAutoVersion).Version

Build-Module -SourcePath .\ `
             -DestinationPath .\dist `
             -Name $moduleName  `
             -IncrementVersion None `
             -FilesToCopy $Files `
             -ExcludedFiles $exclude `
             -FoldersToCopy $folders `
             -Manifest `
             -Version $AutoVersion