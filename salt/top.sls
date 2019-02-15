base:
  'compunaut_chronyd:enabled:True':
    - match: pillar
    - compunaut_chronyd
  '*':
    - compunaut_default
    - compunaut_iptables
