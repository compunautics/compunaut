{%- if salt['service.status']('mysql') == False %}
  {%- if pillar.compunaut_mysql.master is defined %}
    {%- if pillar.compunaut_mysql.master.enabled == True %}
      {%- if salt['file.file_exists']('/var/lib/mysql/grastate.dat') %}

safe_to_bootstrap:
  file.replace:
    - name: /var/lib/mysql/grastate.dat
    - pattern: "safe_to_bootstrap: 0"
    - repl: "safe_to_bootstrap: 1"
    - ignore_if_missing: True

      {%- endif %}

'galera_new_cluster':
  cmd.run:
    - runas: root
    
    {%- endif %}
  {%- else %}

'sleep 20':
  cmd.run

'systemctl start mariadb.service':
  cmd.run:
    - runas: root

  {%- endif %}
{%- endif %}

{%- for minion, password in salt['mine.get']('compunaut_mysql:master:enabled:True', 'get_deb_sys_maint_password', 'pillar').iteritems() %}

/etc/mysql/debian.cnf:
  file.managed:
    - source: salt://compunaut_mysql/config/debian.cnf
    - user: root
    - group: root
    - mode: 0600
    - template: jinja
    - defaults: 
        password: {{ password }}

{%- endfor %}
