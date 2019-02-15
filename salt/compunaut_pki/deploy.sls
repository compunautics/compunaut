ssl-cert:
  group.present:
    - gid: 9003

/etc/ssl/private/:
  file.directory:
    - user: root
    - group: ssl-cert
    - dir_mode: 0770
    - makedirs: true

/etc/ssl/private/ca.crt:
  file.managed:
    - source: salt://compunaut_pki/keys/ca.crt
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/compunaut_pki.crt:
  file.managed:
    - source: salt://compunaut_pki/keys/{{ hostname }}.crt
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/compunaut_pki.key:
  file.managed:
    - source: salt://compunaut_pki/keys/{{ hostname }}.key
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/dhparams.pem:
  file.managed:
    - source: salt://compunaut_pki/keys/dhparams.pem
    - user: root
    - group: ssl-cert
    - mode: 0660

{%- if pillar.compunaut_rundeck is defined %}
  {%- if pillar.compunaut_rundeck.enabled == True %}
/var/lib/rundeck/.ssh/id_rsa:
  file.managed:
    - source: salt://compunaut_rundeck/keys/rundeck-svc_id_rsa
    - makedirs: True
    - user: rundeck
    - group: rundeck
    - mode: 0600
  {%- endif %}
{%- else %}
/home/rundeck-svc/.ssh/authorized_keys:
  file.managed:
    - source: salt://compunaut_rundeck/keys/rundeck-svc_id_rsa.pub
    - makedirs: true
    - user: rundeck-svc
    - group: rundeck-svc
    - mode: 0600
{%- endif %}
