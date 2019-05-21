consul:
  register:
    - name: compunaut_sssd
# will need to figure out how to handle non-vm ifaces here
{% if grains['ip4_interfaces']['ens2'] is defined %}
  {% set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{% endif %}
      check:
        - name: Compunaut SSSD
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/sssd"
            - -c
            - "1:"
          interval: 10s
