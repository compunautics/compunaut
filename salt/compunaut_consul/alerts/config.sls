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
{%- for selection, configs in salt['pillar.get']('compunaut_consul:alerts:notif_selection').iteritems() %}
  {%- for key, value in configs.items() %}
    {%- if 'status' in selection %}
/consul-alerts/config/notif-selection/{{ selection }}/{{ key }}:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-selection/{{ selection }}/{{ key }}
      - value: {{ value }}
    {%- elif 'services' in selection %}
/consul-alerts/config/notif-selection/{{ selection }}:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-selection/{{ selection }}
      - value: {{ configs }}
    {%- endif %}
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
