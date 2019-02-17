libvirt-bin:
  pkg.installed: []
  file.managed:
    - name: /etc/default/libvirtd-bin
    - contents: 'libvirtd_opts="--listen"'
    - require:
      - pkg: libvirt-bin
  virt.keys:
    - country: 'US'
    - state: 'TX'
    - locality: 'Austin'
    - expiration_days: '3650'
    - require:
      - pkg: libvirt-bin
  service.running:
    - name: libvirtd
    - require:
      - pkg: libvirt-bin
      - network: br0
    - watch:
      - file: libvirt-bin

libvirt-doc:
  pkg.installed: []

python-libvirt:
  pkg.installed: []

virtinst:
  pkg.installed: []

libguestfs:
  pkg.installed:
    - pkgs:
      - libguestfs-tools
      - libosinfo-bin
