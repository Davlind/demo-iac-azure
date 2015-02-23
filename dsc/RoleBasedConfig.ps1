$MyData = 
@{
    AllNodes = 
    @(
        @{
            NodeName = "*"
            LogPath  = "C:\Logs"
        },
        @{
            NodeName = "VM-1";
            Role     = "WebServer"
            SiteContents = "C:\Site1"
            SiteName = "Website1"
        },
        @{
            NodeName = "VM-2";
            Role     = "SQLServer"
        },
        @{
            NodeName = "VM-3";
            Role     = "WebServer";
            SiteContents = "C:\Site2"
            SiteName = "Website3"
        }
    );

    NonNodeData = 
    @{
        ConfigFileContents = (Get-Content C:\Template\Config.xml)
     }   
} 

configuration MyConfiguration
{
    Import-DscResource -ModuleName xWebAdministration -Name MSFT_xWebsite

    node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
        xWebsite Site
        {
            Name         = $Node.SiteName
            PhysicalPath = $Node.SiteContents
            Ensure       = "Present"
        }

        File ConfigFile
        {
            DestinationPath = $Node.SiteContents + "\\config.xml"
            Contents = $ConfigurationData.NonNodeData.ConfigFileContents
        }
    }
}