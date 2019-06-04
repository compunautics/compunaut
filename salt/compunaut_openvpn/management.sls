/etc/openvpn/man.pass:
  file.managed:
    - contents: "{{ pillar.compunaut_openvpn.management_secret }}"
    - makedirs: True
    - user: root
    - group: root
    - mode: 0600
