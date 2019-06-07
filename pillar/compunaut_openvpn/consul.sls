consul:
  register:
    - name: compunaut-openvpn
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut OpenVPN Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/openvpn"
            - -c
            - "1:"
          interval: 10s
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openvpn_secrets', tgt_type='pillar').items() %}
        - name: Compunaut OpenVPN Status Check
          args:
            - /etc/consul.d/checks/check_openvpn.pl
            - -H 
            - localhost 
            - -p 
            - "11940"
            - -P 
            - {{ secrets.openvpn_management_password }} 
          interval: 10s
{%- endfor %}
