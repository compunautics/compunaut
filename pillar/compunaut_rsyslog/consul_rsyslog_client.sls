consul:
  register:
    - name: compunaut-rsyslog
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Rsyslog Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/rsyslogd"
            - -c
            - "1:"
          interval: 10s
