consul:
  register:
    - name: compunaut_gitlab
      port: 80
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
      checks:
        - name: Compunaut Gitlab Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "runsvdir -P /opt/gitlab/service"
            - -c
            - "1:"
          interval: 10s
        - name: Compunaut Gitlab Health Endpoint
          args:
            - /usr/lib/nagios/plugins/check_http
            - -H
            - localhost
            - -u
            - /-/health
            - -s
            - "GitLab OK"
            - -t
            - "3"
          interval: 10s
    - name: compunaut_gitlab_apache
      port: 443
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut Gitlab Apache Process
          args:
            - /usr/lib/nagios/plugins/check_procs
            - -a
            - "/usr/sbin/apache2"
            - -c
            - "1:"
          interval: 10s

