{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  sites:
    443-consul.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/proxy.tmpl
      ServerName: consul.{{ vars.domain }}
      ServerAlias: consul.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/compunaut_pki.pem
      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'
      ProxyRoute:
        route_to_local_consul:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://localhost:8500/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://localhost:8500/'
{%- endfor %}
