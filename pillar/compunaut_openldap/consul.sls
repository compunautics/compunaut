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
    - name: compunaut-phpldapadmin
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
    - name: compunaut-ssp
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
            - -I
            - 127.0.0.1
            - -H
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
            - password.{{ vars.domain }}
{%- endfor %}
            - -S
            - -t
            - "3"
          interval: 10s
{%- endif %}
