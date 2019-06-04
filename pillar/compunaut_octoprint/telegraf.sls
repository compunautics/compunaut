telegraf:
  inputs:
    exec:
      commands:
        - /etc/telegraf/telegraf.d/checks/check_octoprint.py
      timeout: "5s"
      name_suffix: "_custom"
      data_format: "influx"
