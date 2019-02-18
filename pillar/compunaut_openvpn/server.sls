{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
openvpn:
  lookup:
    dh_files: []
  server:
    compunaut_vpn:
      ca: /etc/ssl/private/ca.crt
      cert: /etc/ssl/private/compunaut_pki.crt
      key: /etc/ssl/private/compunaut_pki.key
      dh: /etc/ssl/private/dhparams.pem
      server: "{{ vars.openvpn_net }}.0 255.255.255.0"
      proto: tcp-server
      port: 1194
      dev: tun
      tun_mtu: 8950
      client_to_client: True
      keepalive: '5 30'
      management: '127.0.0.1 11940 /etc/openvpn/man.pass'
      push:
        - "dhcp-option DNS {{ vars.openvpn_net }}.1"
        - "push {{ vars.public_net }}.0 255.255.255.0 vpn_gateway 100"
{%- endfor %}
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openvpn_secrets', tgt_type='pillar').items() %}
compunaut_openvpn:
  management_secret: {{ secrets.openvpn_management_password }}
{%- endfor %}
