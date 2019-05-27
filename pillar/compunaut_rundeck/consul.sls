consul:
  register:
    - name: compunaut_rundeck
      port: 4440
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      checks:
        - name: Compunaut Rundeck Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/var/lib/rundeck/bootstrap/rundeck"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Rundeck HTTP Check
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -p 
            - "4440" 
            - -u 
            - /user/login 
            - -s 
            - "Rundeck - Login" 
            - -t 
            - "3"
          interval: 10s
    - name: compunaut_rundeck_uwsgi
      port: 8080
      address: {{ address }}
      checks:
        - name: Compunaut Rundeck UWSGI Process
          args: 
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/bin/uwsgi"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Rundeck UWSGI HTTP Check
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -p 
            - "8080" 
            - -u 
            - /hello.py 
            - -s 
            - "Hello world" 
            - -t 
            - "3"
          interval: 10s
{%- endif %}
