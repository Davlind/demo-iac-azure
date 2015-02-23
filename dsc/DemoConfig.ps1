configuration DemoConfig {

    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    node localhost {
        
        WindowsFeature MSMQFeature {
            Name = "MSMQ-Server"
            Ensure = "Present"
        }

        xRemoteFile ChromeDownload
        {
            Uri = "https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={00000000-0000-0000-0000-000000000000}&lang=en&browser=3&usagestats=0&appname=Google%2520Chrome&needsadmin=prefers/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi" 
            DestinationPath = "C:\Downloads\GoogleChromeStandaloneEnterprise.msi"
        }
         
        Package ChromeInstall
        {
            Ensure = "Present"
            Path = "C:\Downloads\GoogleChromeStandaloneEnterprise.msi"
            Name = "Google Chrome"
            ProductId = ''
            DependsOn = "[xRemoteFile]DownloadChrome"
        }
    }
}