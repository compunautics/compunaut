include:
  - openldap
{%- if pillar.compunaut_openldap is defined %}
  {%- if pillar.compunaut_openldap.enabled == True %}
  - compunaut_apache
  - compunaut_openldap.config
  - compunaut_openldap.users
  - compunaut_openldap.groups
  - compunaut_openldap.connections
  - compunaut_openldap.restart
  - compunaut_openldap.phpldapadmin
  - compunaut_openldap.self_service_password
  - compunaut_openldap.grain
  {%- endif %}
{%- endif %}
