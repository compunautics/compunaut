{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
keepalived:
  vrrp_instance:
    vi_proxy:
      notify: "/etc/keepalived/notify.sh"
      state: BACKUP
      interface: ens2
      virtual_router_id: 30
      priority: 100
      advert_int: 1
      authentication:
        auth_type: PASS
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_keepalived_secrets', tgt_type='pillar').items() %}
        auth_pass: {{ secrets.keepalived_auth_pass }}
  {%- endfor %}
      virtual_ipaddress:
        - {{ vars.public_net }}.{{ vars.proxy_vip }}
{%- endfor %}
