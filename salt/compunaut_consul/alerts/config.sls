###CREATE FOLDER STRUCTURE
/consul-alerts/config/notif-profiles/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-profiles/

/consul-alerts/config/notif-selection/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notif-selection/

/consul-alerts/config/notifiers/slack/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/slack/

/consul-alerts/config/notifiers/email/:
  module.run:
    - consul.put:
      - consul_url: http://localhost:8500
      - key: /consul-alerts/config/notifiers/email/
