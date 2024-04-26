# Setze die Namen der Quell- und Zielgruppen
$quelleGruppenname = "ICT_B_IMAGIC-M-Med_Intensiv"
$zielGruppenname = "ICT_B_imitoCam_Intensivstation"

# Hole die AD-Gruppenobjekte
$quelleGruppe = Get-ADGroup -Filter { Name -eq $quelleGruppenname }
$zielGruppe = Get-ADGroup -Filter { Name -eq $zielGruppenname }

# Überprüfe, ob die Gruppen gefunden wurden
if ($null -eq $quelleGruppe -or $null -eq $zielGruppe) {
    Write-Host "Eine der Gruppen wurde nicht gefunden. Stelle sicher, dass die Gruppen existieren."
    exit
}

# Hole die Mitglieder der Quellgruppe
$quelleGruppenMitglieder = Get-ADGroupMember -Identity $quelleGruppe.DistinguishedName

# Verschiebe die Mitglieder in die Zielgruppe und entferne sie aus der Quellgruppe
foreach ($mitglied in $quelleGruppenMitglieder) {
    Add-ADGroupMember -Identity $zielGruppe -Members $mitglied.DistinguishedName
    Write-Host "Mitglied $($mitglied.SamAccountName) wurde der Zielgruppe hinzugefügt."
}
Write-Host                    
Write-Host Alle Mitglieder wurden der anderen Gruppe hinzugefügt.
Write-Host Die Zielgruppe enthält nun alle Mitglieder der Quellgruppe.
Write-Host Die Mitglieder der Quellgruppe wurden nicht gelöscht.