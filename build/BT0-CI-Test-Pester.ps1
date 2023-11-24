# Pester Configration settings
# _----------------------------_
# ------------------------------
# Invoke-Pester -CodeCoverage .\libs\*.psm1 -CodeCoverageOutputFile 'Coverage.xml' -CodeCoverageOutputFileFormat JaCoCo -script .\BT0-CI-Test-Pester.ps1 -PassThru
$pesterConfig = New-PesterConfiguration -hashtable @{
    CodeCoverage = @{ Enabled = $true;
                      OutputFormat = 'JaCoCo';
                      OutputPath = 'coverage.xml'
                      OutputEncoding = 'utf8'
                      CoveragePercentTarget = 100;
                      path = @('.\libs\sm\*.psm1','.\libs\cmdlets\*.psm1','.\libs\logtastic_lib.psm1')
                    }
    Run         = @{
                      #PassThru = $true
                      #scriptblock = {'.\test\Test-Unit-Pester.ps1'}
                      Path = '..\test\Test-Unit-Pester.ps1'
                    }
    }
Invoke-Pester -Configuration $pesterConfig