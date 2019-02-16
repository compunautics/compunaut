{% for minion, global_vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  settings:
    port: 53
    server: 
      - {{ vars.public_net }}.{{ vars.proxy_vip }}
      - /consul/127.0.0.1#8600
    no-resolv: True
    conf-dir: /etc/dnsmasq.d
    bind-dynamic: True
    local-service: True
resolver:
  use_resolvconf: True
  nameservers:
    - 127.0.0.1
{% endfor %}
