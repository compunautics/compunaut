### COMPUNAUT
compunaut_group:
  group.present:
    - name: compunaut
    - gid: 9001

compunaut:
  user.present:
    - shell: /bin/bash
    - home: /home/compunaut
    - uid: 9001
    - allow_uid_change: true
    - allow_gid_change: true
    - password: {{ pillar.compunaut.users.compunaut.password }}
    - hash_password: True
    - groups:
      - compunaut
      - adm
      - sudo
      - dip
      - plugdev

/home/compunaut:
  file.directory:
    - user: compunaut
    - group: compunaut
    - recurse:
      - user
      - group

### RUNDECK-SVC
rundeck-svc_group:
  group.present:
    - name: rundeck-svc
    - gid: 9101

rundeck-svc:
  user.present:
    - shell: /bin/bash
    - home: /home/rundeck-svc
    - uid: 9101
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - rundeck-svc
      - adm
      - sudo
      - dip
      - plugdev

/home/rundeck-svc:
  file.directory:
    - user: rundeck-svc
    - group: rundeck-svc
    - recurse:
      - user
      - group
