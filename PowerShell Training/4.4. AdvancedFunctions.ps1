function New-User ($FirstName, $LastName)
{
    return "$FirstName $LastName"
}


### Decoration of parameters
function New-User
{
    param (
        [parameter()]
        $FirstName,
        [parameter()]
        $LastName
    )
    return "$FirstName $LastName"
}

function New-User
{
    param (
        [parameter(
            Mandatory = $true,
            Position = 0
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $true,
            Position = 1
        )]
        [string]$LastName
    )
    return "$FirstName $LastName"
}


### Pipeline support in a function
# The examples for below functions use the following object
$users = @(
    [PSCustomObject]@{
        "FirstName" = "Henk"
        "LastName"  = "de Vries"
    },
    [PSCustomObject]@{
        "FirstName" = "Boris"
        "LastName"  = "Feenstra"
    }
)

# Expand with named pipeline support and show usage
function New-User
{
    param (
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$LastName
    )
    Write-Output "$FirstName $LastName"
}

$users | New-User

# Expand with pipeline support and show usage
# Explain in greater detail what the difference between ValueFromPipeline (whole object)
# and ValueFromPipelineByPropertyName (properties of an object) means for the usage in your script.
function New-User
{
    param (
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline
        )]
        [Object]$User
    )
    Write-Output "$($User.FirstName) $($User.LastName)"
}

$users | New-User

### Input processing
function New-User
{
    param (
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$LastName
    )
    begin
    {
        # Execute one time BEFORE the pipeline
        Write-Output "Starting execution"
    }
    process
    {
        # Execute FOREACH pipeline object
        return "$FirstName $LastName"
    }
    end
    {
        # Execute one time AFTER the pipeline
        Write-Output "Finishing execution"
    }
}

$users | New-User

# GROEPSVRAAG: Welke real-world redenen kun je verzinnen voor de input processing

### Parameter sets
function New-User
{
    [cmdletbinding(
        DefaultParameterSetName = "FullName"
    )]
    param (
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "Name"
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "Name"
        )]
        [string]$LastName,

        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "FullName"
        )]
        [string]$FullName
    )
    begin
    {
        # Execute one time BEFORE the pipeline
    }
    process
    {
        # Execute FOREACH pipeline object
        if ($FirstName)
        {
            return "$FirstName $LastName"
        }
        else
        {
            return "$FullName"
        }
    }
    end
    {
        # Execute one time AFTER the pipeline
    }
}
# GROEPSVRAAG: Waarom is de defaultparametersetname nodig?
# GROEPSVRAAG: Samen kijken naar parameters. Welke decoration kan weg 
# (maar werkt nog wel deels)?

# Expand on the previous example by filtering on parametersetname instead of a parameter 
# and returning an user object
function New-User
{
    [cmdletbinding(
        DefaultParameterSetName = "FullName"
    )]
    param (
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "Name"
        )]

        [string]$FirstName,
        [parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "Name"
        )]

        [string]$LastName,
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "FullName"
        )]
        [string]$FullName
    )
    begin
    {
        #Execute one time BEFORE the pipeline
    }
    process
    {
        #Execute FOREACH pipeline object
        $Properties = @{}
        switch ($PSCmdlet.ParameterSetName)
        {
            { $_ -eq "Name" }
            {
                $Properties["FirstName"] = $FirstName
                $Properties["LastName"] = $LastName
            }
            { $_ -eq "FullName" }
            {
                $SplitName = $FullName -split " "
                $First = $SplitName[0]
                $Properties["FirstName"] = $First
                $Properties["LastName"] = ($SplitName | Where-Object { $_ -ne $First }) -join ' '
            }
            default
            {
            }
        }
        return New-Object -TypeName PSCustomObject -Property $Properties
    }
    end
    {
        #Execute one time AFTER the pipeline
    }
}

# Add support for passing an user object
function New-User
{
    [cmdletbinding(
        DefaultParameterSetName = "FullName"
    )]
    param (
        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "Name"
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "Name"
        )]
        [string]$LastName,

        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "FullName"
        )]
        [string]$FullName,

        [parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "User"
        )]
        [PSCustomObject]$User
    )
    begin
    {
        #Execute one time BEFORE the pipeline
    }
    process
    {
        #Execute FOREACH pipeline object
        $properties = @{}
        switch ($PSCmdlet.ParameterSetName)
        {
            { $_ -eq "Name" }
            {
                $properties["FirstName"] = $FirstName
                $properties["LastName"] = $LastName
            }
            { $_ -eq "FullName" }
            {
                $splitName = $FullName -split " "
                $first = $splitName[0]
                $properties["FirstName"] = $first
                $properties["LastName"] = ($splitName | Where-Object { $_ -ne $first }) -join ' '
            }
            { $_ -eq "User" }
            {
                $properties["FirstName"] = $User.FirstName
                $properties["LastName"] = $User.LastName
            }
            default
            {
            }
        }
        return New-Object -TypeName PSCustomObject -Property $properties
    }
    end
    {
        #Execute one time AFTER the pipeline
    }
}