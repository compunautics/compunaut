grafana:
  server:
    enabled: True
    bind:
      port: 3000
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_grafana_secrets', tgt_type='pillar').items() %}
    admin:
      user: {{ secrets.grafana_admin_user }}
      password: {{ secrets.grafana_unencrypted_admin_password }}
    database:
      engine: mysql
      host: compunaut_mysql_database.service.consul
      port: 3306
      name: compunaut_grafana
      user: compunaut_grafana
      password: {{ secrets.grafana_database_password }}
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
    auth:
      ldap:
        enabled: true
        host: 'compunaut-openldap.service.consul'
        port: 636
        use_ssl: 'true'
        bind_dn: ""
        bind_password: ""
        user_search_filter: "(uid=%s)"
        user_search_base_dns: 
          - "{{ secrets.ldap_base }}"
        servers:
          attributes:
            name: "givenName"
            surname: "sn"
            username: "uid"
            member_of: "memberOf"
            email: "mail"
        authorization:
          enabled: true
          admin_group: "cn=grafana_admin,ou=Groups,{{ secrets.ldap_base }}"
          editor_group: "cn=grafana_editor,ou=Groups,{{ secrets.ldap_base }}"
          viewer_group: "cn=grafana_viewer,ou=Groups,{{ secrets.ldap_base }}"
{%- endfor %}
      basic:
        enabled: true
    dashboards:
      enabled: true
      path: /var/lib/grafana/dashboards
    plugins:
      vonage-status-panel:
        enabled: true
      jdbranham-diagram-panel:
        enabled: true
      grafana-clock-panel:
        enabled: true
      grafana-polystat-panel:
        enabled: true
