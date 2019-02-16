base:
  '*proxy*':
    - compunaut_keepalived
  '*salt*':
    - compunaut_salt
  '*vpn*':
    - compunaut_keepalived
  '*':
    - compunaut_chronyd
    - compunaut_default
    - compunaut_dns
    - compunaut_iptables
    - compunaut_pki
