{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  sites:
    443-gitlab.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/proxy.tmpl
      ServerName: gitlab.{{ vars.domain }}
      ServerAlias: gitlab.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/compunaut_pki.pem
      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'
      ProxyRoute:
        route_to_local_gitlab:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://localhost:80/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://localhost:80/'
{%- endfor %}
