###SET UP DEFAULT NOTIFICATION PROFILE
/consul-alerts/config/notif-profiles/default:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-profiles/default
      - value: {{ pillar['compunaut_consul']['alerts']['notif-profiles']['default'] }}

###SET UP DEFAULT NOTIFICATION SELECTORS
'consul kv put consul-alerts/config/notif-selection/status/warning default':
  cmd.run:
    - runas: root

'consul kv put consul-alerts/config/notif-selection/status/critical default':
  cmd.run:
    - runas: root

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
