include:
  - compunaut_keepalived.consul
{%- if 'vpn' in grains['id'] %}
  - compunaut_keepalived.vi_vpn
{%- elif 'proxy' in grains['id'] %}
  - compunaut_keepalived.vi_proxy
{%- endif %}

compunaut_keepalived:
  enabled: True
