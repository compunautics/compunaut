include:
  - compunaut_rsyslog.consul_rsyslog_server

rsyslog:
  listenudp: true
  logbasepath: /srv/remote_logs
  fileowner: root
  filegroup: root
  filemode: '0640'
  dirmode: '0755'
  ### optional forwarder from main syslog server to other remotes
  # target: placeholder.com
  # protocol: udp
