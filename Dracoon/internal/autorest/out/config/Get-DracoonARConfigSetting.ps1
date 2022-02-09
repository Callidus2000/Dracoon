function Get-DracoonARConfigSetting {
<#
.SYNOPSIS
    Request system settings

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.6.0</h3>

### Description:  
Returns a list of configurable system settings.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read global config</span> required.

### Postcondition:
List of configurable settings is returned.

### Further Information:
Check for every settings key new corresponding API and key below.

If `eula_active` is true, but **NOT** accepted yet, or password **MUST** be changed, only the following two values are returned:
* `allow_system_global_weak_password`
* `eula_active`

### Configurable settings
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `branding_server_branding_id` | The branding UUID, which corresponds to _BRANDING-QUALIFIER_ in the new branding server.<br>cf. `GET /system/config/settings/branding` `BrandingConfig.brandingQualifier` | `String` |
| `branding_portal_url` | Access URL to to the Branding Portal<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/branding` `BrandingConfig.brandingProviderUrl` | `String` |
| `dblog` | Write logs to local database.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/eventlog` `EventlogConfig.enabled` | `true or false` |
| `default_downloadshare_expiration_period` | Default expiration period for Download Shares in days<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.downloadShareDefaultExpirationPeriod` | `Integer between 0 and 9999` |
| `default_file_upload_expiration_date` | Default expiration period for all uploaded files in days<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.fileDefaultExpirationPeriod` | `Integer between 0 and 9999` |
| `default_language` | Define which language should be default.<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.languageDefault` | cf. `GET /public/system/info` - `SystemInfo.languageDefault` |
| `default_uploadshare_expiration_period` | Default expiration period for Upload Shares in days<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.uploadShareDefaultExpirationPeriod` | `Integer between 0 and 9999` |
| `enable_client_side_crypto` | Activation status of client-side encryption<br>Can only be enabled once; disabling is **NOT** possible.<br>cf. `GET /system/config/settings/general` `GeneralSettings.cryptoEnabled` | `true or false`<br>default: `false` |
| `eula_active` | Each user has to confirm the EULA at first login.<br>cf. `GET /system/config/settings/general` `GeneralSettings.eulaEnabled` | `true or false` |
| `eventlog_retention_period` | Retention period (in days) of event log entries<br>After that period, all entries are deleted.<br>cf. `GET /system/config/settings/eventlog` `EventlogConfig.retentionPeriod` | `Integer between 0 and 9999`<br>If set to `0`: no logs are deleted<br>Recommended value: `7` |
| `ip_address_logging` | Determines whether a user's IP address is logged.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/eventlog` `EventlogConfig.logIpEnabled`<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.logIpEnabled` | `true or false` |
| `mailserver` | Email server to send emails.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.host` | `DNS name or IPv4 of an email server` |
| `mailserver_authentication_necessary` | Set to `true` if the email server requires authentication.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.authenticationEnabled` | `true or false` |
| `mailserver_password` | **Password is no longer returned.**<br>Check `mailserver_password_set` to determine whether password is set. |  |
| `mailserver_password_set` | Indicates if a password is set for the mailserver (because `mailserver_password` is always returned empty).<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.passwordDefined` | `true or false` |
| `mailserver_port` | Email server port<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.port` | `Valid port number` |
| `mailserver_username` | User ame for email server<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.username` | `Username for authentication` |
| `mailserver_use_ssl` | Email server requires SSL connection?<br>Only visible for _Config Manager_ of Provider Customer.<br>Requires `mailserver_use_starttls` to be `false`<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.username` | `true or false` |
| `mailserver_use_starttls` | Email server requires StartTLS connection?<br>Only visible for _Config Manager_ of Provider Customer.<br>Requires `mailserver_use_ssl` to be `false`<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.starttlsEnabled` | `true or false` |
| `syslog` | Write logs to a syslog interface.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.enabled` | `true or false` |
| `syslog_host` | Syslog server (IP or FQDN)<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.host` | `DNS name or IPv4 of a syslog server` |
| `syslog_port` | Syslog server port<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.port` | `Valid port number` |
| `syslog_protocol` | Protocol to connect to syslog server.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.protocol` | `TCP or UDP` |
| `enable_email_notification_button` | Enable mail notification button.<br>cf. `GET /system/config/settings/general` `GeneralSettings.emailNotificationButtonEnabled` | `true or false` |
| `allow_share_password_sms` | Allow sending of share passwords via SMS.<br>cf. `GET /system/config/settings/general` `GeneralSettings.sharePasswordSmsEnabled` | `true or false` |
| `globally_allow_share_password_sms` | Allow sending of share passwords via SMS **system-wide** (read-only).<br>cf. `GET /system/config/settings/infrastructure` `InfrastructureProperties.smsConfigEnabled` | `true or false` |
| `use_s3_storage` | Defines if S3 is used as storage backend.<br>Can only be enabled once; disabling is **NOT** possible.<br>cf. `GET /system/config/settings/general` `GeneralSettings.useS3Storage` | `true or false` |
| `s3_default_region` |Suggested S3 region (read-only)<br>cf. `GET /system/config/settings/infrastructure` `InfrastructureProperties.s3DefaultRegion` | `Region name` |

</details>

### Deprecated settings
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| <del>`allow_system_global_weak_password`</del> | Determines whether weak password (cf. _Password Policy_ below) is allowed.<br>cf. `GET /system/config/settings/general` `GeneralSettings.weakPasswordEnabled`<br>Use `GET /system/config/policies/passwords` API to get configured password policies. | `true or false` |
| <del>`branding_server_customer`</del> | The UUID of the branding server customer, which corresponds to customer key in the branding server. | `String` |
| <del>`branding_server_url`</del> | Access URL to to the Branding Server.<br>Only visible for _Config Manager_ of Provider Customer. | `String` |
| <del>`email_from`</del> | Sender of system-generated emails<br>Only visible for _Config Manager_ of Provider Customer.<br>**Moved to branding** | `Valid email address` |
| <del>`email_to_sales`</del> | Contact email address for customers to request more user licenses or data volume.<br>**Moved to branding** | `Valid email address` |
| <del>`email_to_support`</del> | Support email address for users<br>**Moved to branding** | `Valid email address` |
| <del>`file_size_js`</del> | Maximum file size (in bytes) for downloads of encrypted files with JavaScript.<br>Bigger files will require a JavaApplet. | `Integer`<br>Recommended value: `10485760` (=`10MB`) |
| <del>`system_name`</del> | System name<br>**Moved to branding** use `product.title` | `Display name of the DRACOON` |

</details>

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Get-DracoonARConfigSetting -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.6.0</h3>

### Description:  
Returns a list of configurable system settings.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read global config</span> required.

### Postcondition:
List of configurable settings is returned.

### Further Information:
Check for every settings key new corresponding API and key below.

If `eula_active` is true, but **NOT** accepted yet, or password **MUST** be changed, only the following two values are returned:
* `allow_system_global_weak_password`
* `eula_active`

### Configurable settings
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `branding_server_branding_id` | The branding UUID, which corresponds to _BRANDING-QUALIFIER_ in the new branding server.<br>cf. `GET /system/config/settings/branding` `BrandingConfig.brandingQualifier` | `String` |
| `branding_portal_url` | Access URL to to the Branding Portal<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/branding` `BrandingConfig.brandingProviderUrl` | `String` |
| `dblog` | Write logs to local database.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/eventlog` `EventlogConfig.enabled` | `true or false` |
| `default_downloadshare_expiration_period` | Default expiration period for Download Shares in days<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.downloadShareDefaultExpirationPeriod` | `Integer between 0 and 9999` |
| `default_file_upload_expiration_date` | Default expiration period for all uploaded files in days<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.fileDefaultExpirationPeriod` | `Integer between 0 and 9999` |
| `default_language` | Define which language should be default.<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.languageDefault` | cf. `GET /public/system/info` - `SystemInfo.languageDefault` |
| `default_uploadshare_expiration_period` | Default expiration period for Upload Shares in days<br>cf. `GET /system/config/settings/defaults` `SystemDefaults.uploadShareDefaultExpirationPeriod` | `Integer between 0 and 9999` |
| `enable_client_side_crypto` | Activation status of client-side encryption<br>Can only be enabled once; disabling is **NOT** possible.<br>cf. `GET /system/config/settings/general` `GeneralSettings.cryptoEnabled` | `true or false`<br>default: `false` |
| `eula_active` | Each user has to confirm the EULA at first login.<br>cf. `GET /system/config/settings/general` `GeneralSettings.eulaEnabled` | `true or false` |
| `eventlog_retention_period` | Retention period (in days) of event log entries<br>After that period, all entries are deleted.<br>cf. `GET /system/config/settings/eventlog` `EventlogConfig.retentionPeriod` | `Integer between 0 and 9999`<br>If set to `0`: no logs are deleted<br>Recommended value: `7` |
| `ip_address_logging` | Determines whether a user's IP address is logged.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/eventlog` `EventlogConfig.logIpEnabled`<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.logIpEnabled` | `true or false` |
| `mailserver` | Email server to send emails.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.host` | `DNS name or IPv4 of an email server` |
| `mailserver_authentication_necessary` | Set to `true` if the email server requires authentication.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.authenticationEnabled` | `true or false` |
| `mailserver_password` | **Password is no longer returned.**<br>Check `mailserver_password_set` to determine whether password is set. |  |
| `mailserver_password_set` | Indicates if a password is set for the mailserver (because `mailserver_password` is always returned empty).<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.passwordDefined` | `true or false` |
| `mailserver_port` | Email server port<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.port` | `Valid port number` |
| `mailserver_username` | User ame for email server<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.username` | `Username for authentication` |
| `mailserver_use_ssl` | Email server requires SSL connection?<br>Only visible for _Config Manager_ of Provider Customer.<br>Requires `mailserver_use_starttls` to be `false`<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.username` | `true or false` |
| `mailserver_use_starttls` | Email server requires StartTLS connection?<br>Only visible for _Config Manager_ of Provider Customer.<br>Requires `mailserver_use_ssl` to be `false`<br>cf. `GET /system/config/settings/mail_server` `MailServerConfig.starttlsEnabled` | `true or false` |
| `syslog` | Write logs to a syslog interface.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.enabled` | `true or false` |
| `syslog_host` | Syslog server (IP or FQDN)<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.host` | `DNS name or IPv4 of a syslog server` |
| `syslog_port` | Syslog server port<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.port` | `Valid port number` |
| `syslog_protocol` | Protocol to connect to syslog server.<br>Only visible for _Config Manager_ of Provider Customer.<br>cf. `GET /system/config/settings/syslog` `SyslogConfig.protocol` | `TCP or UDP` |
| `enable_email_notification_button` | Enable mail notification button.<br>cf. `GET /system/config/settings/general` `GeneralSettings.emailNotificationButtonEnabled` | `true or false` |
| `allow_share_password_sms` | Allow sending of share passwords via SMS.<br>cf. `GET /system/config/settings/general` `GeneralSettings.sharePasswordSmsEnabled` | `true or false` |
| `globally_allow_share_password_sms` | Allow sending of share passwords via SMS **system-wide** (read-only).<br>cf. `GET /system/config/settings/infrastructure` `InfrastructureProperties.smsConfigEnabled` | `true or false` |
| `use_s3_storage` | Defines if S3 is used as storage backend.<br>Can only be enabled once; disabling is **NOT** possible.<br>cf. `GET /system/config/settings/general` `GeneralSettings.useS3Storage` | `true or false` |
| `s3_default_region` |Suggested S3 region (read-only)<br>cf. `GET /system/config/settings/infrastructure` `InfrastructureProperties.s3DefaultRegion` | `Region name` |

</details>

### Deprecated settings
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| <del>`allow_system_global_weak_password`</del> | Determines whether weak password (cf. _Password Policy_ below) is allowed.<br>cf. `GET /system/config/settings/general` `GeneralSettings.weakPasswordEnabled`<br>Use `GET /system/config/policies/passwords` API to get configured password policies. | `true or false` |
| <del>`branding_server_customer`</del> | The UUID of the branding server customer, which corresponds to customer key in the branding server. | `String` |
| <del>`branding_server_url`</del> | Access URL to to the Branding Server.<br>Only visible for _Config Manager_ of Provider Customer. | `String` |
| <del>`email_from`</del> | Sender of system-generated emails<br>Only visible for _Config Manager_ of Provider Customer.<br>**Moved to branding** | `Valid email address` |
| <del>`email_to_sales`</del> | Contact email address for customers to request more user licenses or data volume.<br>**Moved to branding** | `Valid email address` |
| <del>`email_to_support`</del> | Support email address for users<br>**Moved to branding** | `Valid email address` |
| <del>`file_size_js`</del> | Maximum file size (in bytes) for downloads of encrypted files with JavaScript.<br>Bigger files will require a JavaApplet. | `Integer`<br>Recommended value: `10485760` (=`10MB`) |
| <del>`system_name`</del> | System name<br>**Moved to branding** use `product.title` | `Display name of the DRACOON` |

</details>

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'config/settings'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}