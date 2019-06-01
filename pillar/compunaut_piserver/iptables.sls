{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    53:
      protos:
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/16
    67:
      protos:
        - udp
    68:
      protos:
        - udp
    69:
      protos:
        - udp
    389:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/16
    111:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/16
    2049:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/16
    50001:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/16
    5901:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
{%- endfor %}
