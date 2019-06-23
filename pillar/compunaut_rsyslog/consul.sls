consul:
  register:
    - name: compunaut-rsyslog
      checks:
        - name: Compunaut Rsyslog Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/rsyslogd"
            - -c
            - "1:"
          interval: 10s
