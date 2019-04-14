{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    http:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/16
        - {{ vars.openvpn_net }}.0/24
    https:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/16
        - {{ vars.openvpn_net }}.0/24
{% endfor %}
