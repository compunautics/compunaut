{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    53:
      protos:
        - udp
      ips_allow:
        - {{ vars.private_net }}.0/24
        - {{ vars.public_net }}.0/16
{%- endfor %}
