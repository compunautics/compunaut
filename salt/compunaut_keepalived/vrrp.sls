vrrp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - protocol: vrrp
    - save: true
