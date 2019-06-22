audit:
  auditctl:
    rules:
      - -w /etc/consul.d/config.json -p rwa -k consul_config
      - -w /etc/consul.d/services.json -p rwa -k consul_services
      - -w /etc/consul.d/checks -p rwax -k consul_checks
