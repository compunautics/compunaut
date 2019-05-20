consul:
  register:
    - name: compunaut_influxdb_in
      port: 25826
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      checks:
        - name: InfluxDB Relay Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/opt/influxdb_relay/bin/influxdb-relay"
            - -c
            - "1:"
          interval: 10s
        - name: InfluxDB Relay TCP Check
          args:
            - /usr/lib/nagios/plugins/check_tcp 
            - -H 
            - localhost 
            - -p 
            - "25826"
            - -t 
            - "3"
          interval: 10s
    - name: compunaut_influxdb_out
      port: 8086
      address: {{ address }}
      checks:
        - name: InfluxDB Process Check
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/bin/influxd"
            - -c
            - "1:"
          interval: 10s
        - name: InfluxDB Health Endpoint
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -p 
            - "8086"
            - -u 
            - /ping?verbose=true/ 
            - -s 
            - "version" 
            - -t
            - "3"
          interval: 10s
{%- endif %}
