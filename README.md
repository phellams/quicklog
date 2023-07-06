LogTastic is a PowerShell Module that outputs styled log message to the console. It is designed to be used in conjunction with other PowerShell modules to provide a consistent look and feel to the console output.

# 🧩 Features
 🪶 *Enable*/*Disable* log name in log message template, Distinguish between running scripts 
 
 🪶  *Enable*/*Disable* time/date in log message `[🐽-ltm⌚01:43:34]...`

 🪶  *Enable*/*Disable* custom utf-8 Unicode Icon Log name `[🐽-ltm]...`

 🪶  *Inject* utf-8 Unicode Emojis into log messages with `#` > `{ge:#unicode}`

 🪶  *Inject* colored text into log message with `{ct:colorName:texttocolor}`

 🪶  *Inject* Property Names And Value into log message via `{pt:{Name=Value}}` 

 🪶  *Switch* outputs between `Parent` and `SubMessage` types

 🪶  *Ouput* Basic Progress Bars `[|--------------------------->(Speed|PercentComplete)]`

 🪶  *Ouput* Custom Progress Bars  with [`Shelltastic.BarMaster`]()

 🪶  *Output* Colors Loaders with [`Shelltastic.SpinMaster`]()
  
# 🥽Install LogTastic

To install **LogTastic**, follow these steps:

🔹 Clone the repository from GitHub.
🔹 Open a PowerShell session and navigate to the cloned repository directory.
🔹 Run the installation via the command below:
```powershell
# Import the module
git clone https://gitlab.snowlab.tk/shelltastic/LogTastic.git
cd LogTastic
Import-Module -Name logtastic
```
# 📦Package Repository
 🌐 From - *Powershell: PSGallary* -📦[psgallary.com/sgkens/shelltastic.LogTastic]()
```Powershell
# Install The Module from the PsGal
Install-Module -Name logtastic

# Import Module into you powershell session
Import-Module -Name logtastic

# Note! You May Need to change your `ExecutionPolicy`
# Set-ExecutionPolicy
```
🌐 From - *Choco: Chocolatory.org* - 📦[Chocolatory.org/sgkens/shelltastic.LogTastic]()
```Powershell
# Install The Module from the PsGal
choco install logtastic --version 0.1.0

# Import Module into you powershell session
Import-Module -Name logtastic
```




> Installing Chocolate Package Repositoy
[How to Install Choloc](https) `choco.com/packages`

# 🔧Using Module

Example #1 - Minimum Parameters
```Powershell
# Import Module
Import-Module -Name LogTastic

# Minimal Params
Write-LTMessage -Name 'LT' -Message "My Message String" -Type info -Unicode "#jahfu"

# All Params
Write-LTMessage -Message "LTM Message with a type:Action" -Name "ltm" -Type Action
# Ouput
PS > '[🐽-ltm⏰01:43:34]🌟❱ LTM Message with a type:Action  a-ex: 0m 0s 71Ms'

# SubMessage
Write-LTMessage -Name 'LT' -Message "My Message String" -Type info -Unicode "#jahfu"
```
♦ OutPut
```Powershell
#Output Here
```


### Parameter List `Write-LTMessage `
```powershell
Write-LTMessage
  [-Name [String]] # Optional
  [-Message [String]] # Manditory
  [-Type [String][Action|Info|Success|Complete|Error]] # Optional Default info
  [-UniCode [String]"#code"] # Optional Default Logtastic
  [-SubMessage [Switch ]$true] # Default
  [-NoDatTime [Switch] $true] # Default
  [-NoLogIcon [Switch] $true] # Default
```

##  License & Author
📑 **LogTastic** is released under the **MIT License**. See [LICENSE]() for more details.

👤 Authored and maintained by *G K. Snow* @sgkens. 




## 📌 CHANGELOG 