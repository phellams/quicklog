<#
  Commit Fusion template file
  use to create large detailed commits
#>
$Params = @{
  Type  = "improve";
  Scope = "class-lib";
  Description = "improved module(class/cmdlets) logic";
  Notes = @(
    "Updated WriteLog method to construct a string and use [console]::write to output the final string to the console",
    "Updated PeropTune to use regex to parse $logtasitc.message, corrected output to console",
    "Updated colortune to ouput colors correctly, added support for powershell 5.x",
    "Added pester unit test to test class logic via cmdlet",
    "Added Gitlab Ci config",
    "Added CI build scripts",
    "Added Coverails intergrated, configured pester to eeoutput converage report via JaCoCo"
    );
  FeatureNotes = @(
    "Supports color in message body via ColorTune: {ct:blue:my text}",
    "Supports color in message body via PropTune: @{pt:{Property=Value}}",
    "4 cmdlets are provided to interact with logtastic, Get-LogTasticModuleInstance, New-LogTastic, Write-LogTastic, and Write-LogTasticProgress"
  )
  #Footer = "";
  GitUser = "sgkens";
  GitGroup = "powershell";
  # FeatureAddtions = @(
  #   "Exposes all methods and properties of the Table and Rule class"
  #   "``New-Object Spectre.Console.Table`` and ``New-Object Spectre.Console.Rule``"
  # );
  #BugFixes = @();
  #BreakingChanges = @();
  #FeatureNotes = @();
  #AsString = $true #Default is $true
}

# ACTIONS
# -------

# ConventionalCommit with params sent commit
New-ConventionalCommit @Params

# ConventionalCommit with params sent commit
#New-ConventionalCommit @Params | Set-Commit

# ConventionalCommit with params, written to changelog and sent commit
#New-ConventionalCommit @Params | Format-FusionMD | Update-ChangeLog -logfile .\changelog.md | Set-Commit