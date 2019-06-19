{%- set local_minion = grains['id'] %}
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_mission_control hdr(host) -i control.{{ vars.domain }}
      use_backends:
        - compunaut_mission_control if host_mission_control
    compunaut_https:
      acls:
        - host_mission_control hdr(host) -i control.{{ vars.domain }}
      use_backends:
        - compunaut_mission_control if host_mission_control
  backends:
    compunaut_mission_control:
      mode: http
      balance: roundrobin
      servers:
        {{ local_minion }}:
          host: {{ local_minion }}.node.consul
          port: 8080
          check: fall 3 rise 2
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
        - redispatch
{%- endfor %}
