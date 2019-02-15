/usr/lib/nagios/plugins/check_chrony.py:
  file.managed:
    - source: salt://compunaut_chronyd/checks/check_chrony.py
    - makedirs: True
    - user: root
    - group: root
    - mode: 0755
