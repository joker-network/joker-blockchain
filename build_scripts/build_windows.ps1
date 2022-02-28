# $env:path should contain a path to editbin.exe and signtool.exe

# Testing On Win10 X64
# you have to install python and git command tools first.
# Open the powershell as a adminstrator rool.
# Go into the dir "joker-blockchain" and input the command:".\build_scripts\build_windows.ps1"
# This script Copyright by Joker Newwork.
# This script improved by Joker Newwork.
# Having any question, email to : jokercoin@gmail.com or go the mykc.cc
# 2021-06-05

# ERROR LIST AND SOLUTION:

# 1 The term 'npm' is not recognized ...
# 1 Go to : https://nodejs.org/en/ 
# 1 When you install, install the others necessary libs.
# 1 NPM will help you install the vc++ lib fils and the other tools. You may not need to install 2-3 bellow.

# 2 WARNING: lib not found: VCRUNTIME140.dll
# 2 Go to : https://www.microsoft.com/en-us/download/details.aspx?id=48145

# 3 WARNING: lib not found: python39.dll 
# 3 Install the python3.9.5 and find the install location e.g."C:\Users\user\AppData\Local\Programs\Python\Python39" into the system "Environment Variables"

# 4 WARNING: lib not found: VCRUNTIME140_1.dll dependency
# 4 https://download.visualstudio.microsoft.com/download/pr/f1998402-3cc0-466f-bd67-d9fb6cd2379b/A1592D3DA2B27230C087A3B069409C1E82C2664B0D4C3B511701624702B2E2A3/VC_redist.x64.exe
# 4 Visual C++ 2015-2019 X64

# 5 The term 'editbin.exe' is not recognized ...
# 5 My editbin.exe in Win10 is "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64", add it to path.
# 5 editbin.exe have many, you need to find the x64 version.

# 6 The term 'signtool.exe' is not recognized ...
# 6 My signtool.exe is "C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64", add it to path.
# 6 signtool.exe have many, you need to find the x64 version.

$ErrorActionPreference = "Stop"

git submodule update --init --recursive

if(Test-Path '.\build_scripts\win_build')			{
	Remove-Item '.\build_scripts\win_build' -Recurse
}
mkdir build_scripts\win_build

if(Test-Path '.\build_scripts\build\daemon')			{
	Remove-Item '.\build_scripts\build\daemon' -Recurse
}
if(Test-Path '.\build_scripts\dist')			{
	# Remove-Item '.\build_scripts\dist' -Recurse
}

if(Test-Path '.\joker-blockchain-gui\daemon')			{
	Remove-Item '.\joker-blockchain-gui\daemon' -Recurse
}
if(Test-Path '.\joker-blockchain-gui\release-builds')			{
	# Remove-Item '.\joker-blockchain-gui\release-builds' -Recurse
}
if(Test-Path '.\joker-blockchain-gui\Joker-win32-x64')			{
	# Remove-Item '.\joker-blockchain-gui\Joker-win32-x64' -Recurse
}
if(Test-Path '.\joker-blockchain-gui\build')			{
	# Remove-Item '.\joker-blockchain-gui\build' -Recurse
}

Set-Location -Path ".\build_scripts\win_build" -PassThru

git status

Write-Output "   ---"
Write-Output "curl miniupnpc"
Write-Output "   ---"
Invoke-WebRequest -Uri "https://pypi.chia.net/simple/miniupnpc/miniupnpc-2.2.2-cp39-cp39-win_amd64.whl" -OutFile "miniupnpc-2.2.2-cp39-cp39-win_amd64.whl"
Write-Output "Using win_amd64 python 3.9 wheel from https://github.com/miniupnp/miniupnp/pull/475 (2.2.0-RC1)"
Write-Output "Actual build from https://github.com/miniupnp/miniupnp/commit/7783ac1545f70e3341da5866069bde88244dd848"
If ($LastExitCode -gt 0){
    Throw "Failed to download miniupnpc!"
}
else
{
    Set-Location -Path - -PassThru
    Write-Output "miniupnpc download successful."
}

Write-Output "   ---"
Write-Output "Create venv - python3.9 is required in PATH"
Write-Output "   ---"
python -m venv venv
. .\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install wheel pep517
pip install pywin32
pip install pyinstaller==4.5
pip install setuptools_scm
pip install requests

Write-Output "   ---"
Write-Output "Get JOKER_INSTALLER_VERSION"
# The environment variable JOKER_INSTALLER_VERSION needs to be defined
$env:JOKER_INSTALLER_VERSION = python .\build_scripts\installer-version.py -win

