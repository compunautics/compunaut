{% for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  dnsmasq_addresses: salt://dnsmasq/files/dnsmasq.addresses
  settings:
    port: 53
    server:
      - 209.244.0.3
      - 209.244.0.4
      - 1.1.1.1
      - 1.0.0.1
      - /consul/127.0.0.1#8600
    no-resolv: True
    no-hosts: True
  addresses:
### SYSTEM ADDRESSES
    consul.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    control.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    gitlab.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    grafana.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    guacamole.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    ldap.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    password.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
    rundeck.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}

### VM ADDRESSES
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='not I@compunaut_kvm:enabled:True', fun='network.interfaces', tgt_type='compound').items() %}
  {%- if interfaces['ens2'] is defined %}
    {%- set ens2_addr = interfaces['ens2']['inet'][0]['address'] %}
    {{ minion }}: {{ ens2_addr }}
    {{ minion }}.public: {{ ens2_addr }}
  {%- endif %}
  {%- if interfaces['ens3'] is defined %}
    {%- set ens3_addr = interfaces['ens3']['inet'][0]['address'] %}
    {{ minion }}.private: {{ ens3_addr }}
  {%- endif %}
{%- endfor %}

### PRINTER ADDRESSES
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_octoprint:enable:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {%- if interfaces['eth0'] is defined %}
    {%- set eth0_addr = interfaces['eth0']['inet'][0]['address'] %}
    {{ minion }}: {{ eth0_addr }}
  {%- endif %}
{%- endfor %}
{%- for minion, args in salt.saltutil.runner('mine.get', tgt='I@compunaut_octoprint:enable:True', fun='grains.items', tgt_type='compound').items() %}
  {%- set public_hostname = args['host'] %}
    {{ public_hostname }}.{{ vars.domain }}: {{ vars.public_net }}.{{ vars.proxy_vip }}
{%- endfor %}

### HYPERVISOR ADDRESSES
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='I@compunaut_kvm:enabled:True', fun='network.interfaces', tgt_type='compound').items() %}
  {%- if interfaces['br0'] is defined %}
    {%- set br0_addr = interfaces['br0']['inet'][0]['address'] %}
    {{ minion }}: {{ br0_addr }}
    {{ minion }}.public: {{ br0_addr }}
  {%- endif %}
{%- endfor %}

resolver:
  use_resolvconf: True
  nameservers:
    - 127.0.0.1
{%- endfor %}

compunaut_dns:
  server:
    enabled: True
