consul:
  register:
    - name: compunaut_chronyd
      port: 123
{% if grains['ip4_interfaces']['ens2'] is defined %}
  {% set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{% endif %}
      checks:
        - name: Compunaut Chronyd Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/chronyd"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Chronyd Offset
          args:
            - /usr/lib/nagios/plugins/check_chrony.py
            - -w
            - "0.1"
            - -c
            - "0.5"
          interval: 10s
