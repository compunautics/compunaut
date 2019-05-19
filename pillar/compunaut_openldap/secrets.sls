openldap:
  secrets:
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_grafana_secrets', tgt_type='pillar').items() %}
    grafana_admin_user: "{{ secrets.grafana_admin_user }}"
    grafana_admin_password: "{{ secrets.grafana_admin_password  }}"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
    rundeck_admin_user: "{{ secrets.rundeck_admin_user }}"
    rundeck_admin_password: "{{ secrets.rundeck_admin_password }}"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_gitlab_secrets', tgt_type='pillar').items() %}
    gitlab_admin_user: "{{ secrets.gitlab_admin_user }}"
    gitlab_admin_password: "{{ secrets.gitlab_admin_password }}"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_guacamole_secrets', tgt_type='pillar').items() %}
    guac_admin_user: "{{ secrets.guac_admin_user }}"
    guac_admin_password: "{{ secrets.guac_admin_password }}"
    guac_vnc_password: "{{ secrets.guac_vnc_password }}"
{%- endfor %}
