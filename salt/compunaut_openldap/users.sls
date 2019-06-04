manage_compunaut_login_users:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          dn: "{{ pillar.openldap.rootdn }}"
          password: "{{ pillar.openldap.unencrypted_rootpw }}"
    - entries:
      - 'ou=Users,{{ pillar.openldap.base }}':
        - replace:
            ou:
              - Users
            objectClass:
              - organizationalUnit
      - "cn=compunaut_system,ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - compunaut_system
            sn:
              - compunaut_system
            uid:
              - compunaut_system
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1500
            uidNumber: 1000
            homeDirectory: /home/compunaut_system
            loginShell: /bin/false
            description:
              - This user does nothing; it only exists to initialize groups
      - "cn={{ pillar.openldap.secrets.grafana_admin_user }},ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - {{ pillar.openldap.secrets.grafana_admin_user }}
            sn:
              - {{ pillar.openldap.secrets.grafana_admin_user }}
            uid:
              - {{ pillar.openldap.secrets.grafana_admin_user }}
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1501
            uidNumber: 1000
            homeDirectory: /home/{{ pillar.openldap.secrets.grafana_admin_user }}
            loginShell: /bin/false
            userPassword: "{{ pillar.openldap.secrets.grafana_admin_password }}"
            description:
              - Generic Grafana Admin User
      - "cn={{ pillar.openldap.secrets.rundeck_admin_user }},ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - {{ pillar.openldap.secrets.rundeck_admin_user }}
            sn:
              - {{ pillar.openldap.secrets.rundeck_admin_user }}
            uid:
              - {{ pillar.openldap.secrets.rundeck_admin_user }}
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1502
            uidNumber: 1000
            homeDirectory: /home/{{ pillar.openldap.secrets.rundeck_admin_user }}
            loginShell: /bin/false
            userPassword: "{{ pillar.openldap.secrets.rundeck_admin_password }}"
            description:
              - Generic Rundeck Admin User
      - "cn={{ pillar.openldap.secrets.gitlab_admin_user }},ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - {{ pillar.openldap.secrets.gitlab_admin_user }}
            sn:
              - {{ pillar.openldap.secrets.gitlab_admin_user }}
            uid:
              - {{ pillar.openldap.secrets.gitlab_admin_user }}
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1503
            uidNumber: 1000
            mail: "admin@example.com"
            homeDirectory: /home/{{ pillar.openldap.secrets.gitlab_admin_user }}
            loginShell: /bin/false
            userPassword: "{{ pillar.openldap.secrets.gitlab_admin_password }}"
            description:
              - Generic Gitlab Admin User
      - "cn={{ pillar.openldap.secrets.guac_admin_user }},ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - {{ pillar.openldap.secrets.guac_admin_user }}
            sn:
              - {{ pillar.openldap.secrets.guac_admin_user }}
            uid:
              - {{ pillar.openldap.secrets.guac_admin_user }}
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1504
            uidNumber: 1000
            homeDirectory: /home/{{ pillar.openldap.secrets.guac_admin_user }}
            loginShell: /bin/false
            userPassword: "{{ pillar.openldap.secrets.guac_admin_password }}"
            description:
              - Generic Guacamole Admin User
