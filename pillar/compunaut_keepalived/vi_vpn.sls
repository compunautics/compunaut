{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
keepalived:
  config:
    vrrp_script:
      check_openvpn:
        script: '"pgrep -f openvpn"'
        interval: 5
        weight: 10
        rise: 2
        fall: 2
    vrrp_instance:
      vi_vpn:
        notify: "/etc/keepalived/notify.sh"
        track_script:
          - check_openvpn
        state: BACKUP
        interface: ens2
        virtual_router_id: 29
        priority: 100
        advert_int: 1
        authentication:
          auth_type: PASS
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_keepalived_secrets', tgt_type='pillar').items() %}
          auth_pass: {{ secrets.keepalived_auth_pass }}
  {%- endfor %}
        virtual_ipaddress:
          - {{ vars.public_net }}.{{ vars.vpn_vip }}
    virtual_server:
{%- endfor %}