# $env:JOKER_INSTALLER_VERSION = "1.2.11"

if (-not (Test-Path env:JOKER_INSTALLER_VERSION)) {
  $env:JOKER_INSTALLER_VERSION = '0.0.0'
  Write-Output "WARNING: No environment variable JOKER_INSTALLER_VERSION set. Using 0.0.0"
  }
Write-Output "Joker Version is: $env:JOKER_INSTALLER_VERSION"
Write-Output "   ---"

Write-Output "Checking if madmax exists"
Write-Output "   ---"
if (Test-Path -Path .\madmax\) {
    Write-Output "   madmax exists, moving to expected directory"
    mv .\madmax\ .\venv\lib\site-packages\
}

#Write-Output "Checking if bladebit exists"
#Write-Output "   ---"
#if (Test-Path -Path .\bladebit\) {
#    Write-Output "   bladebit exists, moving to expected directory"
#    mv .\bladebit\ .\venv\lib\site-packages\
#}

Write-Output "   ---"
Write-Output "Build joker-blockchain wheels"
Write-Output "   ---"
pip wheel --use-pep517 --extra-index-url https://pypi.chia.net/simple/ -f . --wheel-dir=.\build_scripts\win_build .

Write-Output "   ---"
Write-Output "Install joker-blockchain wheels into venv with pip"
Write-Output "   ---"

Write-Output "pip install miniupnpc"
Set-Location -Path ".\build_scripts" -PassThru
pip install --no-index --find-links=.\win_build\ miniupnpc
# Write-Output "pip install setproctitle"
# pip install setproctitle==1.2.2

Write-Output "pip install joker-blockchain"
pip install --no-index --find-links=.\win_build\ joker-blockchain

Write-Output "   ---"
Write-Output "Use pyinstaller to create joker .exe's"
Write-Output "   ---"
$SPEC_FILE = (python -c 'import joker; print(joker.PYINSTALLER_SPEC_PATH)') -join "`n"
Write-Output $SPEC_FILE
pyinstaller --log-level INFO $SPEC_FILE

Write-Output "   ---"
Write-Output "Copy joker executables to joker-blockchain-gui\"
Write-Output "   ---"
Copy-Item "dist\daemon" -Destination "..\joker-blockchain-gui\" -Recurse
Set-Location -Path "..\joker-blockchain-gui" -PassThru

git status

Write-Output "   ---"
Write-Output "Prepare Electron packager"
Write-Output "   ---"
$Env:NODE_OPTIONS = "--max-old-space-size=3000"
npm install --save-dev electron-winstaller
npm install -g electron-packager
npm install
npm audit fix

git status

Write-Output "   ---"
Write-Output "Electron package Windows Installer"
Write-Output "   ---"
npm run build
If ($LastExitCode -gt 0){
    Throw "npm run build failed!"
}

Write-Output "   ---"
Write-Output "Increase the stack for joker command for (joker plots create) chiapos limitations"
# editbin.exe needs to be in the path
editbin.exe /STACK:8000000 daemon\joker.exe
Write-Output "   ---"

$packageVersion = "$env:JOKER_INSTALLER_VERSION"
$packageName = "Joker-$packageVersion"

Write-Output "packageName is $packageName"

Write-Output "   ---"
Write-Output "fix version in package.json"
choco install jq
cp package.json package.json.orig
jq --arg VER "$env:JOKER_INSTALLER_VERSION" '.version=$VER' package.json > temp.json
rm package.json
mv temp.json package.json
Write-Output "   ---"

Write-Output "   ---"
Write-Output "electron-packager"
electron-packager . Joker --asar.unpack="**\daemon\**" --overwrite --icon=.\src\assets\img\joker.ico --app-version=$packageVersion
Write-Output "   ---"

Write-Output "   ---"
Write-Output "node winstaller.js"
node winstaller.js
Write-Output "   ---"

git status

If ($env:HAS_SECRET) {
   Write-Output "   ---"
   Write-Output "Add timestamp and verify signature"
   Write-Output "   ---"
   signtool.exe timestamp /v /t http://timestamp.comodoca.com/ .\release-builds\windows-installer\JokerSetup-$packageVersion.exe
   signtool.exe verify /v /pa .\release-builds\windows-installer\JokerSetup-$packageVersion.exe
   }   Else    {
   Write-Output "Skipping timestamp and verify signatures - no authorization to install certificates"
}

git status

Write-Output "   ---"
Write-Output "Windows Installer complete"
Write-Output "   ---"
