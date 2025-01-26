<# Commit Fusion template file use to create large detailed commits #>
$Params = @{
  Type  = "changes";
  Scope = "module";
  Description  = "name, theme access, theme mappings and ascii char set";
  Notes = @(
    'UPDATE: `themes-utf8-it.json` updated with new icons.',
    'ADD: `$global` variable for QuickLog module instance.',
    'UPDATE: Root module and manifest updated to reflect module name and theme access.',
    'MOVED: Themes into `libs/themes` folder.',
    'CHANGE: Class variables changed to camelCase.',
    'UPDATE: Theme mappings and methods now return theme properties and icons.',
    'ADD: Support for multi-theme functionality and custom themes (WIP - Incomplete, partially working).',
    'UPDATE: Added and updated theme elements. New method for auto-coloring element parts based on theme properties. Future expansion planned for colorizer support (RGB, Hex, Gradient color generation).',
    'UPDATE: `Get-Elapsed` logic fixed to properly calculate execution time.'
  );
  FeatureNotes = @(
    'Log output is now much cleaner and uses ASCII as the default theme type, with the advanced ASCII character set.',
    'Execution time now displays the correct duration between log outputs.',
    'Theme is now configurable from a JSON file (`libs/themes/theme-ascii-lt.json` is the default).',
    'Time and date in log messages can be enabled/disabled, are themable with icons and color, and output can switch between 12-hour or 24-hour clock formats.'
  );
  Footer = $true
  GitUser = "sgkens";
  GitGroup = "phallems";
  # FeatureAdditions = @(
  # );
  #BugFixes = @();
  BreakingChanges = @(
    'RENAMED: repository name from `logtastic` to `Quicklog`',
    'RENAMED: `Write-LogTastic` to `Write-Quicklog`'
    'RENAMED: `Get-LogTasticTypes` to `Get-QuicklogTypes`'
    'RENAMED: `Get-LogTasticModuleInstance` to `Get-QuicklogModuleInstance`',
    'RENAMED: `Get-LogTasticModuleInstance` to `Get-QuicklogModuleInstance`',
    'RENAMED: `New-LogTastic` to `New-Quicklog`',
    'REMOVED: `Get-QuicklogModuleInstance used `$global:_quicklog.Instance`',
    'REMOVED: param `-unicode` replaced with icon'
  );
  #FeatureNotes = @();
  #AsString = $true #Default is $true
}

# ACTIONS
# -------

# ConventionalCommit with params sent commit
New-Commit @Params
