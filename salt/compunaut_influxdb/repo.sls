influxdb_repo:
  pkgrepo.managed:
    - name: deb https://repos.influxdata.com/ubuntu xenial stable
    - dist: xenial
    - file: /etc/apt/sources.list.d/influxdata.list
    - keyid: 2582E0C5
    - keyserver: keyserver.ubuntu.com
