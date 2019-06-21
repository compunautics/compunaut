install_guacamole_dependencies:
  pkg.installed:
    - pkgs:
      - tomcat8
      - git
      - autoconf
      - libtool
      - libmysql-java
      - libcairo2-dev 
      - libossp-uuid-dev 
      - libavcodec-dev 
      - libavutil-dev 
      - libswscale-dev 
      - libfreerdp-dev 
      - libpango1.0-dev 
      - libssh2-1-dev 
      - libtelnet-dev 
      - libvncserver-dev 
      - libpulse-dev 
      - libssl-dev 
      - libvorbis-dev 
      - libwebp-dev 
      - libpng12-dev
      - libpng16-16

/var/lib/tomcat8/webapps/guacamole.war:
  file.managed:
    - source: http://archive.apache.org/dist/guacamole/1.0.0/binary/guacamole-1.0.0.war
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644
    - source_hash: 93f66f43f4ea77011dc44df2aeeb297dd270cb0f34593d221e58968216a469cf
    - require:
      - pkg: install_guacamole_dependencies

https://github.com/apache/guacamole-server.git:
  git.detached:
    - target: /tmp/guacamole-server
    - rev: 1.0.0
    - require:
      - pkg: install_guacamole_dependencies

install_guacd:
  cmd.run:
    - cwd: /tmp/guacamole-server
    - user: root
    - name: |
        autoreconf -fi
        ./configure --with-init-dir=/etc/init.d
        make && make install
        ldconfig
        systemctl enable guacd
    - require:
      - git: https://github.com/apache/guacamole-server.git
    - unless: test -f /usr/local/sbin/guacd
