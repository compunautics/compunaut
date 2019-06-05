consul:
  register:
    - name: compunaut_nfs
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Rpcbind Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/sbin/rpcbind"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Rpc Mountd Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/rpc.mountd"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut NFSD Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "nfsd"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut NFS Health Check
          args:
            - /etc/consul.d/checks/check_nfs_health.sh
          interval: 20s
