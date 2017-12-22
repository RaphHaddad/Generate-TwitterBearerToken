param(
    [Parameter(Mandatory = $true)]
    [String]
    $ClientId,

    [Parameter(Mandatory = $true)]
    [String]
    $ClientSecret,

    [Parameter(Mandatory = $true)]
    [String]
    $RedirectUri
)

function Request-AuthCode($clientId, $redirectUri)
{
    Add-Type -AssemblyName System.Web
    $urlEncoded = [System.Web.HttpUtility]::UrlDecode($redirectUri)
    $state = Get-Random
    $url = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id={0}&redirect_uri={1}&state={2}&scope=r_basicprofile" -f $clientId, $urlEncoded, $state
    $url | Set-Clipboard
}

function Exchange-CodeForAuthToken($code, $redirectUri, $clientId, $clientSecret)
{
    $uri = "https://www.linkedin.com/oauth/v2/accessToken"
    $headers = @{
        "Content-Type" = "application/x-www-form-urlencoded"
    }
    $body = @{
        "grant_type" = "authorization_code";
        "code" = $code;
        "redirect_uri" = $redirectUri;
        "client_id" = $clientId;
        "client_secret" = $clientSecret;
    }
    $response = Invoke-RestMethod -Method POST `
                                  -Uri $uri `
                                  -Headers $headers `
                                  -Body $body
    return $response.access_token
}

Request-AuthCode $ClientId $RedirectUri
$code = Read-Host -Prompt "A URL as been added to your clipboard navigate to it, authorise your app and enter the 'code' part of the URL here"
Exchange-CodeForAuthToken $code $RedirectUri $ClientId $ClientSecret | Set-Clipboard
Write-Output "LinkedIn Access Token should now be on your clipboard"
