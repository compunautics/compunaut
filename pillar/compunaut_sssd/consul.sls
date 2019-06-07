consul:
  register:
    - name: compunaut-sssd
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      check:
        - name: Compunaut SSSD
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/sssd"
            - -c
            - "1:"
          interval: 10s
