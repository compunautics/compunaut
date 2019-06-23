rsyslog:
  listenudp: true
  logbasepath: /srv/remote_logs
  fileowner: root
  filegroup: root
  filemode: '0640'
  dirmode: '0755'

compunaut_rsyslog
  server:
    enabled: True
