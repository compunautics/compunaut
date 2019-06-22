audit:
  auditctl:
    rules:
      - -w /etc/gitlab/gitlab.rb -p rwa -k gitlab_config
