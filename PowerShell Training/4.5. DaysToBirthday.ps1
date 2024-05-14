function Get-DaysToBirthday
{
    [CmdletBinding(
        DefaultParameterSetName = "ByDate"
    )]
    param (
        [Parameter(
            ParameterSetName = "ByDate",
            Mandatory = $true
        )]
        [DateTime] $Date,

        [Parameter(
            ParameterSetName = "ByDayAndMonth",
            Mandatory = $true
        )]
        [Int] $Day,

        [Parameter(
            ParameterSetName = "ByDayAndMonth",
            Mandatory = $true
        )]
        [Int] $MonthNumber
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        { $_ -eq "ByDate"}
        {
            $birthdayDate = (Get-Date -Date $Date).Date
        }
        { $_ -eq "ByDayAndMonth"}
        {
            $birthdayDate = (Get-Date -Month $MonthNumber -Day $Day).Date
        }
        default
        {
        }
    }

    $daysToBirthday = ($birthdayDate - (Get-Date).Date).Days
    return "It's just $daysToBirthday days until your birthday!"
}