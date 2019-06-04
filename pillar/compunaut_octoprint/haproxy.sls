{%- set local_minion = grains['id'] %}
{%- set short_local_minion = grains['host'] %}
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_{{ short_local_minion }} hdr(host) -i {{ short_local_minion }}.{{ vars.domain }}
        - host_webcam_{{ short_local_minion }} hdr(host) -i webcam.{{ short_local_minion }}.{{ vars.domain }}
      use_backends:
        - {{ short_local_minion }} if host_{{ short_local_minion }}
        - webcam.{{ short_local_minion }} if host_webcam_{{ short_local_minion }}
    compunaut_https:
      acls:
        - host_{{ short_local_minion }} hdr(host) -i {{ short_local_minion }}.{{ vars.domain }}
        - host_webcam_{{ short_local_minion }} hdr(host) -i webcam.{{ short_local_minion }}.{{ vars.domain }}
      use_backends:
        - {{ short_local_minion }} if host_{{ short_local_minion }}
        - webcam.{{ short_local_minion }} if host_webcam_{{ short_local_minion }}
  backends:
    {{ short_local_minion }}:
      mode: http
      balance: roundrobin
      servers:
        {{ local_minion }}:
          host: {{ grains.ip4_interfaces.eth0.0 }}
          port: 443
          check: ssl verify none fall 3 rise 2
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
    webcam.{{ short_local_minion }}:
      mode: http
      balance: roundrobin
      servers:
        {{ local_minion }}:
          host: {{ grains.ip4_interfaces.eth0.0 }}
          port: 443
          check: ssl verify none fall 3 rise 2
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
{%- endfor %}
