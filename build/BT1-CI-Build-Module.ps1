if (Get-Module -ListAvailable -name psmpacker | Where-Object { $_.version -eq "0.1.5.0" }) {
    install-module -name psmpacker -repository powershell -MinimumVersion 0.1.5
}
import-module -name psmpacker -MinimumVersion 0.1.5

$AutoVersion = (Get-GitAutoVersion).Version

Remove-Item -Path .\dist\CommitFusion -Recurse -Force -ErrorAction SilentlyContinue

Build-Module -SourcePath .\ `
             -DestinationPath .\dist `
             -Name "logtastic" `
             -IncrementVersion None `
             -FilesToCopy "logtastic.psm1","logtastic.psd1","LICENSE","icon.png" `
             -ExcludedFiles "New-NerdIcon.ps1" `
             -FoldersToCopy "libs" `
             -Manifest `
             -Version $AutoVersion