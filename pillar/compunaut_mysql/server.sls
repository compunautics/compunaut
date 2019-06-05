{%- set local_minion = grains['id'] %} # get hostname
{%- set wsrep_cluster_address = [] %}
{%- set existing_databases = [] %}
{%- set existing_users = [] %}
mysql:
  clients:
    mysql:
      default_character_set: utf8
    mysqldump:
      default_character_set: uft8
  server:
    root_user: 'root'
# generate random password
{%- for minion, id in salt.saltutil.runner('mine.get', tgt='compunaut_mysql:master:enabled:True', fun='get_minion_id', tgt_type='pillar' ).items() %}
  {%- set master_id = id | string %}
  {%- set command = 'echo '+master_id+' | sha256sum | cut -d- -f1' %} # define command to generate random password
    root_password: "{{ salt['cmd.shell'](command) }}"
{%- endfor %}
    user: mysql
    mysqld:
# dynamically get ens2 if for the nodes to bind to
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set bind_address = grains['ip4_interfaces']['ens2'][0] %}
      wsrep_node_address: {{ bind_address }}
{%- endif %}
      bind-address: 0.0.0.0
      max_connect_errors: 1024
      datadir: /var/lib/mysql
      log_bin: /var/log/mysql/mysql-bin.log
      binlog_format: row
      default-storage-engine: innodb
      innodb_autoinc_lock_mode: 2
      replicate-ignore-db:
        - mysql
      wsrep_on: ON
      wsrep_provider: /usr/lib/galera/libgalera_smm.so
      wsrep_cluster_name: compunaut_db
      wsrep_sst_method: rsync
      wsrep_node_name: {{ local_minion }}
# dynamically get all ens2 ifs for all nodes to generate cluster address
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_mysql:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {%- if interfaces['ens2'] is not defined %}
    {%- set wsrep_cluster_address = '0.0.0.0' %}
  {%- else %}
    {%- do wsrep_cluster_address.append(interfaces['ens2']['inet'][0]['address']) %}
  {%- endif %}
{%- endfor %}
      wsrep_cluster_address: gcomm://{{ wsrep_cluster_address | join(',') }}
  dev:
    install: True
  database:
{%- for minion, configs in salt.saltutil.runner('mine.get', tgt='not I@compunaut_kvm:enabled:True and not I@compunaut_mysql:enabled:True', fun='get_mysql_configs', tgt_type='compound').items() | unique %}
  {%- if configs is not none %}
    {%- for config, args in configs.items() %}
      {%- if 'database' in config %}
        {%- if args is not none %}
          {%- if args not in existing_databases %}
    {{ args|yaml(False)|indent(4) }}
            {%- do existing_databases.append(args)%}
          {%- endif %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
  user:
{%- for minion, configs in salt.saltutil.runner('mine.get', tgt='not I@compunaut_kvm:enabled:True and not I@compunaut_mysql:enabled:True', fun='get_mysql_configs', tgt_type='compound').items() | unique %}
  {%- if configs is not none %}
    {%- for config, args in configs.items() %}
      {%- if 'user' in config %}
        {%- if args is not none %}
          {%- for key, values in args.items() %}
            {%- if key not in existing_users %}
    {{ key }}:
      {{ values|yaml(False)|indent(6) }}
              {%- do existing_users.append(key)%}
            {%- endif %}
          {%- endfor %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
