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
        - host_mission_control_ssl hdr(host) -i control.{{ vars.domain }}
      use_backends:
        - compunaut_mission_control if host_mission_control_ssl
  backends:
    compunaut_mission_control:
      mode: http
      balance: roundrobin
      servers:
{% for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_mission_control:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {% if interfaces['ens2'] is not defined %}
    {% set address = '127.0.0.1' %}
  {% else %}
    {% set address = interfaces['ens2']['inet'][0]['address'] %}
  {% endif %}
        {{ minion }}:
          host: {{ address }}
          port: 8080
{% endfor %}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
{% endfor %}
