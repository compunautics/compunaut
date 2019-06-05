{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
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
    50101:
      protos:
        - tcp
        - udp
      ips_allow:
        - {{ vars.public_net }}.0/16
{%- endfor %}
