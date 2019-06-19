{%- set local_minion = grains['id'] %}
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_ldap hdr(host) -i ldap.{{ vars.domain }}
        - host_password hdr(host) -i password.{{ vars.domain }}
      use_backends:
        - compunaut_ldap if host_ldap
        - compunaut_ldap if host_password
    compunaut_https:
      acls:
        - host_ldap hdr(host) -i ldap.{{ vars.domain }}
        - host_password hdr(host) -i password.{{ vars.domain }}
      use_backends:
        - compunaut_ldap if host_ldap
        - compunaut_ldap if host_password
  backends:
    compunaut_ldap:
      mode: http
      balance: roundrobin
      cookie: "CNAUT_LDAP_ID insert indirect nocache"
      servers:
        {{ local_minion }}:
          host: {{ local_minion }}.node.consul
          port: 443
          check: ssl verify none fall 3 rise 2 cookie {{ local_minion }}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
        - redispatch
{%- endfor %}
