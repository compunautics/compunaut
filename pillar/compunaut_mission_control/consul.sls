consul:
  register:
    - name: compunaut-mission-control
      port: 8080
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Apache Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/apache2"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Mission Control HTTP Check
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -p 
            - "8080"
            - -u 
            - /index.html
            - -s 
            - "Compunaut Fleet Controller" 
            - -t 
            - "3"
          interval: 10s
