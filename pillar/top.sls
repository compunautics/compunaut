base:
  '*consul*':
    - compunaut_rsyslog.client
  '*db*':
    - compunaut_mysql
    - compunaut_influxdb
    - compunaut_rsyslog.client
  '*db01*':
    - compunaut_mysql.master
    - compunaut_rsyslog.client
  '*gitlab*':
    - compunaut_gitlab
    - compunaut_rsyslog.client
  '*kvm*':
    - compunaut_kvm
    - compunaut_rsyslog.client
  '*ldap*':
    - compunaut_openldap
    - compunaut_rsyslog.client
  '*monitor*':
    - compunaut_grafana
    - compunaut_rsyslog.client
  '*netboot*':
    - compunaut_guacamole
    - compunaut_piserver
    - compunaut_rsyslog.client
  '*log*':
    - compunaut_nfs
    - compunaut_rsyslog
  '*proxy*':
    - compunaut_haproxy
    - compunaut_keepalived
    - compunaut_mission_control
    - compunaut_rsyslog.client
  '*prtr*':
    - compunaut_octoprint
    - compunaut_rsyslog.client
  '*rundeck*':
    - compunaut_rsyslog.client
    - compunaut_rundeck
  '*salt*':
    - compunaut_rsyslog.client
    - compunaut_salt
    - compunaut_kvm
  '*vpn*':
    - compunaut_keepalived
    - compunaut_openvpn
    - compunaut_rsyslog.client
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
