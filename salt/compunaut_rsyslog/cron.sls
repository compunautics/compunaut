/srv/remote_logs/cron_remote_logs.sh:
  file.managed:
    - source: salt://compunaut_rsyslog/cron/cron_remote_logs.sh
    - user: root
    - group: root
    - mode: 0750
    - makedirs: True

cron_remote_logs:
  cron.present:
    - name: /srv/remote_logs/cron_remote_logs.sh
    - user: root
    - minute: 45
    - hour: 4
    - comment: Cron to rotate remote logs
