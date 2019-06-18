saltstack.repo:
  pkgrepo.managed:
    - name: deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/2018.3 xenial main
    - file: /etc/apt/sources.list.d/saltstack.list
    - keyid: DE57BFBE
    - keyserver: keyserver.ubuntu.com
