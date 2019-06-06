###SET UP DEFAULT NOTIFICATION PROFILE
/consul-alerts/config/notif-profiles/default:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-profiles/default
      - value: |
          {{ pillar['compunaut_consul']['alerts']['notif-profiles']['default'] }}

###SET UP DEFAULT NOTIFICATION SELECTORS
/consul-alerts/config/notif-selection/warning:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-selection/status/warning
      - value: default

/consul-alerts/config/notif-selection/critical:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-selection/status/critical
      - value: default

###SET UP NOTIFIERS
{%- for node, slack_args in salt['pillar.get']('compunaut_consul:alerts:notifiers:slack').items() %}
  {%- for key, value in slack_args.items() %}
/consul-alerts/config/notifiers/slack/{{ key }}:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/slack/{{ key }}
      - value: {{ value }}
  {%- endfor %}
{%- endfor %}

/consul-alerts/config/notifiers/email/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/email/
