$AzCredentialsAsset = 'AzureCredentials'
#Authenticate Azure
#Get the credential with the above name from the Automation Asset store
$AzCredentials = Get-AutomationPSCredential -Name $AzCredentialsAsset
$AzCredentials.password.MakeReadOnly()
Connect-AzAccount -Credential $AzCredentials
$usernames2 = Get-AutomationVariable -Name 'AVDUserAccess' 
$usernames3 = $usernames2 -split (',')
$ResourceName = Get-AutomationVariable -Name 'Resource' 
##^(?:(?<username>[^@]+)@(?<domain>.+)|(?<domain>[^\\]+)\\(?<username>.+))$


foreach ($upn in $usernames3) {
New-AzRoleAssignment -SignInName $upn -RoleDefinitionName "Desktop Virtualization User" -ResourceName $ResourceName -ResourceGroupName RSG-WVD -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups' }
