$Array = Import-Csv -Path '.\6.3.csv'

#Working with JSON (Hashtable = PSCustomObject)
$HashTable = Get-Content '.\6.3.json' | ConvertFrom-Json -Depth 99
$Countries = ($HashTable | Get-Member -MemberType NoteProperty).Name
foreach ($Country in $Countries)
{
    $Provinces = ($HashTable.$Country | Get-Member -MemberType NoteProperty).Name
    foreach ($Province in $Provinces)
    {
        $HashTable.$Country.$Province
    }
}

#As a hashtable
$HashTable = Get-Content '.\6.3.json' | ConvertFrom-Json -Depth 99 -AsHashtable
$Countries = $HashTable.Keys
foreach ($Country in $Countries)
{
    $Provinces = $HashTable[$Country].Keys
    foreach ($Province in $Provinces)
    {
        $HashTable[$Country][$Province]
    }
}

#Shorter, but is it faster?
$HashTable = Get-Content '.\6.3.json' | ConvertFrom-Json -Depth 99 -AsHashtable
foreach ($Country in $HashTable.Keys)
{
    foreach ($Province in $HashTable[$Country].Keys)
    {
        $HashTable[$Country][$Province]
    }
}