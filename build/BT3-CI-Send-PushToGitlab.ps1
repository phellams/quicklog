$ModuleManifest = Test-ModuleManifest -path .\dist\logtastic\logtastic.psd1
$modulename = "logtastic"
$GITLAB_NUGET_PROJECT_TOKEN = 'QuKeQXyos8vHSpGzT6rE'
$GitLab_Username = "sgkens"
$gitlab_Group = "powershell"
$gitlab_uri = "https://gitlab.lab.davilion.online"

try {
  dotnet nuget remove source gitlab
  dotnet nuget add source $gitlab_uri/api/v4/projects/128/packages/nuget/index.json --name gitlab --username $GitLab_Username --password $GITLAB_NUGET_PROJECT_TOKEN
}
catch {
  Write-Host "Failed to push to gitlab"
  Write-Host $_
}
try {
  dotnet nuget push .\dist\nuget\$($ModuleManifest.CompanyName).$modulename.$($ModuleManifest.Version).nupkg --source gitlab
  dotnet nuget remove source gitlab
}
catch {
  Write-Host "Failed to push to gitlab"
  Write-Host $_
}