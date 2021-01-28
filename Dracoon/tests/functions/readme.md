# Description

This is where the function tests go.

Make sure to put them in folders reflecting the actual module structure.

It is not necessary to differentiate between internal and public functions here.

The following PSFConfig-Settings are neeeded for the tests:
```
Set-PSFConfig -Module 'Dracoon' -Name 'pester.clientId' -Value "ThisIsAnID" -Description "The OAuth Client ID" -AllowDelete -PassThru | Register-PSFConfig
Set-PSFConfig -Module 'Dracoon' -Name 'pester.clientSecret' -Value "ThisShoudBeSecret" -Description "The OAuth Client Secret" -AllowDelete
Set-PSFConfig -Module 'Dracoon' -Name 'pester.credentials' -Value $credentials -AllowDelete -PassThru | Register-PSFConfig
Set-PSFConfig -Module 'Dracoon' -Name 'pester.fqdn' -Value "mydracoon.com" -AllowDelete -PassThru | Register-PSFConfig
```

Adding the parameters  `-PassThru | Register-PSFConfig` the settings get saved permanently in the registry.