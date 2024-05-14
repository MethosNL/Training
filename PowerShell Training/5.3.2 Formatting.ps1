# Simple function to add 2 numbers with ValueFromPipeline
function Invoke-Addition
{
    param (
        [parameter(
            ValueFromPipeline
        )]
        $Base,
        [parameter()]
        $Addition
    )

    return $Base + $Addition
}

# Add 2
2 | Invoke-Addition -Addition 2

# Add 2 (2 times)
2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2

# Add 2 (multiple times)
2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2 | Invoke-Addition -Addition 2

# Now with some formatting
Invoke-Addition -Base 2 -Addition 2 |
    Invoke-Addition -Addition 2 | 
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2 |
    Invoke-Addition -Addition 2

# Real-life example - Create a custom object
# Using the pipeline to add properties
$Object = New-Object -TypeName PSCustomObject |
    Add-Member -MemberType NoteProperty -Name 'One' -Value 'One' |
    Add-Member -MemberType NoteProperty -Name 'Two' -Value 'Two' |
    Add-Member -MemberType NoteProperty -Name 'Three' -Value 'Three' |
    Add-Member -MemberType NoteProperty -Name 'Four' -Value 'Four'

# Naming the properties directly
$Object = New-Object -TypeName -PSCustomProperty -Property @{
    'One'   = 'One'
    'Two'   = 'Two'
    'Three' = 'Three'
    'Four'  = 'Four'
}

# Using a variable (NOT splatting!!!)
$Properties = @{
    'One'   = 'One'
    'Two'   = 'Two'
    'Three' = 'Three'
    'Four'  = 'Four'
}
$Object = New-Object -TypeName -PSCustomProperty -Property $Properties
