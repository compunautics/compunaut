{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_guacamole_secrets', tgt_type='pillar').items() %}
compunaut_guacamole:
  secrets:
    guac_admin_user: "{{ secrets.guac_admin_user }}"
    guac_database_password: "{{ secrets.guac_database_password }}"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
    ldap_base: "{{ secrets.ldap_base }}"
    ldap_rootdn: "{{ secrets.ldap_rootdn }}"
    ldap_unencrypted_rootpw: "{{ secrets.ldap_unencrypted_rootpw }}"
{%- endfor %}
