function Get-AzureRecursiveGroupMembers{
    [CmdletBinding()]
    param (
        [string]$ObjectID
    )
    begin{
        $Users = @()
    }
    process{
        $AllGroupMembers = Get-AzureADGroupMember -ObjectId $ObjectID -All $True
        $Groups = $AllGroupMembers | Where-Object {$_.ObjectType -eq "Group"}
        $TempUsers = $AllGroupMembers | Where-Object {$_.ObjectType -eq "User"}

        Foreach($Group in $Groups){
            $TempUsers = $null
            $TempUsers = Get-AzureRecursiveGroupMembers -ObjectId $Group.ObjectId
            if($TempUsers.count -gt 0){
                $Users += $TempUsers
            }
        }
        $Users += $TempUsers | Select-Object -Unique
    }
    end{
        return $Users
    }
}
