{%- set local_minion = grains['id'] %}
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_guacamole hdr(host) -i guacamole.{{ vars.domain }}
      use_backends:
        - compunaut_guacamole if host_guacamole
    compunaut_https:
      acls:
        - host_guacamole hdr(host) -i guacamole.{{ vars.domain }}
      use_backends:
        - compunaut_guacamole if host_guacamole
  backends:
    compunaut_guacamole:
      mode: http
      balance: roundrobin
      cookie: "CNAUT_GUAC_ID insert indirect nocache"
      servers:
        {{ local_minion }}:
          host: {{ local_minion }}.node.consul
          port: 443
          check: ssl verify none resolvers dnsmasq fall 3 rise 2 cookie {{ local_minion }}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
        - redispatch
{%- endfor %}
