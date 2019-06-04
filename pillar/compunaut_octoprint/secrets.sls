{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_octoprint_secrets', tgt_type='pillar').items() %}
compunaut_octoprint:
  secrets:
    octoprint_api_key: "{{ secrets.octoprint_api_key }}"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
    ldap_base: "{{ secrets.ldap_base }}"
{%- endfor %}
