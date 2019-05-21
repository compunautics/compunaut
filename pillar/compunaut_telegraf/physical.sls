{%- if grains['manufacturer'] is defined %}
  {%- if 'Dell' in grains['manufacturer'] %}
telegraf:
  inputs:
    sensors:
    ipmi_sensor:
      interval: "180s"
      timeout: "120s"
      metric_version: 2
    exec:
      commands:
        - /etc/telegraf/telegraf.d/checks/check_omreport.py
      timeout: "5s"
      name_suffix: "_custom"
      data_format: "influx"
  {%- endif %}
{%- endif %}
