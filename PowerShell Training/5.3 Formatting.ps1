# Show the usage of regions

#region [variables]
$servicesToCheck = @("W32Time", "wuauserv", "wscsvc") # I want to check these services
# Output the data with a timeout
[Int] $timeout = 2
#endregion

#region [retrieve data]
$services = Get-Service -Name $servicesToCheck
#endregion

#region [output data]
# Output all found services
foreach ($service in $services)
{
    Write-Output -InputObject $service
    Start-Sleep -Seconds $timeout
}
#endregion