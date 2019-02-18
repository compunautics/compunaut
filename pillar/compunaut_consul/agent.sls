{%- set hostname = grains['id'] %}
consul:
  service: True
  user: consul
  group: consul
  version: 1.4.2
  download_host: releases.hashicorp.com
  config:
    node_name: {{ hostname }}
    protocol: 3
    server: False
    datacenter: compunaut
    ui: False
    enable_script_checks: True
    log_level: info
    data_dir: /opt/consul
    retry_interval: 15s
    retry_join:
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_consul:server:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {%- if minion != hostname %}
    {%- if interfaces['ens2'] is not defined %}
      {%- set retry_join = '127.0.0.1' %}
    {%- else %}
      {%- set retry_join = interfaces['ens2']['inet'][0]['address'] %}
    {%- endif %}
      - {{ retry_join }}
  {%- endif %}
{%- endfor %}
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set bind_addr = grains['ip4_interfaces']['ens2'][0] %}
    bind_addr: {{ bind_addr }}
    client_addr: "{{ bind_addr }} 127.0.0.1"
{%- elif grains['ip4_interfaces']['br0'] is defined %}
  {%- set bind_addr = grains['ip4_interfaces']['br0'][0] %}
    bind_addr: {{ bind_addr }}
    client_addr: "{{ bind_addr }} 127.0.0.1"
{%- elif grains['ip4_interfaces']['eth0'] is defined %}
  {%- set bind_addr = grains['ip4_interfaces']['eth0'][0] %}
    bind_addr: {{ bind_addr }}
    client_addr: "{{ bind_addr }} 127.0.0.1"
{%- endif %}
{%- for minion, id in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_minion_id', tgt_type='pillar' ).items() %}
  {%- set set_consul_encryption = salt['cmd.shell']('echo '+id|string+' | sha256sum | cut -d- -f1 | cut -c1-15 | base64') %}
    encrypt: {{ set_consul_encryption }}
{%- endfor %}
