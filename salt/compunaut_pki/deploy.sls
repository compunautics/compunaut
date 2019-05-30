{%- set hostname = grains['id'] %}
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

/etc/ssl/private/compunaut_pki.pem:
  file.append:
    - sources:
      - salt://compunaut_pki/keys/{{ hostname }}.crt
      - salt://compunaut_pki/keys/{{ hostname }}.key
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/dhparams.pem:
  file.managed:
    - source: salt://compunaut_pki/keys/dhparams.pem
    - user: root
    - group: ssl-cert
    - mode: 0660

/home/compunaut/.ssh/authorized_keys:
  file.managed:
    - source: salt://compunaut_pki/keys/id_rsa.pub
    - makedirs: True
    - user: compunaut
    - group: compunaut
    - mode: 0600

{%- if pillar.compunaut_openldap is defined %}
  {%- if pillar.compunaut_openldap.enabled == True %}
/etc/ssl/private/compunaut_openldap.service.consul.crt:
  file.managed:
    - source: salt://compunaut_pki/keys/compunaut_openldap.service.consul.crt
    - user: root
    - group: ssl-cert
    - mode: 0660
  
/etc/ssl/private/compunaut_openldap.service.consul.key:
  file.managed:
    - source: salt://compunaut_pki/keys/compunaut_openldap.service.consul.key
    - user: root
    - group: ssl-cert
    - mode: 0660
  {%- endif %}
{%- endif %}

{%- if pillar.compunaut_rundeck is defined %}
  {%- if pillar.compunaut_rundeck.enabled == True %}
/var/lib/rundeck/.ssh/id_rsa:
  file.managed:
    - source: salt://compunaut_pki/keys/rundeck-svc_id_rsa
    - makedirs: True
    - user: rundeck
    - group: rundeck
    - mode: 0600
  {%- endif %}
{%- else %}
/home/rundeck-svc/.ssh/authorized_keys:
  file.managed:
    - source: salt://compunaut_pki/keys/rundeck-svc_id_rsa.pub
    - makedirs: true
    - user: rundeck-svc
    - group: rundeck-svc
    - mode: 0600
{%- endif %}
