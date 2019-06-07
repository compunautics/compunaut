###SET UP DEFAULT NOTIFICATION PROFILE
{%- for profile, configs in salt['pillar.get']('compunaut_consul:alerts:notif_profiles').iteritems() %}
/consul-alerts/config/notif-profiles/{{ profile }}:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-profiles/{{ profile }}
      - value: {{ configs }}
{%- endfor %}

###SET UP DEFAULT NOTIFICATION SELECTORS
{%- for selection, types in salt['pillar.get']('compunaut_consul:alerts:notif_selection').iteritems() %}
  {%- for type, configs in types.items() %}
    {%- for key, value in configs.items() %}
/consul-alerts/config/notif-selection/{{ type }}/{{ key }}:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-profiles/{{ type }}/{{ key }}
      - value: {{ value }}
    {%- endfor %}
  {%- endfor %}
{%- endfor %}

###SET UP NOTIFIERS
{%- for key, value in salt['pillar.get']('compunaut_consul:alerts:notifiers:slack').iteritems() %}
"consul kv put consul-alerts/config/notifiers/slack/{{ key }} {{ value }}":
  cmd.run:
    - runas: root
{%- endfor %}

{%- for key, value in salt['pillar.get']('compunaut_consul:alerts:notifiers:email').iteritems() %}
  {%- if 'receivers' in key %}
/consul-alerts/config/notifiers/email/receivers:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/email/receivers
      - value: {{ value }}
  {%- else %}
"consul kv put consul-alerts/config/notifiers/email/{{ key }} {{ value }}":
  cmd.run:
    - runas: root
  {%- endif %}
{%- endfor %}
