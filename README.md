# Mediawiki with Apache based LDAP authentication

Mediawiki with Apache based LDAP authentication and some other extensions.

Based on the official Mediawiki container.

## General

| Topic  | Description                                                             |
|--------|-------------------------------------------------------------------------|
| Image  | See [Docker Hub](https://hub.docker.com/repository/docker/neredera/mediawiki-ldap). |
| Source | See [GitHub](https://github.com/neredera/docker-mediawiki-ldap).      |

## Installation

```sh
docker pull neredera/docker-mediawiki-ldap
```

### Tags

| Tag    | Description                                                                                                   | Size                                                                                                                             |
|--------|---------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| latest | Latest master build                                                                                           | ![Size](https://shields.beevelop.com/docker/image/image-size/neredera/mediawiki-ldap/latest.svg?style=flat-square) |
| 1.34.2 | Release matching to mediawiki [1.34.2](https://github.com/neredera/docker-mediawiki-ldap/releases/tag/1.34.2) | ![Size](https://shields.beevelop.com/docker/image/image-size/neredera/mediawiki-ldap/1.34.2.svg?style=flat-square) |

### Volumes

Specific for LDAP authentication:

| File                                          | Description                                                         |
|-----------------------------------------------|---------------------------------------------------------------------|
| /var/www/html/LocalSettings.php               | Add wfLoadExtension('Auth_remoteuser'); to LocalSettings.php        |
| /etc/apache2/sites-available/000-default.conf | 000-default.conf |

## Samples

### 000-default.conf

```yaml
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Location />
                AuthName "LDAP Authentication"
                AuthType Basic
                AuthBasicProvider ldap
                AuthLDAPGroupAttribute member
                AuthLDAPGroupAttributeIsDN On

                # Example for Microsoft AD. For more details see Apache authnz_ldap documentation.
                AuthLDAPRemoteUserAttribute sAMAccountName
                AuthLDAPURL ldap://LdapServerHost:Port/?sAMAccountName?sub

                AuthLDAPBindDN "LdapUserDn"
                AuthLDAPBindPassword LdapUserPwd
                Require valid-user

        </Location>
</VirtualHost>
```
