$moduleName = "Attached"
$modulesPath = "C:\Users\$($Env:UserName)\OneDrive\Documents\PowerShell\Modules"
$version = [version]::New(1, 0, 0)

# Create the module directory if it does not exist
if (-not ($moduleDirectory = Get-Item -Path (Join-Path -Path $modulesPath -ChildPath $moduleName) -ErrorAction SilentlyContinue))
{
    $moduleDirectory = New-Item -ItemType Directory -Path $ModulesPath -Name $ModuleName
}

if (-not ($moduleVersionDirectory = Get-Item -Path (Join-Path -Path $moduleDirectory.FullName -ChildPath "$version") -ErrorAction SilentlyContinue))
{
    $moduleVersionDirectory = New-Item -ItemType Directory -Path (Join-Path -Path $moduleDirectory.FullName -ChildPath "$version")
}

# Create the content of the module
@"
function Get-Foo
{
    write-output 'My foo is strong!'
}
"@ | Out-File -FilePath (Join-Path -Path $moduleVersionDirectory.FullName -ChildPath "$moduleName.psm1")

# Generate the module manifest
$parameters = @{
    Guid              = (New-Guid).Guid
    Path              = (Join-Path -Path $moduleVersionDirectory.FullName -ChildPath "$moduleName.psd1")
    Author            = "Jeff Wouters"
    CompanyName       = "Methos"
    RootModule        = ".\$moduleName.psm1"
    Copyright         = "Methos " + (Get-Date).Year
    FunctionsToExport = "Get-Foo"
    Description       = "My first module"
    ModuleVersion     = $version
}
New-ModuleManifest @parameters