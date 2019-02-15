install_default_packages:
  pkg.installed:
    - pkgs:
      - software-properties-common
      - monitoring-plugins
      - monitoring-plugins-basic
      - monitoring-plugins-common
      - monitoring-plugins-standard
      - vim
      - htop
      - curl
      - sshpass
      - jq
      - mlocate
      - traceroute
      - mtr
      - python-pip

install_default_python_modules:
  pip.installed:
    - pkgs:
      - ruamel.yaml
      - pynag
