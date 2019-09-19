# Dockerized ldap client
  * ssl enforced
  * based on opensuse:leap

## minimal example
```bash
docker run --rm particlekit/ldap-client ldapsearch -w password \
-h ldap.forumsys.com -D 'uid=gauss,dc=example,dc=com' -b 'dc=example,dc=com'
```
