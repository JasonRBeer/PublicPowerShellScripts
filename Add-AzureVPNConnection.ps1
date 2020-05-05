<#
.SYNOPSIS
    Adds a VPN to the Azure VPN Client.
.DESCRIPTION
    Adds a VPN to the Azure VPN Client. Replaces a current VPN if it has the same name. Does not remove other existing VPNs.
.PARAMETER ScriptLogLocation
    The directory in which you would like the log file
.PARAMETER LogFileName
    The name (with extension) you would like for the log file 
.PARAMETER AzureVPNClientDirectory
    The full path to the directory in which the Azure VPN Client stores information.
.PARAMETER LocalStateDirectory
    The full path to the directory where the log files directory and rasphone.pbk file are stored.
.PARAMETER RASPhoneFile
    The full path of the rasphone.pbk file used by Azure VPN Client.
.PARAMETER NewVPNHeader
    The header in the rasphone.pbk file for the the VPN that will be added or replaced. This should match the first line of the RASPhoneEntry.
.PARAMETER RASPhoneEntry
    The full entry that will be added to the rasphone.pbk file.
.INPUTS
    None
.OUTPUTS
    Log file stored in C:\ExampleFolder\Add-AzureVPNConnection\Add-AzureVPNConnection.log
.NOTES
    Version:        1.0
    Author:         Jason Beer
    Creation Date:  3/25/2020
    Purpose/Change: Initial script development
