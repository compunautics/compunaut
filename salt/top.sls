base:
  'compunaut_kvm:enabled:True':
    - match: pillar
    - compunaut_kvm
    - compunaut_openmanage
  'compunaut_pki:enabled:True':
    - match: pillar
    - compunaut_pki.deploy
  'compunaut_keepalived:enabled:True':
    - match: pillar
    - compunaut_keepalived
  'compunaut_openvpn:enabled:True':
    - match: pillar
    - compunaut_openvpn
  'compunaut_dns:enabled:True':
    - match: pillar
    - compunaut_dns
  'compunaut_consul:enabled:True':
    - match: pillar
    - compunaut_consul
  'compunaut_mysql:enabled:True':
    - match: pillar
    - compunaut_mysql
  'compunaut_influxdb:enabled:True':
    - match: pillar
    - compunaut_influxdb
  'compunaut_openldap:enabled:True':
    - match: pillar
    - compunaut_openldap
  'not I@compunaut_openldap:enabled:True':
    - match: compound
    - compunaut_openldap
  'compunaut_guacamole:enabled:True':
    - match: pillar
    - compunaut_guacamole
  'compunaut_piserver:enabled:True':
    - match: pillar
    - compunaut_piserver
  'compunaut_gitlab:enabled:True':
    - match: pillar
    - compunaut_gitlab
  'compunaut_grafana:enabled:True':
    - match: pillar
    - compunaut_grafana
  'compunaut_rundeck:enabled:True':
    - match: pillar
    - compunaut_rundeck
  'compunaut_mission_control:enabled:True':
    - match: pillar
    - compunaut_mission_control
  'compunaut_haproxy:enabled:True':
    - match: pillar
    - compunaut_haproxy
  '*':
    - compunaut_chronyd
    - compunaut_default
    - compunaut_iptables
    - compunaut_sssd
    - compunaut_telegraf
