base:
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
