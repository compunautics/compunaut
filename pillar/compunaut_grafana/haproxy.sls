{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_grafana hdr(host) -i grafana.{{ vars.domain }}
      use_backends:
        - compunaut_grafana if host_grafana
    compunaut_https:
      acls:
        - host_grafana hdr(host) -i grafana.{{ vars.domain }}
      use_backends:
        - compunaut_grafana if host_grafana
  backends:
    compunaut_grafana:
      mode: http
      balance: roundrobin
      cookie: "CNAUT_GRAF_ID insert indirect nocache"
      servers:
  {%- for minion, hostname in salt.saltutil.runner('mine.get', tgt='compunaut_grafana:enabled:True', fun='network.get_hostname', tgt_type='pillar').items() %}
        {{ hostname }}:
          host: {{ hostname }}.node.consul
          port: 443
          check: ssl verify none resolvers consul fall 3 rise 2 cookie {{ hostname }}
  {%- endfor %}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
        - redispatch
{%- endfor %}
