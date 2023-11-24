# --CONFIG--
$apikey               = "c47b5f976dfaf9275d0bbbb7b671c81b78a70ff0"
$ModuleName           = "logtastic"
$ProGet_chocInstance  = "https://proget.lab.davilion.online.tk/nuget/Choco"
$ProGet_nugetInstace  = "https://proget.lab.davilion.online.tk/nuget/nuget"
$ProGet_PSGalInstance = 'proget_local_instance'
$ModuleInfo           = Test-ModuleManifest -path ".\dist\$ModuleName\$ModuleName`.psd1"
$semver               = $ModuleInfo.version.Major.ToString() + "." + $ModuleInfo.version.Minor.ToString() + "." + $ModuleInfo.version.Build.ToString()
# Output FileNames
$nupkgFileName        = "$($ModuleInfo.CompanyName).$($ModuleName).$semver.nupkg"
$zipFileName          = "$($ModuleName).zip"

# Force Tls12
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if($ModuleInfo){

  # Push to ProGet Chocolatey
  if(Get-command choco){
    write-host "Checking if Chocolatey is installed, skipping install"
    write-host "Pushing to chocolatey: .\dist\choco\$nupkgFileName"
    choco push ".\dist\choco\$nupkgFileName" --source $ProGet_chocInstance --apikey $apikey
    write-host "Pushed to chocolatey $nupkgFileName - Complete"
  }
  else{
    write-host "Chocolatey is not installed, installing Chocolatey"
    break;
  }

  # Push to ProGet Nuget
  if(Get-command nuget.exe){
    write-host "Checking if Nuget is installed, skipping install"
    write-host "Pushing to Nuget: .\dist\nuget\$nupkgFileName"
    nuget push ".\dist\nuget\$nupkgFileName" -source $ProGet_nugetInstace -apikey $apikey
    write-host "Pushed to Nuget $nupkgFileName - Complete"
  }
  else{
    write-host "Nuget is not installed, installing Nuget"
    break;
  }
  # # Push to ProGet PSGallery
  write-host "Pushing to Powershell-Nuget-Proget: .\dist\psgal\$zipFileName"

  # puish to proget pscore repo 'powershell gallery'
  # Publish-Module -Path ".\dist\$zipFileName" -Repository pscore -NuGetApiKey $apikey
  Register-PSRepository -name "proget_local_instance" -SourceLocation "https://proget.lab.davilion.online.tk/pscore" -InstallationPolicy Trusted
  publish-Module `
    -path ".\dist\$ModuleName" `
    -Repository $ProGet_PSGalInstance `
    -NuGetApiKey $apikey `
    -projecturi $ModuleInfo.ProjectUri `
    -licenseuri $ModuleInfo.LicenseUri `
    -IconUri 'https://gitlab.snowlab.tk/sgkens/resources/-/blob/raw/modules/CommitFusion/dist/v1/ccommits-logo_GitIcon_51.20dpi.png' `
    -ReleaseNotes $ModuleInfo.ReleaseNotes `
    -Tags $ModuleInfo.Tags `
    -Verbose
  Unregister-PSRepository -Name proget_local_instance
}



