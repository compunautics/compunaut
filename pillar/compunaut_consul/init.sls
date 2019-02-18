include:
  - compunaut_consul.iptables
  - compunaut_consul.telegraf
{%- if 'consul' in grains['id'] %}
  - compunaut_consul.server
  - compunaut_consul.haproxy
{%- else %}
  - compunaut_consul.agent
{%- endif %}

compunaut_consul:
  enabled: True
