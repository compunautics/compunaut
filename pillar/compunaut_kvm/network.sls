{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
compunaut_kvm:
  salt01:
    network:
      bond0:
        - eno1
        - enp4s0f0
      br0:
        ipaddr: {{ vars.public_net }}.100
        netmask: 255.255.255.0
        gateway: {{ vars.public_net }}.1
        dns:
          - "209.244.0.3"
          - "209.244.0.4"
  kvm02:
    network:
      bond0:
        - eno1
        - enp6s0f0
      br0:
        ipaddr: {{ vars.public_net }}.101
        netmask: 255.255.255.0
        gateway: {{ vars.public_net }}.1
        dns:
          - "209.244.0.3"
          - "209.244.0.4"
  kvm03:
    network:
      bond0:
        - eno1
        - enp35s0f0
      br0:
        ipaddr: {{ vars.public_net }}.102
        netmask: 255.255.255.0
        gateway: {{ vars.public_net }}.1
        dns:
          - "209.244.0.3"
          - "209.244.0.4"
{%- endfor %}
