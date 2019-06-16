'deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.4/ubuntu xenial main':
  pkgrepo.managed:
    - dist: xenial
    - file: /etc/apt/sources.list.d/mariadb.list
    - keyid: C74CD1D8
    - keyserver: keyserver.ubuntu.com
