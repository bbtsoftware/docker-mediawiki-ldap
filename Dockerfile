# from https://hub.docker.com/_/mediawiki
FROM mediawiki:1.34.4

# Add extensions:

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
      https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Auth_remoteuser \
      /var/www/html/extensions/Auth_remoteuser

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
      https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LoopFunctions \
      /var/www/html/extensions/LoopFunctions

# Activate Apache LDAP
RUN a2enmod ldap authnz_ldap
