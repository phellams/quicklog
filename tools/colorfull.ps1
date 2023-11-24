using namespace system.drawing

add-type -path C:\colorful.console.dll

$ccosole = [colorful.console]

$ccosole.write("Hello World", $ccosole::green, $ccosole::black)

$color = [System.Drawing.Color]

# Get All Properties Names Base
$color.DeclaredProperties.where({$_.PropertyType -match "System.Drawing.Color"}).name

# New From RGP
