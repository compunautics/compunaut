manage_acls:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'olcDatabase={1}mdb,cn=config':
        - replace:
           olcAccess:
             - '{0}to dn.children="ou=Groups,{{ pillar.openldap.base }}" by self write by group.exact="cn=compunaut_ldap_admin,ou=Groups,{{ pillar.openldap.base }}" write by users read by * auth'
             - '{1}to dn.children="ou=Users,{{ pillar.openldap.base }}" by self write by group.exact="cn=compunaut_ldap_admin,ou=Groups,{{ pillar.openldap.base }}" write by users read by * auth'
             - '{2}to attrs=userPassword by self write by anonymous auth by * none'
             - '{3}to attrs=shadowLastChange by self write by * read'
             - '{4}to * by * read'
