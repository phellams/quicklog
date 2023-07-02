$ModuleManifest = Test-ModuleManifest -path .\dist\logtastic\logtastic.psd1

$GitLab_Username = "sgkens"
$gitlab_Group = "powershell"
$gitlab_uri = "https://gitlab.snowlab.tk"
$token = "QuKeQXyos8vHSpGzT6rE"

try{
  dotnet nuget add source $gitlab_uri/api/v4/projects/128/packages/nuget/index.json --name gitlab --username $GitLab_Username --password $token
  dotnet nuget add source $gitlab_uri/api/v4/projects/128/packages/nuget/index.json --name gitlab --username $GitLab_Username --password $token
}catch{
  Write-Host "Failed to push to gitlab"
  Write-Host $_
}
try{
    dotnet nuget push .\dist\$($ModuleManifest.CompanyName).logtastic.$($ModuleManifest.Version).nupkg --source gitlab
    dotnet nuget push .\dist\$($ModuleManifest.CompanyName).logtastic.$($ModuleManifest.Version).nupkg --source gitlab
}
catch{
    Write-Host "Failed to push to gitlab"
    Write-Host $_
}