consul:
  register:
    - name: compunaut-consul-apache
      port: 443
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      checks:
        - name: Compunaut Consul Apache Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/apache2"
            - -c
            - "1:"
          interval: 10s
    - name: compunaut-consul-alerts
      port: 9000
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Consul Alerts Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/opt/consul_alerts/bin/consul-alerts"
            - -c
            - "1:"
          interval: 10s
