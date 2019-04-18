manage_guacConfigGroup:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'cn=guacConfigGroup,cn=schema,cn=config':
        - add:
            cn: 
              - guacConfigGroup
            objectClass:
              - olcSchemaConfig
            olcAttributeTypes:
              - "{0}( 1.3.6.1.4.1.38971.1.1.1 NAME 'guacConfigProtocol' SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )"
              - "{1}( 1.3.6.1.4.1.38971.1.1.2 NAME 'guacConfigParameter' SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )"
            olcObjectClasses:
              - "{0}( 1.3.6.1.4.1.38971.1.2.1 NAME 'guacConfigGroup' DESC 'Guacamole configuration group' SUP groupOfNames MUST guacConfigProtocol MAY guacConfigParameter )"
