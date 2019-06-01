install_cgi_plugin_deps:
  pkg.installed:
    - pkgs:
      - make
      - gcc

'curl http://uwsgi.it/install | bash -s cgi /usr/bin/uwsgi':
  cmd.run:
    - runas: root
    - unless: test -f /root/uwsgi_latest_from_installer/plugins/stats_pusher_socket/plugin.o
    - require: 
      - pkg: install_cgi_plugin_deps

/usr/lib/cgi-bin:
  file.recurse:
    - source: salt://compunaut_rundeck/uwsgi/
    - makedirs: True
    - user: rundeck
    - group: rundeck
    - file_mode: 0700
    - dir_mode: 0700

'systemctl restart uwsgi.service':
  cmd.run:
    - runas: root
