telegraf:
  secrets:
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_octoprint_secrets', tgt_type='pillar').items() %}
    octoprint_api_key: {{ secrets.octoprint_api_key }}
{%- endfor %}
