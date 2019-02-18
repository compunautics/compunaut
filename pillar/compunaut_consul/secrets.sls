{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_octoprint_secrets', tgt_type='pillar').items() %}
compunaut_consul:
  secrets:
    octoprint: {{ secrets.octoprint_api_key }}
{%- endfor %}
