include:
  - compunaut_dns.consul
{%- if 'salt' in grains['id'] %}
  - compunaut_dns.kvm
{%- elif 'kvm' in grains['id'] %}
  - compunaut_dns.kvm
{%- elif 'vpn' in grains['id'] %}
  - compunaut_dns.server
  - compunaut_dns.iptables
{%- else %}
  - compunaut_dns.client
{%- endif %}

compunaut_dns:
  enabled: True
