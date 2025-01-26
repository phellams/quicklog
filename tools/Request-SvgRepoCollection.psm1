<#
.SYNOPSIS
    Downloads a collection of SVG icons from SVGRepo.

.DESCRIPTION
    The Request-SvgRepoCollection cmdlet downloads SVG icons from the SVGRepo website for a given collection name.
    It supports downloading multiple pages of icons within a collection and caches the downloaded icons to minimize redundant HTTP requests.

.PARAMETER CollectionName
    The name of the collection from SVGRepo to download.

.PARAMETER OutFolder
    Optional. The output folder where the collection will be saved.
    Defaults to the current execution path if not specified.

.EXAMPLE
    Request-SvgRepoCollection -CollectionName "free-hand-drawn" -OutFolder "C:\Icons"

.NOTES
    This cmdlet parses HTML from SVGRepo using HtmlAgilityPack or PowerHTML to extract the SVG icons' URLs and downloads them.
#>

Add-Type -Path '..\HtmlAgilityPack.1.11.67\lib\NetCore45\HtmlAgilityPack.dll'

function Request-SvgRepoCollection {
    [CmdletBinding()]
    [OutputType([void])]
    [Alias('svgrepo')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$CollectionName,

        [Parameter(Mandatory = $false)]
        [string]$OutFolder = (Get-Location).Path
    )

    # Create cache file path
    $cachePath = "$env:USERPROFILE\Documents\_SvgRepoCollectionCache.json"
    
    # Initialize cache if not exists
    if (-not (Test-Path $cachePath)) {
        New-Item -Path $cachePath -ItemType File -Force | Out-Null
        $cache = @()
    }
    else {
        $cacheContent = Get-Content -Path $cachePath
        if ($cacheContent -eq "") {
            $cache = @()
        }
        else {
            $cache = $cacheContent | ConvertFrom-Json
        }
    }

    # Check if collection is already cached
    $collectionCache = $cache | Where-Object { $_.collectionName -eq $CollectionName }

    if ($collectionCache) {
        [console]::WriteLine("Collection '$CollectionName' found in cache. Skipping download.")
        return
    }

    # Base URL for collection
    # https://www.svgrepo.com/collection/coco-two-color-icons
    $baseUrl = "https://www.svgrepo.com/collection/$CollectionName"
    $page = 1
    $icons = @()

    do {
        $url = if ($page -gt 1) { "$baseUrl/$page/" } else { $baseUrl }
        [console]::WriteLine("Fetching page $page from $url")

        # Fetch HTML content
        try {
            $html = Invoke-WebRequest -Uri $url -UseBasicParsing
        }
        catch {
            [console]::WriteLine("No more pages found.")
            break
        }

        # Parse HTML with HtmlAgilityPack or PowerHTML
        $doc = [HtmlAgilityPack.HtmlDocument]::new()
        $doc.LoadHtml($html.Content)

        # Extract icons
        $nodes = $doc.DocumentNode.SelectNodes("//div[contains(@class, 'style_node*')]//a//img")
        
        if ($null -eq $nodes) {
            [console]::WriteLine("No more icons found on this page.")
            break
        }

        foreach ($node in $nodes) {
            $iconUrl = $node.Attributes['src'].Value
            $iconName = [System.IO.Path]::GetFileNameWithoutExtension($iconUrl)
            $iconPath = Join-Path $OutFolder "$iconName.svg"
            
            [console]::WriteLine("Downloading icon $iconName to $iconPath")

            # Download the icon
            Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath

            # Add to icons array
            $icons += [pscustomobject]@{
                iconName = $iconName
                iconPath = $iconPath
                iconUrl  = $iconUrl
            }
        }

        $page++
    } while ($true)

    # Create collection object for cache
    $collectionObject = [pscustomobject]@{
        collectionName = $CollectionName
        icons          = $icons
    }

    # Update cache with new collection
    $cache += $collectionObject

    # Save updated cache
    $cache | ConvertTo-Json -Depth 5 | Set-Content -Path $cachePath
}

$cmdlet_config = @{
    Function = @('Request-SvgRepoCollection')
    Alias    = @('svgrepo')
}

Export-ModuleMember @cmdlet_config
