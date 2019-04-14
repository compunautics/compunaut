{% set existing_backends = [] %}
{% set existing_acls = [] %}
{% set existing_use_backends = [] %}
haproxy:
  global:
    daemon: True
    user: haproxy
    group: haproxy
    ssl-default-bind-ciphers: "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256"
    ssl-default-bind-options: "no-sslv3 no-tlsv10 no-tlsv11"
    tune.ssl.default-dh-param: 2048
    chroot:
      enable: True
      path: /var/lib/haproxy
    log:
      - 127.0.0.1 local0
    stats:
      enable: True
      socketpath: /var/lib/haproxy/stats
      mode: 666
      level: admin
  defaults:
    log: global
    maxconn: 8000
    retries: 3
    options:
      - redispatch
    timeouts:
      - http-request 10s
      - queue 1m
      - connect 10s
      - client 1m
      - server 1m
      - check 10s
  listens:
    stats:
      bind:
        - "127.0.0.1:8998"
      mode: http
      stats:
        enable: True
        uri: "/stats"
        refresh: "20s"
  backends:
{%- for minion, configs in salt.saltutil.runner('mine.get', tgt='not I@compunaut_haproxy:enabled:True', fun='get_haproxy_configs', tgt_type='compound').items() | unique %}
  {%- if configs is not none %}
    {%- for config, args in configs.items() %}
      {%- if 'backend' in config %}
        {%- if args is not none %}
          {%- for key, values in args.items() %}
            {%- if key not in existing_backends %}
    {{ key }}:
      {{ values }}
              {%- do existing_backends.append(key)%}
            {%- endif %}
          {%- endfor %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
  frontends:
    compunaut_http:
      bind: "0.0.0.0:80"
      mode: http
      reqadds:
        - X-Forwarded-Proto:\ http
      options:
        - httplog
        - http-ignore-probes
        - forwardfor
        - http-keep-alive
      acls:
{%- for minion, configs in salt.saltutil.runner('mine.get', tgt='not I@compunaut_haproxy:enabled:True', fun='get_haproxy_configs', tgt_type='compound').items() | unique %}
  {%- if configs is not none %}
    {%- for config, args in configs.items() %}
      {%- if 'frontend' in config %}
        {%- if args is not none %}
          {%- for key, values in args.items() %}
            {%- if values.acls is not none %}
              {%- for acl in values.acls %}
                {%- if acl not in existing_acls %}
        - {{ acl }}
                  {%- do existing_acls.append(acl)%}
                {%- endif %}
              {%- endfor %}
            {%- endif %}
          {%- endfor %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
      use_backends:
{%- for minion, configs in salt.saltutil.runner('mine.get', tgt='not I@compunaut_haproxy:enabled:True', fun='get_haproxy_configs', tgt_type='compound').items() | unique %}
  {%- if configs is not none %}
    {%- for config, args in configs.items() %}
      {%- if 'frontend' in config %}
        {%- if args is not none %}
          {%- for key, values in args.items() %}
            {%- if values.use_backends is not none %}
              {%- for use_backend in values.use_backends %}
                {%- if use_backend not in existing_use_backends %}
        - {{ use_backend }}
                  {%- do existing_use_backends.append(use_backend)%}
                {%- endif %}
              {%- endfor %}
            {%- endif %}
          {%- endfor %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
