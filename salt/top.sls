base:
  'compunaut_kvm:enabled:True':
    - match: pillar
    - compunaut_kvm
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
  '*':
    - compunaut_chronyd
    - compunaut_default
    - compunaut_iptables
