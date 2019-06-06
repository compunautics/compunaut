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

/var/lib/rundeck/var/uploads/:
  file.directory:
    - user: rundeck-svc
{%- if pillar.compunaut_rundeck is defined %}
  {%- if pillar.compunaut_rundeck.enabled == True %}
    - group: rundeck
    - mode: 0770
  {%- else %}
    - group: rundeck-svc
    - mode: 0700
  {%- endif %}
{%- endif %}
    - makedirs: True

### RUNDECK
{%- if pillar.compunaut_rundeck is defined %}
  {%- if pillar.compunaut_rundeck.enabled == True %}
rundeck_group:
  group.present:
    - name: rundeck
    - gid: 9201

rundeck:
  user.present:
    - shell: /bin/bash
    - home: /var/lib/rundeck
    - uid: 9201
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - rundeck
      - adm
      - sudo

/var/lib/rundeck:
  file.directory:
    - user: rundeck
    - group: rundeck
    - recurse:
      - user
      - group
  {%- endif %}
{%- endif %}
