telegraf:
  inputs:
    exec:
      commands:
        - /etc/telegraf/telegraf.d/checks/check_rundeck.py
      timeout: "5s"
      name_suffix: "_custom"
      data_format: "influx"
  secrets:
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
    rundeck_admin_user: {{ secrets.rundeck_admin_user }}
    rundeck_admin_unencrypted_password: {{ secrets.rundeck_admin_unencrypted_password }}
{%- endfor %}
