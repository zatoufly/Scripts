# Demande du chemin de destistation (où va la copie des datas)
$path_destination = Read-Host "Vers où sauvegarder les données ? (C:/D:/E:)"

New-Item -ItemType Directory -Path "$path_destination\" -Name "SAUVEGARDE"

# Copy Chrome Profile
$confirmation = Read-Host "Sauvegarder le profile Chrome ? (y/n)"
if ($confirmation -eq 'y') {
	Copy-Item -Path "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data" -Destination "$path_destination\SAUVEGARDE\" -Recurse
}

# Copy current User folder
$confirmation = Read-Host "Sauvegarder les dossiers utilisateurs ? (y/n)"
if ($confirmation -eq 'y') {
	Copy-Item -Path "$env:USERPROFILE\Desktop","$env:USERPROFILE\Documents","$env:USERPROFILE\Pictures","$env:USERPROFILE\Music","$env:USERPROFILE\Downloads","$env:USERPROFILE\Videos" -Destination "$path_destination\SAUVEGARDE\" -Recurse 
}
