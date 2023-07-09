$sourceName = "GitLab"
$sourceLocation = "https://gitlab.snowlab.tk/api/v4/groups/powershell/packages/nuget"
$nugetProvider = Get-PackageProvider -Name NuGet
$nugetProvider.AddPackageSource($sourceName, $sourceLocation)