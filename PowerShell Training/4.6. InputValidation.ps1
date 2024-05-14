# Test some validations and try to break them

function Test-RangeValidation
{
    [CmdletBinding()]
    param (
        [ValidateRange(0, 10)]
        $RangeValidation
    )
    Write-Output "Succes"
}

function Test-SetValidation
{
    [CmdletBinding()]
    param (
        [ValidateSet("North", "East", "South", "West")]
        $SetValidation
    )
    Write-Output "Succes"
}

function Test-CountValidation
{
    [CmdletBinding()]
    param (
        [ValidateCount(1, 4)]
        $CountValidation
    )
    Write-Output "Succes"
}

function Test-PatternValidation
{
    [CmdletBinding()]
    param (
        [ValidatePattern("\s+Succes$")]
        $PatternValidation
    )
    Write-Output "Succes"
}

function Test-LengthValidation
{
    [CmdletBinding()]
    param (
        [ValidateLength(8, 32)]
        $LengthValidation
    )
    Write-Output "Succes"
}

function Test-ScriptValidation
{
    [CmdletBinding()]
    param (
        [ValidateScript({ $_ % 2 })]
        $ScriptValidation
    )
    Write-Output "Succes"
}

# The following example shows why an ErrorMessage is nice to include
function Test-ScriptValidation2
{
    [CmdletBinding()]
    param (
        [ValidateScript({
                if ($_ -in @(0, 1, 2, 3, 5, 8, 13, 21, 34, 55))
                {
                    return $true
                }
            })]
        $ScriptValidation
    )
    Write-Output "Succes"
}

# Input the following Errormessage
# }, ErrorMessage = "This number isn't part of the first 11 numbers in the Fibonacci sequence.")]

function Test-NotNullValidation
{
    [CmdletBinding()]
    param (
        [ValidateNotNull()]
        $Value
    )
    Write-Output "Succes"
}

# Also test an array containing a $null here
function Test-NotNullOrEmptyValidation
{
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        $Value
    )
    Write-Output "Succes"
}

function Test-NotNullOrWhiteSpaceValidation
{
    [CmdletBinding()]
    param (
        [ValidateNotNullOrWhiteSpace()]
        $Value
    )
    Write-Output "Succes"
}
# The above 2 examples should be tested with a string with just a space.
