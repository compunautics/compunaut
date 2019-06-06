###CREATE FOLDER STRUCTURE
/consul-alerts/config/:
  module.run:
    - consul.put:
      - key: /consul-alerts/config/
