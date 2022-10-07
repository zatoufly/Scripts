New-Item -ItemType Directory -Path "C:\" -Name "SAUVEGARDE"
Copy-Item -Path "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data" -Destination "C:\SAUVEGARDE\" -Recurse