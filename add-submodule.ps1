# Description: Add a submodule to the project
git submodule add -b Main https://gitlab.snowlab.tk/powershell/powerunicode.git .\libs\submodules\powerunicode

# Update all submodules to the latest commit on their remote branch
git submodule update --remote