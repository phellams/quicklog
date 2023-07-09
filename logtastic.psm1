using module libs\logtastic_lib.psm1
using module libs\cmdlets\Write-LogTastic.psm1

$logtastic = [logtastic]::new($null)

Function Get-LogTasticModuleInstance() {
    [alias("gltmi")]
    [CmdletBinding()]
    [OutPutType([object])]
    param()
    process{
        return $logtastic
    }
}

Export-ModuleMember -Function Write-LogTastic, Get-LogTasticModuleInstance