param(
    [Parameter(Mandatory=$true)]
    [string]
    $ConsumerKey,

    [Parameter(Mandatory=$true)]
    [string]
    $ConsumerSecret
)

function Generate-Base64Encoding($consumerKey, $consumerSecret)
{
    $combined = "$consumerKey$consumerSecret".Replace(' ', ':')
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($combined)
    $encodedSecrets = [System.Convert]::ToBase64String($bytes)
    return $encodedSecrets
}

function Obtain-BearerToken($secrets)
{
    $authHeader = "Basic $secrets"
    $headers = @{
        "Authorization" = $authHeader;
        "Content-Type" = "application/x-www-form-urlencoded;charset=UTF-8.";
    }

    $body = "grant_type=client_credentials"

    $token = Invoke-RestMethod -Uri "https://api.twitter.com/oauth2/token" `
                               -Method POST `
                               -Headers $headers `
                               -Body $body
    return $token.access_token
}

$encoded = Generate-Base64Encoding($ConsumerKey, $ConsumerSecret)
Obtain-BearerToken($encoded) | Set-Clipboard
Write-Output "Twitter bearer token should now be on your clipboard"
