BeforeAll { import-module .\quicklog.psm1 }

Describe "cmdlets" {

  # it "Get-QuicklogModuleInstance should be type Quicklog" {
  #   $(Get-QuicklogModuleInstance).GetType().Name | Should -be Quicklog
  # }

  it "Write-Quicklog | Should return void" {
    $logname = "Ql"
    # Default Message with no param given
    Write-Quicklog "Default Message {cs:yellow:Type=info} Message no param switch" | should -be $null
    Write-Quicklog -Message "Default Message {cs:yellow:Type=info} with logname" -Name $logname | should -be $null

    [string[]]$types = "info", "action", "success", "error", "complete", "response", "request", "download", "upload", "read", "write"

    # #! Loop through types
    foreach ($type in $types) {
      start-sleep -milliseconds 1000
      Write-Quicklog -Message "$type Message" -Name $logname -Type $type | should -be $null
      Write-Quicklog -Message "$type Message Custom unicode" -Name $logname -Type $type -icon "default-icon" | should -be $null
      Write-Quicklog -Message "$type Message @{pt:{prop=propvalue}} with propture @{pt:{prop=propvalue}}" -Name $logname -Type $type | should -be $null
      Write-Quicklog -Message "$type Message with colortune {cs:blue:blue colored Text}" -Name $logname -Type $type  | should -be $null
      Write-Quicklog -Message "$type SubMessage" -Name $logname -Type $type -SubMessage | should -be $null
      Write-Quicklog -Message "$type Message With No Exection Time" -Name $logname -Type $type -NoExecTime | should -be $null
      Write-Quicklog -Message "$type Message With No Emoji Icon" -Name $logname -Type $type -noLogIcon | should -be $null
      Write-Quicklog -Message "$type Message With No Date/Time Stamp" -Name $logname -Type $type -noDateTime | should -be $null
      Write-Quicklog -Message "$type Message With No Emoji Icon and No Date/Time Stamp" -Name $logname -Type $type -NoDateTime -NoLogIcon -NoExecTime | should -be $null
    }
  }
  
  it "New-Quicklog should -be of Type: Quicklog" {
    (New-Quicklog).gettype().name | should -be Quicklog
  }

  it "Get-LogType should -be of Type: Object[]" {
    (Get-QuicklogTypes).gettype().name | should -be Object[]
  }

  it "Write-QuicklogProgressc should -be of Type: $`Null" {
    Write-QuicklogProgress -barcount 100 `
                           -Percent 36 `
                           -Name 'Quicklog' `
                           -Status "Running" `
                           -SubMessage `
                           -Total "369mb" `
                           -Bandwidth "467.2mb" `
                           -Transferred "863.2gb" `
                           -Eta "8Mins, 12Secs" `
                           -NoDateTime `
                           -NoLogIcon | should -be  $Null
  
    Write-QuicklogProgress  -BarCount 100 `
                            -Percent 36 `
                            -Name 'Quicklog' `
                            -Status "Running" `
                            -Total "369mb" `
                            -Bandwidth "467.2mb" `
                            -Transferred "863.2gb" `
                            -Eta "8Mins, 12Secs" | should -be $Null
    Write-QuicklogProgress  -BarCount 100 `
                            -Percent 92 `
                            -Name 'Quicklog' `
                            -Status "Running" `
                            -Total "369mb" `
                            -Bandwidth "467.2mb" `
                            -Transferred "863.2gb" `
                            -Eta "8Mins, 12Secs" | should -be $Null

    Write-QuicklogProgress  -BarCount 100 `
                            -Percent 0 `
                            -Name 'Quicklog' `
                            -Status "Running" `
                            -Total "369mb" `
                            -Bandwidth "467.2mb" `
                            -Transferred "863.2gb" `
                            -Eta "8Mins, 12Secs" | should -be $Null

    Write-QuicklogProgress  -BarCount 100 `
                            -Percent 100 `
                            -Name 'Quicklog' `
                            -Status "Running" `
                            -Total "369mb" `
                            -Bandwidth "467.2mb" `
                            -Transferred "863.2gb" `
                            -Eta "8Mins, 12Secs" | should -be $Null
  }
}
