ul:
  register:
    - name: compunaut_haproxy
      port: 80
{% if grains['ip4_interfaces']['ens2'] is defined %}
  {% set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{% endif %}
      checks:
        - name: Compunaut Haproxy Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "haproxy"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Haproxy Stats Endpoint
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -p 
            - "8998" 
            - -u 
            - /stats 
            - -s 
            - "Statistics Report" 
            - -t 
            - "3"
          interval: 10s
