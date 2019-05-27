disable_signup:
  cmd.run:
    - name: "gitlab-rails runner 'ApplicationSetting.last.update_attributes(signup_enabled: false)'"
    - runas: root

create_saltstack_token:
  cmd.script:
    - source: salt://compunaut_gitlab/config/create_saltstack_token.sh
    - template: jinja
    - shell: /bin/bash
    - runas: root
    - defaults:
      saltstack_token: {{ pillar.gitlab.token }}
