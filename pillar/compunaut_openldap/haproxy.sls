{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_ldap hdr(host) -i ldap.{{ vars.domain }}
      use_backends:
        - compunaut_ldap if host_ldap
    compunaut_https:
      acls:
        - host_ldap hdr(host) -i ldap.{{ vars.domain }}
      use_backends:
        - compunaut_ldap if host_ldap
  backends:
    compunaut_ldap:
      mode: http
      balance: roundrobin
      cookie: "CNAUT_LDAP_ID insert indirect nocache"
      servers:
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_openldap:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {%- if interfaces['ens2'] is not defined %}
    {%- set address = '127.0.0.1' %}
  {%- else %}
    {%- set address = interfaces['ens2']['inet'][0]['address'] %}
  {%- endif %}
        {{ minion }}:
          host: {{ address }}
          port: 80
          check: ssl verify none fall 3 rise 2 cookie {{ minion }}
{%- endfor %}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
        - redispatch
{%- endfor %}
