{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
nfs:
  server:
    enabled: True
    share:
      srv_rundeck_execution_logs:
        path: /srv/rundeck_execution_logs
        host:
          public: 
            host: {{ vars.public_net }}.0/24
            params:
              - rw
              - no_root_squash
              - sync
{%- endfor %}

compunaut_nfs:
  server:
    enabled: True
