$uriObject = New-Object -TypeName "System.UriBuilder" -ArgumentList "https", "catfact.ninja", 443, "fact"

# Werken met web requests
# Opvragen van data
$response = Invoke-WebRequest -Method Get -Uri $uriObject.Uri.AbsoluteUri

# Data bekijken
$response
if ($response.StatusCode -eq 200)
{
    Write-Output ($response.Content | ConvertFrom-Json)
}

# En nu makkelijker
$response = Invoke-RestMethod -Method Get -Uri $uriObject.Uri.AbsoluteUri
if ($response)
{
    $response
}