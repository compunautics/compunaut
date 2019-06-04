### README
# Some raspbian mirrors are unreliable
# Pick a specific one from this list:
# https://www.raspbian.org/RaspbianMirrors

raspbian_apt_sources_list:
  file.managed:
    - name: /etc/apt/sources.list
    - contents: deb http://mirror.umd.edu/raspbian/raspbian/ stretch main contrib non-free rpi
    - user: root
    - group: root
    - mode: 0644

/etc/apt/sources.list.d/raspi.list:
  file.managed:
    - contents: deb http://mirror.umd.edu/raspbian/raspbian/ stretch main contrib non-free rpi
    - user: root
    - group: root
    - mode: 0644
