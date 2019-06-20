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
  {%- for minion, hostname in salt.saltutil.runner('mine.get', tgt='compunaut_openldap:enabled:True', fun='network.get_hostname', tgt_type='pillar').items() %}
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
