{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    8301:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/24
    8500:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
    8600:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/24
    8300:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
    8302:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/24
{%- endfor %}
