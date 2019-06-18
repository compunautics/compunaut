{%- set existing_groups = [] %}
manage_compunaut_login_groups:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          dn: "{{ pillar.openldap.rootdn }}"
          password: "{{ pillar.openldap.unencrypted_rootpw }}"
    - entries:
      - 'ou=Groups,{{ pillar.openldap.base }}':
        - replace:
            ou:
              - Groups
            objectClass:
              - organizationalUnit
      - 'cn=compunaut_ldap_admin,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - compunaut_ldap_admin
            objectClass:
              - top
              - groupOfNames
            member:
              - cn=compunaut_system,ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for LDAP Administration rights
      - 'cn=compunaut_users,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - compunaut_users
            objectClass:
              - top
              - posixGroup
            gidNumber: 1500
            description:
              - This group does nothing; it exists only as a generic group for all users
      - 'cn=compunaut_sudo,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - sudo
              - compunaut_sudo
            objectClass:
              - top
              - posixGroup
            gidNumber: 27
            memberUid:
              - compunaut_system
            description:
              - Sudoers; Add users to this group if they should have sudoers access to linux
      - 'cn=compunaut_linux,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - compunaut_linux
            objectClass:
              - top
              - groupOfNames
            member:
              - cn=compunaut_system,ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Linux Access; Add users to sudo if they should also have sudoers access
      - 'cn=compunaut_consul,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - compunaut_consul
            objectClass:
              - top
              - posixGroup
            gidNumber: 661
            memberUid:
              - compunaut_system
            description:
              - Group for Consul UI Access
      - 'cn=compunaut_octoprint,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - compunaut_octoprint
            objectClass:
              - top
              - posixGroup
            gidNumber: 601
            memberUid:
              - compunaut_system
            description:
              - This group allows access to the Octoprint UI of the printers
      - 'cn=gitlab_user,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - gitlab_user
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.gitlab_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Gitlab Users
      - 'cn=rundeck_admin,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - rundeck_admin
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.rundeck_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Rundeck Admins
{%- for minion, projects in salt['mine.get']('compunaut_rundeck:enabled:True', fun='get_rundeck_projects', tgt_type='pillar').iteritems() %}
  {%- if projects is defined %}
    {%- for project, args in projects.items() %}
      {%- if project not in existing_groups %}
      - 'cn=rundeck_{{ project|lower }},ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn: 
              - rundeck_{{ project|lower }}
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.rundeck_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for access to the {{ project }} project
        {% do existing_groups.append(project) %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
      - 'cn=grafana_admin,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - grafana_admin
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.grafana_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Grafana Admins
      - 'cn=grafana_editor,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - grafana_editor
            objectClass:
              - top
              - groupOfNames
            member:
              - cn=compunaut_system,ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Grafana Editors
      - 'cn=grafana_viewer,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - grafana_viewer
            objectClass:
              - top
              - groupOfNames
            member:
              - cn=compunaut_system,ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Grafana Viewers
      - 'cn=guacamole_user,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - guacamole_user
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.guac_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Grafana Viewers
