# PowerShell Social Media Helpers
## Twitter
Generates a Twitter [bearer token](https://developer.twitter.com/en/docs/basics/authentication/overview/application-only) to be used for Twitter API calls for application-only authorisation.

Usuage:

```PowerShell
.\Generate-TwitterBearerToken.ps1 -ConsumerKey "xvz1evFS4wEEPTGEFPHBog" -ConsumerSecret "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
```

You can get your specific application's ConsumerKey and ConsumerSecret from the [Twitter Application page](https://apps.twitter.com/)

# LinkedIn
Generate a LinkedIn [Access Token](https://developer.linkedin.com/docs/oauth2)

Usuage:
```PowerShell
.\Generate-LinkedInToken.ps1 -ClientId "862ghj12jrgal2" -ClientSecret "FKI7Djs89Af7T8M7" -RedirectUri "http://wwww.raph.ws"
```

You can get your specific application's ClientId and ClientSecret from the [LinkedIn Application page](https://www.linkedin.com/developer/apps)