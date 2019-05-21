base:
  '*db*':
    - compunaut_mysql
    - compunaut_influxdb
  '*db01*':
    - compunaut_mysql.master
  '*kvm*':
    - compunaut_kvm
  '*ldap*':
    - compunaut_openldap
  '*monitor*':
    - compunaut_grafana
  '*netboot*':
    - compunaut_guacamole
  '*proxy*':
    - compunaut_haproxy
    - compunaut_keepalived
    - compunaut_mission_control
  '*rundeck*':
    - compunaut_rundeck
  '*salt*':
    - compunaut_salt
    - compunaut_kvm
  '*vpn*':
    - compunaut_keepalived
    - compunaut_openvpn
  '*':
    - compunaut_chronyd
    - compunaut_consul
    - compunaut_default
    - compunaut_dns
    - compunaut_iptables
    - compunaut_openldap.client
    - compunaut_pki
    - compunaut_sssd
    - compunaut_telegraf
