/var/lib/rundeck/logs/:
  file.directory:
    - user: rundeck
    - group: rundeck
    - mode: 0750
    - makedirs: True
