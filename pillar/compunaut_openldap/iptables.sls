{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    389:
      ips_allow:
        - {{ vars.public_net }}.0/24
    636:
      ips_allow:
        - {{ vars.public_net }}.0/24
    80:
      ips_allow:
        - {{ vars.public_net }}.0/24
{%- endfor %}
