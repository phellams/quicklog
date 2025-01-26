---
layout: default
---

**LogTastic** outputs styled log messages to the console. It is designed to be used in conjunction with other PowerShell modules and scripts to provide a consistent look and feel to the console output. LogTastic  uses ```system.console.write``` instead of `Write-Host` to output log string to the console.

## 💠 Module Features

- **Enable**/**Disable** log name in log message template, Distinguish between running scripts
- **Enable**/**Disable** time/date in log message `[🍥-logt⏰01:40:52]...`.
- **Enable**/**Disable** custom utf-8 Unicode Icon Log name `[🍥-logt]...`.
- **Add** utf-8 Unicode Emojis into log messages with `#` > `{ge:#unicode}`.
- **Add** colored text [***powershell color palet***] into log message with `{ct:colorName:texts}`.
- **Add** property names And value into log message via `@{pt:{Name=Value}}`
- **Switch** outputs between `Parent` and `SubMessage` types.
- **Ouput** basic progress bars `[########>------------------>(25mb/sec | 6.88% Complete)]`, for cuztomizable bars and loaders you can use [`Tadpol`](https://github.com/sgkens/tadpol).

### 📥 Clone source

1. Clone the repository from **GitHub** `git clone https://github.com/sgkens/logtastic.git`
2. Open a ***PowerShell*** session and navigate to the cloned repository directory.
3. **Run** the *Module Import* via the command below:

    ```powershell
    # Import the module
    git clone https://github.com/sgkens/logtastic.git
    cd logtastic
    import-module -Name logtastic

    # Get version
    get-module -name logtastic | select-object name,version

    # Check imported module functions
    get-module -Name logtastic | select-object -expand exportedfunctions
    get-module -Name logtastic | select-object version
    ```

### 💼 Releases

Download the latest release from the [**Releases**](https://github.com/sgkens/logtastic/releases) page.

### 💼 Release

```powershell
# Import the module
git clone https://gitlab.snowlab.tk/shelltastic/LogTastic.git
cd LogTastic
Import-Module -Name logtastic
```

## 🐥 Using the Module

#### 🔹`Write-LogTastic`

Used to write logmessages to the console.

```powershell
Write-LogTastic [-Message] '<message>' [[-Type] '<type>']
                [-Name '<name>'] [-Unicode '<unicode>'] 
                [-SubMessage] [-NoDateTime] [-NoLogIcon] 
                [-NoExectime] [-NoEmoji]
```

```powershell
# Minimal Params Default type=info
Write-LogTastic -Message "My Message String" 
# Output
[🍥-logt⏰01:41:41]📝❯ My Message String 🔸 ⏱ ex: 0m 1s 0ms

# ------

# Log Message with property in body specify color
Write-LogTastic -Message "My {ct:red:Custom Text} @{pt:{Message=String}}" -Type Info -Name customname -Unicode "#2795"
# Ouput
[➕-customname⏰02:02:47]📝❯ My Custom Text ○-Message:String 🔸 ⏱ ex: 0m 1s 0ms

# -----
# SubMessage with specified emoji
Write-LogTastic -Name 'LT' -Message "My Message String" -Type info -Unicode "#1F433" -SubMessage
# Output
[🐳-LT⏰02:00:44]     ↪ My Message String
```

#### 🔹`New-LogTastic`

Returns a new instance of the logtastic class.

```powershell
# using logtastic class 
# -> Generate Log Message
$LogTastic = New-LogTastic
$LogTastic.Theme = 'utfe' # default(utfe) avail: acsii(WIP), NerdF(WIP)
$LogTastic.noemoji = $true # disable emojis and ouput (Get-LogTypes).logName
$logTastic.Name = 'logt'
$logTastic.enablelogdate()
$logTastic.disablelogdate()
$logTastic.unicode = # utfcode
$logTastic.disableLogIcon()
$logTastic.EnableLogIcon()
$logTastic.EnableExTime()
$logTastic.DisableExTime()
$logTastic.GenerateLog(
    "MyMessage @{pt:{prop=in message {ct:red:this is colored red}}",
    "info", # 'Error', 'Success', 'Info', 'Complete', 'Action','response','request','upload','download','read','write'
    $false # $true for submessage
)
$logTastic.WriteLog()

# ----

# -> Generate Log Message
$logtastic.GenerateProgress(@{
    barcount = 60
    percent = 80
    status = "Running"
    submessage = $false
    total = 100 
    bandwidth = "1.2mb"
    transfered = "86.2mb"
    eta = ""
})
$logtastic.WriteProgress()

```

#### 🔹`Get-LogTypes`

Return a list of LogTypes as `system.object[]` **array**.

```powershell
Get-LogTypes

# Output
id       name     logname emoji
--       ----     ------- -----
Error    Error    ERR     ⭕
Success  Success  SUC     🟢
Info     Info     INF     📝
Complete Complete COM     ✅
Action   Action   ACT     🧿
response response RES     🌎
request  request  REQ     🌐
upload   upload   UPL     ⏫
download download DOW     ⏬
```

#### 🔹`New-LogTasticProGressBar`

Ouputs a custom progress bar.

```powershell
Write-LogTasticProgress [-Barcount(Manditory) '<[int]count>']
                        [-Percent(Manditory) '<[int]percentComplete>']
                        [-Total(Manditory) '[int]<Total>'] 
                        [-Name '<[string]Name>'] 
                        [-Status '<secondsRemaining>'] 
                        [-Submessage '<currentOperation>'] 
                        [-Bandwidth '<[string]Bandwidth>'] 
                        [-Transferred '<[string]Transferred>']
                        [-Eta '<[string]EstimatedTime>']
                        [-NoDateTime '<switch|bool>']
                        [-NoLogIcon '<switch|bool>']

```

```powershell
```

#### 🔹`Get-LogTasticModuleInstance`

Returns Module instance of logtastic used by other cmdlets.

```powershell
(Get-LogTasticModuleInstance).GenerateLog(...
(Get-LogTasticModuleInstance).WriteLog()
```




Text can be **bold**, _italic_, or ~~strikethrough~~.

[Link to another page](./another-page.html).

There should be whitespace between paragraphs.

There should be whitespace between paragraphs. We recommend including a README, or a file with information about your project.

# Header 1

This is a normal paragraph following a header. GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere.

## Header 2

> This is a blockquote following a header.
>
> When something is important enough, you do it even if the odds are not in your favor.

### Header 3

```js
// Javascript code with syntax highlighting.
var fun = function lang(l) {
  dateformat.i18n = require('./lang/' + l)
  return true;
}
```

```ruby
# Ruby code with syntax highlighting
GitHubPages::Dependencies.gems.each do |gem, version|
  s.add_dependency(gem, "= #{version}")
end
```

#### Header 4

*   This is an unordered list following a header.
*   This is an unordered list following a header.
*   This is an unordered list following a header.

##### Header 5

1.  This is an ordered list following a header.
2.  This is an ordered list following a header.
3.  This is an ordered list following a header.

###### Header 6

| head1        | head two          | three |
|:-------------|:------------------|:------|
| ok           | good swedish fish | nice  |
| out of stock | good and plenty   | nice  |
| ok           | good `oreos`      | hmm   |
| ok           | good `zoute` drop | yumm  |

### There's a horizontal rule below this.

* * *

### Here is an unordered list:

*   Item foo
*   Item bar
*   Item baz
*   Item zip

### And an ordered list:

1.  Item one
1.  Item two
1.  Item three
1.  Item four

### And a nested list:

- level 1 item
  - level 2 item
  - level 2 item
    - level 3 item
    - level 3 item
- level 1 item
  - level 2 item
  - level 2 item
  - level 2 item
- level 1 item
  - level 2 item
  - level 2 item
- level 1 item

### Small image

![Octocat](https://github.githubassets.com/images/icons/emoji/octocat.png)

### Large image

![Branching](https://guides.github.com/activities/hello-world/branching.png)


### Definition lists can be used with HTML syntax.

<dl>
<dt>Name</dt>
<dd>Godzilla</dd>
<dt>Born</dt>
<dd>1952</dd>
<dt>Birthplace</dt>
<dd>Japan</dd>
<dt>Color</dt>
<dd>Green</dd>
</dl>

```
Long, single-line code blocks should not wrap. They should horizontally scroll if they are too long. This line should be long enough to demonstrate this.
```

```
The final element.
```
