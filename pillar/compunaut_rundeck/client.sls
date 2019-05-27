{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
rundeck:
  username: "{{ secrets.rundeck_admin_user }}"
  password: "{{ secrets.rundeck_admin_unencrypted_password }}"
  url: 'http://localhost:4440'
  client:
    enabled: True
    secret:
      octoprint/api_key:
        type: password
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_octoprint_secrets', tgt_type='pillar').items() %}
        content: "{{ secrets.octoprint_api_key }}"
  {%- endfor %}
      rundeck/top_user:
        type: password
        content: "{{ secrets.rundeck_admin_user }}"
      rundeck/top_password:
        type: password
        content: "{{ secrets.rundeck_admin_unencrypted_password }}"
    project:
      Node_Ops:
        description: Admin Operations against the whole platform
        plugin:
          import:
            address: https://github.com/compunautics/compunaut_rundeck_jobs.git
            format: yaml
            file_pattern: ".*Node_Ops.*\\.yaml"
      Print_Ops:
        description: Printer Operations against deployed printers
        plugin:
          import:
            address: https://github.com/compunautics/compunaut_rundeck_jobs.git
            format: yaml
            file_pattern: ".*Print_Ops.*\\.yaml"
{%- endfor %}
