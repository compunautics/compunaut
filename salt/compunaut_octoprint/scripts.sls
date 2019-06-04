/etc/consul.d/scripts/register_filament.py:
  file.managed:
    - source: salt://compunaut_octoprint/scripts/register_filament.py
    - template: jinja
    - user: consul
    - group: consul
    - mode: 0755
    - makedirs: True

/etc/consul.d/scripts/make_available.py:
  file.managed:
    - source: salt://compunaut_octoprint/scripts/make_available.py
    - template: jinja
    - user: consul
    - group: consul
    - mode: 0755
    - makedirs: True

/etc/consul.d/scripts/make_unavailable.py:
  file.managed:
    - source: salt://compunaut_octoprint/scripts/make_unavailable.py
    - template: jinja
    - user: consul
    - group: consul
    - mode: 0755
    - makedirs: True
