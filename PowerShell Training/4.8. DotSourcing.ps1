# Run a remote script which outputs a string
& '.\8.1 script.ps1'

# The following command will not show output on the variable 
# since it isn't available in the current scope.
$MyFoo
Get-MyFoo

# This time the variable will show output since it was pulled to the current scope.
. '.\8.1 script.ps1'
$MyFoo
Get-MyFoo

# Following this example, show a further example.
# Create function with variable which stays within it's scope
function Invoke-DotSourceExplanation
{
    Write-Output "This content will always be shown"

    $innerScopeVariable = "This content can only be accessed from inside the function"

    $returnVariable = "This content will be returned"
    return $returnVariable
}

# Try to access the inner scope variable
$innerScopeVariable

# Pull the inner scope variable to the script by dot sourcing
. Invoke-DotSourceExplanation

# Access the inner scope variable
$innerScopeVariable

# Show alternative options with $global and $script scope
function Invoke-GlobalScopedVariableFunction
{
    Write-Output "Just some output"

    $Global:globalVariable = "This is a global variable"

    $Script:scriptVariable = "This is a script variable"
}

# Show the variables are accessible within the script.
Invoke-GlobalScopedVariableFunction
$globalVariable
$scriptVariable