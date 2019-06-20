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
  {%- for minion, hostname in salt.saltutil.runner('mine.get', tgt='compunaut_mission_control:enabled:True', fun='network.get_hostname', tgt_type='pillar').items() %}
        {{ hostname }}:
          host: {{ hostname }}.node.consul
          port: 8080
          check: fall 3 rise 2 resolvers consul
  {%- endfor %}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
        - redispatch
{%- endfor %}
