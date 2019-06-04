### FOR HYPERVISORS, IF THEY ARE DELL MACHINES
# Install openmanage
{%- if grains['manufacturer'] is defined %}
  {%- if 'Dell' in grains['manufacturer'] %}
set_openmanage_path:
  environ.setenv:
    - name: PATH
    - value: PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/dell/srvadmin/sbin/

install_openmanage_repo:
  pkgrepo.managed:
    - name: "deb http://linux.dell.com/repo/community/ubuntu xenial openmanage"
    - file: /etc/apt/sources.list.d/linux.dell.com.sources.list
    - keyid: 1285491434D8786F
    - keyserver: pool.sks-keyservers.net

install_openmanage:
  pkg.installed:
    - name: srvadmin-all

/opt/dell/srvadmin/etc/omarolemap:
  file.managed:
    - source: salt://compunaut_openmanage/install/omarolemap
    - makedirs: True
    - user: root
    - group: root
    - mode: 0640

dataeng:
  service.running:
    - enable: True

dsm_om_connsvc:
  service.running:
    - enable: True

open_1311:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - protocol: tcp
    - save: true
  {%- endif %}
{%- endif %}

### README
# If you are unable to get output from `omreport storage controller`
# Then you may need to update the firmware. Follow instructions here:
# http://sysadmin.wikia.com/wiki/PERC_firmware_upgrade_on_debian
#
# For PERC H700I, get updates from here:
# https://www.dell.com/support/home/us/en/04/drivers/driversdetails?driverid=9fvj2
# 
# For BIOS updates:
# https://wiki.ubuntu.com/DellBIOS
