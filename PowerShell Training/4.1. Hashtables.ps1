# Werken met hashtables
@{}.GetType()
@().GetType()

# Zelf een hashtable maken
$hashtable = @{
    "value"  = "test value"
    "object" = @{
        "objectvalue" = "test object"
    }
    "array"  = @(
        "test 1", "test 2"
    )
}

# Data toevoegen aan een hashtable
$hashtable.Add("secondvalue", "test second value")

# Door een hashtable itereren
foreach ($object in $hashtable.GetEnumerator())
{    
    $object
    Write-Output "###"
}

# En nu nuttig
$hashtable.GetEnumerator() | ForEach-Object {    
    Write-Output "The value for key $($_.Key) is $($_.Value)"
}

# hashtable omzetten naar JSON (ook handig voor het inspecteren van een hashtable)
$hashtable | ConvertTo-Json

# Opdracht
# Maak in 2 of 3-tallen een hashtable met daarin per deelnemer de volgende gegevens:
# - Voornaam
# - Achternaam
# - Leeftijd
# - Kinderen (per kind de voornaam, achternaam en leeftijd)
# - Woonplaats
# Converteer de hashtable tot een JSON object

$hashtable = @{
    "persons" = @(
        @{
            "firstname" = "Rein"
            "lastname"  = "Leen"
            "age"       = 38
            "children"  = @(
                @{
                    "firstname" = "Robin"
                    "lastname"  = "Leen"
                    "age"       = 11
                },
                @{
                    "firstname" = "Zoë"
                    "lastname"  = "Leen"
                    "age"       = 3
                },
                @{
                    "firstname" = "Famke"
                    "lastname"  = "Leen"
                    "age"       = 0
                }
            )
            "city"      = "Houten" 
        },
        @{
            "firstname" = "Jeff"
            "lastname"  = "Wouters"
            "age"       = $null
            "children"  = $null
            "city"      = "Nieuwegein" 
        }
    )
}

# Inspectie levert op dat de kinderen niet zichtbaar zijn (default depth = 2)
# Laten zien dat Depth kan helpen om dit zichtbaar te maken.
$hashtable | ConvertTo-Json

# Verdere inspectie levert op dat de hashtable de objecten niet gekoppeld houdt.
# Toevoegen van [PSCustomObject] voor ieder persoon lost dit issue op.
$hashtable.persons
$hashtable = @{
    "persons" = @(
        [PSCustomObject]@{
            "firstname" = "Rein"
            "lastname"  = "Leen"
            "age"       = 38
            "children"  = @(
                @{
                    "firstname" = "Robin"
                    "lastname"  = "Leen"
                    "age"       = 11
                },
                @{
                    "firstname" = "Zoë"
                    "lastname"  = "Leen"
                    "age"       = 3
                },
                @{
                    "firstname" = "Famke"
                    "lastname"  = "Leen"
                    "age"       = 0
                }
            )
            "city"      = "Houten" 
        },
        [PSCustomObject]@{
            "firstname" = "Jeff"
            "lastname"  = "Wouters"
            "age"       = $null
            "children"  = $null
            "city"      = "Nieuwegein" 
        }
    )
}
$hashtable.persons