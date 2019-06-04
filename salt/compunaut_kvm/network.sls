# INSTALL BRIDGE UTILS
bridge-utils:
  pkg.installed

{%- set local_minion = grains['id'] %}
{%- for node, attrs in salt['pillar.get']('compunaut_kvm').items() %}
  {%- if local_minion in node %}
    {%- for attr, args in attrs.items() %}
      {%- if 'network' in attr %}
        {%- for interface in args.bond0 %}
# DEFINE PHYSICAL INTERFACES
{{ interface }}:
  network.managed:
    - enabled: True
    - mtu: 8950
    - type: slave
    - master: bond0
        {%- endfor %}

# COMBINE PHYSICAL INTERFACES INTO BOND INTERFACE
bond0:
  network.managed:
    - enabled: True
    - mtu: 8950
    - type: bond
    - proto: manual
    - mode: active-backup
    - miimon: 100
    - bridge: br0
    - slaves: {{ args.bond0.0 }} {{ args.bond0.1 }}
    - require:
        {%- for interface in args.bond0 %}
      - network: {{ interface }}
        {%- endfor %}

# SET UP BRIDGES
# Public network bridge, attached to bond interface
br0:
  network.managed:
    - enabled: True
    - mtu: 8950
    - type: bridge
    - proto: static
    - ports: bond0
    - use:
      - network: bond0
    - require:
      - network: bond0
    - noifupdown: True
    - ipaddr: {{ args.br0.ipaddr }}
    - netmask: {{ args.br0.netmask }}
    - gateway: {{ args.br0.gateway }}
    - dns:
        {%- for dns in args.br0.dns %}
      - {{ dns }}
        {%- endfor %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}

# Disable KVM default network
'virsh net-destroy default':
  cmd.run:
    - runas: root
    - onlyif: virsh net-list --all | grep default

'virsh net-undefine default':
  cmd.run:
    - runas: root
    - onlyif: virsh net-list --all | grep default

# Private network bridge, defined through KVM
/srv/salt-images/br1.xml:
  file.managed:
    - makedirs: True
    - source: salt://compunaut_kvm/network/br1.xml
    - template: jinja

'virsh net-define /srv/salt-images/br1.xml':
  cmd.run:
    - runas: root
    - unless: virsh net-list --name | grep br1

'virsh net-autostart br1':
  cmd.run

'virsh net-start br1':
  cmd.run:
    - runas: root
    - unless: virsh net-list | grep br1

# Restart the private network when settings change
'virsh net-destroy br1 && virsh net-start br1':
  cmd.run:
    - onchanges:
      - file: /srv/salt-images/br1.xml
