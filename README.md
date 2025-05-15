# tajir-releases

# 1. Download the stable ZIP to your Downloads folder
Invoke-WebRequest `
  -Uri "https://nssm.cc/release/nssm-2.24.zip" `
  -OutFile "$Env:USERPROFILE\Downloads\nssm.zip"

# 2. Unzip it
Expand-Archive `
  -Path "$Env:USERPROFILE\Downloads\nssm.zip" `
  -DestinationPath "$Env:USERPROFILE\Downloads\nssm"

# 3. (Optional) Copy the 64‑bit binary into your System32 so it's in your PATH
Copy-Item `
  -Path "$Env:USERPROFILE\Downloads\nssm\nssm-2.24\win64\nssm.exe" `
  -Destination "C:\Windows\System32\"


#verify its installed
nssm version


nssm install TajirEdgeServer "C:\Users\POS\Downloads\tajir-edge-server.exe"


nssm start TajirEdgeServer



nssm set TajirEdgeServer AppStdout C:\Users\POS\Downloads\logs\service.log
nssm set TajirEdgeServer AppStderr C:\Users\POS\Downloads\logs\service-error.log
