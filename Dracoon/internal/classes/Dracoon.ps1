import-module PSFramework

Class Dracoon {
    hidden [string]$webServiceRoot
    [string]$serverRoot
    hidden static [string]$dateFormat = 'yyyy-MM-dd'
    hidden static [int]$maxRecursionLevelSSP = 50

    hidden [int]$homeRoomParentId
    hidden [int]$projectsRoomParentId
    hidden [int]$openIDConfigId = 4
    hidden [int]$adminGroupId#=6
    hidden [String] $authToken
    [String] $authenticatedUser
    [switch] $verbose
    $oauthToken_Expires_in
    $headers = @{ }
    Dracoon ([PSCredential]$credentials, [string]$baseUrl) {
        # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        Write-PSFMessage "Verbinde Dracoon $baseUrl mittels Credentials-Objekt"

        $this.serverRoot = Get-DracoonServerRoot $baseUrl
        $this.webServiceRoot = "$($this.serverRoot)/api"
        $this.Login($credentials)
    }
    Dracoon ([String]$AccessToken, [string]$baseUrl) {
        # [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        Write-PSFMessage "Verbinde Dracoon $baseUrl mittels AccessToken $AccessToken" -functionName "[Dracoon]::new(AccessToken, baseUrl)"

        $this.serverRoot = Get-DracoonServerRoot $baseUrl
        $this.webServiceRoot = "$($this.serverRoot)/api"
        $this.Login($AccessToken)
    }
    hidden Login([PSCredential]$credentials) {

        # [void][System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
        # $this.jsonserial = New-Object -TypeName System.Web.Script.Serialization.JavaScriptSerializer
        # $this.jsonserial.MaxJsonLength = 2147483647
        $parameter = @{login = $credentials.UserName; password = $credentials.GetNetworkCredential().Password; language = "1"; authType = "sql" }
        $result = Invoke-DracoonAPI -connection $this -path "/v4/auth/login"  -body $parameter -method Post -hideParameters $true
        Write-PSFMessage $result
        $this.authToken = $result.token
        $this.authenticatedUser = $credentials.UserName
        $this.headers.Add("X-Sds-Auth-Token", $this.authToken)
        Write-PSFMessage "This-Type: $($this.gettype())"
    }

    hidden Login([string]$AccessToken) {
        Write-PSFMessage "Login with AccessToken <$AccessToken>" -Level Debug
        if ($AccessToken){
            $this.authToken = "Bearer $AccessToken"
            #$this.oauthToken_Expires_in = $tokenContent.expires_in
            $this.authenticatedUser = "OAuth"
            $this.headers.Add("Authorization", $this.authToken)
        }else{throw "AccessToken is null"}
    }
#     [PSCustomObject]GetGroups([string]$filter) {
#         $groups = $this.InvokeGet("/v4/groups?filter=$filter")
#         return $groups.items
#     }
#     [PSCustomObject]GetGroups() {
#         return $this.GetGroups("")
#     }
#     [PSCustomObject]GetGroupMembers([int]$groupId, [string]$filter) {
#         $groups = $this.InvokeGet("/v4/groups/$groupId/users?filter=$filter")
#         return $groups.items
#     }
#     [PSCustomObject]GetGroupMembers([int]$groupId) {
#         return $this.GetGroupMembers($groupId, "isMember:eq:true")
#     }
#     [PSCustomObject]AddGroupMembers([int]$groupId, [int[]]$userIdArray) {
#         $parameter = @{ids = $userIdArray }
#         $result = $this.InvokePost("/v4/groups/$groupId/users", $parameter)
#         return $result
#     }

#     [PSCustomObject]CreateGroup([string]$groupName) {
#         $parameter = @{name = "$groupName" }
#         $result = $this.InvokePost("/v4/groups", $parameter)
#         #if ($verbose) {Log-Message ("Authentication-Token: {0}" -f $result.token)}
#         Write-PSFMessage $result
#         return $result
#     }
#     [PSCustomObject]DeleteUser([int]$id) {
#         $result = $this.DeleteUser($id, $false)
#         return $result
#     }
#     [PSCustomObject]GetLastAdminRooms([int]$userId) {
#         $result = $this.InvokeGet("/v4/users/$userId/last_admin_rooms")
#         return $result.items
#     }
#     [PSCustomObject]GetUserDetails([int]$userId) {
#         $result = $this.InvokeGet("/v4/users/$userId")
#         return $result
#     }
#     [PSCustomObject]GetCurrentUserInfos() {
#         $result = $this.InvokeGet("/v4/user/account")
#         return $result
#     }
#     [PSCustomObject]UpdateUser([int]$userId, [Hashtable]$metaData) {
#         $result = $this.InvokePut("/v4/users/$userId", $metaData)
#         return $result
#     }
#     [PSCustomObject]SetUserAttributes([int]$userId, [Hashtable]$userAttributes) {
#         $result = $this.SetUserAttributes($userId, $userAttributes, $false)
#         return $result
#     }
#     [PSCustomObject]AddUserAttributes([int]$userId, [Hashtable]$userAttributes) {
#         $result = $this.SetUserAttributes($userId, $userAttributes, $true)
#         return $result
#     }

#     [Hashtable]GetUserAttributes([int]$userId) {
#         $attributes = @{ }
#         $userDetails = $this.GetUserDetails($userId)
#         foreach ($item in $userDetails.userAttributes.items) {
#             $attributes.add($item.key, $item.value)
#         }
#         return $attributes
#     }
#     [PSCustomObject]LockUser([int]$userId, [bool]$lock) {
#         return $this.UpdateUser($userId, @{isLocked = $lock })
#         return $result
#     }
#     [PSCustomObject]CreateMailUser([string]$login, [string]$firstName, [string]$lastName, [string]$title, [string]$gender, [string]$eMail) {
#         return $this.CreateMailUser($login, $firstName, $lastName, $title, $gender, $eMail, $false)
#     }
#     [PSCustomObject]CreateMailUser([string]$login, [string]$password, [string]$firstName, [string]$lastName, [string]$title, [string]$gender, [string]$eMail, [bool]$notifyUser) {
#         return $this.CreateMailUser($login, $password, $firstName, $lastName, $title, $gender, $eMail, $notifyUser, $false)
#     }
#     [PSCustomObject]CreateMailUser([string]$login, [string]$password, [string]$firstName, [string]$lastName, [string]$title, [string]$gender, [string]$eMail, [bool]$notifyUser, [bool]$enableOpenID) {
#         $parameter = @{firstName = $firstName; lastName = $lastName; authMethods = @(@{authId = "sql"; isEnabled = "true" }); login = $login; title = $title; gender = $gender; expiration = @{enableExpiration = "false"; expireAt = "2018-01-01T00:00:00" }; receiverLanguage = "de-DE"; email = $eMail; notifyUser = "$notifyUser"; needsToChangePassword = "true"; password = $password }
#         if ($enableOpenID) {
#             $parameter["authMethods"] += (@{authId = "openid"; isEnabled = $true; options = @(@{key = "openid_config_id"; value = $this.openIDConfigId }; @{key = "username"; value = $eMail }) })
#         }
#         $result = $this.InvokePost("/v4/users", $parameter)
#         return $result
#     }
#     [PSCustomObject]UploadFile([string]$fullFilePath, [int]$parentNodeId) {
#         return $this.UploadFile((get-item $fullFilePath), $parentNodeId)
#     }
#     [PSCustomObject]UploadFile([System.IO.FileSystemInfo]$fullFilePath, [int]$parentNodeId) {
#         $result = $null
#         Write-PSFMessage "Lade Datei hoch: $fullFilePath"
#         $parameter = @{"parentId" = $parentNodeId; "name" = $fullFilePath.Name; "classification" = 2; "size" = $fullFilePath.length; "expiration" = @{"enableExpiration" = $false; "expireAt" = "2018-01-01T00:00:00" }; "notes" = "" }
#         $initUpload = $this.InvokePost("/v4/nodes/files/uploads", $parameter)
#         try {
#             $result = Invoke-RestMethod $initUpload.uploadUrl -ContentType "application/octet-stream" -Method Post -Headers $this.headers -InFile $fullFilePath.FullName

#             Write-PSFMessage $result
#             $result = $this.Invoke(("/v4/uploads/{0}" -f $initUpload.token), $null, [Microsoft.Powershell.Commands.WebRequestMethod]::Put, $false)
#         }
#         catch {
#             Write-PSFMessage "Fehler $_"
#             $this.InvokeDelete(("/v4/uploads/{0}" -f $initUpload.token))
#             throw $_
#         }
#         return $result
#     }
#     # [PSCustomObject]GetEventLog([int]$limit, [int]$offset, [string]$filter) {
#     [PSCustomObject]GetEventLog([int]$limit, [int]$offset, [hashtable]$additionalParamater) {
#         $parameterTable = @{limit = $limit; offset = $offset }
#         $parameterTable += $additionalParamater
#         # $uri = "/v4/eventlog/events?type=6&limit=$limit&offset=$offset"
#         # if ($filter) {
#         #     $uri += "&$filter"
#         # }
#         $events = $this.InvokeGet("/v4/eventlog/events", $parameterTable)
#         return $events
#     }
#     [PSCustomObject]GetNode([int]$nodeId) {
#         $node = $this.InvokeGet("/v4/nodes/$nodeId")
#         return $node
#     }
#     [PSCustomObject]GetNodeList([hashtable]$parameterTable) {
#         $nodes = $this.InvokeGet("/v4/nodes", $parameterTable)
#         return $nodes
#     }
#     [PSCustomObject]GetParents([int]$nodeId) {
#         $parents = $this.InvokeGet("/v4/nodes/$nodeId/parents")
#         return $parents
#     }
#     [PSCustomObject]SearchNode([int]$parentNode, [string]$searchString, [string]$filter, [string]$sort) {
#         $parameterTable = @{search_string = $searchString; filter = $filter; sort = $sort; parent_id = $parentNode }
#         $nodes = $this.InvokeGet("/v4/nodes/search", $parameterTable)
#         return $nodes
#     }
#     [PSCustomObject]MoveNodes([int]$targetNodeId, [int[]]$nodesToMove) {
#         Write-PSFMessage "Verschiebe nach $targetNodeId : $nodesToMove"
#         $parameter = @{resolutionStrategy = "overwrite"; keepShareLinks = $true; nodeIds = $nodesToMove }
#         $result = $this.InvokePost("/v4/nodes/$targetNodeId/move_to", $parameter)
#         return $result
#     }
#     [PSCustomObject]CopyNodes([int]$targetNodeId, [int[]]$nodesToMove) {
#         Write-PSFMessage "Kopiere nach $targetNodeId : $nodesToMove"
#         $parameter = @{resolutionStrategy = "overwrite"; keepShareLinks = $true; nodeIds = $nodesToMove }
#         $result = $this.InvokePost("/v4/nodes/$targetNodeId/copy_to", $parameter)
#         return $result
#     }
#     [PSCustomObject]CreateFolder([int]$parentNodeId, [string]$name, [string]$notes) {
#         Write-PSFMessage "Lege Ordner $name unter der Node $parentNodeId an, Comment=$notes"
#         $parameter = @{parentId = $parentNodeId; name = $name; notes = $notes }
#         $result = $this.InvokePost("/v4/nodes/folders", $parameter)
#         return $result
#     }
}