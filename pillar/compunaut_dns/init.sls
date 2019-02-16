include:
  - compunaut_dnsmasq.consul
{% if 'salt' in grains['id'] %}
  - compunaut_dnsmasq.salt
{% elif 'kvm' in grains['id'] %}
  - compunaut_dnsmasq.salt
{% elif 'vpn' in grains['id'] %}
  - compunaut_dnsmasq.server
  - compunaut_dnsmasq.iptables
{% else %}
  - compunaut_dnsmasq.client
{% endif %}
