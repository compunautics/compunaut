{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_gitlab hdr(host) -i gitlab.{{ vars.domain }}
      use_backends:
        - compunaut_gitlab if host_gitlab
    compunaut_https:
      acls:
        - host_gitlab hdr(host) -i gitlab.{{ vars.domain }}
      use_backends:
        - compunaut_gitlab if host_gitlab
  backends:
    compunaut_gitlab:
      mode: http
      balance: roundrobin
      cookie: "CNAUT_GTLB_ID insert indirect nocache"
      servers:
  {%- for minion, hostname in salt.saltutil.runner('mine.get', tgt='compunaut_gitlab:enabled:True', fun='network.get_hostname', tgt_type='pillar').items() %}
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
