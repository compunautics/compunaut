base:
  'compunaut_kvm:enabled:True':
    - match: pillar
    - compunaut_kvm
    - compunaut_openmanage
  'compunaut_salt:enabled:True':
    - match: pillar
    - compunaut_pki
  'compunaut_pki:enabled:True':
    - match: pillar
    - compunaut_pki
  'compunaut_keepalived:enabled:True':
    - match: pillar
    - compunaut_keepalived
  'compunaut_openvpn:enabled:True':
    - match: pillar
    - compunaut_openvpn
  'compunaut_dns:enabled:True':
    - match: pillar
    - compunaut_dns
  'compunaut_consul:enabled:True':
    - match: pillar
    - compunaut_consul
  'compunaut_mysql:enabled:True':
    - match: pillar
    - compunaut_mysql
  'compunaut_haproxy:enabled:True':
    - match: pillar
    - compunaut_haproxy
  '*':
    - compunaut_chronyd
    - compunaut_default
    - compunaut_iptables
