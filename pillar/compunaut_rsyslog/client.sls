include:
  - compunaut_rsyslog.consul_rsyslog_client

rsyslog:
  target: compunaut-rsyslog-server.service.consul
  protocol: udp
  custom:
    - salt://compunaut_default/rsyslog/50-default.conf
