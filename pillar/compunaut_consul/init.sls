include:
  - compunaut_consul.audit
  - compunaut_consul.iptables
  - compunaut_consul.secrets
  - compunaut_consul.telegraf
{%- if 'consul' in grains['id'] %}
  - compunaut_consul.alerts
  - compunaut_consul.apache
  - compunaut_consul.consul
  - compunaut_consul.haproxy
  - compunaut_consul.server
{%- else %}
  - compunaut_consul.agent
{%- endif %}

compunaut_consul:
  enabled: True
