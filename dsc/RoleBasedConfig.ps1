$ConfigurationData = @{
  AllNodes = @(
    @{NodeName = 'Server1';Role='Web'},
    @{NodeName = 'Server2';Role='FileShare'}
    @{NodeName = 'Server3';Role=@('FileShare','Web')}
  )
}

configuration RoleConfiguration
{
    param ($Roles)

    switch ($Roles)
    {
        'FileShare' {
                        WindowsFeature FileSharing
                        {
                            Name = 'FS-FileServer'
                        } 
                    }
        'Web'       {
                        WindowsFeature Web
                        {
                            Name = 'web-Server'
                        } 
                    }        
    }
}

configuration MyFirstServerConfig 
{
    node $allnodes.NodeName
    {
        WindowsFeature snmp
        {
            Name = 'SNMP-Service'
        }       

        RoleConfiguration MyServerRoles
        {
            Roles = $Node.Role
        }
    }
}