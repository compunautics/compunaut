install_consul_keyring:
  cmd.run:
    - name: 'consul keyring -install {{ pillar['consul']['config']['encrypt'] }}'
    - runas: root

use_consul_keyring:
  cmd.run:
    - name: 'consul keyring -use {{ pillar['consul']['config']['encrypt'] }}'
    - runas: root
