$ModuleManifest = Test-ModuleManifest .\dist\logtastic\logtastic.psd1
if(Get-command choco.exe){
  write-host "Chocolatey is installed, skipping install"
  write-host "Pushing to chocolatey"
  choco.exe push .\dist\logtastic.$($ModuleManifest.Version).nupkg --source https://community.chocolatey.org/
  write-host "Pushed to chocolatey - Complete"
}else{
  write-host "Chocolatey is not installed, installing Chocolatey"
  break;
}