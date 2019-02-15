base:
  'compunaut_chronyd:enabled:True':
    - match: pillar
    - compunaut_chronyd
  'compunaut_pki:enabled:True':
    - match: pillar
    - compunaut_pki
  '*':
    - compunaut_default
    - compunaut_iptables
