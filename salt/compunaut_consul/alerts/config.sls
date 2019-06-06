###CREATE FOLDER STRUCTURE
/consul-alerts/config/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-profiles/
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-selection/
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/slack/
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/email/
