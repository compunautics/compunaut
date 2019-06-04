/etc/sudoers.d/netboot:
  file.managed:
    - contents: "netboot ALL=(ALL) NOPASSWD: /usr/bin/piserver"
    - user: root
    - group: root
    - mode: 0440
