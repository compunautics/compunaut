'hostnamectl set-hostname $(cat /etc/salt/minion_id)':
  cmd.run:
    - runas: root
    - unless: grep $(uname -n) /etc/salt/minion_id
