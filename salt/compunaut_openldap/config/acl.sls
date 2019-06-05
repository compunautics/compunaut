manage_acls:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'olcDatabase={1}mdb,cn=config':
        - add:
           olcAccess: "{3}to dn.children='{{ pillar.openldap.base }}' by group.exact='cn=compunaut_ldap_admin,ou=Groups,{{ pillar.openldap.base }}' write"
