{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_gitlab_secrets', tgt_type='pillar').items() %}
gitlab:
  url: http://localhost/
  user: root
  token: {{ secrets.gitlab_root_token }}
  client:
    enabled: True
    group:
      compunaut:
        enabled: True
        description: This project contains repositories that can be used to manage local, private copies of the Compunautics repos from github.com. This is useful if unique customizations are needed.
    repository:
      compunaut/compunaut:
        enabled: True
{%- endfor %}
