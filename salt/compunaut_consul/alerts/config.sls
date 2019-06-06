###CREATE FOLDER STRUCTURE
/consul-alerts/config/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/
