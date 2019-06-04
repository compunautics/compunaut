compunaut:
{%- set random_password = 'openssl rand -base64 12 2> /dev/null' %}
  users:
    compunaut:
      password: {{ salt['cmd.shell'](random_password) }}
