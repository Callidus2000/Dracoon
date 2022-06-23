function Get-DracoonSoftwareVersion {
    <#
    .SYNOPSIS
    Request software version information

    .DESCRIPTION
    ### Description:
    Public software version information.

    ### Precondition:
    None.

    ### Postcondition:
    Sofware version information is returned.

    ### Further Information:
    The version of DRACOON Server consists of two components:
    * **API**
    * **Core** (referred to as _"Server"_)

    which are versioned individually.

    .PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

    .EXAMPLE
    PS C:\> Get-DracoonSoftwareVersion -Connection $connection

    ### Description:
    Public software version information.

    ### Precondition:
    None.

    ### Postcondition:
    Sofware version information is returned.

    ### Further Information:
    The version of DRACOON Server consists of two components:
    * **API**
    * **Core** (referred to as _"Server"_)

    which are versioned individually.

    .LINK
    <unknown>
    #>
    param (
        [parameter(Mandatory)]
        $Connection
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/public/software/version"
        EnablePaging = $EnablePaging
    }

    Invoke-DracoonAPI @apiCallParameter
}