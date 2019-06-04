{%- if grains['manufacturer'] is defined %}
  {%- if 'Dell' in grains['manufacturer'] %}
udev_for_ipmi_sensor:
  file.managed:
    - name: /etc/udev/rules.d/52-telegraf-ipmi.rules
    - contents: KERNEL=="ipmi*", MODE="660", GROUP="telegraf"
    - user: root
    - group: root
    - mode: 0644

reload_udev_for_ipmi_sensor:
  cmd.run:
    - name: /bin/udevadm control --reload-rules
    - runas: root
    - onchanges:
      - file: /etc/udev/rules.d/52-telegraf-ipmi.rules

apply_udev_for_ipmi_sensor:
  cmd.run:
    - name: /bin/udevadm trigger
    - runas: root
    - onchanges:
      - file: /etc/udev/rules.d/52-telegraf-ipmi.rules
  {%- endif %}
{%- endif %}
