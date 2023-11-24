# Import the required JSON file containing ASCII Extended properties


# Define the PowerASCII class
class PowerAscii {
  static [PsCustomObject]$Codex

  # Constructor to initialize the class
  PowerASCII() {
    [PowerAscii]::Codex = Get-Content -Raw -Path "$PSScriptRoot/acsuii-ec-codex.json" | ConvertFrom-Json
  }

  # Function to print all ASCII Extended characters
  static [PsCustomObject]AsciiCodex() {
    return [PowerAscii]::Codex
  }

  # Function to print all characters of a specific ASCII code range
  static [Void]PrintAll() {
    write-host -foregroundColor gray "|--------------------------------------------------------------------------------|"
    write-host -foregroundColor gray "|-|| CharList |||-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.*|"
    write-host -foregroundColor gray "|--------------------------------------------------------------------------------|"
   [PowerAscii]::AsciiCodex() | ForEach-Object {
      write-host "| Charid " -nonewline; write-host -foregroundColor Magenta "$($_.id)" -NoNewline; write-host " " -nonewline
      write-host "| ecvalue " -nonewline; write-host -foregroundColor Magenta "$($_.char) " -NoNewline;
      write-host "| Description " -nonewline; write-host -foregroundColor Magenta "$($_.description)" -NoNewline;
      write-host ""
    }
  }

  static [String]GetChar($id){
    return [char]([PowerAscii]::AsciiCodex().where({ $_.id -eq $id }).id)
  }

  # Function to output the ASCII Extended data as a formatted string
  static [Void]OutString() {
    [PowerAscii]::Codex.foreach({
      "ID: $($_.id)`nName: $([char]$_.name)`nDescription: $($_.description)`nCode: $($_.code)`necvalue: $([char]$_.ecvalue)`n"
    }) | Out-String
  }
}