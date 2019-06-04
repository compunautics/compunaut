consul:
  register:
    - name: compunaut_octoprint
      port: 5000
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      checks:
        - name: Compunaut Octoprint Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/opt/octoprint/OctoPrint/venv/bin/octoprint"
            - -c
            - "1:"
          interval: 10s
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_octoprint_secrets', tgt_type='pillar').items() %}
        - name: Compunaut Octoprint 
          args:
            - /usr/lib/nagios/plugins/check_http 
            - -k 
            - "X-Api-Key: {{ secrets.octoprint_api_key }}"
            - -H 
            - localhost 
            - -p 
            - "5000" 
            - -u 
            - /api/version
            - -t 
            - "3"
          interval: 10s
  {%- endfor %}
    - name: compunaut_motion
      port: 8081
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Motion Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/bin/motion"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Motion TCP Check
          args:
            - /usr/lib/nagios/plugins/check_tcp 
            - -H 
            - localhost 
            - -p 
            - "8081"
            - -t 
            - "3"
          interval: 10s
        - name: Compunaut Motion Log Check
          args:
            - /usr/lib/nagios/plugins/check_log 
            - -F 
            - /var/log/motion/motion.log 
            - -O 
            - /etc/consul.d/checks/motion.log 
            - -q 
            - "'Failed to open video device'"
          interval: 30s
