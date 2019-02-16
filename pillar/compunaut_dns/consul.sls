consul:
  register:
    - name: compunaut_dnsmasq
      port: 53
{% if grains['ip4_interfaces']['ens2'] is defined %}
  {% set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{% endif %}
      checks:
        - name: Compunaut dnsmasq Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/dnsmasq"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut dnsmasq DNS Resolution
          args:
            - /usr/lib/nagios/plugins/check_dns
            - -s
            - 127.0.0.1
            - -H
            - salt
            - -t
            - "3"
          interval: 10s
