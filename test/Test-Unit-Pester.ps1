using module ..\Logtastic.psm1

BeforeAll {
}

Describe "cmdlets" {
  it "Get-LogTasticModuleInstance should be type logtastic" {
    $(Get-LogTasticModuleInstance).GetType().Name | Should -be logtastic
  }

  it "Write-LogTastic | Should return void" {
    $logname = "Logtastic"


    # Default Message with no param given
    Write-LogTastic "Default Message Type=info Message no param switch"
    Write-LogTastic -Message "Default Message Type=info with logname" -Name $logname

    [string[]]$types = "info", "action", "success", "error", "complete"

    # #! Loop through types
    foreach ($type in $types) {
      Write-LogTastic -Message "$type Message" -Name $logname -Type $type | should -be $null
      Write-LogTastic -Message "$type Message Custom unicode" -Name $logname -Type $type -unicode "#1F517" | should -be $null
      Write-LogTastic -Message "$type Message with propture @{pt:{prop=propvalue}}" -Name $logname -Type $type | should -be $null
      Write-LogTastic -Message "$type Message with colortune {ct:blue:blue colored Text}" -Name $logname -Type $type  | should -be $null
      Write-LogTastic -Message "$type SubMessage" -Name $logname -Type $type -SubMessage | should -be $null
      Write-LogTastic -Message "$type Message With No Exection Time" -Name $logname -Type $type -NoExecTime | should -be $null
      Write-LogTastic -Message "$type Message With No Emoji Icon" -Name $logname -Type $type -noLogIcon | should -be $null
      Write-LogTastic -Message "$type Message With No Date/Time Stamp" -Name $logname -Type $type -noDateTime | should -be $null
      Write-LogTastic -Message "$type Message With No Emoji Icon and No Date/Time Stamp" -Name $logname -Type $type -NoDateTime -NoLogIcon | should -be $null
    }
  }
  
  it "New-LogTastic should -be of Type: LogTastic" {
    (New-LogTastic).gettype() | should -be LogTastic
  }

  it "Write-LogTasticProgressc should -be of Type: $Null" {
    Write-LogTasticProgress -barcount 100 `
                            -Percent 36 `
                            -Name 'Logtastic' `
                            -Status "Running" `
                            -SubMessage `
                            -Total "369mb" `
                            -Bandwidth "467.2mb" `
                            -Transferred "863.2gb" `
                            -Eta "8Mins, 12Secs" `
                            -NoDateTime `
                            -NoLogIcon | should -be $Null
  
    Write-LogTasticProgress -BarCount 100 `
                            -Percent 36 `
                            -Name 'Logtastic' `
                            -Status "Running" `
                            -Total "369mb" `
                            -Bandwidth "467.2mb" `
                            -Transferred "863.2gb" `
                            -Eta "8Mins, 12Secs" | should -be $Null
  }
}