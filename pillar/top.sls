base:
  '*kvm*':
    - compunaut_kvm
  '*proxy*':
    - compunaut_keepalived
  '*salt*':
    - compunaut_salt
    - compunaut_kvm
  '*vpn*':
    - compunaut_keepalived
    - compunaut_openvpn
  '*':
    - compunaut_chronyd
    - compunaut_consul
    - compunaut_default
    - compunaut_dns
    - compunaut_iptables
    - compunaut_pki
