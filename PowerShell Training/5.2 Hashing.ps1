# Show both hashes are different
Compare-Object -ReferenceObject $hashedPlainTextString -DifferenceObject $hashedPlainTextString2

$hash = Get-FileHash -Path "C:\Temp\git\Clean%20Trainings\PowerShell Training\5.2 Hashing.ps1"
$hash.Hash

# Show getting the hash again gives the same result. After this. Change a single letter and try again.
$hash2 = Get-FileHash -Path "C:\Temp\git\Clean%20Trainings\PowerShell Training\5.2 Hashing.ps1"
$hash2.Hash