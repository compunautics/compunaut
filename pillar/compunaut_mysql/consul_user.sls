mysql:
  user:
    consul:
      host: localhost
{%- for minion, id in salt.saltutil.runner('mine.get', tgt='compunaut_mysql:master:enabled:True', fun='get_minion_id', tgt_type='pillar' ).items() %}
  {%- set master_id = id | string %}
  {%- set command = 'echo '+master_id+master_id+' | sha256sum | cut -d- -f1' %} # define command to generate random password
      password: "{{ salt['cmd.shell'](command) }}"
{%- endfor %}

