consul:
  register:
    - name: compunaut_telegraf
# pretty sure that I'm going to need to put in logic to work with non-vm ifaces
{% if grains['ip4_interfaces']['ens2'] is defined %}
  {% set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{% endif %}
      check:
        - name: Compunaut Telegraf
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/bin/telegraf"
            - -c
            - "1:"
          interval: 10s
