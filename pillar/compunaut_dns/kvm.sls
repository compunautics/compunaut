{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  settings:
    port: 53
    server:
      - 209.244.0.3
      - 209.244.0.4
      - 1.1.1.1
      - 1.0.0.1
      - /consul/127.0.0.1#8600
      - /private/{{ vars.public_net }}.{{ vars.vpn_vip }}
      - /prtr/{{ vars.public_net }}.{{ vars.vpn_vip }}
      - /public/{{ vars.public_net }}.{{ vars.vpn_vip }}
      - /real/{{ vars.public_net }}.{{ vars.vpn_vip }}
      - /vpn/{{ vars.public_net }}.{{ vars.vpn_vip }}
    no-resolv: True
    interface: lo
resolver:
  use_resolvconf: True
  nameservers:
    - 127.0.0.1
{%- endfor %}
