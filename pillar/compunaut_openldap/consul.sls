consul:
  register:
    - name: compunaut-openldap
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      port: 389
      checks:
        - name: Compunaut OpenLDAP Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/slapd"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut OpenLDAP TCP Check
          args:
            - /usr/lib/nagios/plugins/check_tcp 
            - -H 
            - localhost 
            - -p 
            - "636" 
            - -t 
            - "3"
          interval: 10s
    - name: compunaut_phpldapadmin
      address: {{ address }}
      port: 80
      checks:
        - name: Compunaut phpLDAPAdmin Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/apache2"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut phpLDAPAdmin HTTP Check
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -H 
            - localhost 
            - -u 
            - /phpldapadmin/ 
            - -t 
            - "3"
          interval: 10s
    - name: compunaut_ssp
      address: {{ address }}
      port: 443
      checks:
        - name: Compunaut Self Service Password Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/apache2"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Self Service Password HTTP Check
          args:
            - /usr/lib/nagios/plugins/check_http
            - -H
            - localhost
            - -p
            - "443"
            - -u
            - /index.php
            - -t
            - "3"
          interval: 10s
{%- endif %}