#>
param(
[string]$ScriptLogLocation = "C:\ExampleFolder\Add-AzureVPNConnection",
[string]$LogFileName = "Add-AzureVPNConnection.log",
[string]$AzureVPNClientDirectory = "$env:LOCALAPPDATA\Packages\Microsoft.AzureVpn_8wekyb3d8bbwe",
[string]$LocalStateDirectory = (Join-Path $AzureVPNClientDirectory "LocalState"),
[string]$RASPhoneFile = (Join-Path $LocalStateDirectory "rasphone.pbk"),
[string]$NewVPNHeader = "[VPN Connection Name]",
[string]$RASPhoneEntry =
@"
[VPN Connection Name]
Encoding=<Removed>
PBVersion=<Removed>
Type=<Removed>
AutoLogon=<Removed>
UseRasCredentials=<Removed>
LowDateTime=-<Removed>
HighDateTime=<Removed>
DialParamsUID=<Removed>
Guid=<Removed>
VpnStrategy=<Removed>
ExcludedProtocols=<Removed>
LcpExtensions=<Removed>
DataEncryption=<Removed>
SwCompression=<Removed>
NegotiateMultilinkAlways=<Removed>
SkipDoubleDialDialog=<Removed>
DialMode=<Removed>
OverridePref=<Removed>
RedialAttempts=<Removed>
RedialSeconds=<Removed>
IdleDisconnectSeconds=<Removed>
RedialOnLinkFailure=<Removed>
CallbackMode=<Removed>
CustomDialDll=
CustomDialFunc=
CustomRasDialDll=
ForceSecureCompartment=<Removed>
DisableIKENameEkuCheck=<Removed>
AuthenticateServer=<Removed>
ShareMsFilePrint=<Removed>
BindMsNetClient=<Removed>
SharedPhoneNumbers=<Removed>
GlobalDeviceSettings=<Removed>
PrerequisiteEntry=
PrerequisitePbk=
PreferredPort=
PreferredDevice=
PreferredBps=<Removed>
PreferredHwFlow=<Removed>
PreferredProtocol=<Removed>
PreferredCompression=<Removed>
PreferredSpeaker=<Removed>
PreferredMdmProtocol=<Removed>
PreviewUserPw=<Removed>
PreviewDomain=<Removed>
PreviewPhoneNumber=<Removed>
ShowDialingProgress=<Removed>
ShowMonitorIconInTaskBar=<Removed>
CustomAuthKey=<Removed>
AuthRestrictions=<Removed>
IpPrioritizeRemote=<Removed>
IpInterfaceMetric=<Removed>
IpHeaderCompression=<Removed>
IpAddress=<Removed>
IpDnsAddress=<Removed>
IpDns2Address=<Removed>
IpWinsAddress=<Removed>
IpWins2Address=<Removed>
IpAssign=<Removed>
IpNameAssign=<Removed>
IpDnsFlags=<Removed>
IpNBTFlags=<Removed>
TcpWindowSize=<Removed>
UseFlags=<Removed>
IpSecFlags=<Removed>
IpDnsSuffix=
Ipv6Assign=<Removed>
Ipv6Address=<Removed>
Ipv6PrefixLength=<Removed>
Ipv6PrioritizeRemote=<Removed>
Ipv6InterfaceMetric=<Removed>
Ipv6NameAssign=<Removed>
Ipv6DnsAddress=<Removed>
Ipv6Dns2Address=<Removed>
Ipv6Prefix=<Removed>
Ipv6InterfaceId=<Removed>
DisableClassBasedDefaultRoute=<Removed>
DisableMobility=<Removed>
NetworkOutageTime=<Removed>
IDI=
IDR=
ImsConfig=<Removed>
IdiType=<Removed>
IdrType=<Removed>
ProvisionType=<Removed>
PreSharedKey=
CacheCredentials=<Removed>
NumCustomPolicy=<Removed>
NumEku=<Removed>
UseMachineRootCert=<Removed>
Disable_IKEv2_Fragmentation=<Removed>
NumServers=<Removed>
ServerListServerName=<Removed>
ServerListFriendlyName=
RouteVersion=<Removed>
NumRoutes=<Removed>
NumNrptRules=<Removed>
AutoTiggerCapable=<Removed>
NumAppIds=<Removed>
NumClassicAppIds=<Removed>
SecurityDescriptor=
ApnInfoProviderId=
ApnInfoUsername=
ApnInfoPassword=
ApnInfoAccessPoint=
ApnInfoAuthentication=<Removed>
ApnInfoCompression=<Removed>
DeviceComplianceEnabled=<Removed>
DeviceComplianceSsoEnabled=<Removed>
DeviceComplianceSsoEku=
DeviceComplianceSsoIssuer=
FlagsSet=<Removed>
Options=<Removed>
DisableDefaultDnsSuffixes=<Removed>
NumTrustedNetworks=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
ThirdPartyProfileInfo=<Removed>
NumDnsSearchSuffixes=<Removed>
PowershellCreatedProfile=<Removed>
ProxyFlags=<Removed>
ProxySettingsModified=
ProvisioningAuthority=
AuthTypeOTP=<Removed>
GREKeyDefined=<Removed>
NumPerAppTrafficFilters=<Removed>
AlwaysOnCapable=<Removed>
DeviceTunnel=<Removed>
PrivateNetwork=<Removed>

NETCOMPONENTS=
ms_msclient=<Removed>
ms_server=<Removed>

MEDIA=<Removed>
Port=
Device=

DEVICE=<Removed>
PhoneNumber=<Removed>
AreaCode=
CountryCode=<Removed>
CountryID=<Removed>
UseDialingRules=<Removed>
Comment=
FriendlyName=
LastSelectedPhone=<Removed>
PromoteAlternates=<Removed>
TryNextAlternateOnFail=<Removed>

"@
)

# Start Logging (path will be created if it doesn't already exist)
Start-Transcript -Path (Join-Path $ScriptLogLocation $LogFileName) -Append

# Check if Azure VPN Client is installed by checking for this directory (It is added during install and removed during uninstall)
$IsInstalled = Test-Path -LiteralPath $AzureVPNClientDirectory

# This file is created when the first VPN conenction is added. Additional VPN connections are appended to the file
$VPNsExist = Test-Path -LiteralPath $RASPhoneFile

