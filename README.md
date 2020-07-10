# Mediawiki with Apache based LDAP authentication

Mediawiki with Apache based LDAP authentication and some other extensions.

Based on the [official Mediawiki container](https://hub.docker.com/_/mediawiki).

## Information

| Service | Stats                                                                                     |
|---------|-------------------------------------------------------------------------------------------|
| Docker  | [![Build](https://img.shields.io/docker/cloud/build/bbtsoftwareag/mediawiki-ldap.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/mediawiki-ldap/builds) [![Pulls](https://img.shields.io/docker/pulls/bbtsoftwareag/mediawiki-ldap.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/mediawiki-ldap) [![Stars](https://img.shields.io/docker/stars/bbtsoftwareag/mediawiki-ldap.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/mediawiki-ldap) [![Automated](https://img.shields.io/docker/cloud/automated/bbtsoftwareag/mediawiki-ldap.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/mediawiki-ldap/builds) |
| GitHub  | [![Last commit](https://img.shields.io/github/last-commit/bbtsoftware/docker-mediawiki-ldap.svg?style=flat-square)](https://github.com/bbtsoftware/docker-mediawiki-ldap/commits/master) [![Issues](https://img.shields.io/github/issues-raw/bbtsoftware/docker-mediawiki-ldap.svg?style=flat-square)](https://github.com/bbtsoftware/docker-mediawiki-ldap/issues) [![PR](https://img.shields.io/github/issues-pr-raw/bbtsoftware/docker-mediawiki-ldap.svg?style=flat-square)](https://github.com/bbtsoftware/docker-mediawiki-ldap/pulls) [![Size](https://img.shields.io/github/repo-size/bbtsoftware/docker-mediawiki-ldap.svg?style=flat-square)](https://github.com/bbtsoftware/docker-mediawiki-ldap/) [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/bbtsoftware/docker-mediawiki-ldap/blob/master/LICENSE) |

## General

| Topic  | Description                                                             |
|--------|-------------------------------------------------------------------------|
| Image  | See [Docker Hub](https://hub.docker.com/repository/docker/bbtsoftwareag/mediawiki-ldap). |
| Source | See [GitHub](https://github.com/bbtsoftware/docker-mediawiki-ldap).      |

## Installation

```sh
docker pull bbtsoftwareag/docker-mediawiki-ldap
```

### Tags

| Tag    | Description                                                                                                      | Size                                                                                                                    |
|--------|------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------|
| latest | Latest release                                                                                                   | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/mediawiki-ldap/latest.svg?style=flat-square) |
| 1.34.2 | Release matching to mediawiki [1.34.2](https://github.com/bbtsoftware/docker-mediawiki-ldap/releases/tag/1.34.2) | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/mediawiki-ldap/1.34.2.svg?style=flat-square) |

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
