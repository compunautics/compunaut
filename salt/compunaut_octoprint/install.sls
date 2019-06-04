install_octoprint_dependencies:
  pkg.installed:
    - pkgs:
      - git
      - python-pip
      - virtualenv
      - libsasl2-dev
      - python-dev
      - libldap2-dev
      - libssl-dev
      - cura-engine

octoprint_group:
  group.present:
    - name: octoprint
    - gid: 9021

octoprint:
  user.present:
    - shell: /bin/bash
    - home: /opt/octoprint
    - uid: 9021
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - octoprint
      - dialout

/opt/octoprint/.octoprint/printerProfiles:
  file.directory:
    - user: octoprint
    - group: octoprint
    - makedirs: True
    - recurse:
      - user
      - group

/etc/sudoers.d/octoprint:
  file.managed:
    - source: salt://compunaut_octoprint/sudo/octoprint
    - user: root
    - group: root
    - mode: 0440

https://github.com/foosel/OctoPrint.git:
  git.cloned:
    - target: /opt/octoprint/OctoPrint
    - user: octoprint
    - require:
      - pkg: install_octoprint_dependencies
      - file: /opt/octoprint/.octoprint/printerProfiles

install_octoprint:
  cmd.run:
    - cwd: /opt/octoprint/OctoPrint
    - runas: octoprint
    - name: |
        virtualenv venv
        /opt/octoprint/OctoPrint/venv/bin/python setup.py install
    - unless: test -f /opt/octoprint/OctoPrint/venv/bin/octoprint

/opt/octoprint/OctoPrint/venv/bin/pip install https://github.com/compunautics/OctoPrint-LDAP/archive/master.zip:
  cmd.run:
    - cwd: /opt/octoprint/OctoPrint
    - runas: octoprint

/etc/init.d/octoprint:
  file.managed:
    - source: salt://compunaut_octoprint/install/octoprint.init
    - user: root
    - group: root
    - mode: 0755

/etc/default/octoprint:
  file.managed:
    - source: salt://compunaut_octoprint/install/octoprint.default
    - user: root
    - group: root
    - mode: 0644

refresh_systemd_for_octoprint:
  cmd.run:
    - name: systemctl daemon-reload
    - runas: root
    - require:
      - file: /etc/init.d/octoprint
      - file: /etc/default/octoprint
