base:
  'compunaut_kvm:enabled:True':
    - match: pillar
    - compunaut_kvm,compunaut_openmanage
  'compunaut_dns:enabled:True':
    - match: pillar
    - compunaut_dns
  'compunaut_salt:enabled:True':
    - match: pillar
    - compunaut_pki
  'compunaut_pki:enabled:True':
    - match: pillar
    - compunaut_pki
  'compunaut_keepalived:enabled:True':
    - match: pillar
    - compunaut_keepalived
  'compunaut_openvpn:enabled:True'
    - match: pillar
    - compunaut_openvpn
  '*':
    - compunaut_chronyd
    - compunaut_default
    - compunaut_iptables
