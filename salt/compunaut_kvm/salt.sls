salt_vms:
  cmd.script:
    - source: salt://compunaut_kvm/salt/salt_vms.sh
    - template: jinja
    - shell: /bin/bash
    - runas: root
    - defaults:
{%- set master_key = salt['key.finger_master']() %}
        master_key: {{ master_key }}
{%- for minion, hostname in salt['mine.get']('compunaut_salt:enabled:True', 'network.interfaces', 'pillar').iteritems()|sort %}
  {%- if interfaces['br0'] is defined %}
    {%- set br0_addr = interfaces['br0']['inet'][0]['address'] %}
        master_ip: {{ br0_addr }}
  {%- endif %}
{%- endfor %}
