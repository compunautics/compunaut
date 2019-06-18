/etc/apache2/sites-available/443-consul.conf:
  file.managed:
    - source: salt://compunaut_consul/apache/config/443-consul.conf
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644

a2ensite 443-consul.conf:
  cmd.run:
    - unless: test -f /etc/apache2/sites-enabled/443-consul.conf
    - require:
      - file: /etc/apache2/sites-available/443-consul.conf

restart_apache2_for_consul_conf:
  service.running:
    - name: apache2
    - enable: True
    - watch:
      - file: /etc/apache2/sites-available/443-consul.conf
