/home/netboot/Desktop/compunaut-raspi.tar.xz:
  file.managed:
    - source: http://images.compunaut.io/images/compunaut-raspi.tar.xz
    - source_hash: f9f97bb27e588db33d5417fff4436d8e160824b9474ed30a55485a02cb1084d9ffe3678288c4ef7baca170074781afd40284eeb4261f6fca5d08a2ca5be858dd
    - unless: ls /home/netboot/Desktop/compunaut-raspi.tar.xz
    - user: root
    - group: root
    - mode: 0644
