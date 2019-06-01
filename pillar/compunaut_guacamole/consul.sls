consul:
  register:
    - name: compunaut_guacamole
      port: 8080
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      checks:
        - name: Compunaut Guacamole Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "org.apache.catalina.startup.Bootstrap"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Guacamole HTTP Check
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -p 
            - "8080"
            - -u 
            - /guacamole/ 
            - -s 
            - "Login screen for logged-out users" 
            - -t 
            - "3"
          interval: 10s
    - name: compunaut_guacd
      port: 4822
      address: {{ address }}
      checks:
        - name: Compunaut Guacd Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/local/sbin/guacd"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Guacd TCP Check
          args:
            - /usr/lib/nagios/plugins/check_tcp 
            - -H 
            - localhost 
            - -p 
            - "4822" 
            - -t 
            - "3"
          interval: 10s
    - name: compunaut_guacamole_apache
      port: 443
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Rundeck Apache Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/apache2"
            - -c
            - "1:"
          interval: 10s
