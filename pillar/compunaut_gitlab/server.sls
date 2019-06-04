{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_gitlab_secrets', tgt_type='pillar').items() %}
gitlab:
  server:
    enabled: true
    initial_root_password: {{ secrets.gitlab_admin_unencrypted_password }}
  {%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
    url: 'http://gitlab.{{ vars.domain }}'
    trusted_proxies: 
      - '{{ vars.public_net }}.0/24'
    source:
      engine: pkg
    mail:
      engine: 'smtp'
      host: 'localhost'
      port: 25
      user: ''
      password: ''
      domain: '{{ vars.domain }}'
      use_tls: false
      from: 'gitlab@{{ vars.domain }}'
      reply_to: 'no-reply@{{ vars.domain }}'
  {%- endfor %}
    identity:
      label: LDAP
      engine: ldap
      host: compunaut-openldap.service.consul
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
      base: {{ secrets.ldap_base }}
      port: 636
      uid: uid
      method: simple_tls
      verify_certificates: false
      bind_dn: {{ secrets.ldap_rootdn }}
      password: {{ secrets.ldap_unencrypted_rootpw }}
      user_filter: 'memberOf=cn=gitlab_user,ou=Groups,{{ secrets.ldap_base }}'
  {%- endfor %}
{%- endfor %}
