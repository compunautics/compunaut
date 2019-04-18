include:
  - openldap
{%- if pillar.compunaut_openldap.enabled is defined %}
  - compunaut_openldap.config
  - compunaut_openldap.users
  - compunaut_openldap.groups
  - compunaut_openldap.restart
  - compunaut_openldap.phpldapadmin
{%- endif %}
