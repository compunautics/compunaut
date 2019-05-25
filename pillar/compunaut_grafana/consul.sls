consul:
  register:
    - name: compunaut_grafana
      port: 3000
{% if grains['ip4_interfaces']['ens2'] is defined %}
  {% set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{% endif %}
      checks:
        - name: Compunaut Grafana Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/grafana-server"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Grafana Health Endpoint
          args:
            - /usr/lib/nagios/plugins/check_http
            - -H
            - localhost
            - -p
            - "3000"
            - -u
            - /api/health
            - -s
            - '"database": "ok"'
            - -t
            - "5"
          interval: 10s
