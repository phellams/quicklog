using module ..\PSMPacker\libs\Build-Module.psm1
Build-Module -SourcePath .\ `
             -DestinationPath .\dist `
             -Name "LogTastic" `
             -IncrementVersion None `
             -FilesToCopy "logtastic.psm1","logtastic.psd1","LICENSE","icon.png" `
             -ExcludedFiles "New-NerdIcon.ps1" `
             -FoldersToCopy "libs" `
             -Manifest `
             -Version 0.1.0 