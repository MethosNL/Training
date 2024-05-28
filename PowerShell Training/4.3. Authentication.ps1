$basePath = "/public/v2"
$uriObject = New-Object -TypeName "System.UriBuilder" -ArgumentList "https", "gorest.co.in", 443

# Retrieve users
$uriObject.Path = "$basePath/users"
Invoke-RestMethod -Uri $uriObject.Uri.AbsoluteUri -Method Get

# Een gebruiker creëren 
$apiToken = "7106ef7d44efc93103a66ef15cc861b94c6225db0dc2e7308cc97ab72021ede5"
$body = @{
    "name"   = "Henk de Vries"
    "email"  = "gekkehenkie@voorbeeld.com"
    "gender" = "male"
    "status" = "active"
}

# Werkt niet omdat authenticatie ontbreekt
Invoke-RestMethod -Uri $uriObject.Uri.AbsoluteUri -Method Post -Body $body

$headers = @{
    "Authorization" = "Bearer $apiToken"
}

# Nu werkt het wel
Invoke-RestMethod -Uri $uriObject.Uri.AbsoluteUri -Method Post -Body $body -Headers $headers

# Controle
$id = 
$uriObject.Path = "$basePath/users/$id"
Invoke-RestMethod -Uri $uriObject.Uri.AbsoluteUri -Method Get

# Wat als een API XML verwacht?
$headers.Add("Accept", "application/json")