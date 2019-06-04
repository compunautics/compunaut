consul:
  register:
    - name: compunaut_keepalived
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Keepalived Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/keepalived"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Keepalived State
          args:
            - /etc/consul.d/checks/check_keepalived_state.sh
          interval: 10s
