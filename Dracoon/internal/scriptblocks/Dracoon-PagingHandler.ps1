Set-PSFScriptblock -Name 'Dracoon.PagingHandler' -Scriptblock {
    # $EnablePaging -eq $true
    Write-PSFMessage "Dracoon.PagingHandler" -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
    try {
        if (($result -is [array])) {
            Write-PSFMessage "Paging enabled, aber keine Range zurückgeliefert" -Level Warning  -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
            return $result
        }
        else {
            Write-PSFMessage "Paging enabled, starte Schleife, result.range=$($result.range)" -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
            $allItems = ($result.items)
            write-psfmessage "Anzahl ermittelter Items: $($allItems.count)" -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
            $URLParameter.limit = $result.range.limit
            $URLParameter.offset = $result.range.offset
            while ($result.range.total -gt $allItems.count) {
                Write-PSFMessage "result.range.total=$($result.range.total) -gt allItems.count=$($allItems.count)" -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
                $URLParameter.offset = $allItems.count
                $nextParameter = @{
                    Connection     = $Connection
                    Path           = $Path
                    Body           = $Body
                    URLParameter   = $URLParameter
                    Method         = $Method
                    HideParameters = $HideParameters
                }
                $result = Invoke-DracoonAPI @nextParameter
                $allItems += ($result.items)
            }
            return $allItems
        }
        # if (-not ($response.Headers["X-Total-Count"])) {
        #     Write-PSFMessage "Paging enabled, but no X-Total-Count header" -Level Warning -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
        # }
        # else {
        #     $totalCount = $response.Headers["X-Total-Count"]
        #     Write-PSFMessage "Paging enabled, starting loop, totalCount=$totalCount" -ModuleName Gitea -FunctionName 'Gitea-PagingHandler'
        #     $allItems = $result
        #     $resultCount = ($result | Measure-Object).count
        #     write-psfmessage "Current Item-Count: $(($allItems|Measure-Object).count)" -ModuleName Gitea -FunctionName 'Gitea-PagingHandler'
        #     # If no Page was given as a parameter then the returned object count as the configured limit
        #     if (!($UrlParameter.limit)) {
        #         $UrlParameter.limit = $resultCount
        #     }
        #     # If no Page was given as a parameter then it was page 1 we just requested
        #     if (!($UrlParameter.page)) {
        #         $UrlParameter.page = 1
        #     }

        #     while ($totalCount -gt $allItems.count) {
        #         # Fetch the next page of items
        #         $UrlParameter.page = $UrlParameter.page + 1
        #         Write-PSFMessage "totalCount=$totalCount -gt allItems.count=$($allItems.count)"  -ModuleName Gitea -FunctionName 'Gitea-PagingHandler'
        #         $nextParameter = @{
        #             Connection     = $Connection
        #             Path           = $Path
        #             Body           = $Body
        #             UrlParameter   = $UrlParameter
        #             Method         = $Method
        #             HideParameters = $HideParameters
        #             # NO EnablePaging in the next Call
        #         }
        #         write-psfmessage "InvokeAPI with Params= $($nextParameter|convertto-json -depth 10)" -Level Debug -ModuleName Gitea -FunctionName 'Gitea-PagingHandler'
        #         $result = Invoke-GiteaAPI @nextParameter
        #         $allItems += ($result)
        #     }

        #     return $allItems
        # }
    }
    catch {
        Write-PSFMessage "$_" -ErrorRecord $_ -Tag "Catch" -ModuleName Dracoon -FunctionName 'Dracoon-PagingHandler'
    }
}