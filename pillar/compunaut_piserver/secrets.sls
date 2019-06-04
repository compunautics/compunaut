compunaut_piserver:
  secrets:
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_guacamole_secrets', tgt_type='pillar').items() %}
    guac_vnc_password: "{{ secrets.guac_vnc_password }}"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
    ldap_base: "{{ secrets.ldap_base }}"
    ldap_rootdn: "{{ secrets.ldap_rootdn }}"
    ldap_unencrypted_rootpw: "{{ secrets.ldap_unencrypted_rootpw }}"
{%- endfor %}
