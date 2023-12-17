using module libs\logtastic_lib.psm1
using module libs\cmdlets\Get-LogTasticModuleInstance.psm1
using module libs\cmdlets\New-LogTastic.psm1
using module libs\cmdlets\Write-LogTastic.psm1
using module libs\cmdlets\Write-LogTasticProgress.psm1

Export-ModuleMember -Function Write-LogTastic, `
                              Get-LogTasticModuleInstance, `
                              Write-LogTasticProgress, `
                              New-LogTastic
<# ----------------------------------------o
& CLASSNAME: [logtastic]
~ VERSION: 0.1.0
- AUTHOR: Snoonx @ SimpleScripts.dev
- LICENSE: MIT   
* DESCRIPTION:   
    LogTastic is a PowerShell Module that outputs styled log message to the console. 
    It is designed to be used in conjunction with other PowerShell modules to provide 
    a consistent look and feel to the console output.
  
? DEPENDANCIES:
    • Get-Elapsed
    • Get-Proptune
    • Get-ColorTune 
    • PowerUnicode 
? NOTES
    This class is still in development and is not ready for production use.
    @Colorful comments vscode url: 
        - #? https://marketplace.visualstudio.com/items?itemName=bierner.colorful-comments
    BUILD ENV
        Powershellcore 7.3.1
----------------------------------------o #>