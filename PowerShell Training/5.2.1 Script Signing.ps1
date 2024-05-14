# Define the certificate name
$certificateName = "PowerShell Code Signing"

# Create a PowerShell script with the following content
`"Write-Output "This is my signed script!"`" | Out-File -FilePath ".\SignedScript.ps1"

# Generate a self-signed Certificate for code signing if required
if (-not ($certificate = Get-ChildItem -Path "Cert:\CurrentUser\My" -CodeSigningCert))
{
    $certificate = New-SelfSignedCertificate -CertStoreLocation "Cert:\CurrentUser\My" -Subject "CN=$certificateName" -KeySpec Signature -Type CodeSigningCert
}

# Verify that the certificate has been created:
Get-ChildItem -Path "Cert:\CurrentUser\My" -CodeSigningCert

#region Needed to trust certificate, not required when using PKI infrastructure
# Export the Certificate to "Documents" Folder in your computer
$certificatePath = [Environment]::GetFolderPath("MyDocuments") + "\$certificateName.cer"
Export-Certificate -Cert $certificate -FilePath $certificatePath

# Add Certificate to the "Trusted Root Store" - RunAsAdmin
Get-Item $certificatePath | Import-Certificate -CertStoreLocation "Cert:\LocalMachine\Root"
#endregion Needed to trust certificate, not required when using PKI infrastructure

# Sign the PowerShell script you created with the self-signed certificate that you generated:
Set-AuthenticodeSignature -FilePath ".\SignedScript.ps1" -Certificate $certificate

# Verify the script signature (status must be Valid):
Get-AuthenticodeSignature -FilePath ".\SignedScript.ps1"

# Attempt to run the script
.\SignedScript.ps1

# Edit the script
$content = Get-Content -Path ".\SignedScript.ps1"
$content -replace "signed script", "signed, but edited script" | Out-File -FilePath ".\SignedScript.ps1"

# Try to run it again
.\SignedScript.ps1