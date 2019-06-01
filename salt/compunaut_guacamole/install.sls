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
    - source: https://cfhcable.dl.sourceforge.net/project/guacamole/current/binary/guacamole-0.9.14.war
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644
    - source_hash: 8831d9720a6a984919dd00f683c114136f35e0f07b33df171714026ecb23d94d
    - require:
      - pkg: install_guacamole_dependencies

https://github.com/apache/guacamole-server.git:
  git.detached:
    - target: /tmp/guacamole-server
    - rev: 0.9.14
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