/srv/salt-images/compunaut-minion.qcow2:
  file.managed:
    - source: {{ pillar.compunaut_hypervisor.image_source.base_image }}
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644
    - source_hash: {{ pillar.compunaut_hypervisor.image_source.source_hash }}
    - unless: ls /srv/salt-images/compunaut-minion.qcow2
