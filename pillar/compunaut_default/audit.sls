audit:
  auditctl:
    rules:
      - -w /var/log/audit/ -k auditlog
      - -w /etc/audit/ -p wa -k auditconfig
      - -w /etc/libaudit.conf -p wa -k auditconfig
      - -w /etc/audisp/ -p wa -k audispconfig
      - -w /sbin/auditctl -p x -k audittools
      - -w /sbin/auditd -p x -k audittools
