New-Item -ItemType Directory -Path "C:\" -Name "SAUVEGARDE"
Copy-Item -Path "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data" -Destination "C:\SAUVEGARDE\" -Recurse
Copy-Item -Path "$env:USERPROFILE\Desktop","$env:USERPROFILE\Documents","$env:USERPROFILE\Pictures","$env:USERPROFILE\Music","$env:USERPROFILE\Downloads","$env:USERPROFILE\Videos" -Destination "C:\SAUVEGARDE\" -Recurse
