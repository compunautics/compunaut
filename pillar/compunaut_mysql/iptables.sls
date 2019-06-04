{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    mysql:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
    4567:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
    4568:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
    4444:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/24
{%- endfor %}
