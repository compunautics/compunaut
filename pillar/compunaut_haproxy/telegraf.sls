telegraf:
  inputs:
    haproxy:
      servers:
        - 'socket:/var/lib/haproxy/stats'
