{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  compunaut_sites:
    consul:
      ServerName: consul.{{ vars.domain }}
      ServerAlias: consul.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/compunaut_pki.pem
      ProxyRoute:
        ProxyPassSource: '/'
        ProxyPassTarget: 'http://localhost:8500/'
        ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
        ProxyPassReverseSource: '/'
        ProxyPassReverseTarget: 'http://localhost:8500/'
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
      Location:
        target: '/'
        AuthLDAPUrl: 'ldap://compunaut-openldap.service.consul/{{ secrets.ldap_base }}?uid'
        ldap_group: 'cn=compunaut_consul,ou=Groups,{{ secrets.ldap_base }}'
  {%- endfor %}
{%- endfor %}
