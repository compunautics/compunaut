/etc/sudoers.d/telegraf:
  file.managed:
    - contents: |
        Cmnd_Alias SMARTCTL = /usr/sbin/smartctl
        telegraf  ALL=(ALL) NOPASSWD: SMARTCTL
        Defaults!SMARTCTL !logfile, !syslog, !pam_session
    - user: root
    - group: root
    - mode: 0440
