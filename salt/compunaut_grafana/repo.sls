grafana.repo:
  pkgrepo.managed:
    - name: deb https://packages.grafana.com/oss/deb stable main
    - file: /etc/apt/sources.list.d/grafana.list
    - keyid: 24098CB6
    - keyserver: keyserver.ubuntu.com
