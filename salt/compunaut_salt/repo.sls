{%- if grains['osfullname'] is defined %}
  {%- if 'Raspbian' in grains['osfullname'] %}
saltstack.repo:
  pkgrepo.managed:
    - name: deb http://repo.saltstack.com/apt/debian/9/armhf/archive/2018.3.3 stretch main
    - file: /etc/apt/sources.list.d/saltstack.list
    - keyid: DE57BFBE
    - keyserver: keyserver.ubuntu.com
    - clean_file: True
    - refresh: False
  {%- else %}
saltstack.repo:
  pkgrepo.managed:
    - name: deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/archive/2018.3.3 xenial main
    - file: /etc/apt/sources.list.d/saltstack.list
    - keyid: DE57BFBE
    - keyserver: keyserver.ubuntu.com
    - clean_file: True
    - refresh: False
  {%- endif %}
{% endif %}
