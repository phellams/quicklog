LogTastic is a PowerShell Module that outputs styled log message to the console. It is designed to be used in conjunction with other PowerShell modules to provide a consistent look and feel to the console output.

# 🧩 Features
- Enable/Disable log name in log message template
- Enable/Disable time/date in logmessage
- Enable/Disable custom utf-8 Unicode Icon Log name 
- Inject utf-8 Unicode Emoji into log message`{ge:unicode}`
- Inject colored text into log message via `{ct:colorName:text}`
- Inject Property Name And Value into log message via `{pt:{Name=Value}}`
- Switch outputs between parent and sub message types
- Basic Progress Bar
- Custom Progressbar bars with `BarMaster`
- Colors Loaders with `SpinMaster`
  
# 🥽Install LogTastic

To install **LogTastic**, follow these steps:

1. Clone the repository from GitHub.
2. Open a PowerShell session and navigate to the cloned repository directory.
3. Run the installation via the command below:
```powershell
# Import the module
git clone https://gitlab.snowlab.tk/shelltastic/LogTastic.git
cd LogTastic
Import-Module -Name CommitFusion
...
```

### 📦 From Package Repository
*Microsoft.PSGallary*
```Powershell
# Install The Module from the PsGal
Install-Module -Name LogTastic -MinimumVersion 0.1.2

# Import Module into you powershell session
Import-Module -Name LogTastic

# Note! You May Need to change your `ExecutionPolicy`
# Set-ExecutionPolicy
```

*Chololac*

```Powershell
# Install The Module from the PsGal
Install-Module -Name LogTastic -MinimumVersion 0.1.2

# Import Module into you powershell session
Import-Module -Name LogTastic
```
> Installing Chocolate Repository
[How to Install Choloc](https) `choco.com/packages`

#  Using LogTastic

Example #1 - Minimum Parameters
```Powershell
Write-LTMessage -Name 'ql' -Message "My Message String" -Type info -Unicode "#jahfu"
```
♦ OutPut
```Powershell
#Output Here
```


Parameter List `Write-LTMessage `
```powershell
-Name [string] 
-Message [string] 
-Type [string][Action|info|success|complete|error]
-uncicode [string]"#code"
-SubMessage [switch]$true
-NoDatTime [switch]$true
-NoLogIcon [switch]$true
```

## 📑 License
LogTastic is released under the MIT License. See LICENSE for more details.

## 👤 Author
LogTastic is authored and maintained by @sgkens.