if($IsInstalled -and !$VPNsExist){ # Installed but no VPNs configured
    Write-Host "The Azure VPN Client is installed and no VPNs exist. Creating the rasphone.pbk file and adding this connection."
    # Create a rasphone.pbk file with the connection information
    #   Commenting out the line below. It should work but it looks like there is a bug in PowerShell 5.1
    #   The File does not get created with UTF8 encoding and therefore the VPN client cannot read it -Jason Beer
    #$RASPhoneEntry | Out-File -Encoding "UTF8" -LiteralPath $RASPhoneFile -NoClobber -Force
    #   Using this method instead
    $Utf8Encoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($RASPhoneFile, $RASPhoneEntry, $Utf8Encoding)
}
elseif($IsInstalled -and $VPNsExist){ # Installed and VPNs Exist
    Write-Host "The Azure VPN Client is installed and some VPNs exist. Adding this VPN connection."
    # Create a backup of the current rasphone.pbk file before making any edits
    #   First find an available file name for the backup
    #   (starts with rasphoneBACKUP01.pbk and continues iterating until an available name is found)
    $BackupFileNameBase = "rasphoneBACKUP"
    $BackupFileExtension = ".pbk"
    $i=0
    Do{
        $i++
        $iFormatted = "{0:D2}" -f [int32]$i
        $BackupFileName = "$BackupFileNameBase$iFormatted$BackupFileExtension"
        $FullBackupPath = Join-Path $LocalStateDirectory $BackupFileName  
    }While(Test-Path -LiteralPath $FullBackupPath)
    
    #   Create a new backup with the unused backup name
    Copy-Item -LiteralPath $RASPhoneFile -Destination $FullBackupPath

    # Load the file's content into an array
    #   Each element of the array is a differnet line in the file
    $FileContent = Get-Content -LiteralPath $FullBackupPath
    
    # Loop through the content one line at a time to find the different VPN setups
    #   Each VPN has a "header" like [VPN Name] then is followed by the settings
    $CurrentVPNs = @()
    For($i=0;$i -lt $FileContent.count;$i++){
        # If this line of the file is a VPN "header" then add that VPN to the array of VPNs
        if($FileContent[$i] -like "[[]*[]]"){
            $CurrentVPNs += [PSCustomObject]@{
                Header = $FileContent[$i]
                StartLine = $i
                EndLine = $null
            }
            # Update the EndLine of the previous VPN if this isn't the first VPN found
            if($CurrentVPNs.count -gt 1){
                $CurrentVPNs[$CurrentVPNs.count-2].EndLine = $i-1
            }
        }
        # If this is the last line of the file, update the last VPNs EndLine
        if($i -eq $FileContent.Count-1){
            $CurrentVPNs[$CurrentVPNs.count-1].EndLine = $i
        }
    }

    # Check if any of the current VPNs have the same name as the new VPN, if not add them to the new array
    $NewVPNs = $null
    Foreach($VPN in $CurrentVPNs){
        if($VPN.Header -ne $NewVPNHeader){
            $NewVPNs += $FileContent[$VPN.StartLine..$VPN.EndLine]
        }
        elseif($VPN.Header -eq $NewVPNHeader){
            $Utf8Encoding = New-Object System.Text.UTF8Encoding $False
            [System.IO.File]::WriteAllLines($RASPhoneFile, $RASPhoneEntry, $Utf8Encoding)
        }
        else{
            Write-Error -Message "Something unexpected happened."
        }

        # Overwrite the existing file with the new VPN information
        $Utf8Encoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllLines($RASPhoneFile, $RASPhoneEntry, $Utf8Encoding)
        if($NewVPNs){
            $NewVPNs | Out-File -LiteralPath $RASPhoneFile -Encoding "UTF8" -Append -Force
        }
    }
}
elseif(!$IsInstalled){ # Client isn't installed
    Write-Host "The Azure VPN Client is not installed. Creating the directories, the rasphone.pbk file, and adding this connection."
    
    if(Test-Path -Path $LocalStateDirectory){
        Write-Host "The LocalState directory already exists."
    }
    else{
        Write-Host "Creating the LocalState directory."
        New-Item -ItemType Directory -Path $LocalStateDirectory
    }
    # Create a rasphone.pbk file with the connection information
    #   Commenting out the line below. It should work but it looks like there is a bug in PowerShell 5.1
    #   The File does not get created with UTF8 encoding and therefore the VPN client cannot read it -Jason Beer
    #$RASPhoneEntry | Out-File -Encoding "UTF8" -LiteralPath $RASPhoneFile -NoClobber -Force
    #   Using this method instead
    $Utf8Encoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($RASPhoneFile, $RASPhoneEntry, $Utf8Encoding)
}
else{
    Write-Error -Message "Something unexpected happened."
}

# Stop Logging
Stop-Transcript