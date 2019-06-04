install_piserver_dependencies:
  pkg.installed:
    - pkgs:
      - binfmt-support
      - qemu-user-static

/var/lib/piserver:
  mount.mounted:
    - device: /dev/mapper/compunaut--minion--vg-piserver
    - fstype: ext4
    - opts: defaults,errors=remount-ro
    - dump: 0
    - pass_num: 2
    - mkmnt: True

/tmp/piserver_debs:
  file.recurse:
    - source: salt://compunaut_piserver/install

install_dnsmasq:
  cmd.run:
    - name: apt install /tmp/piserver_debs/dnsmasq-base_*.deb /tmp/piserver_debs/dnsmasq_*.deb -y
    - runas: root

install_piserver:
  cmd.run:
    - name: apt install /tmp/piserver_debs/piserver*.deb -y
    - runas: root
