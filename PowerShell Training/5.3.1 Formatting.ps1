# Create a function with many Parameters
function Get-OutputWithManyParameters ($Param1, $Param2, $Param3, $Param4, $Param5, $Param6, $Param7, $Param8, $Param9, $Param10, $Param11, $Param12, $Param13, $Param14, $Param15, $Param16, $Param17, $Param18, $Param19, $Param20) {
    Write-Output "$Param1, $Param2, $Param3, $Param4, $Param5, $Param6, $Param7, $Param8, $Param9, $Param10, $Param11, $Param12, $Param13, $Param14, $Param15, $Param16, $Param17, $Param18, $Param19, $Param20"
}

# Show a great way to miss Parameters
Get-OutputWithManyParameters -Param1 "waarde 1" -Param2 "waarde 2" -Param4 "waarde 4" -Param6 "waarde 6" -Param7 "waarde 7" -Param9 "waarde 9" -Param10 "waarde 10"

# Show a better way with backticks
Get-OutputWithManyParameters `
    -Param1 "waarde 1" `
    -Param2 "waarde 2" `
    -Param4 "waarde 4" `
    -Param6 "waarde 6" `
    -Param7 "waarde 7" `
    -Param9 "waarde 9" `
    -Param10 "waarde 10"

# Or without backticks
Get-OutputWithManyParameters
    -Param1 "waarde 1"
    -Param2 "waarde 2"
    -Param4 "waarde 4"
    -Param6 "waarde 6"
    -Param7 "waarde 7"
    -Param9 "waarde 9"
    -Param10 "waarde 10"

# Show an even better way with splatting
# Use-case: build/fill parameters in loop
$Parameters = @{
    "Param1" = "waarde 1"
    "Param2" = "waarde 2"
    "Param3" = "waarde 3"
    "Param4" = "waarde 4"
    "Param5" = "waarde 5"
    "Param6" = "waarde 6"
    "Param7" = "waarde 7"
    "Param8" = "waarde 8"
    "Param9" = "waarde 9"
    "Param10" = "waarde 10"
    "Param11" = "waarde 11"
    "Param12" = "waarde 12"
    "Param13" = "waarde 13"
    "Param14" = "waarde 14"
    "Param15" = "waarde 15"
    "Param16" = "waarde 16"
    "Param17" = "waarde 17"
    "Param18" = "waarde 18"
    "Param19" = "waarde 19"
    "Param20" = "waarde 20"
}

Get-OutputWithManyParameters @Parameters