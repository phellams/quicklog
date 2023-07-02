# powershell function template 
#
Function Get-ColorTune(){
    [CmdletBinding()]
    param(
        [parameter(mandatory=$true)]
        [string]$text,
        [parameter(mandatory=$false)]
        [ValidateSet(
            "blue",
            "yellow",
            "green",
            "red",
            "white",
            "black",
            "cyan",
            "magenta",
            "gray",
            "darkgray",
            "darkblue",
            "darkyellow",
            "darkgreen",
            "darkred",
            "darkcyan",
            "darkmagenta", ignorecase =$true)]
        $color = "white"
    )
    process{
        switch($color){
            "blue" { return "`e[34m$text`e[0m"}
            "yellow" { return "`e[33m$text`e[0m"}
            "green" { return "`e[32m$text`e[0m"}
            "red" { return "`e[31m$text`e[0m"}
            "white" { return "`e[37m$text`e[0m"}
            "black" { return "`e[30m$text`e[0m"}
            "cyan" { return "`e[36m$text`e[0m"}
            "magenta" { return "`e[35m$text`e[0m"}
            "gray" { return "`e[90m$text`e[0m"}
            "darkgray" { return "`e[90m$text`e[0m"}
            "darkblue" { return "`e[34m$text`e[0m"}
            "darkyellow" { return "`e[33m$text`e[0m"}
            "darkgreen" { return "`e[32m$text`e[0m"}
            "darkred" { return "`e[31m$text`e[0m"}
            "darkcyan" { return "`e[36m$text`e[0m"}
            "darkmagenta" { return "`ee[35m$text`e[0m"}
            default { return "`e[37m$text`e[0m"}
        }
    }
}
