# Bypass for a single script
PowerShell.exe -ExecutionPolicy Bypass -File ".\SignedScript.ps1"

# Bypass for a single session
Set-ExecutionPolicy Bypass -Scope Process
.\SignedScript.ps1

# Disable ExecutionPolicy for single session
function Disable-ExecutionPolicy
{
    (
        $context = $ExecutionContext.GetType().GetField("_context", "nonpublic,instance").GetValue($ExecutionContext)).GetType().GetField("_authorizationManager", "nonpublic,instance").SetValue($context, (New-Object -TypeName "System.Management.Automation.AuthorizationManager" "Microsoft.PowerShell")
    )
}

Disable-ExecutionPolicy
.\SignedScript.ps1