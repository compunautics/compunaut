include:
  - compunaut_rsyslog.consul_rsyslog_client

rsyslog:
  target: compunaut-rsyslog-server.service.consul
  protocol: udp
